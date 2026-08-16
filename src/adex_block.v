// ============================================================================
// adex_block: population primitive (implementation plan M0, section 3-4)
// ----------------------------------------------------------------------------
// One block = 1 prime + 2 fast-positive + 3 slow-negative units (6 units).
// Arithmetic is shift/add/subtract ONLY: no multiply, no divide, no LUT.
//
// Fixed point: prime is Q4.12 (16-bit signed, 1.0 = 4096). Fast units are
// 10-bit signed, slow units are 12-bit signed. All coupling is a binary
// selection of a constant (shift-scaled), never a product.
//
// Update equations per plan section 4 (per cycle, no spike):
//   V' = V - (V >> KV) + fast_drive - slow_drive + Iext - inh + exc
//   F_i' = F_i - (F_i >> KF_i) + (V > VTRIG ? FINC_i : 0)
//   W_i' = W_i + (decay_tick_i ? relax(W_i) : 0) + (V > VTH ? WBUMP : 0)
// On V > VTH: V' = V - VSTEP (subtractive reset) and the slow units bump.
// Each slow unit decays by approximately one eighth every KS_i cycles. The
// period counters make all configured periods through 71 effective with the
// 12-bit state precision.
//
// Width strategy: every narrow signed operand is widened to its expression's
// context by plain assignment into a wider `signed` wire (Verilog sign-extends
// automatically), so there are no hand-rolled {{N{MSB}}, ...} concatenations
// and no lint WIDTHEXPAND. Next-state values are combinational wires; the
// clocked block only samples them, so there are no blocking assignments in
// sequential logic (BLKSEQ-clean).
//
// Area note: the prime accumulator is 18-bit signed. Worst-case |sum| is
// bounded by |v| + leak + fast + slow + |iext| + |inh| + exc < ~44k, far
// inside 18-bit (+-131071); sat16 still clamps to +-32767, so behaviour is
// identical to a wider accumulator while the adders are 2 bits leaner.
//
// All behavioural constants are parameters: the values below are initial
// defaults to be tuned at M1 (regime matching), not frozen numbers.
// ============================================================================
`default_nettype none

module adex_block #(
    // ----- Prime (Q4.12, 16-bit signed) -----
    parameter signed [15:0] VINIT_Q   = -16'sd2048,  // reset value (-0.5)
    parameter        [3:0]  KV        =  4'd4,       // leak shift: tau = 2^KV cycles

    // ----- Fast-positive units (10-bit signed) -----
    parameter        [3:0]  KF0       = 4'd1,        // decay shifts
    parameter        [3:0]  KF1       = 4'd2,
    parameter        [3:0]  FSH0      = 4'd1,        // drive output shifts
    parameter        [3:0]  FSH1      = 4'd1,

    // ----- Slow-negative units (12-bit signed) -----
    // KS triple is the block's assigned coprime period set (plan section 5).
    // Periods up to 71: declared 7 bits so nothing truncates.
    parameter        [6:0]  KS0       = 7'd5,
    parameter        [6:0]  KS1       = 7'd7,
    parameter        [6:0]  KS2       = 7'd11,
    parameter        [3:0]  SSH0      = 4'd3,        // drive output shifts
    parameter        [3:0]  SSH1      = 4'd3,
    parameter        [3:0]  SSH2      = 4'd3,
    parameter        [3:0]  SLOW_DECAY_SHIFT = 4'd3,
    // Phase-counter width. 6 bits covers the baseline periods (<=43); 7 bits
    // is required for the stretch periods (<=71). Kept a parameter so the
    // baseline can be placed leaner without truncating the stretch.
    parameter        [3:0]  PHASE_W   = 4'd7,

    // ----- Drive / coupling -----
    parameter        [3:0]  EXC_SHIFT = 4'd3         // excitation  = 1.0 >> EXC_SHIFT
) (
    input  wire       clk,
    input  wire       rst_n,      // active-low
    input  wire       ext_drive,  // PWM input current (binary)
    input  wire       inh_in,     // inhibitory input from partner
    input  wire       exc_in,     // excitatory input from ring
    input  wire signed [13:0] cfg_vth_q,
    input  wire signed [13:0] cfg_vtrig_q,
    input  wire signed [13:0] cfg_vstep_q,
    input  wire signed [11:0] cfg_iext_q,
    input  wire        [8:0]  cfg_finc0,
    input  wire        [8:0]  cfg_finc1,
    input  wire        [9:0]  cfg_wbump_q,
    input  wire        [11:0] cfg_inh_amt_q,
    output reg        spike       // registered spike output
);

    // ---------------- State ----------------
    reg signed [15:0] v;           // prime potential (Q4.12)
    reg signed [9:0]  f0, f1;      // fast-positive units
    reg signed [11:0] w0, w1, w2;  // slow-negative units
    reg [PHASE_W-1:0] w0_phase, w1_phase, w2_phase;

    // ---------------- Combinational ----------------
    wire spike_now = (v > cfg_vth_q);
    wire trig_now  = (v > cfg_vtrig_q);

    // Runtime controls widened by implicit sign-extension. The config fields are
    // UNSIGNED; cast to a wide unsigned first (zero-extend), THEN to signed, so
    // the full value range stays positive (a raw $signed() of an unsigned reg
    // replays the bit pattern as signed and wraps values >= 2^(w-1)).
    wire signed [15:0] inh_amt_q16 = $signed({4'b0000, cfg_inh_amt_q}); // 12-bit unsigned -> 16-bit signed
    wire signed [15:0] exc_amt     = 16'sd4096 >>> EXC_SHIFT;
    wire signed [15:0] wbump_q16   = $signed({6'b000000, cfg_wbump_q});
    wire signed [11:0] finc0_12    = $signed({3'b000, cfg_finc0});
    wire signed [11:0] finc1_12    = $signed({3'b000, cfg_finc1});

    // Unit states widened to 16-bit signed context.
    wire signed [15:0] f0_16 = $signed(f0);
    wire signed [15:0] f1_16 = $signed(f1);
    wire signed [15:0] w0_16 = $signed(w0);
    wire signed [15:0] w1_16 = $signed(w1);
    wire signed [15:0] w2_16 = $signed(w2);

    // Drive contributions (16-bit signed context; shifts act after widening).
    wire signed [15:0] fast_drive = 16'sd0 + (f0_16 >>> FSH0) + (f1_16 >>> FSH1);
    wire signed [15:0] slow_drive = 16'sd0 + (w0_16 >>> SSH0) + (w1_16 >>> SSH1) + (w2_16 >>> SSH2);

    // Prime accumulator context (18-bit signed). See header for the range proof.
    wire signed [17:0] v_18      = $signed(v);
    wire signed [17:0] vstep_18  = $signed(cfg_vstep_q);
    wire signed [17:0] iext_18   = $signed(cfg_iext_q);
    wire signed [17:0] inh_18    = $signed(inh_amt_q16);
    wire signed [17:0] exc_18    = $signed(exc_amt);
    wire signed [17:0] fast_18   = $signed(fast_drive);
    wire signed [17:0] slow_18   = $signed(slow_drive);

    // Slow-phase / unit widened contexts.
    wire signed [13:0] w0_14 = $signed(w0);
    wire signed [13:0] w1_14 = $signed(w1);
    wire signed [13:0] w2_14 = $signed(w2);
    wire signed [13:0] wbump_14 = $signed({4'b0000, cfg_wbump_q}); // 10-bit unsigned -> 14-bit signed

    // ---------------- Next-state (combinational) ----------------
    wire signed [17:0] v_spk_sum = 18'sd0 + v_18 - vstep_18;   // subtractive reset
    wire signed [17:0] v_dyn_sum = 18'sd0 + v_18 - (v_18 >>> KV)   // leak
                                 + fast_18 - slow_18                // units
                                 + (ext_drive ? iext_18 : 18'sd0)  // external current
                                 - (inh_in    ? inh_18  : 18'sd0)  // reciprocal inhibition
                                 + (exc_in    ? exc_18  : 18'sd0); // ring excitation
    wire signed [17:0] v_sum = spike_now ? v_spk_sum : v_dyn_sum;

    // Fast-positive: decay always, accumulate while V near threshold
    wire signed [11:0] f0_next = 12'sd0 + $signed(f0) - ($signed(f0) >>> KF0) + (trig_now ? finc0_12 : 12'sd0);
    wire signed [11:0] f1_next = 12'sd0 + $signed(f1) - ($signed(f1) >>> KF1) + (trig_now ? finc1_12 : 12'sd0);

    // Slow-negative: all three units relax toward zero on their own periods.
    // Periods are taken in the PHASE_W-bit counter domain so a period that
    // does not fit (e.g. 71 with PHASE_W=6) reads as 0 and simply never ticks.
    wire [PHASE_W-1:0] w0_period = KS0[PHASE_W-1:0];
    wire [PHASE_W-1:0] w1_period = KS1[PHASE_W-1:0];
    wire [PHASE_W-1:0] w2_period = KS2[PHASE_W-1:0];
    wire w0_decay_tick = (w0_period != {PHASE_W{1'b0}}) && (w0_phase == (w0_period - 1'b1));
    wire w1_decay_tick = (w1_period != {PHASE_W{1'b0}}) && (w1_phase == (w1_period - 1'b1));
    wire w2_decay_tick = (w2_period != {PHASE_W{1'b0}}) && (w2_phase == (w2_period - 1'b1));
    wire [PHASE_W-1:0] w0_phase_next = w0_decay_tick ? {PHASE_W{1'b0}} : w0_phase + 1'b1;
    wire [PHASE_W-1:0] w1_phase_next = w1_decay_tick ? {PHASE_W{1'b0}} : w1_phase + 1'b1;
    wire [PHASE_W-1:0] w2_phase_next = w2_decay_tick ? {PHASE_W{1'b0}} : w2_phase + 1'b1;

    function automatic signed [13:0] slow_relax(input signed [13:0] value);
        reg signed [13:0] magnitude;
        begin
            if (value > 14'sd0) begin
                magnitude = value >>> SLOW_DECAY_SHIFT;
                if (magnitude == 14'sd0) magnitude = 14'sd1;
                slow_relax = -magnitude;
            end else begin
                // The slow units only ever accumulate +wbump (spike) and relax
                // toward zero, so their state is always >= 0; a negative value
                // is unreachable and its branch is omitted (area fix, behaviour
                // identical for all reachable states).
                slow_relax = 14'sd0;
            end
        end
    endfunction

    // Slow bump shared across the three slow-unit accumulators (all three
    // add the same (spike_now ? wbump_14 : 0) term; factoring it into one
    // 1-bit-conditioned wire lets synthesis build a single AND/MUX instead
    // of three, trimming a little adder-drive area. Behaviour-identical:
    // each unit still adds wbump_14 exactly on its own spike clock.)
    wire signed [13:0] wbump_term_14 = (spike_now ? wbump_14 : 14'sd0);

    wire signed [13:0] w0_next = 14'sd0 + w0_14
                               + (w0_decay_tick ? slow_relax(w0_14) : 14'sd0)
                               + wbump_term_14;
    wire signed [13:0] w1_next = 14'sd0 + w1_14
                               + (w1_decay_tick ? slow_relax(w1_14) : 14'sd0)
                               + wbump_term_14;
    wire signed [13:0] w2_next = 14'sd0 + w2_14
                               + (w2_decay_tick ? slow_relax(w2_14) : 14'sd0)
                               + wbump_term_14;

    // ---------------- Saturating helpers ----------------
    // sat16's input is only ever the 18-bit prime accumulator (v_sum); the
    // 20-bit signature was wider than any caller. Narrowing to [17:0] is
    // behaviour-identical: v_sum can exceed +-32767 (up to ~+-131071) so the
    // clamps are still reachable, and the dropped top bits are pure sign-
    // extension, so every comparison result is unchanged. ABC builds one
    // 2-bit-leaner comparator.
    function automatic signed [15:0] sat16(input signed [17:0] x);
        begin
            if      (x >  18'sd32767) sat16 =  16'sd32767;
            else if (x < -18'sd32768) sat16 = -16'sd32768;
            else                      sat16 = x[15:0];
        end
    endfunction

    function automatic signed [9:0] sat10(input signed [11:0] x);
        begin
            if      (x >  12'sd511) sat10 =  10'sd511;
            else if (x < -12'sd512) sat10 = -10'sd512;
            else                    sat10 = x[9:0];
        end
    endfunction

    function automatic signed [11:0] sat12(input signed [13:0] x);
        begin
            if      (x >  14'sd2047) sat12 =  12'sd2047;
            else if (x < -14'sd2048) sat12 = -12'sd2048;
            else                     sat12 = x[11:0];
        end
    endfunction

    // ---------------- Dynamics ----------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            v     <= VINIT_Q;
            f0    <= 10'sd0;
            f1    <= 10'sd0;
            w0    <= 12'sd0;
            w1    <= 12'sd0;
            w2    <= 12'sd0;
            w0_phase <= {PHASE_W{1'b0}};
            w1_phase <= {PHASE_W{1'b0}};
            w2_phase <= {PHASE_W{1'b0}};
            spike <= 1'b0;
        end else begin
            spike <= spike_now;
            v     <= sat16(v_sum);
            f0    <= sat10(f0_next);
            f1    <= sat10(f1_next);
            w0    <= sat12(w0_next);
            w1    <= sat12(w1_next);
            w2    <= sat12(w2_next);
            w0_phase <= w0_phase_next;
            w1_phase <= w1_phase_next;
            w2_phase <= w2_phase_next;
        end
    end

endmodule
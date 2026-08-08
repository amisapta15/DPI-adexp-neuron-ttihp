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
//   W_i' = W_i - (W_i >> KS_i) + (V > VTH ? WBUMP_i : 0)
// On V > VTH: V' = V - VSTEP (subtractive reset) and the slow units bump.
//
// All behavioural constants are parameters: the values below are initial
// defaults to be tuned at M1 (regime matching), not frozen numbers.
// ============================================================================
`default_nettype none

module adex_block #(
    // ----- Prime (Q4.12, 16-bit signed) -----
    parameter signed [15:0] VINIT_Q   = -16'sd2048,  // reset value (-0.5)
    parameter signed [15:0] VTH_Q     =  16'sd4096,  // spike threshold (1.0)
    parameter signed [15:0] VTRIG_Q   =  16'sd3072,  // fast-unit trigger (0.75)
    parameter signed [15:0] VSTEP_Q   =  16'sd4096,  // subtractive reset step (1.0)
    parameter        [3:0]  KV        =  4'd4,       // leak shift: tau = 2^KV cycles

    // ----- Fast-positive units (10-bit signed) -----
    parameter        [3:0]  KF0       = 4'd1,        // decay shifts
    parameter        [3:0]  KF1       = 4'd2,
    parameter signed [9:0]  FINC0     = 10'sd128,    // increments while V > VTRIG
    parameter signed [9:0]  FINC1     = 10'sd192,
    parameter        [3:0]  FSH0      = 4'd1,        // drive output shifts
    parameter        [3:0]  FSH1      = 4'd1,

    // ----- Slow-negative units (12-bit signed) -----
    // KS triple is the block's assigned coprime period set (plan section 5).
    // Periods up to 71: declared 7 bits so nothing truncates.
    parameter        [6:0]  KS0       = 7'd5,
    parameter        [6:0]  KS1       = 7'd7,
    parameter        [6:0]  KS2       = 7'd11,
    // Set WBUMP1/WBUMP2 to 0 to recover the "one designated unit" variant.
    parameter signed [11:0] WBUMP0    = 12'sd256,
    parameter signed [11:0] WBUMP1    = 12'sd256,
    parameter signed [11:0] WBUMP2    = 12'sd256,
    parameter        [3:0]  SSH0      = 4'd3,        // drive output shifts
    parameter        [3:0]  SSH1      = 4'd3,
    parameter        [3:0]  SSH2      = 4'd3,

    // ----- Drive / coupling -----
    parameter signed [15:0] IEXT_Q    = 16'sd1024,   // external current (0.25)
    parameter        [3:0]  INH_SHIFT = 4'd3,        // inhibition = 1.0 >> INH_SHIFT
    parameter        [3:0]  EXC_SHIFT = 4'd3         // excitation  = 1.0 >> EXC_SHIFT
) (
    input  wire       clk,
    input  wire       rst_n,      // active-low
    input  wire       ext_drive,  // PWM input current (binary)
    input  wire       inh_in,     // inhibitory input from partner
    input  wire       exc_in,     // excitatory input from ring
    output reg        spike       // registered spike output
);

    // ---------------- State ----------------
    reg signed [15:0] v;           // prime potential (Q4.12)
    reg signed [9:0]  f0, f1;      // fast-positive units
    reg signed [11:0] w0, w1, w2;  // slow-negative units

    // ---------------- Combinational ----------------
    wire spike_now = (v > VTH_Q);
    wire trig_now  = (v > VTRIG_Q);

    wire signed [15:0] fast_drive = 16'sd0 + (f0 >>> FSH0) + (f1 >>> FSH1);
    wire signed [15:0] slow_drive = 16'sd0 + (w0 >>> SSH0) + (w1 >>> SSH1) + (w2 >>> SSH2);
    wire signed [15:0] inh_amt    = 16'sd4096 >>> INH_SHIFT;
    wire signed [15:0] exc_amt    = 16'sd4096 >>> EXC_SHIFT;

    // ---------------- Update temps ----------------
    reg signed [19:0] v_sum;
    reg signed [11:0] f0_next, f1_next;
    reg signed [13:0] w0_next, w1_next, w2_next;

    // ---------------- Saturating helpers ----------------
    function automatic signed [15:0] sat16(input signed [19:0] x);
        begin
            if      (x >  20'sd32767) sat16 =  16'sd32767;
            else if (x < -20'sd32768) sat16 = -16'sd32768;
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
            spike <= 1'b0;
        end else begin
            spike <= spike_now;

            // Prime update
            if (spike_now) begin
                v_sum = 20'sd0 + v - VSTEP_Q;            // subtractive reset
            end else begin
                v_sum = 20'sd0 + v - (v >>> KV)          // leak
                      + fast_drive                       // fast-positive upstroke
                      - slow_drive                       // slow-negative adaptation
                      + (ext_drive ? IEXT_Q : 16'sd0)    // external current
                      - (inh_in    ? inh_amt : 16'sd0)   // reciprocal inhibition
                      + (exc_in    ? exc_amt : 16'sd0);  // ring excitation
            end
            v <= sat16(v_sum);

            // Fast-positive units: decay always, accumulate while V near threshold
            f0_next = 12'sd0 + f0 - (f0 >>> KF0) + (trig_now ? FINC0 : 10'sd0);
            f1_next = 12'sd0 + f1 - (f1 >>> KF1) + (trig_now ? FINC1 : 10'sd0);
            f0 <= sat10(f0_next);
            f1 <= sat10(f1_next);

            // Slow-negative units: decay always, bump on the block's own spike
            w0_next = 14'sd0 + w0 - (w0 >>> KS0) + (spike_now ? WBUMP0 : 12'sd0);
            w1_next = 14'sd0 + w1 - (w1 >>> KS1) + (spike_now ? WBUMP1 : 12'sd0);
            w2_next = 14'sd0 + w2 - (w2 >>> KS2) + (spike_now ? WBUMP2 : 12'sd0);
            w0 <= sat12(w0_next);
            w1 <= sat12(w1_next);
            w2 <= sat12(w2_next);
        end
    end

endmodule

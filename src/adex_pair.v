// ============================================================================
// adex_pair: one E/I pair with reciprocal inhibition (implementation plan M2)
// ----------------------------------------------------------------------------
// E block's spike subtracts (shift-scaled) into I's update and vice versa,
// via the blocks' inh_in inputs. The slow-negative KS triple per block comes
// from the plan section 5 table; pair 0 defaults are E(5,7,11) / I(13,17,19).
//
// Runtime INH_AMT_Q is the inhibition-strength knob used by the pair-level
// tests (escape-versus-release transition, rebound spiking; plan section 8).
// The pair forwards active configuration values to its E and I blocks.
// ============================================================================
`default_nettype none

module adex_pair #(
    // Slow-negative periods per block. 7 bits: periods up to 71.
    parameter [6:0] E_KS0 = 7'd5,  E_KS1 = 7'd7,  E_KS2 = 7'd11,
    parameter [6:0] I_KS0 = 7'd13, I_KS1 = 7'd17, I_KS2 = 7'd19,
    // Phase-counter width (see adex_block). 6 bits covers periods <= 63, which
    // is the whole baseline; the stretch pair (periods <= 71) must use 7.
    parameter [3:0] PHASE_W = 4'd7
) (
    input  wire clk,
    input  wire rst_n,
    input  wire e_drive,   // PWM input current for the E block
    input  wire i_drive,   // PWM input current for the I block
    input  wire e_exc,     // network ring excitation into E (tie 0 at pair level)
    input  wire signed [13:0] e_vth_q,
    input  wire signed [13:0] i_vth_q,
    input  wire signed [11:0] e_iext_q,
    input  wire signed [11:0] i_iext_q,
    input  wire signed [13:0] cfg_vtrig_q,
    input  wire signed [13:0] cfg_vstep_q,
    input  wire        [8:0]  cfg_finc0,
    input  wire        [8:0]  cfg_finc1,
    input  wire        [9:0]  cfg_wbump_q,
    input  wire        [11:0] cfg_inh_amt_q,
    output wire e_spike,
    output wire i_spike
);

    wire e_spk, i_spk;

    adex_block #(
        .KS0       (E_KS0), .KS1 (E_KS1), .KS2 (E_KS2), .PHASE_W (PHASE_W)
    ) e_block (
        .clk       (clk),
        .rst_n     (rst_n),
        .ext_drive (e_drive),
        .inh_in    (i_spk),   // I's spike inhibits E
        .exc_in    (e_exc),
        .cfg_vth_q (e_vth_q),
        .cfg_vtrig_q (cfg_vtrig_q),
        .cfg_vstep_q (cfg_vstep_q),
        .cfg_iext_q (e_iext_q),
        .cfg_finc0 (cfg_finc0),
        .cfg_finc1 (cfg_finc1),
        .cfg_wbump_q (cfg_wbump_q),
        .cfg_inh_amt_q (cfg_inh_amt_q),
        .spike     (e_spk)
    );

    adex_block #(
        .KS0       (I_KS0), .KS1 (I_KS1), .KS2 (I_KS2), .PHASE_W (PHASE_W)
    ) i_block (
        .clk       (clk),
        .rst_n     (rst_n),
        .ext_drive (i_drive),
        .inh_in    (e_spk),   // E's spike inhibits I
        .exc_in    (1'b0),
        .cfg_vth_q (i_vth_q),
        .cfg_vtrig_q (cfg_vtrig_q),
        .cfg_vstep_q (cfg_vstep_q),
        .cfg_iext_q (i_iext_q),
        .cfg_finc0 (cfg_finc0),
        .cfg_finc1 (cfg_finc1),
        .cfg_wbump_q (cfg_wbump_q),
        .cfg_inh_amt_q (cfg_inh_amt_q),
        .spike     (i_spk)
    );

    assign e_spike = e_spk;
    assign i_spike = i_spk;

endmodule

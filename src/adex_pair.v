// ============================================================================
// adex_pair: one E/I pair with reciprocal inhibition (implementation plan M2)
// ----------------------------------------------------------------------------
// E block's spike subtracts (shift-scaled) into I's update and vice versa,
// via the blocks' inh_in inputs. The slow-negative KS triple per block comes
// from the plan section 5 table; pair 0 defaults are E(5,7,11) / I(13,17,19).
//
// INH_SHIFT is the inhibition-strength knob used by the pair-level tests
// (escape-versus-release transition, rebound spiking; plan section 8).
// All remaining block behaviour uses the block defaults; lift more parameters
// up here when M2 measurement shows a per-role split is needed.
// ============================================================================
`default_nettype none

module adex_pair #(
    // Per-role overrides (defaults = block profile)
    parameter signed [15:0] E_VTH_Q   =  16'sd4096,
    parameter signed [15:0] I_VTH_Q   =  16'sd4096,
    parameter signed [15:0] E_IEXT_Q  =  16'sd1024,
    parameter signed [15:0] I_IEXT_Q  =  16'sd1024,
    parameter        [3:0]  INH_SHIFT = 4'd3,

    // Slow-negative periods per block (plan section 5). 7 bits: periods up to 71.
    parameter [6:0] E_KS0 = 7'd5,  E_KS1 = 7'd7,  E_KS2 = 7'd11,
    parameter [6:0] I_KS0 = 7'd13, I_KS1 = 7'd17, I_KS2 = 7'd19
) (
    input  wire clk,
    input  wire rst_n,
    input  wire e_drive,   // PWM input current for the E block
    input  wire i_drive,   // PWM input current for the I block
    input  wire e_exc,     // network ring excitation into E (tie 0 at pair level)
    output wire e_spike,
    output wire i_spike
);

    wire e_spk, i_spk;

    adex_block #(
        .VTH_Q     (E_VTH_Q),
        .IEXT_Q    (E_IEXT_Q),
        .KS0       (E_KS0), .KS1 (E_KS1), .KS2 (E_KS2),
        .INH_SHIFT (INH_SHIFT)
    ) e_block (
        .clk       (clk),
        .rst_n     (rst_n),
        .ext_drive (e_drive),
        .inh_in    (i_spk),   // I's spike inhibits E
        .exc_in    (e_exc),
        .spike     (e_spk)
    );

    adex_block #(
        .VTH_Q     (I_VTH_Q),
        .IEXT_Q    (I_IEXT_Q),
        .KS0       (I_KS0), .KS1 (I_KS1), .KS2 (I_KS2),
        .INH_SHIFT (INH_SHIFT)
    ) i_block (
        .clk       (clk),
        .rst_n     (rst_n),
        .ext_drive (i_drive),
        .inh_in    (e_spk),   // E's spike inhibits I
        .exc_in    (1'b0),
        .spike     (i_spk)
    );

    assign e_spike = e_spk;
    assign i_spike = i_spk;

endmodule

// ============================================================================
// adex_network: coupled-pair network (implementation plan M3/M4)
// ----------------------------------------------------------------------------
// N_PAIRS=2 is the baseline (two isolated E/I pairs sharing the pin budget).
// N_PAIRS=3 is the stretch: adds pair 2 and the sparse excitatory ring
// E0 -> E1 -> E2 -> E0 (plan section 4). No block anywhere shares a slow
// period (plan section 5):
//   pair 0: E(5,7,11)  I(13,17,19)
//   pair 1: E(23,29,31) I(37,41,43)
//   pair 2: E(47,53,59) I(61,67,71)
//
// Vector index convention: [2p] = E_p, [2p+1] = I_p.
// ============================================================================
`default_nettype none

module adex_network #(
    parameter N_PAIRS = 2          // 2 = baseline, 3 = stretch
) (
    input  wire clk,
    input  wire rst_n,
    input  wire [2*N_PAIRS-1:0] ext_drive,  // [2p] = E_p PWM, [2p+1] = I_p PWM
    output wire [2*N_PAIRS-1:0] spike,      // [2p] = E_p spike, [2p+1] = I_p spike
    input  wire signed [13:0] cfg_vth0_q,
    input  wire signed [13:0] cfg_vth1_q,
    input  wire signed [13:0] cfg_vth2_q,
    input  wire signed [13:0] cfg_vth3_q,
    input  wire signed [11:0] cfg_iext0_q,
    input  wire signed [11:0] cfg_iext1_q,
    input  wire signed [11:0] cfg_iext2_q,
    input  wire signed [11:0] cfg_iext3_q,
    input  wire signed [13:0] cfg_vtrig_q,
    input  wire signed [13:0] cfg_vstep_q,
    input  wire        [8:0]  cfg_finc0,
    input  wire        [8:0]  cfg_finc1,
    input  wire        [9:0]  cfg_wbump_q,
    input  wire        [11:0] cfg_inh_amt_q
);

    wire e0s, i0s, e1s, i1s;
    wire e0_exc;   // ring input into E0 (0 in baseline, E2's spike in stretch)
    wire e1_exc;   // ring input into E1 (0 in baseline, E0's spike in stretch)

    adex_pair #(
        .E_KS0     (7'd5),  .E_KS1 (7'd7),  .E_KS2 (7'd11),
        .I_KS0     (7'd13), .I_KS1 (7'd17), .I_KS2 (7'd19),
        .PHASE_W   (4'd6)   // baseline periods <= 43 fit in 6 bits
    ) pair0 (
        .clk       (clk),
        .rst_n     (rst_n),
        .e_drive   (ext_drive[0]),
        .i_drive   (ext_drive[1]),
        .e_exc     (e0_exc),
        .e_vth_q   (cfg_vth0_q),
        .i_vth_q   (cfg_vth1_q),
        .e_iext_q  (cfg_iext0_q),
        .i_iext_q  (cfg_iext1_q),
        .cfg_vtrig_q (cfg_vtrig_q),
        .cfg_vstep_q (cfg_vstep_q),
        .cfg_finc0 (cfg_finc0),
        .cfg_finc1 (cfg_finc1),
        .cfg_wbump_q (cfg_wbump_q),
        .cfg_inh_amt_q (cfg_inh_amt_q),
        .e_spike   (e0s),
        .i_spike   (i0s)
    );

    adex_pair #(
        .E_KS0     (7'd23), .E_KS1 (7'd29), .E_KS2 (7'd31),
        .I_KS0     (7'd37), .I_KS1 (7'd41), .I_KS2 (7'd43),
        .PHASE_W   (4'd6)   // baseline periods <= 43 fit in 6 bits
    ) pair1 (
        .clk       (clk),
        .rst_n     (rst_n),
        .e_drive   (ext_drive[2]),
        .i_drive   (ext_drive[3]),
        .e_exc     (e1_exc),
        .e_vth_q   (cfg_vth2_q),
        .i_vth_q   (cfg_vth3_q),
        .e_iext_q  (cfg_iext2_q),
        .i_iext_q  (cfg_iext3_q),
        .cfg_vtrig_q (cfg_vtrig_q),
        .cfg_vstep_q (cfg_vstep_q),
        .cfg_finc0 (cfg_finc0),
        .cfg_finc1 (cfg_finc1),
        .cfg_wbump_q (cfg_wbump_q),
        .cfg_inh_amt_q (cfg_inh_amt_q),
        .e_spike   (e1s),
        .i_spike   (i1s)
    );

    generate
        if (N_PAIRS == 3) begin : gen_pair2
            wire e2s, i2s;

            adex_pair #(
                .E_KS0     (7'd47), .E_KS1 (7'd53), .E_KS2 (7'd59),
                .I_KS0     (7'd61), .I_KS1 (7'd67), .I_KS2 (7'd71),
                .PHASE_W   (4'd7)   // stretch periods up to 71 need 7 bits
            ) pair2 (
                .clk       (clk),
                .rst_n     (rst_n),
                .e_drive   (ext_drive[4]),
                .i_drive   (ext_drive[5]),
                .e_exc     (e1s),    // ring: E1 excites E2
                // The submitted configuration bank targets the four-block
                // baseline. Stretch builds reuse E0/I0 controls for pair 2.
                .e_vth_q   (cfg_vth0_q),
                .i_vth_q   (cfg_vth1_q),
                .e_iext_q  (cfg_iext0_q),
                .i_iext_q  (cfg_iext1_q),
                .cfg_vtrig_q (cfg_vtrig_q),
                .cfg_vstep_q (cfg_vstep_q),
                .cfg_finc0 (cfg_finc0),
                .cfg_finc1 (cfg_finc1),
                .cfg_wbump_q (cfg_wbump_q),
                .cfg_inh_amt_q (cfg_inh_amt_q),
                .e_spike   (e2s),
                .i_spike   (i2s)
            );

            assign e0_exc = e2s;                     // ring: E2 excites E0
            assign e1_exc = e0s;                     // ring: E0 excites E1
            assign spike  = {i2s, e2s, i1s, e1s, i0s, e0s};
        end else begin : gen_no_pair2
            assign e0_exc = 1'b0;                    // baseline: no cross-pair coupling
            assign e1_exc = 1'b0;
            assign spike  = {i1s, e1s, i0s, e0s};
        end
    endgenerate

endmodule

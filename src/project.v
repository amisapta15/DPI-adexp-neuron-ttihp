/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

/* verilator lint_off DECLFILENAME */
module tt_um_dpi_adexp (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // ----------------------------------------------------
    // Bidirectional outputs are unused. Inputs provide write-only SPI mode 0:
    //   uio_in[0] = CS_N, uio_in[1] = SCLK, uio_in[2] = MOSI.
    // SCLK is synchronised into clk; see adex_config.v for timing limits.
    // ----------------------------------------------------
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    // ----------------------------------------------------
    // Baseline pin map (plan section 6):
    //   ui_in[0] PWM E0     ui_in[1] PWM I0
    //   ui_in[2] PWM E1     ui_in[3] PWM I1
    //   uo_out[0] spike E0  uo_out[1] spike I0
    //   uo_out[2] spike E1  uo_out[3] spike I1
    //   uo_out[4] any-spike aggregate (debug)
    // Stretch (M4): set N_PAIRS to 3; pins occupy [0..5].
    // ----------------------------------------------------
    wire [3:0] spikes;
    wire signed [15:0] cfg_vth0_q, cfg_vth1_q, cfg_vth2_q, cfg_vth3_q;
    wire signed [15:0] cfg_iext0_q, cfg_iext1_q, cfg_iext2_q, cfg_iext3_q;
    wire signed [15:0] cfg_vtrig_q, cfg_vstep_q;
    wire        [8:0]  cfg_finc0, cfg_finc1;
    wire        [10:0] cfg_wbump_q;
    wire        [14:0] cfg_inh_amt_q;

    adex_config u_config (
      .clk           (clk),
      .rst_n         (rst_n),
      .spi_cs_n      (uio_in[0]),
      .spi_sclk      (uio_in[1]),
      .spi_mosi      (uio_in[2]),
      .cfg_vth0_q    (cfg_vth0_q),
      .cfg_vth1_q    (cfg_vth1_q),
      .cfg_vth2_q    (cfg_vth2_q),
      .cfg_vth3_q    (cfg_vth3_q),
      .cfg_iext0_q   (cfg_iext0_q),
      .cfg_iext1_q   (cfg_iext1_q),
      .cfg_iext2_q   (cfg_iext2_q),
      .cfg_iext3_q   (cfg_iext3_q),
      .cfg_vtrig_q   (cfg_vtrig_q),
      .cfg_vstep_q   (cfg_vstep_q),
      .cfg_finc0     (cfg_finc0),
      .cfg_finc1     (cfg_finc1),
      .cfg_wbump_q   (cfg_wbump_q),
      .cfg_inh_amt_q (cfg_inh_amt_q)
    );

    adex_network #(
      .N_PAIRS   (2)
    ) net (
        .clk       (clk),
        .rst_n     (rst_n),
        .ext_drive ({ui_in[3], ui_in[2], ui_in[1], ui_in[0]}),
        .spike     (spikes),
        .cfg_vth0_q (cfg_vth0_q),
        .cfg_vth1_q (cfg_vth1_q),
        .cfg_vth2_q (cfg_vth2_q),
        .cfg_vth3_q (cfg_vth3_q),
        .cfg_iext0_q (cfg_iext0_q),
        .cfg_iext1_q (cfg_iext1_q),
        .cfg_iext2_q (cfg_iext2_q),
        .cfg_iext3_q (cfg_iext3_q),
        .cfg_vtrig_q (cfg_vtrig_q),
        .cfg_vstep_q (cfg_vstep_q),
        .cfg_finc0 (cfg_finc0),
        .cfg_finc1 (cfg_finc1),
        .cfg_wbump_q (cfg_wbump_q),
        .cfg_inh_amt_q (cfg_inh_amt_q)
    );

    // Aggregate computed from the internal spike bus, not from uo_out bits:
    // deriving the OR from the outputs themselves would be a circular path.
    assign uo_out[3:0] = spikes;
    assign uo_out[4]   = (spikes != 4'b0);
    assign uo_out[7:5] = 3'b0;

  // All output pins must be assigned. If not used, assign to 0.
  //assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  //assign uio_out = 0;
  //assign uio_oe  = 0;

    // List unused inputs to prevent warnings.
    wire _unused = &{ena, ui_in[7:4], uio_in[7:3], 1'b0};

endmodule
/* verilator lint_on DECLFILENAME */

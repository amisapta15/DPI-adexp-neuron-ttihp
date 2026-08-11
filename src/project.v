/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

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
    // Bidirectional pins unused in the baseline (serial config
    // loader is deferred; plan section 6 fallback).
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

    adex_network #(
        .N_PAIRS   (2),
        .INH_SHIFT (4'd3)
    ) net (
        .clk       (clk),
        .rst_n     (rst_n),
        .ext_drive ({ui_in[3], ui_in[2], ui_in[1], ui_in[0]}),
        .spike     (spikes)
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

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule

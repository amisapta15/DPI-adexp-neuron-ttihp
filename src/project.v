/*
<<<<<<< HEAD
 * Copyright (c) 2025 Saptarshi Ghosh
=======
 * Copyright (c) 2026 Your Name
>>>>>>> template/main
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

<<<<<<< HEAD
// Uncomment to switch back to LUT16
//`define USE_LUT16

module tt_um_dpi_adexp (
    input  wire [7:0] ui_in,     // dedicated inputs
    output wire [7:0] uo_out,    // dedicated outputs
    input  wire [7:0] uio_in,    // bidirectional inputs
    output wire [7:0] uio_out,   // bidirectional outputs
    output wire [7:0] uio_oe,    // bidirectional enable
    input  wire       ena,       // enable signal from harness (unused)
    input  wire       clk,       // clock
    input  wire       rst_n      // active-low reset
);

    // ----------------------------------------------------
    // Tie off bidirectional outputs (not used by this core)
    // ----------------------------------------------------
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    // ----------------------------------------------------
    // Instantiate the AdEx Neuron Core
    // ----------------------------------------------------
    adex_neuron_system_tt_lut32 core (
        .clk    (clk),
        .rst_n  (rst_n),
        .ui_in  (ui_in),
        .uo_out (uo_out),
        .uio_in (uio_in)
    );

endmodule
=======
module tt_um_analog_example (
    input  wire       VGND,
    input  wire       VDPWR,    // 1.8v power supply
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    inout  wire [7:0] ua,       // Analog pins, only ua[5:0] can be used
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

endmodule
>>>>>>> template/main

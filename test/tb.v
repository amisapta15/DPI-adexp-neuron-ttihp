`default_nettype none
`timescale 1ns / 1ps

<<<<<<< HEAD
/* This testbench instantiates the DUT and connects wires for cocotb.
*/
module tb ();

  // Dump signals to a VCD file for debugging with gtkwave.
=======
/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/
module tb ();

  // Dump the signals to a VCD file. You can view it with gtkwave or surfer.
>>>>>>> template/main
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

<<<<<<< HEAD
  // DUT signals
=======
  // Wire up the inputs and outputs:
>>>>>>> template/main
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

<<<<<<< HEAD
  // IMPORTANT: Replace 'tt_um_your_github_username_adexp_neuron' with the
  // exact name of your top-level Verilog module.
=======
  // Replace tt_um_example with your module name:
>>>>>>> template/main
  tt_um_dpi_adexp user_project (
      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (uo_out),   // Dedicated outputs
      .uio_in (uio_in),   // IOs: Input path
      .uio_out(uio_out),  // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
<<<<<<< HEAD
      .ena    (ena),      // enable
=======
      .ena    (ena),      // enable - goes high when design is selected
>>>>>>> template/main
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // not reset
  );

<<<<<<< HEAD
endmodule
=======
endmodule
>>>>>>> template/main

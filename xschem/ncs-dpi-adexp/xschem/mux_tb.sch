v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 70 -430 870 -30 {flags=graph
y1=0
y2=1.5
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=800e-6
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="out
s0
s1"
dataset=-1
unitx=1
logx=0
logy=0
autoload=1
sim_type=tran
rawfile=$netlist_dir/tg2_tb.raw
color="4 5 12"}
B 2 75 -830 875 -430 {flags=graph
y1=0
y2=1.5
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=800e-6
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="s1
s0
in1
in0"
color="12 5 21 18"
dataset=-1
unitx=1
logx=0
logy=0
sim_type=tran
autoload=1
rawfile=$netlist_dir/tg2_tb.raw}
N 60 235 60 315 {lab=GND}
N 210 120 210 200 {lab=GND}
N 210 30 210 60 {lab=S0}
N 180 370 180 400 {lab=in0}
N 180 460 180 530 {lab=GND}
N 330 375 330 405 {lab=in1}
N 330 465 330 535 {lab=GND}
N 265 215 265 295 {lab=GND}
N 265 125 265 155 {lab=S1}
N 705 190 730 190 {lab=in0}
N 655 210 730 210 {lab=in1}
N 760 280 760 305 {lab=S0}
N 780 280 780 330 {lab=S1}
N 880 280 880 300 {lab=GND}
N 880 140 880 160 {lab=VDD}
N 1030 220 1050 220 {lab=out}
C {simulator_commands_shown.sym} -300 -230 0 0 {name=lib_import
simulator=ngspice
only_toplevel=false 
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt"
}
C {vsource.sym} 60 205 0 0 {name=VDD1 value=1.2 savecurrent=false}
C {gnd.sym} 60 315 0 0 {name=l7 lab=GND}
C {vdd.sym} 60 175 0 0 {name=l8 lab=VDD}
C {vdd.sym} 880 140 0 0 {name=l1 lab=VDD}
C {vsource.sym} 180 430 0 0 {name=VIN0 value="SIN(0.2 0.2 10k)"}
C {vsource.sym} 210 90 0 0 {name=Vsel value="PULSE(0 1.2 50u 1n 1n 300u 800u)"}
C {gnd.sym} 210 200 0 0 {name=l3 lab=GND}
C {lab_pin.sym} 210 30 2 1 {name=p9 sig_type=std_logic lab=S0}
C {lab_pin.sym} 180 370 2 1 {name=p3 sig_type=std_logic lab=in0}
C {gnd.sym} 180 530 0 0 {name=l4 lab=GND}
C {lab_pin.sym} 705 190 2 1 {name=p5 sig_type=std_logic lab=in0}
C {lab_pin.sym} 760 305 2 1 {name=p7 sig_type=std_logic lab=S0}
C {vsource.sym} 330 435 0 0 {name=VIN1 value="SIN(0.2 0.2 10k 0 0 180)"}
C {lab_pin.sym} 330 375 2 1 {name=p1 sig_type=std_logic lab=in1}
C {gnd.sym} 330 535 0 0 {name=l5 lab=GND}
C {vsource.sym} 265 185 0 0 {name=Vsel1 value="PULSE(0 1.2 400u 1n 1n 300u 800u)"}
C {gnd.sym} 265 295 0 0 {name=l6 lab=GND}
C {lab_pin.sym} 265 125 2 1 {name=p4 sig_type=std_logic lab=S1}
C {lab_pin.sym} 655 210 2 1 {name=p6 sig_type=std_logic lab=in1
}
C {lab_pin.sym} 780 330 2 1 {name=p8 sig_type=std_logic lab=S1
}
C {gnd.sym} 880 300 0 0 {name=l10 lab=GND}
C {simulator_commands_shown.sym} -420 190 0 0 {name=TB_Simulator
simulator=ngspice
only_toplevel=false 
value="
.param temp 27
.control
op
write tg2_tb.raw
save v(S0) v(S1) v(in0) v(in1) v(out)
tran 1u 800u
write tg2_tb.raw
.endc
"}
C {launcher.sym} -370 90 0 0 {name=h5
descr="load waves"
tclcommand="xschem raw_read $netlist_dir/tg1_tb.raw tran"
}
C {launcher.sym} -360 40 0 0 {name=h4
descr=SimulateNGSPICE
tclcommand="
# Setup the default simulation commands if not already set up
# for example by already launched simulations.
set_sim_defaults
puts $sim(spice,1,cmd) 

# Change the Xyce command. In the spice category there are currently
# 5 commands (0, 1, 2, 3, 4). Command 3 is the Xyce batch
# you can get the number by querying $sim(spice,n)
set sim(spice,1,cmd) \{ngspice  \\"$N\\" -a\}

# change the simulator to be used (Xyce)
set sim(spice,default) 0

# Create FET and BIP .save file
mkdir -p $netlist_dir
write_data [save_params] $netlist_dir/[file rootname [file tail [xschem get current_name]]].save

# run netlist and simulation
xschem netlist
simulate
"}
C {mux21.sym} 880 220 0 0 {name=x1}
C {lab_pin.sym} 1050 220 0 1 {name=p10 sig_type=std_logic lab=out}

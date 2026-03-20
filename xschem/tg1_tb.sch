v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 80 -440 880 -40 {flags=graph
y1=0
y2=1.5
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-3.1566021e-07
x2=80.968434e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="sel
out"
color="4 5"
dataset=-1
unitx=1
logx=0
logy=0
autoload=1
sim_type=tran
rawfile=$netlist_dir/tg1_tb.raw
rainbow=1}
B 2 910 -440 1710 -40 {flags=graph
y1=0
y2=2
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
node="sel
in0"
color="4 12"
dataset=-1
unitx=1
logx=0
logy=0
autoload=1
sim_type=tran
rawfile=$netlist_dir/tg1_tb.raw}
N 90 130 90 210 {lab=GND}
N 850 40 850 60 {lab=VDD}
N 440 120 440 200 {lab=GND}
N 440 30 440 60 {lab=sel}
N 240 50 240 80 {lab=in0}
N 240 140 240 210 {lab=GND}
N 745 110 780 110 {lab=in0}
N 745 145 765 145 {lab=sel}
N 920 110 1020 110 {lab=out}
N 850 160 850 250 {lab=GND}
C {simulator_commands_shown.sym} -300 -230 0 0 {name=lib_import
simulator=ngspice
only_toplevel=false 
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt"
}
C {vsource.sym} 90 100 0 0 {name=VDD1 value=1.2 savecurrent=false}
C {gnd.sym} 90 210 0 0 {name=l7 lab=GND}
C {vdd.sym} 90 70 0 0 {name=l8 lab=VDD}
C {vdd.sym} 850 40 0 0 {name=l1 lab=VDD}
C {vsource.sym} 240 110 0 0 {name=VIN0 value="SIN(0.2 0.2 10k)"}
C {vsource.sym} 440 90 0 0 {name=Vsel value="PULSE(0 1.2 100u 1n 1n 600u 800u)"
}
C {gnd.sym} 440 200 0 0 {name=l3 lab=GND}
C {lab_pin.sym} 440 30 2 1 {name=p9 sig_type=std_logic lab=sel}
C {simulator_commands_shown.sym} -270 10 0 0 {name=TB_Simulator
simulator=ngspice
only_toplevel=false 
value="
.param temp 27

.control
op
write tg1_tb.raw
save v(sel) v(in0) v(out) v(out)-v(in0)
tran 1u 800u
write tg1_tb.raw
.endc
"}
C {lab_pin.sym} 1020 110 0 1 {name=p2 sig_type=std_logic lab=out}
C {lab_pin.sym} 240 50 2 1 {name=p3 sig_type=std_logic lab=in0}
C {gnd.sym} 240 210 0 0 {name=l4 lab=GND}
C {lab_pin.sym} 745 110 2 1 {name=p5 sig_type=std_logic lab=in0}
C {gnd.sym} 850 250 0 0 {name=l2 lab=GND}
C {lab_pin.sym} 745 145 2 1 {name=p7 sig_type=std_logic lab=sel}
C {tg_lv.sym} 845 115 0 0 {name=x1}
C {launcher.sym} -220 -90 0 0 {name=h5
descr="load waves"
tclcommand="xschem raw_read $netlist_dir/tg1_tb.raw tran"
}
C {launcher.sym} -210 -140 0 0 {name=h4
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

v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 360 -590 1160 -190 {flags=graph
y1=0
y2=2
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=10e-6
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=""
color=""
dataset=-1
unitx=1
logx=0
logy=0
}
N -450 -410 -310 -410 {lab=#net1}
N -270 -380 -270 -360 {lab=#net2}
N -510 -450 -510 -440 {lab=VDD}
N -270 -450 -270 -440 {lab=VDD}
N -450 -410 -450 -350 {lab=#net1}
N -470 -410 -450 -410 {lab=#net1}
N -510 -350 -450 -350 {lab=#net1}
N -510 -380 -510 -350 {lab=#net1}
N -580 -410 -510 -410 {lab=VDD}
N -580 -450 -580 -410 {lab=VDD}
N -580 -450 -510 -450 {lab=VDD}
N -510 -470 -510 -450 {lab=VDD}
N -270 -410 -190 -410 {lab=VDD}
N -270 -450 -190 -450 {lab=VDD}
N -270 -460 -270 -450 {lab=VDD}
N -190 -450 -190 -410 {lab=VDD}
N -510 -290 -510 -250 {lab=#net3}
N -270 -300 -270 -250 {lab=#net4}
N -780 -270 -780 -250 {lab=#net3}
N -780 -250 -510 -250 {lab=#net3}
C {devices/code_shown.sym} 30 -560 0 0 {name=NGSPICE only_toplevel=true 
value="

.options savecurrents
.include block_1_input.save

.param temp=27
.control
save all 

op

write block_1_input.raw
set appendwrite

tran 1p 100n

plot i(VIn)

write block_1_input.raw
.endc
"}
C {devices/code_shown.sym} -690 -80 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/title.sym} 210 -40 0 0 {name=l5 author="Copyright 2023 IHP PDK Authors"}
C {sg13g2_pr/annotate_fet_params.sym} -120 -390 0 0 {name=annot2 ref=M6}
C {sg13g2_pr/sg13_lv_pmos.sym} -490 -410 0 1 {name=M6
l=0.45u
w=1.0u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -290 -410 0 0 {name=M7
l=0.45u
w=1.0u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {devices/ammeter.sym} -270 -330 0 0 {name=Icop}
C {vdd.sym} -510 -470 0 0 {name=l6 lab=VDD}
C {vdd.sym} -270 -460 0 0 {name=l7 lab=VDD}
C {devices/vsource.sym} -780 -420 0 0 {name=Vdd value=1.2}
C {vdd.sym} -780 -450 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} -780 -390 0 0 {name=l8 lab=GND}
C {isource.sym} -780 -300 0 0 {name=I0 value="pulse(0 10n 0 1n 1n 10n 20n)"}
C {devices/ammeter.sym} -510 -320 2 0 {name=Iin}
C {devices/gnd.sym} -270 -200 0 0 {name=l3 lab=GND}
C {devices/vsource.sym} -270 -230 0 0 {name=VIn value=0}
C {vdd.sym} -780 -330 0 0 {name=l2 lab=VDD}
C {launcher.sym} 430 -130 0 0 {name=h1
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
C {launcher.sym} 710 -130 0 0 {name=h2
descr="OP annotate" 
tclcommand="xschem annotate_op"
}
C {launcher.sym} 920 -130 0 0 {name=h3
descr="Load waves" 
tclcommand="
xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw dc
xschem setprop rect 2 0 fullxzoom
"
}

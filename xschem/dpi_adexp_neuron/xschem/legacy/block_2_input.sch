v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 40 -470 600 -170 {flags=graph
y1=-4e-09
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=-0.63788445
x2=0.38211555
divx=5
subdivx=1
node=i(vin)
color=4
dataset=-1
unitx=1
logx=0
logy=0
sim_type=dc
autoload=1
y2=6e-09}
T {Ctrl-Click to execute launcher} 180 -160 0 0 0.3 0.3 {layer=11}
T {.save file can be created with IHP->"Create FET and BIP .save file"} 180 -40 0 0 0.3 0.3 {layer=11}
N -320 -250 -320 -230 {lab=GND}
N -650 -460 -650 -420 {lab=vg}
N -550 -450 -550 -420 {lab=vt}
N -320 -360 -320 -310 {lab=#net1}
N -130 -360 -130 -310 {lab=#net1}
N -230 -360 -130 -360 {lab=#net1}
N -230 -470 -230 -360 {lab=#net1}
N -320 -360 -230 -360 {lab=#net1}
N -230 -280 -130 -280 {lab=VDD}
N -230 -290 -230 -280 {lab=VDD}
N -320 -280 -230 -280 {lab=VDD}
N -130 -230 -130 -220 {lab=vmem}
N -130 -160 -130 -130 {lab=#net2}
N -130 -60 -130 -50 {lab=GND}
N -130 -100 -30 -100 {lab=GND}
N -30 -100 -30 -60 {lab=GND}
N -130 -60 -30 -60 {lab=GND}
N -130 -70 -130 -60 {lab=GND}
N -180 -100 -170 -100 {lab=vt}
N -380 -280 -360 -280 {lab=vg}
N -90 -280 -40 -280 {lab=vmem}
N -40 -280 -40 -230 {lab=vmem}
N -130 -230 -40 -230 {lab=vmem}
N -130 -250 -130 -230 {lab=vmem}
C {sg13g2_pr/sg13_lv_pmos.sym} -340 -280 0 0 {name=M6
l=0.45u
w=1.0u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -110 -280 0 1 {name=M7
l=0.45u
w=1.0u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -150 -100 0 0 {name=M5
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {devices/vsource.sym} -430 -390 0 0 {name=Vdd value=1.2}
C {vdd.sym} -430 -420 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} -430 -360 0 0 {name=l8 lab=GND}
C {devices/gnd.sym} -320 -230 0 0 {name=l2 lab=GND}
C {devices/ammeter.sym} -130 -190 0 0 {name=Icop}
C {devices/vsource.sym} -550 -390 0 0 {name=VT value=0.060068}
C {devices/gnd.sym} -550 -360 0 0 {name=l4 lab=GND}
C {devices/gnd.sym} -130 -50 0 0 {name=l7 lab=GND}
C {devices/vsource.sym} -650 -390 2 0 {name=VG value=0.6}
C {devices/gnd.sym} -650 -360 0 0 {name=l3 lab=GND}
C {isource.sym} -320 -440 0 0 {name=I0 value=DC 10n}
C {vdd.sym} -230 -290 0 0 {name=l6 lab=VDD}
C {lab_pin.sym} -650 -460 0 0 {name=p4 sig_type=std_logic lab=vg}
C {lab_pin.sym} -550 -450 0 0 {name=p5 sig_type=std_logic lab=vt}
C {lab_pin.sym} -380 -280 0 0 {name=p7 sig_type=std_logic lab=vg}
C {lab_pin.sym} -180 -100 0 0 {name=p8 sig_type=std_logic lab=vt}
C {devices/code_shown.sym} -430 70 0 0 {name=NGSPICE only_toplevel=true 
value="
.options savecurrents
.include block_2_input.save

.param temp=27
.control
save all 

op

write block_2_input.raw
set appendwrite

dc VIn 0 1.2 0.01

let Iin_current = i(VIin#branch)
let Icop_current = i(VIcop#branch)
plot Iin_current Icop_current

write block_1_input.raw
.endc
"}
C {devices/code_shown.sym} -830 220 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/title.sym} 210 80 0 0 {name=l9 author="Copyright 2023 IHP PDK Authors"}
C {devices/launcher.sym} 240 -90 0 0 {name=h1
descr="OP annotate" 
tclcommand="xschem annotate_op"
}
C {devices/launcher.sym} 240 -60 0 0 {name=h2
descr="Load waves" 
tclcommand="
xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw dc
xschem setprop rect 2 0 fullxzoom
"
}
C {launcher.sym} 240 -120 0 0 {name=h3
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
C {lab_pin.sym} -40 -280 1 0 {name=p1 sig_type=std_logic lab=vmem
}

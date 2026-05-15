v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 450 -940 1010 -640 {flags=graph
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
divx=5
subdivx=1
dataset=-1
unitx=1
logx=0
logy=0
sim_type=dc
autoload=0
x1=-0.15853443
x2=1.6414656
color=4
node=i(VDS)
y1=8.7962957
y2=13.796293}
B 2 -1760 -480 -960 -80 {flags=graph
y1=-2
y2=0
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-1.5e-06
x2=8.5e-06
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=i(vds)
dataset=-1
unitx=1
logx=0
logy=0
autoload=1
color=4}
T {Ctrl-Click to execute launcher} 590 -630 0 0 0.3 0.3 {layer=11}
T {.save file can be created with IHP->"Create FET and BIP .save file"} 590 -510 0 0 0.3 0.3 {layer=11}
N -490 -440 -490 -430 {lab=VDD}
N -560 -400 -490 -400 {lab=VDD}
N -560 -440 -560 -400 {lab=VDD}
N -490 -460 -490 -440 {lab=VDD}
N -490 -370 -490 -340 {lab=#net1}
N -450 -400 -420 -400 {lab=vg}
N -790 -380 -790 -350 {lab=vg}
N -580 -170 -490 -170 {lab=VDD}
N -580 -440 -580 -170 {lab=VDD}
N -560 -440 -490 -440 {lab=VDD}
N -580 -440 -560 -440 {lab=VDD}
N -490 -200 -490 -170 {lab=VDD}
N -490 -280 -490 -260 {lab=#net2}
C {sg13g2_pr/sg13_lv_pmos.sym} -470 -400 0 1 {name=M6
l=0.45u
w=1.0u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {vdd.sym} -490 -460 0 0 {name=l6 lab=VDD}
C {devices/vsource.sym} -660 -390 0 0 {name=Vdd value=1.2}
C {vdd.sym} -660 -420 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} -660 -360 0 0 {name=l8 lab=GND}
C {devices/ammeter.sym} -490 -310 0 0 {name=VDS}
C {devices/code_shown.sym} -330 50 0 0 {name=NGSPICE only_toplevel=true 
value="

.options savecurrents
.include Csource.save

.param temp=27
.control
save all 

op

write Csourceraw
set appendwrite

dc VT 0 0.5 0.01 VT1 0 3.3 0.1

plot i(VDS)

write Csource.raw
.endc
"}
C {devices/code_shown.sym} -660 70 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {sg13g2_pr/annotate_fet_params.sym} -760 -260 0 0 {name=annot2 ref=M6}
C {devices/launcher.sym} 650 -560 0 0 {name=h1
descr="OP annotate" 
tclcommand="xschem annotate_op"
}
C {devices/launcher.sym} 650 -530 0 0 {name=h2
descr="Load waves" 
tclcommand="
xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw dc
xschem setprop rect 2 0 fullxzoom
"
}
C {launcher.sym} 650 -590 0 0 {name=h3
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
C {devices/vsource.sym} -790 -410 0 0 {name=VT value=0.060068}
C {lab_pin.sym} -790 -350 2 0 {name=p5 sig_type=std_logic lab=vg
}
C {lab_pin.sym} -420 -400 2 0 {name=p1 sig_type=std_logic lab=vg
}
C {vdd.sym} -790 -440 0 0 {name=l3 lab=VDD}
C {devices/vsource.sym} -490 -230 2 0 {name=VT1 value=0}

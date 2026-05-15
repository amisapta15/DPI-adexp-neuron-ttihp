v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 -1060 -1440 -260 -1040 {flags=graph
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=5e-6
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
rawfile=$netlist_dir/trim.raw
sim_type=tran
y2=5.2e-6
autoload=1
color="4 5"
node="i(vmeas)
ibias"}
N -1270 -660 -1270 -640 {lab=GND}
N -1200 -660 -1200 -640 {lab=GND}
N -1120 -660 -1120 -640 {lab=GND}
N -1040 -650 -1040 -630 {lab=GND}
N -970 -640 -970 -620 {lab=GND}
N -1270 -740 -1270 -720 {lab=CSen}
N -1200 -740 -1200 -720 {lab=DB0}
N -1120 -750 -1120 -720 {lab=DB1}
N -1040 -730 -1040 -710 {lab=DB2}
N -970 -720 -970 -700 {lab=DB3}
N -1040 -850 -1040 -830 {lab=CSen}
N -1080 -830 -1040 -830 {lab=CSen}
N -1060 -870 -1040 -870 {lab=DB3}
N -1060 -870 -1060 -860 {lab=DB3}
N -1080 -860 -1060 -860 {lab=DB3}
N -1080 -890 -1040 -890 {lab=DB2}
N -1060 -910 -1040 -910 {lab=DB1}
N -1060 -920 -1060 -910 {lab=DB1}
N -1080 -920 -1060 -920 {lab=DB1}
N -1040 -950 -1040 -930 {lab=DB0}
N -1080 -950 -1040 -950 {lab=DB0}
N -980 -790 -980 -780 {lab=GND}
N -980 -790 -770 -790 {lab=GND}
N -980 -810 -980 -790 {lab=GND}
N -770 -820 -770 -790 {lab=GND}
N -810 -880 -770 -880 {lab=#net1}
N -900 -880 -870 -880 {lab=#net2}
N -980 -970 -980 -960 {lab=VDD}
C {devices/title.sym} -1610 -320 0 0 {name=l5 author="Yuan Li"}
C {devices/code_shown.sym} -1650 -810 0 0 {name=NGSPICE only_toplevel=true 
value="
.include trimmer.save
.option savecurrent
.param temp=127
.control
set noaskquit
save all 
op
write trim.raw
alter Ven dc 1.8
alter ven1 dc 1.8
alter ven2 dc 0.0
alter ven3 dc 0.0
alter ven4 dc 0.0
tran 1n 5u
write trim.raw
*plot en enN enMon
*plot D0 D1 D2 D3
*plot vstart
*plot vbp vbp_casc
*plot v(ibias)/300
plot vmeas#branch
*quit
.endc
"}
C {lab_pin.sym} -1080 -950 2 1 {name=p1 sig_type=std_logic lab=DB0}
C {vsource.sym} -1340 -670 0 0 {name=V1 value=1.8}
C {devices/gnd.sym} -1340 -640 0 0 {name=l3 lab=GND}
C {vsource.sym} -1270 -690 0 0 {name=Ven value=1.8}
C {devices/gnd.sym} -1270 -640 0 0 {name=l4 lab=GND}
C {devices/gnd.sym} -980 -780 0 0 {name=l1 lab=GND}
C {simulator_commands_shown.sym} -1650 -990 0 0 {
name=Libs_Ngspice
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
"
      }
C {vsource.sym} -1200 -690 0 0 {name=Ven1 value=1.8
"}
C {devices/gnd.sym} -1200 -640 0 0 {name=l8 lab=GND}
C {vsource.sym} -1120 -690 0 0 {name=Ven2 value=1.8
"}
C {devices/gnd.sym} -1120 -640 0 0 {name=l10 lab=GND}
C {vsource.sym} -1040 -680 0 0 {name=Ven3 value=1.8
"}
C {devices/gnd.sym} -1040 -630 0 0 {name=l12 lab=GND}
C {vsource.sym} -970 -670 0 0 {name=Ven4 value=1.8
"}
C {devices/gnd.sym} -970 -620 0 0 {name=l14 lab=GND}
C {devices/launcher.sym} -1270 -1080 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/trim.raw tran"
}
C {trimmer.sym} -980 -880 0 0 {name=x1}
C {vdd.sym} -1340 -700 0 0 {name=l19 lab=VDD}
C {lab_pin.sym} -1080 -920 2 1 {name=p2 sig_type=std_logic lab=DB1}
C {lab_pin.sym} -1080 -890 2 1 {name=p3 sig_type=std_logic lab=DB2}
C {lab_pin.sym} -1080 -860 2 1 {name=p4 sig_type=std_logic lab=DB3}
C {lab_pin.sym} -1080 -830 2 1 {name=p5 sig_type=std_logic lab=CSen}
C {res.sym} -770 -850 0 0 {name=R1
value=300
footprint=1206
device=resistor
m=1}
C {ammeter.sym} -840 -880 3 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {vdd.sym} -980 -970 0 0 {name=l2 lab=VDD}
C {lab_pin.sym} -1200 -740 2 1 {name=p6 sig_type=std_logic lab=DB0}
C {lab_pin.sym} -1120 -750 2 1 {name=p7 sig_type=std_logic lab=DB1}
C {lab_pin.sym} -1040 -730 2 1 {name=p8 sig_type=std_logic lab=DB2}
C {lab_pin.sym} -970 -720 2 1 {name=p9 sig_type=std_logic lab=DB3}
C {lab_pin.sym} -1270 -740 2 1 {name=p10 sig_type=std_logic lab=CSen}

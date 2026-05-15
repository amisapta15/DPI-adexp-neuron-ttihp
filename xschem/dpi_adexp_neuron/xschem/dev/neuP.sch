v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -1280 -707.5 -1280 -697.5 {lab=VDD}
N -1280 -637.5 -1280 -617.5 {lab=GND}
N -1150 -510 -1150 -437.5 {lab=GND}
N -1090 -540 -1030 -540 {lab=Vthr}
N -1090 -620 -1090 -540 {lab=Vthr}
N -1110 -540 -1090 -540 {lab=Vthr}
N -1150 -620 -1090 -620 {lab=Vthr}
N -1150 -620 -1150 -570 {lab=Vthr}
N -1150 -660 -1150 -620 {lab=Vthr}
N -1150 -750 -1150 -720 {lab=VDD}
C {devices/code_shown.sym} -1610 -540 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.include diodes.lib
.include sg13g2_bondpad.lib
"}
C {devices/code_shown.sym} -1005 -785 0 0 {name=NGSPICE only_toplevel=true 
value="
.options savecurrents
.include neuT.save
.param temp=27
.control
save all
op
write neuT.raw
dc I0 0 0.2n 10p
write neuT.raw
plot v(vthr)
.endc
"}
C {simulator_commands_shown.sym} -1610 -680 0 0 {
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
C {devices/gnd.sym} -1280 -617.5 0 0 {name=l23 lab=GND}
C {vdd.sym} -1280 -707.5 0 0 {name=l24 lab=VDD}
C {lab_wire.sym} -1070 -540 1 0 {name=p2 sig_type=std_logic lab=Vthr}
C {devices/gnd.sym} -1150 -437.5 0 0 {name=l3 lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} -1130 -540 0 1 {name=M3
l=0.15u
w=0.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {devices/vsource.sym} -1280 -667.5 0 0 {name=Vdd2 value=1.65}
C {noconn.sym} -1030 -540 2 0 {name=l1}
C {vdd.sym} -1150 -747.5 0 0 {name=l2 lab=VDD}
C {isource.sym} -1150 -690 0 0 {name=I0 value=1n}
C {lab_pin.sym} -1150 -540 0 0 {name=p10 sig_type=std_logic lab=GND}

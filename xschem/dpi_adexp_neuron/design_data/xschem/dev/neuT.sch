v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -790 -1057.5 -790 -1047.5 {lab=VDD}
N -790 -987.5 -790 -967.5 {lab=GND}
N -580 -1030 -520 -1030 {lab=Vthr}
N -640 -1130 -640 -1060 {lab=VDD}
N -640 -900 -640 -880 {lab=#net1}
N -640 -980 -640 -960 {lab=Vthr}
N -580 -1030 -580 -980 {lab=Vthr}
N -600 -1030 -580 -1030 {lab=Vthr}
N -640 -980 -580 -980 {lab=Vthr}
N -640 -1000 -640 -980 {lab=Vthr}
C {devices/code_shown.sym} -1140 -1090 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.include diodes.lib
.include sg13g2_bondpad.lib
"}
C {devices/code_shown.sym} -535 -1335 0 0 {name=NGSPICE only_toplevel=true 
value="
.options savecurrents
.include neuT.save
.param temp=27
.control
save all
op
write neuT.raw
*dc I0 100u 110u 10n
tran 500p 1u
write neuT.raw
plot v(vthr)
.endc
"}
C {simulator_commands_shown.sym} -1140 -1230 0 0 {
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
C {devices/vsource.sym} -790 -1017.5 0 0 {name=Vdd1 value=1.8}
C {devices/gnd.sym} -790 -967.5 0 0 {name=l23 lab=GND}
C {vdd.sym} -790 -1057.5 0 0 {name=l24 lab=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} -620 -1030 0 1 {name=M2
l=0.15u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {vdd.sym} -640 -1130 0 0 {name=l4 lab=VDD}
C {lab_pin.sym} -640 -1030 0 0 {name=p1 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -560 -1030 1 0 {name=p2 sig_type=std_logic lab=Vthr}
C {devices/gnd.sym} -640 -877.5 0 0 {name=l3 lab=GND}
C {isource.sym} -640 -930 0 0 {name=I0 value=2.5u}
C {noconn.sym} -520 -1030 2 0 {name=l1}

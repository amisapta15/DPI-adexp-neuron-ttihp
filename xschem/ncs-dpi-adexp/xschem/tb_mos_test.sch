v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -500 20 -500 60 {lab=VDD}
N -500 120 -500 160 {lab=0}
N -270 0 -210 0 {lab=Vg}
N -380 120 -380 160 {lab=0}
N -170 -130 -170 -110 {lab=VDD}
N -170 -50 -170 -30 {lab=#net1}
N -170 30 -170 160 {lab=0}
N -170 0 -150 0 {lab=0}
N -150 0 -150 30 {lab=0}
N -170 30 -150 30 {lab=0}
N -380 20 -380 60 {lab=Vg}
N -60 0 0 0 {lab=Vg}
N 40 -130 40 -30 {lab=VDD}
N 40 -0 60 -0 {lab=VDD}
N 60 -30 60 -0 {lab=VDD}
N 40 -30 60 -30 {lab=VDD}
N 40 30 40 60 {lab=#net2}
N 40 120 40 160 {lab=0}
C {sg13g2_pr/sg13_hv_nmos.sym} -190 0 0 0 {name=Mn
l=1u
w=1u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {ammeter.sym} -170 -80 0 0 {name=Vdn savecurrent=true spice_ignore=0}
C {vsource.sym} -380 90 0 0 {name=Vgs value=0 savecurrent=false}
C {gnd.sym} -170 160 0 0 {name=l1 lab=0}
C {vdd.sym} -170 -130 0 0 {name=l2 lab=VDD}
C {vsource.sym} -500 90 0 0 {name=Vdd value=1.2 savecurrent=false}
C {vdd.sym} -500 20 0 0 {name=l3 lab=VDD}
C {gnd.sym} -500 160 0 0 {name=l4 lab=0}
C {simulator_commands_shown.sym} 360 -270 0 0 {
name=Libs_Ngspice
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
"
      }
C {simulator_commands_shown.sym} 360 -90 0 0 {name=Simulator2
simulator=ngspice
only_toplevel=false 
value="
.param temp=27
.control
save all 
dc Vgs 0 1.2 0.01
write dc_hv_sweep.raw
.endc
"}
C {lab_wire.sym} -380 40 0 0 {name=p1 sig_type=std_logic lab=Vg}
C {gnd.sym} -380 160 0 0 {name=l5 lab=0}
C {lab_wire.sym} -240 0 0 0 {name=p2 sig_type=std_logic lab=Vg}
C {ammeter.sym} 40 90 0 0 {name=Vdp savecurrent=true spice_ignore=0}
C {gnd.sym} 40 160 0 0 {name=l6 lab=0}
C {vdd.sym} 40 -130 0 0 {name=l7 lab=VDD}
C {lab_wire.sym} -30 0 0 0 {name=p3 sig_type=std_logic lab=Vg}
C {sg13g2_pr/sg13_hv_pmos.sym} 20 0 0 0 {name=Mp
l=1u
w=1u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}

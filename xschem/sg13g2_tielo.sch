v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -270 -180 -240 -180 {lab=VDD}
N -270 -140 -240 -140 {lab=VSS}
N 20 30 20 60 {lab=VSS}
N -40 0 -20 0 {lab=net2}
N -40 -220 -40 -190 {lab=VDD}
N 80 -130 80 0 {lab=net1}
N 20 0 40 0 {lab=VSS}
N 40 0 40 30 {lab=VSS}
N 20 30 40 30 {lab=VSS}
N -40 -160 -20 -160 {lab=VDD}
N -20 -190 -20 -160 {lab=VDD}
N -40 -190 -20 -190 {lab=VDD}
N 140 30 140 60 {lab=VSS}
N 80 0 100 0 {lab=net1}
N 140 0 160 0 {lab=VSS}
N 160 0 160 30 {lab=VSS}
N 140 30 160 30 {lab=VSS}
N 20 -160 20 -30 {lab=net3}
N -100 -160 -80 -160 {lab=net2}
N 80 -220 80 -190 {lab=VDD}
N 80 -160 100 -160 {lab=VDD}
N 100 -190 100 -160 {lab=VDD}
N 80 -190 100 -190 {lab=VDD}
N 140 -80 140 -30 {lab=L_LO}
N 20 -160 40 -160 {lab=net3}
N 140 -80 170 -80 {lab=L_LO}
N -100 -160 -100 -110 {lab=net2}
N -100 -110 -40 -110 {lab=net2}
N -40 -130 -40 -110 {lab=net2}
N -40 -110 -40 -0 {lab=net2}
C {sg13g2_pr/sg13_lv_nmos.sym} 0 0 0 0 {name=MN1
l=0.13u
w=0.385u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {iopin.sym} -270 -140 2 0 {name=p2 lab=VSS}
C {iopin.sym} -270 -180 2 0 {name=p3 lab=VDD}
C {lab_wire.sym} 20 30 3 0 {name=p1 sig_type=std_logic lab=VSS}
C {lab_wire.sym} 80 -100 3 0 {name=p4 sig_type=std_logic lab=net1}
C {sg13g2_pr/sg13_lv_pmos.sym} -60 -160 0 0 {name=MP1
l=0.13u
w=0.3u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_wire.sym} -40 -190 3 1 {name=p5 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -60 -110 0 0 {name=p6 sig_type=std_logic lab=net2}
C {sg13g2_pr/sg13_lv_nmos.sym} 120 0 0 0 {name=MN2
l=0.13u
w=0.88u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 140 30 3 0 {name=p7 sig_type=std_logic lab=VSS}
C {lab_wire.sym} 20 -100 3 0 {name=p8 sig_type=std_logic lab=net3}
C {sg13g2_pr/sg13_lv_pmos.sym} 60 -160 0 0 {name=MP2
l=0.13u
w=1.045u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_wire.sym} 80 -190 3 1 {name=p9 sig_type=std_logic lab=VDD}
C {opin.sym} 170 -80 0 0 {name=p10 lab=L_LO}

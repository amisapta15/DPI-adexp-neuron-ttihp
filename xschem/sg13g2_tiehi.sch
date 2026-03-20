v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -270 -180 -240 -180 {lab=VDD}
N -270 -140 -240 -140 {lab=VSS}
N -30 30 -30 60 {lab=VSS}
N -90 0 -70 0 {lab=net1}
N -90 -50 -90 0 {lab=net1}
N -90 -50 -30 -50 {lab=net1}
N -30 -50 -30 -30 {lab=net1}
N 30 -220 30 -190 {lab=VDD}
N 30 -130 30 -0 {lab=net2}
N -30 0 -10 -0 {lab=VSS}
N -10 -0 -10 30 {lab=VSS}
N -30 30 -10 30 {lab=VSS}
N 30 -160 50 -160 {lab=VDD}
N 50 -190 50 -160 {lab=VDD}
N 30 -190 50 -190 {lab=VDD}
N 90 30 90 60 {lab=VSS}
N 30 0 50 0 {lab=net2}
N 90 0 110 0 {lab=VSS}
N 110 0 110 30 {lab=VSS}
N 90 30 110 30 {lab=VSS}
N -30 -160 -30 -50 {lab=net1}
N -30 -160 -10 -160 {lab=net1}
N 150 -220 150 -190 {lab=VDD}
N 150 -160 170 -160 {lab=VDD}
N 170 -190 170 -160 {lab=VDD}
N 150 -190 170 -190 {lab=VDD}
N 90 -160 90 -30 {lab=net3}
N 90 -160 110 -160 {lab=net3}
N 150 -130 150 -80 {lab=L_HI}
N 150 -80 180 -80 {lab=L_HI}
C {sg13g2_pr/sg13_lv_nmos.sym} -50 0 0 0 {name=MN1
l=0.13u
w=0.3u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {iopin.sym} -270 -140 2 0 {name=p2 lab=VSS}
C {iopin.sym} -270 -180 2 0 {name=p3 lab=VDD}
C {lab_wire.sym} -30 30 3 0 {name=p1 sig_type=std_logic lab=VSS}
C {lab_wire.sym} -50 -50 0 0 {name=p4 sig_type=std_logic lab=net1}
C {sg13g2_pr/sg13_lv_pmos.sym} 10 -160 0 0 {name=MP1
l=0.13u
w=0.66u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_wire.sym} 30 -190 3 1 {name=p5 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 30 -90 3 0 {name=p6 sig_type=std_logic lab=net2}
C {sg13g2_pr/sg13_lv_nmos.sym} 70 0 0 0 {name=MN2
l=0.13u
w=0.795u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 90 30 3 0 {name=p7 sig_type=std_logic lab=VSS}
C {lab_wire.sym} 90 -80 3 0 {name=p8 sig_type=std_logic lab=net3}
C {sg13g2_pr/sg13_lv_pmos.sym} 130 -160 0 0 {name=MP2
l=0.13u
w=1.155u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_wire.sym} 150 -190 3 1 {name=p9 sig_type=std_logic lab=VDD}
C {opin.sym} 180 -80 0 0 {name=p10 lab=L_HI}

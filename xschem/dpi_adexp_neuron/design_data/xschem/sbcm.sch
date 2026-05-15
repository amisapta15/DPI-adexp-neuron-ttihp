v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 60 -230 60 -200 {lab=VDD}
N -80 -230 -80 -200 {lab=VDD}
N -80 -230 60 -230 {lab=VDD}
N -20 -170 20 -170 {lab=#net1}
N -80 0 -80 40 {lab=#net1}
N 60 -140 60 -60 {lab=#net2}
N -40 -170 -20 -170 {lab=#net1}
N 0 -30 20 -30 {lab=IREF}
N -80 -140 -80 -60 {lab=#net3}
N -20 -170 -20 40 {lab=#net1}
N -140 130 -140 160 {lab=IREF}
N -140 40 -140 60 {lab=#net1}
N -140 40 -80 40 {lab=#net1}
N -180 -230 -180 90 {lab=VDD}
N -180 -230 -80 -230 {lab=VDD}
N -80 40 -20 40 {lab=#net1}
N -140 120 -140 130 {lab=IREF}
N 0 -30 0 130 {lab=IREF}
N -40 -30 0 -30 {lab=IREF}
N -140 130 0 130 {lab=IREF}
N 60 0 60 150 {lab=ICOPY}
N -230 -230 -180 -230 {lab=VDD}
N -370 -220 -360 -220 {lab=VDD}
N -370 -190 -360 -190 {lab=GND}
C {sg13g2_pr/sg13_lv_pmos.sym} 40 -170 0 0 {name=M6
l=0.5u
w=15.0u
ng=5
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} -80 -170 0 0 {name=p8 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 60 -170 0 1 {name=p9 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} -60 -170 0 1 {name=M9
l=0.5u
w=15.0u
ng=5
m=10
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 40 -30 0 0 {name=M1
l=0.5u
w=15.0u
ng=5
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} -80 -30 0 0 {name=p1 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 60 -30 0 1 {name=p2 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} -60 -30 0 1 {name=M2
l=0.5u
w=15.0u
ng=5
m=10
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -160 90 0 0 {name=M23
l=0.5u
w=21.0u
ng=7
m=10
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} -140 90 0 1 {name=p4 sig_type=std_logic lab=GND}
C {iopin.sym} -370 -220 2 0 {name=p3 lab=VDD}
C {lab_pin.sym} -360 -220 2 0 {name=p5 sig_type=std_logic lab=VDD}
C {lab_pin.sym} -230 -230 0 0 {name=p6 sig_type=std_logic lab=VDD}
C {lab_pin.sym} -360 -190 0 1 {name=p7 sig_type=std_logic lab=GND}
C {iopin.sym} -370 -190 2 0 {name=p10 lab=GND}
C {iopin.sym} -140 160 2 0 {name=p11 lab=IREF}
C {iopin.sym} 60 150 2 0 {name=p12 lab=ICOPY}

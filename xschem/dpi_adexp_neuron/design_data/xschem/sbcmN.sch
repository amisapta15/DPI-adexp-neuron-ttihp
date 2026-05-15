v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -370 -210 -360 -210 {lab=GND}
N -20 -160 60 -160 {lab=#net1}
N -20 -10 70 -10 {lab=#net2}
N -130 -130 -130 -60 {lab=#net2}
N -130 -60 -110 -60 {lab=#net2}
N -110 -60 -110 -40 {lab=#net2}
N -110 20 -110 110 {lab=GND}
N -110 110 110 110 {lab=GND}
N 110 20 110 110 {lab=GND}
N 100 -130 100 -80 {lab=#net3}
N 110 -80 110 -40 {lab=#net3}
N 100 -80 110 -80 {lab=#net3}
N -130 -200 -130 -190 {lab=#net1}
N 100 -260 100 -190 {lab=ICOPY}
N -130 -200 -20 -200 {lab=#net1}
N -130 -220 -130 -200 {lab=#net1}
N -20 -200 -20 -160 {lab=#net1}
N -90 -160 -20 -160 {lab=#net1}
N -110 -60 -20 -60 {lab=#net2}
N -20 -60 -20 -10 {lab=#net2}
N -70 -10 -20 -10 {lab=#net2}
C {lab_pin.sym} -360 -210 0 1 {name=p7 sig_type=std_logic lab=GND}
C {iopin.sym} -370 -210 2 0 {name=p10 lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} -110 -160 0 1 {name=M3
l=0.5u
w=8.0u
ng=1
m=10
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 80 -160 0 0 {name=M4
l=0.5u
w=8.0u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -90 -10 0 1 {name=M5
l=0.5u
w=8.0u
ng=1
m=10
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 90 -10 0 0 {name=M7
l=0.5u
w=8.0u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} -10 110 1 1 {name=p13 sig_type=std_logic lab=GND}
C {lab_pin.sym} -110 -10 2 1 {name=p14 sig_type=std_logic lab=GND}
C {lab_pin.sym} -130 -160 2 1 {name=p15 sig_type=std_logic lab=GND}
C {lab_pin.sym} 100 -160 0 1 {name=p16 sig_type=std_logic lab=GND}
C {lab_pin.sym} 110 -10 0 1 {name=p17 sig_type=std_logic lab=GND}
C {iopin.sym} -130 -220 2 0 {name=p11 lab=IREF}
C {iopin.sym} 100 -260 0 0 {name=p12 lab=ICOPY}

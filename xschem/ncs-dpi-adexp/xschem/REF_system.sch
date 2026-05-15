v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 1 -410 -470 {}
N -10 -320 -10 -280 {lab=REQ}
N -50 -320 -50 -310 {lab=Vrefcap}
N -50 -330 -50 -320 {lab=Vrefcap}
N -220 -320 -50 -320 {lab=Vrefcap}
N -50 -250 -50 -170 {lab=#net1}
N -10 -140 40 -140 {lab=V_ref}
N -10 -320 100 -320 {lab=REQ}
N -10 -360 -10 -320 {lab=REQ}
N -10 -460 90 -460 {lab=ACK}
N -500 -430 -500 -350 {lab=V_mem}
N -260 -70 -50 -70 {lab=GND}
N -260 -70 -260 -50 {lab=GND}
N -500 -70 -260 -70 {lab=GND}
N -50 -430 -50 -390 {lab=#net2}
N -220 -360 -220 -320 {lab=Vrefcap}
N -460 -320 -220 -320 {lab=Vrefcap}
N -50 -540 -50 -490 {lab=VDD}
N -80 -460 -50 -460 {lab=VDD}
N -80 -360 -50 -360 {lab=VDD}
N -80 -280 -50 -280 {lab=GND}
N -50 -110 -50 -70 {lab=GND}
N -80 -140 -50 -140 {lab=GND}
N -500 -290 -500 -70 {lab=GND}
N -530 -320 -500 -320 {lab=GND}
N -980 -590 -980 -570 {lab=GND}
N -1010 -620 -980 -620 {lab=psub}
N -980 -590 -940 -590 {lab=GND}
N -940 -650 -940 -590 {lab=GND}
N -980 -650 -940 -650 {lab=GND}
N -840 -590 -840 -570 {lab=GND}
N -870 -620 -840 -620 {lab=psub}
N -840 -590 -800 -590 {lab=GND}
N -800 -650 -800 -590 {lab=GND}
N -840 -650 -800 -650 {lab=GND}
N -700 -590 -700 -570 {lab=GND}
N -730 -620 -700 -620 {lab=psub}
N -700 -590 -660 -590 {lab=GND}
N -660 -650 -660 -590 {lab=GND}
N -700 -650 -660 -650 {lab=GND}
C {sg13g2_pr/sg13_hv_pmos.sym} -30 -360 0 1 {name=M10
l=0.5u
w=1u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} -30 -280 0 1 {name=M11
l=0.5u
w=1u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} -30 -460 0 1 {name=M12
l=0.5u
w=1u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} -480 -320 0 1 {name=M13
l=0.5u
w=1u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} -30 -140 0 1 {name=M14
l=4u
w=4u
ng=2
m=4
model=sg13_hv_nmos
spiceprefix=X
}
C {iopin.sym} -50 -540 0 0 {name=p1 lab=VDD}
C {iopin.sym} -260 -50 0 0 {name=p2 lab=GND}
C {ipin.sym} 40 -140 0 1 {name=p3 lab=V_ref}
C {ipin.sym} 100 -320 0 1 {name=p4 lab=REQ}
C {ipin.sym} 90 -460 0 1 {name=p5 lab=ACK}
C {ipin.sym} -500 -430 0 0 {name=p6 lab=V_mem}
C {opin.sym} -220 -360 0 0 {name=p7 lab=Vrefcap}
C {lab_wire.sym} -60 -460 0 0 {name=p8 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -60 -360 0 0 {name=p9 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -60 -280 0 0 {name=p10 sig_type=std_logic lab=GND}
C {lab_wire.sym} -60 -140 0 0 {name=p11 sig_type=std_logic lab=GND}
C {lab_wire.sym} -510 -320 0 0 {name=p12 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_hv_nmos.sym} -960 -620 0 1 {name=Mdum3
l=4u
w=2u
ng=4
m=2
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} -1010 -620 0 0 {name=p18 sig_type=std_logic lab=GND}
C {lab_wire.sym} -980 -570 0 0 {name=p19 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_hv_nmos.sym} -820 -620 0 1 {name=Mdum4
l=3u
w=0.5u
ng=1
m=4
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} -870 -620 0 0 {name=p20 sig_type=std_logic lab=GND}
C {lab_wire.sym} -840 -570 0 0 {name=p21 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_hv_nmos.sym} -680 -620 0 1 {name=Mdum5
l=3u
w=2u
ng=1
m=4
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} -730 -620 0 0 {name=p22 sig_type=std_logic lab=GND}
C {lab_wire.sym} -700 -570 0 0 {name=p23 sig_type=std_logic lab=GND}

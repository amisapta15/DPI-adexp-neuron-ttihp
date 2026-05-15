v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 350 -310 350 -290 {lab=I_in}
N 540 -310 540 -290 {lab=I_in}
N 450 -310 540 -310 {lab=I_in}
N 580 -260 580 -230 {lab=V_mem}
N 540 -230 580 -230 {lab=V_mem}
N 350 -310 450 -310 {lab=I_in}
N 450 -360 450 -310 {lab=I_in}
N 445 -70 540 -70 {lab=GND}
N 350 -230 350 -70 {lab=GND}
N 580 -130 620 -130 {lab=V_lk}
N 580 -260 690 -260 {lab=V_mem}
N 270 -260 310 -260 {lab=V_lk}
N 445 -70 445 -45 {lab=GND}
N 350 -70 445 -70 {lab=GND}
N 540 -230 540 -160 {lab=V_mem}
N -220 -170 -220 -160 {lab=VDD}
N 540 -100 540 -70 {lab=GND}
N 510 -130 540 -130 {lab=GND}
N 350 -260 380 -260 {lab=nwell}
N 510 -260 540 -260 {lab=nwell}
N -210 -510 -180 -510 {lab=nwell}
N -250 -540 -250 -480 {lab=VDD}
N -250 -540 -210 -540 {lab=VDD}
N -210 -560 -210 -540 {lab=VDD}
N -250 -480 -210 -480 {lab=VDD}
N -70 -510 -40 -510 {lab=nwell}
N -110 -540 -70 -540 {lab=VDD}
N -70 -560 -70 -540 {lab=VDD}
N -110 -540 -110 -510 {lab=VDD}
N -70 -480 -70 -460 {lab=I_in}
N -210 -360 -210 -340 {lab=GND}
N -240 -390 -210 -390 {lab=GND}
N -210 -360 -170 -360 {lab=GND}
N -170 -420 -170 -360 {lab=GND}
N -210 -420 -170 -420 {lab=GND}
N -70 -360 -70 -340 {lab=GND}
N -100 -390 -70 -390 {lab=GND}
N -70 -360 -30 -360 {lab=GND}
N -30 -420 -30 -360 {lab=GND}
N -70 -420 -30 -420 {lab=GND}
N 70 -360 70 -340 {lab=GND}
N 40 -390 70 -390 {lab=GND}
N 70 -360 110 -360 {lab=GND}
N 110 -420 110 -360 {lab=GND}
N 70 -420 110 -420 {lab=GND}
C {sg13g2_pr/sg13_hv_pmos.sym} 330 -260 0 0 {name=Mdifl
l=2u
w=2u
ng=2
m=8
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 560 -260 0 1 {name=Mdifr
l=2u
w=2u
ng=2
m=8
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 560 -130 0 1 {name=Mtau
l=4u
w=4u
ng=2
m=4
model=sg13_hv_nmos
spiceprefix=X
}
C {opin.sym} 690 -260 0 0 {name=p1 lab=V_mem}
C {ipin.sym} 620 -130 0 1 {name=p2 lab=V_lk}
C {ipin.sym} 450 -360 0 1 {name=p4 lab=I_in}
C {iopin.sym} -220 -170 1 1 {name=p5 lab=VDD}
C {iopin.sym} 445 -45 0 0 {name=p6 lab=GND}
C {lab_wire.sym} 280 -260 0 0 {name=p3 sig_type=std_logic lab=V_lk}
C {lab_wire.sym} 380 -260 0 1 {name=p8 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 510 -130 0 0 {name=p9 sig_type=std_logic lab=GND}
C {lab_wire.sym} 510 -260 0 0 {name=p12 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_hv_pmos.sym} -230 -510 0 0 {name=Mdum1
l=2u
w=5u
ng=10
m=2
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} -180 -510 0 1 {name=p13 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -210 -560 0 0 {name=p14 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_hv_pmos.sym} -90 -510 0 0 {name=Mdum2
l=2u
w=1u
ng=1
m=8
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} -40 -510 0 1 {name=p15 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -70 -560 0 0 {name=p16 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -70 -460 0 0 {name=p17 sig_type=std_logic lab=I_in}
C {sg13g2_pr/sg13_hv_nmos.sym} -190 -390 0 1 {name=Mdum3
l=4u
w=2u
ng=4
m=2
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} -240 -390 0 0 {name=p18 sig_type=std_logic lab=GND}
C {lab_wire.sym} -210 -340 0 0 {name=p19 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_hv_nmos.sym} -50 -390 0 1 {name=Mdum4
l=3u
w=0.5u
ng=1
m=4
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} -100 -390 0 0 {name=p20 sig_type=std_logic lab=GND}
C {lab_wire.sym} -70 -340 0 0 {name=p21 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_hv_nmos.sym} 90 -390 0 1 {name=Mdum5
l=3u
w=2u
ng=1
m=4
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} 40 -390 0 0 {name=p22 sig_type=std_logic lab=GND}
C {lab_wire.sym} 70 -340 0 0 {name=p23 sig_type=std_logic lab=GND}

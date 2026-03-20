v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -210 -620 -180 -620 {lab=VDD}
N -210 -580 -180 -580 {lab=VSS}
N 10 -520 10 -430 {lab=IN}
N 70 -520 70 -430 {lab=OUT}
N -210 -540 -180 -540 {lab=SEL}
N -90 -520 10 -520 {lab=IN}
N 10 -620 10 -520 {lab=IN}
N 70 -520 230 -520 {lab=OUT}
N 70 -620 70 -520 {lab=OUT}
N 40 -390 40 -350 {lab=SEL}
N -20 -660 40 -660 {lab=selbar}
N -160 -430 -130 -430 {lab=selbar}
N -330 -430 -290 -430 {lab=SEL}
N -230 -500 -230 -480 {lab=VDD}
N -230 -380 -230 -360 {lab=VSS}
N -20 -350 40 -350 {lab=SEL}
N 420 -650 420 -620 {lab=VDD}
N 420 -560 420 -540 {lab=nwell}
N 420 -510 420 -490 {lab=VSS}
N 420 -430 420 -400 {lab=pwell}
N 260 -720 260 -690 {lab=VDD}
N 220 -630 260 -630 {lab=VDD}
N 220 -690 220 -630 {lab=VDD}
N 220 -690 260 -690 {lab=VDD}
N 220 -410 260 -410 {lab=VSS}
N 220 -410 220 -350 {lab=VSS}
N 220 -350 260 -350 {lab=VSS}
N 260 -350 260 -310 {lab=VSS}
N 260 -380 320 -380 {lab=pwell}
N 260 -660 320 -660 {lab=nwell}
N 40 -620 40 -580 {lab=nwell}
N 40 -460 40 -430 {lab=pwell}
C {ipin.sym} -90 -520 0 0 {name=p2 lab=IN}
C {iopin.sym} -210 -620 2 0 {name=p1 lab=VDD}
C {iopin.sym} -210 -580 2 0 {name=p3 lab=VSS}
C {opin.sym} 230 -520 0 0 {name=p4 lab=OUT}
C {lab_pin.sym} -180 -620 2 0 {name=p5 sig_type=std_logic lab=VDD}
C {lab_pin.sym} -180 -580 2 0 {name=p6 sig_type=std_logic lab=VSS}
C {ipin.sym} -210 -540 0 0 {name=p7 lab=SEL}
C {lab_pin.sym} -180 -540 2 0 {name=p9 sig_type=std_logic lab=SEL}
C {lab_pin.sym} -20 -350 0 0 {name=p21 sig_type=std_logic lab=SEL}
C {lab_pin.sym} -130 -430 2 0 {name=p11 sig_type=std_logic lab=selbar}
C {inv_lv.sym} -240 -430 0 0 {name=x1}
C {lab_pin.sym} -230 -500 2 0 {name=p8 sig_type=std_logic lab=VDD}
C {lab_pin.sym} -230 -360 2 0 {name=p10 sig_type=std_logic lab=VSS}
C {lab_pin.sym} -330 -430 0 0 {name=p14 sig_type=std_logic lab=SEL}
C {lab_pin.sym} -20 -660 0 0 {name=p15 sig_type=std_logic lab=selbar}
C {sg13g2_pr/sg13_lv_nmos.sym} 40 -410 3 0 {name=M3
l=0.15u
w=8u
ng=8
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 40 -640 1 0 {name=M4
l=0.15u
w=8u
ng=8
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 240 -660 0 0 {name=Mdumm1
l=0.15u
w=1u
ng=1
m=2
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 240 -380 0 0 {name=Mdumm2
l=0.15u
w=1u
ng=1
m=2
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/ntap1.sym} 420 -590 0 0 {name=R1
model=ntap1
spiceprefix=X
w=12.64e-6
l=5.11e-6
}
C {sg13g2_pr/ptap1.sym} 420 -460 0 0 {name=R2
model=ptap1
spiceprefix=X
w=11.96e-6
l=5.15e-6
}
C {lab_pin.sym} 420 -540 2 0 {name=p16 sig_type=std_logic lab=nwell}
C {lab_pin.sym} 420 -650 2 0 {name=p17 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 420 -400 2 0 {name=p18 sig_type=std_logic lab=pwell}
C {lab_pin.sym} 420 -510 2 0 {name=p19 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 40 -580 3 0 {name=p12 sig_type=std_logic lab=nwell}
C {lab_pin.sym} 40 -460 1 0 {name=p20 sig_type=std_logic lab=pwell}
C {lab_pin.sym} 260 -720 2 0 {name=p13 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 260 -310 2 0 {name=p22 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 320 -660 2 0 {name=p23 sig_type=std_logic lab=nwell}
C {lab_pin.sym} 320 -380 2 0 {name=p24 sig_type=std_logic lab=pwell}

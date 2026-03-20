v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -240 -680 -210 -680 {lab=VDD}
N -240 -640 -210 -640 {lab=VSS}
N 10 -520 10 -430 {lab=IN}
N 70 -520 70 -430 {lab=OUT}
N -240 -600 -210 -600 {lab=SEL}
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
N 200 -660 200 -630 {lab=VDD}
N 160 -570 200 -570 {lab=VDD}
N 160 -630 160 -570 {lab=VDD}
N 160 -630 200 -630 {lab=VDD}
N 150 -480 190 -480 {lab=VSS}
N 150 -480 150 -420 {lab=VSS}
N 150 -420 190 -420 {lab=VSS}
N 190 -420 190 -380 {lab=VSS}
N 190 -450 250 -450 {lab=VSS}
N 200 -600 260 -600 {lab=VDD}
N 40 -620 40 -580 {lab=VDD}
N 40 -460 40 -430 {lab=VSS}
C {ipin.sym} -90 -520 0 0 {name=p2 lab=IN}
C {iopin.sym} -240 -680 2 0 {name=p1 lab=VDD}
C {iopin.sym} -240 -640 2 0 {name=p3 lab=VSS}
C {iopin.sym} 230 -520 0 0 {name=p4 lab=OUT}
C {lab_pin.sym} -210 -680 2 0 {name=p5 sig_type=std_logic lab=VDD}
C {lab_pin.sym} -210 -640 2 0 {name=p6 sig_type=std_logic lab=VSS}
C {ipin.sym} -240 -600 0 0 {name=p7 lab=SEL}
C {lab_pin.sym} -210 -600 2 0 {name=p9 sig_type=std_logic lab=SEL}
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
C {sg13g2_pr/sg13_lv_pmos.sym} 180 -600 0 0 {name=Mdumm1
l=0.15u
w=1u
ng=1
m=2
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 170 -450 0 0 {name=Mdumm2
l=0.15u
w=1u
ng=1
m=2
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 40 -580 3 0 {name=p12 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 40 -460 1 0 {name=p20 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 200 -660 2 0 {name=p13 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 190 -380 2 0 {name=p22 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 260 -600 2 0 {name=p23 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 250 -450 2 0 {name=p24 sig_type=std_logic lab=VSS}

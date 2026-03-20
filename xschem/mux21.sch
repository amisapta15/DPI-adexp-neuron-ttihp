v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 65 -330 95 -330 {lab=VDD}
N 65 -290 95 -290 {lab=VSS}
N 65 -250 95 -250 {lab=IN0}
N 65 -220 95 -220 {lab=IN1}
N 65 -185 95 -185 {lab=SEL0}
N 65 -150 95 -150 {lab=SEL1}
N 65 -120 95 -120 {lab=OUT}
N 385 -265 425 -265 {lab=OUT}
N 385 -350 385 -265 {lab=OUT}
N 220 -320 255 -320 {lab=SEL0}
N 225 -350 255 -350 {lab=IN0}
N 225 -105 255 -105 {lab=IN1}
N 225 -75 255 -75 {lab=SEL1}
N 320 -425 320 -410 {lab=VDD}
N 320 -295 320 -270 {lab=VSS}
N 320 -175 320 -165 {lab=VDD}
N 320 -50 320 -30 {lab=VSS}
N 385 -265 385 -105 {lab=OUT}
C {lab_pin.sym} 425 -265 0 1 {name=p2 sig_type=std_logic lab=OUT}
C {lab_pin.sym} 225 -350 2 1 {name=p5 sig_type=std_logic lab=IN0}
C {lab_pin.sym} 220 -320 2 1 {name=p7 sig_type=std_logic lab=SEL0}
C {tg_lv.sym} 365 -350 0 0 {name=x1}
C {tg_lv.sym} 365 -105 0 0 {name=x2}
C {lab_pin.sym} 225 -105 2 1 {name=p1 sig_type=std_logic lab=IN1
}
C {lab_pin.sym} 225 -75 2 1 {name=p3 sig_type=std_logic lab=SEL1}
C {iopin.sym} 65 -330 2 0 {name=p4 lab=VDD}
C {iopin.sym} 65 -290 2 0 {name=p6 lab=VSS}
C {lab_pin.sym} 95 -330 2 0 {name=p8 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 95 -290 2 0 {name=p9 sig_type=std_logic lab=VSS}
C {ipin.sym} 65 -250 0 0 {name=p10 lab=IN0}
C {lab_pin.sym} 95 -250 2 0 {name=p11 sig_type=std_logic lab=IN0}
C {ipin.sym} 65 -220 0 0 {name=p12 lab=IN1}
C {lab_pin.sym} 95 -220 2 0 {name=p13 sig_type=std_logic lab=IN1}
C {ipin.sym} 65 -185 0 0 {name=p14 lab=SEL0}
C {lab_pin.sym} 95 -185 2 0 {name=p15 sig_type=std_logic lab=SEL0}
C {ipin.sym} 65 -150 0 0 {name=p16 lab=SEL1}
C {lab_pin.sym} 95 -150 2 0 {name=p17 sig_type=std_logic lab=SEL1}
C {opin.sym} 95 -120 0 0 {name=p18 lab=OUT}
C {lab_pin.sym} 65 -120 0 0 {name=p19 sig_type=std_logic lab=OUT}
C {lab_pin.sym} 320 -425 1 0 {name=p20 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 320 -175 1 0 {name=p21 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 320 -270 2 0 {name=p22 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 320 -30 2 0 {name=p23 sig_type=std_logic lab=VSS}

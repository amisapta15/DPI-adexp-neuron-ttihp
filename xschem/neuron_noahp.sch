v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 390 -240 390 -180 {lab=VDD}
N 390 -80 390 -30 {lab=GND}
N -40 -130 -10 -130 {lab=Vmem}
N 550 260 720 260 {lab=REQ}
N 190 280 250 280 {lab=V_ref}
N 720 80 720 260 {lab=REQ}
N -40 250 250 250 {lab=Vmem}
N -40 60 -40 250 {lab=Vmem}
N 550 230 580 230 {lab=ACK}
N 720 80 750 80 {lab=REQ}
N 720 -130 720 80 {lab=REQ}
N -550 -150 -510 -150 {lab=I_in}
N -100 -130 -100 -110 {lab=Vmem}
N -100 -130 -40 -130 {lab=Vmem}
N -210 -130 -100 -130 {lab=Vmem}
N -360 -230 -360 -180 {lab=VDD}
N -360 -80 -360 -20 {lab=GND}
N -550 -110 -510 -110 {lab=V_lk}
N -40 60 -20 60 {lab=Vmem}
N -40 -130 -40 60 {lab=Vmem}
N 140 -230 140 -190 {lab=VDD}
N 140 -70 140 -10 {lab=GND}
N 580 290 580 310 {lab=Vrefcap}
N 550 290 580 290 {lab=Vrefcap}
N 580 370 580 430 {lab=GND}
N 580 290 620 290 {lab=Vrefcap}
N 400 160 400 200 {lab=VDD}
N -490 -440 -460 -440 {lab=VDD}
N -490 -400 -460 -400 {lab=GND}
N 380 320 380 380 {lab=GND}
N -100 -50 -100 10 {lab=GND}
N 600 -240 600 -180 {lab=VDD}
N 600 -80 600 -30 {lab=GND}
N 670 -130 720 -130 {lab=REQ}
N 460 -130 540 -130 {lab=#net1}
N 290 -130 330 -130 {lab=Vfb}
C {inv.sym} 480 -130 0 0 {name=Xinv1}
C {inv.sym} 690 -130 0 0 {name=Xinv2}
C {DPI.sym} -360 -130 0 0 {name=Xdpi1}
C {FB_system.sym} 140 -130 0 0 {name=Xfb}
C {REF_system.sym} 400 260 0 0 {name=Xref}
C {ipin.sym} 190 280 0 0 {name=p1 lab=V_ref}
C {iopin.sym} -490 -400 2 0 {name=p2 lab=GND}
C {iopin.sym} -490 -440 2 0 {name=p3 lab=VDD}
C {opin.sym} 750 80 0 0 {name=p4 lab=REQ}
C {ipin.sym} 580 230 0 1 {name=p5 lab=ACK}
C {ipin.sym} -550 -150 0 0 {name=p6 lab=I_in
}
C {ipin.sym} -550 -110 0 0 {name=p8 lab=V_lk
}
C {opin.sym} -20 60 0 0 {name=p13 lab=Vmem}
C {lab_wire.sym} 320 -130 0 0 {name=p14 sig_type=std_logic lab=Vfb}
C {opin.sym} 620 290 0 0 {name=p7 lab=Vrefcap}
C {lab_wire.sym} 400 190 3 1 {name=p11 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -360 -200 3 1 {name=p12 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 140 -200 3 1 {name=p15 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 390 -210 3 1 {name=p16 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -360 -60 3 0 {name=p18 sig_type=std_logic lab=GND}
C {lab_wire.sym} 380 340 3 0 {name=p21 sig_type=std_logic lab=GND}
C {lab_wire.sym} 140 -50 3 0 {name=p9 sig_type=std_logic lab=GND}
C {lab_wire.sym} 390 -70 3 0 {name=p27 sig_type=std_logic lab=GND}
C {lab_wire.sym} 580 390 3 0 {name=p29 sig_type=std_logic lab=GND}
C {lab_wire.sym} -100 -30 3 0 {name=p30 sig_type=std_logic lab=GND}
C {sg13g2_pr/cap_cmim.sym} -100 -80 2 0 {name=Cmem
model=cap_cmim
w=44.4e-6
l=15e-6
m=1
spiceprefix=X}
C {sg13g2_pr/cap_cmim.sym} 580 340 2 0 {name=Cref
model=cap_cmim
w=22.1e-6
l=15e-6
m=1
spiceprefix=X}
C {lab_wire.sym} 600 -210 3 1 {name=p17 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 600 -70 3 0 {name=p28 sig_type=std_logic lab=GND}

v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 400 -230 400 -170 {lab=VDD}
N 400 -90 400 -20 {lab=GND}
N 480 -130 550 -130 {lab=#net1}
N 610 -230 610 -170 {lab=VDD}
N 610 -90 610 -20 {lab=GND}
N 290 -130 340 -130 {lab=Vfb}
N -40 -130 -10 -130 {lab=Vmem}
N 400 -20 610 -20 {lab=GND}
N 140 -20 400 -20 {lab=GND}
N 720 160 720 260 {lab=REQ}
N 690 -130 720 -130 {lab=REQ}
N 550 260 720 260 {lab=REQ}
N 550 300 610 300 {lab=V_ref}
N 140 -230 140 -180 {lab=VDD}
N 290 -230 400 -230 {lab=VDD}
N 520 -230 610 -230 {lab=VDD}
N -130 -230 140 -230 {lab=VDD}
N 400 100 400 200 {lab=VDD}
N 400 100 520 100 {lab=VDD}
N 520 -230 520 100 {lab=VDD}
N 400 -230 520 -230 {lab=VDD}
N -350 70 -350 140 {lab=VDD}
N -350 70 -130 70 {lab=VDD}
N -130 -230 -130 70 {lab=VDD}
N 720 80 720 160 {lab=REQ}
N 100 -20 100 380 {lab=GND}
N 100 380 400 380 {lab=GND}
N 70 380 100 380 {lab=GND}
N -40 230 250 230 {lab=Vmem}
N -40 60 -40 230 {lab=Vmem}
N 290 -300 290 -230 {lab=VDD}
N 140 -230 290 -230 {lab=VDD}
N 70 380 70 460 {lab=GND}
N 550 230 580 230 {lab=ACK}
N 720 80 750 80 {lab=REQ}
N 720 -130 720 80 {lab=REQ}
N -530 -170 -530 20 {lab=I_in}
N -550 -170 -530 -170 {lab=I_in}
N -530 20 -150 20 {lab=I_in}
N -550 250 -500 250 {lab=V_lkahp}
N -550 210 -500 210 {lab=V_thrahp}
N -550 160 -500 160 {lab=V_adapt}
N -100 -130 -100 -110 {lab=Vmem}
N -100 -130 -40 -130 {lab=Vmem}
N -100 -50 -100 380 {lab=GND}
N -100 380 70 380 {lab=GND}
N -210 -130 -100 -130 {lab=Vmem}
N -350 380 -100 380 {lab=GND}
N -360 -230 -130 -230 {lab=VDD}
N -360 -230 -360 -180 {lab=VDD}
N -360 -80 -360 -20 {lab=GND}
N -360 -20 100 -20 {lab=GND}
N -510 -170 -510 -150 {lab=I_in}
N -530 -170 -510 -170 {lab=I_in}
N -550 -130 -510 -130 {lab=V_th}
N -510 -110 -510 -100 {lab=V_lk}
N -550 -100 -510 -100 {lab=V_lk}
N -10 -130 -10 -120 {lab=Vmem}
N 140 -60 140 -20 {lab=GND}
N 100 -20 140 -20 {lab=GND}
N -500 160 -500 190 {lab=V_adapt}
N -500 210 -500 230 {lab=V_thrahp}
N -350 280 -350 380 {lab=GND}
N 400 320 400 380 {lab=GND}
N 550 290 550 300 {lab=V_ref}
N 250 230 250 250 {lab=Vmem}
N -170 160 720 160 {lab=REQ}
N -170 160 -170 170 {lab=REQ}
N -200 170 -170 170 {lab=REQ}
N -150 20 -150 190 {lab=I_in}
N -200 190 -150 190 {lab=I_in}
N -200 220 -170 220 {lab=CapAdap}
N -40 60 -20 60 {lab=Vmem}
N -40 -130 -40 60 {lab=Vmem}
C {inv.sym} 480 -130 0 0 {name=Xinv1}
C {inv.sym} 690 -130 0 0 {name=Xinv2}
C {DPI.sym} -360 -130 0 0 {name=Xdpi1}
C {FB_system.sym} 140 -120 0 0 {name=Xfb}
C {ADAP_system.sym} -350 210 0 0 {name=Xadap}
C {REF_system.sym} 400 260 0 0 {name=Xref}
C {ipin.sym} 610 300 0 1 {name=p1 lab=V_ref}
C {iopin.sym} 70 460 0 0 {name=p2 lab=GND}
C {iopin.sym} 290 -300 0 0 {name=p3 lab=VDD}
C {opin.sym} 750 80 0 0 {name=p4 lab=REQ}
C {ipin.sym} 580 230 0 1 {name=p5 lab=ACK}
C {ipin.sym} -550 -170 0 0 {name=p6 lab=I_in
}
C {ipin.sym} -550 -130 0 0 {name=p7 lab=V_th
}
C {ipin.sym} -550 -100 0 0 {name=p8 lab=V_lk
}
C {ipin.sym} -550 160 0 0 {name=p9 lab=V_adapt
}
C {ipin.sym} -550 210 0 0 {name=p10 lab=V_thrahp
}
C {ipin.sym} -550 250 0 0 {name=p11 lab=V_lkahp
}
C {capa.sym} -100 -80 0 0 {name=Cmem
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {opin.sym} -170 220 0 0 {name=p12 lab=CapAdap}
C {opin.sym} -20 60 0 0 {name=p13 lab=Vmem}
C {lab_wire.sym} 320 -130 0 0 {name=p14 sig_type=std_logic lab=Vfb}

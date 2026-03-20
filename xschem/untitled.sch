v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -30 -120 -30 -70 {lab=VDD}
N -220 20 -170 20 {lab=I_ref}
N 440 0 470 0 {lab=#net1}
N 610 0 640 0 {lab=ACK}
N -210 40 -170 40 {lab=ACK}
N 530 40 530 100 {lab=GND}
N 360 40 360 100 {lab=GND}
N 130 0 300 0 {lab=REQ}
N 130 -20 180 -20 {lab=Vmem}
N -10 -90 -10 -70 {lab=GND}
N 450 100 530 100 {lab=GND}
N -210 40 -210 140 {lab=ACK}
N -210 140 640 140 {lab=ACK}
N -220 0 -170 0 {lab=I_lk}
N -460 -140 -460 -110 {lab=VDD}
N -460 30 -460 60 {lab=GND}
N -610 -70 -540 -70 {lab=in_VI}
N -610 -10 -540 -10 {lab=cm_VI}
N -480 -140 -480 -110 {lab=bias_VPI}
N -350 -40 -170 -40 {lab=I_in}
N 130 20 180 20 {lab=Vrefcap}
N 360 -70 360 -40 {lab=VDD}
N 530 -70 530 -40 {lab=VDD}
N 450 100 450 180 {lab=GND}
N 360 100 450 100 {lab=GND}
N 640 0 640 140 {lab=ACK}
C {neuron_noahp.sym} -20 30 0 0 {name=Xneuron}
C {vdd.sym} -30 -120 0 0 {name=l1 lab=VDD}
C {gnd.sym} 450 180 0 0 {name=l2 lab=GND}
C {lab_pin.sym} 640 110 2 1 {name=p9 sig_type=std_logic lab=ACK}
C {inv.sym} 440 0 0 0 {name=Xinv3}
C {inv.sym} 610 0 0 0 {name=Xinv4}
C {lab_wire.sym} -10 -80 0 1 {name=p6 sig_type=std_logic lab=GND}
C {lab_pin.sym} -220 20 0 0 {name=p1 sig_type=std_logic lab=I_ref}
C {lab_pin.sym} -220 0 0 0 {name=p4 sig_type=std_logic lab=I_lk}
C {V2I_shift_final.sym} -480 100 0 0 {name=xv2i}
C {vdd.sym} -460 -140 0 0 {name=l5 lab=VDD}
C {lab_wire.sym} -200 -40 0 0 {name=p2 sig_type=std_logic lab=I_in}
C {gnd.sym} -460 60 0 0 {name=l10 lab=GND}
C {vdd.sym} 360 -70 0 0 {name=l21 lab=VDD}
C {vdd.sym} 530 -70 0 0 {name=l22 lab=VDD}
C {lab_wire.sym} 220 0 0 0 {name=p10 sig_type=std_logic lab=REQ}
C {lab_wire.sym} 180 -20 0 0 {name=p12 sig_type=std_logic lab=Vmem}
C {lab_wire.sym} 180 20 0 0 {name=p20 sig_type=std_logic lab=Vrefcap}
C {ipin.sym} -610 -70 0 0 {name=p3 lab=in_VI}
C {ipin.sym} -610 -10 0 0 {name=p5 lab=cm_VI}
C {ipin.sym} -480 -140 1 0 {name=p7 lab=bias_VPI}

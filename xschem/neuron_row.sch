v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -30 -90 -30 -70 {lab=VDD}
N -220 20 -170 20 {lab=ref_VNI}
N 130 0 180 0 {lab=req_VABO}
N 130 -20 180 -20 {lab=mem_VNTO}
N -10 -90 -10 -70 {lab=GND}
N -220 0 -170 0 {lab=tau_VNI}
N -460 -140 -460 -110 {lab=VDD}
N -460 30 -460 60 {lab=GND}
N -610 -70 -540 -70 {lab=in_VI}
N -610 -10 -540 -10 {lab=cm_VI}
N -480 -140 -480 -110 {lab=bias_VPI}
N -350 -40 -170 -40 {lab=I_in}
N 130 20 180 20 {lab=refcap_VTO}
N -690 -320 -660 -320 {lab=VDD}
N -690 -290 -660 -290 {lab=GND}
N -220 40 -170 40 {lab=ack_VABI}
C {neuron_noahp.sym} -20 30 0 0 {name=Xneuron}
C {lab_wire.sym} -10 -90 3 1 {name=p6 sig_type=std_logic lab=GND}
C {V2I.sym} -480 100 0 0 {name=xv2i}
C {lab_wire.sym} -200 -40 0 0 {name=p2 sig_type=std_logic lab=I_in}
C {ipin.sym} -610 -70 0 0 {name=p3 lab=in_VI}
C {ipin.sym} -610 -10 0 0 {name=p5 lab=cm_VI}
C {ipin.sym} -480 -140 1 0 {name=p7 lab=bias_VPI}
C {iopin.sym} -690 -320 2 0 {name=p8 lab=VDD}
C {lab_wire.sym} -460 -130 1 0 {name=p11 sig_type=std_logic lab=VDD}
C {iopin.sym} -690 -290 2 0 {name=p13 lab=GND}
C {lab_wire.sym} -460 40 3 0 {name=p14 sig_type=std_logic lab=GND}
C {lab_wire.sym} -30 -90 3 1 {name=p15 sig_type=std_logic lab=VDD}
C {opin.sym} 180 -20 0 0 {name=p25 lab=mem_VNTO}
C {opin.sym} 180 0 0 0 {name=p10 lab=req_VABO}
C {opin.sym} 180 20 0 0 {name=p12 lab=refcap_VTO}
C {ipin.sym} -220 0 0 0 {name=p4 lab=tau_VNI}
C {ipin.sym} -220 20 0 0 {name=p1 lab=ref_VNI}
C {ipin.sym} -220 40 0 0 {name=p9 lab=ack_VABI}

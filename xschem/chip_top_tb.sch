v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 5 -220 -650 800 -650 800 -300 -220 -300 -220 -650 {}
N 510 -600 510 -580 {lab=VDD}
N 510 -520 510 -480 {lab=NN_tau_VNI}
N -180 -550 -180 -530 {lab=#net1}
N 680 -600 680 -580 {lab=VDD}
N 680 -520 680 -480 {lab=NN_ref_VNI}
N 510 -440 510 -380 {lab=GND}
N 550 -440 560 -440 {lab=NN_tau_VNI}
N 560 -480 560 -440 {lab=NN_tau_VNI}
N 510 -480 560 -480 {lab=NN_tau_VNI}
N 510 -480 510 -470 {lab=NN_tau_VNI}
N 680 -440 680 -380 {lab=GND}
N 720 -440 730 -440 {lab=NN_ref_VNI}
N 730 -480 730 -440 {lab=NN_ref_VNI}
N 680 -480 730 -480 {lab=NN_ref_VNI}
N 680 -480 680 -470 {lab=NN_ref_VNI}
N 510 -380 560 -380 {lab=GND}
N 680 -380 730 -380 {lab=GND}
N 510 -380 510 -360 {lab=GND}
N 680 -380 680 -360 {lab=GND}
N 330 -490 330 -450 {lab=V2I_bias_VPI}
N 380 -530 380 -490 {lab=V2I_bias_VPI}
N 370 -530 380 -530 {lab=V2I_bias_VPI}
N 330 -490 380 -490 {lab=V2I_bias_VPI}
N 330 -500 330 -490 {lab=V2I_bias_VPI}
N 330 -590 380 -590 {lab=VDD}
N 330 -590 330 -560 {lab=VDD}
N 330 -600 330 -590 {lab=VDD}
N 330 -390 330 -360 {lab=GND}
N 310 -530 330 -530 {lab=VDD}
N 150 -370 150 -350 {lab=GND}
N 150 -460 150 -430 {lab=V2I_cm_VI}
N 150 -520 150 -500 {lab=GND}
N 150 -610 150 -580 {lab=V2I_in_VI}
N 1070 200 1130 200 {lab=BUF_prob_VX1O}
N 1130 200 1130 220 {lab=BUF_prob_VX1O}
N 1130 280 1130 300 {lab=GND}
N 910 -40 1030 -40 {lab=NN_req_VABO[10:0]}
N 1350 20 1350 50 {lab=GND}
N 1090 20 1090 50 {lab=GND}
N 1090 -100 1090 -90 {lab=VDD}
N 1350 -100 1350 -90 {lab=VDD}
N 1420 -40 1460 -40 {lab=NN_ack_VABI[10:0]}
N 260 90 260 140 {lab=VDD}
N 280 90 280 140 {lab=GND}
N 350 320 350 370 {lab=V2I_in_VI,V2I_bias_VPI,V2I_cm_VI,NN_tau_VNI,NN_ref_VNI,BUF_prob_VX1O}
N 320 100 320 140 {lab=IO_config_VS[7:0]}
N 340 100 340 140 {lab=NN_req_VABO[10:8],uio_out[4:0]}
N 360 100 360 140 {lab=NN_req_VABO[7:0]}
N 380 100 380 140 {lab=3*GND,NN_ack_VABI[10:8],MUX_sel1_VSI,MUX_sel0_VSI}
N 400 100 400 140 {lab=NN_ack_VABI[7:0]}
N 610 200 650 200 {lab=uio_out[4:0]}
N -30 -370 -30 -350 {lab=GND}
N -30 -460 -30 -430 {lab=MUX_sel1_VSI}
N -30 -530 -30 -510 {lab=GND}
N -30 -620 -30 -590 {lab=MUX_sel0_VSI}
N 1160 -40 1290 -40 {lab=NN_req_VA[10:0]}
N 1090 -100 1120 -100 {lab=VDD}
N 1090 -120 1090 -100 {lab=VDD}
N 1120 -100 1120 -70 {lab=VDD}
N 1090 20 1120 20 {lab=GND}
N 1090 10 1090 20 {lab=GND}
N 1120 -10 1120 20 {lab=GND}
N 1350 -100 1380 -100 {lab=VDD}
N 1350 -120 1350 -100 {lab=VDD}
N 1380 -100 1380 -70 {lab=VDD}
N 1350 20 1380 20 {lab=GND}
N 1350 10 1350 20 {lab=GND}
N 1380 -10 1380 20 {lab=GND}
C {simulator_commands_shown.sym} 930 -1070 0 0 {name=example_Simulator1
simulator=ngspice
only_toplevel=false 
value="
.param temp=27

.ic V(NN_req_VABO[10])=1.2 V(NN_req_VABO[9])=1.2 V(NN_req_VABO[8])=1.2
+V(NN_req_VABO[7])=1.2 V(NN_req_VABO[6])=1.2 V(NN_req_VABO[5])=1.2
+V(NN_req_VABO[4])=1.2 V(NN_req_VABO[3])=1.2 V(NN_req_VABO[2])=1.2
+V(NN_req_VABO[1])=1.2 V(NN_req_VABO[0])=1.2
.ic V(NN_ack_VABI[10])=1.2 V(NN_ack_VABI[9])=1.2 V(NN_ack_VABI[8])=1.2
+V(NN_ack_VABI[7])=1.2 V(NN_ack_VABI[6])=1.2 V(NN_ack_VABI[5])=1.2
+V(NN_ack_VABI[4])=1.2 V(NN_ack_VABI[3])=1.2 V(NN_ack_VABI[2])=1.2
+V(NN_ack_VABI[1])=1.2 V(NN_ack_VABI[0])=1.2
.ic V(xchip.NN_mem_VNT[10])=0 V(xchip.NN_mem_VNT[9])=0 V(xchip.NN_mem_VNT[8])=0
+V(xchip.NN_mem_VNT[7])=0 V(xchip.NN_mem_VNT[6])=0 V(xchip.NN_mem_VNT[5])=0
+V(xchip.NN_mem_VNT[4])=0 V(xchip.NN_mem_VNT[3])=0 V(xchip.NN_mem_VNT[2])=0
+V(xchip.NN_mem_VNT[1])=0 V(xchip.NN_mem_VNT[0])=0
.ic V(xchip.NN_refcap_VT[10])=0 V(xchip.NN_refcap_VT[9])=0 V(xchip.NN_refcap_VT[8])=0
+V(xchip.NN_refcap_VT[7])=0 V(xchip.NN_refcap_VT[6])=0 V(xchip.NN_refcap_VT[5])=0
+V(xchip.NN_refcap_VT[4])=0 V(xchip.NN_refcap_VT[3])=0 V(xchip.NN_refcap_VT[2])=0
+V(xchip.NN_refcap_VT[1])=0 V(xchip.NN_refcap_VT[0])=0

.options gmin=1e-13
.options method=gear
.control

save V(NN_req_VABO[10]) V(NN_req_VABO[9]) V(NN_req_VABO[8])
+V(NN_req_VABO[7]) V(NN_req_VABO[6]) V(NN_req_VABO[5])
+V(NN_req_VABO[4]) V(NN_req_VABO[3]) V(NN_req_VABO[2])
+V(NN_req_VABO[1]) V(NN_req_VABO[0])
save V(NN_ack_VABI[10]) V(NN_ack_VABI[9]) V(NN_ack_VABI[8])
+V(NN_ack_VABI[7]) V(NN_ack_VABI[6]) V(NN_ack_VABI[5])
+V(NN_ack_VABI[4]) V(NN_ack_VABI[3]) V(NN_ack_VABI[2])
+V(NN_ack_VABI[1]) V(NN_ack_VABI[0])
save V(BUF_prob_VX1O) V(xchip.buf2mux_VTX1[1]) V(xchip.buf2mux_VTX1[0])
save V(xchip.NN_mem_VNT[10]) V(xchip.NN_mem_VNT[9]) V(xchip.NN_mem_VNT[8])
+V(xchip.NN_mem_VNT[7]) V(xchip.NN_mem_VNT[6]) V(xchip.NN_mem_VNT[5])
+V(xchip.NN_mem_VNT[4]) V(xchip.NN_mem_VNT[3]) V(xchip.NN_mem_VNT[2])
+V(xchip.NN_mem_VNT[1]) V(xchip.NN_mem_VNT[0])
save V(xchip.NN_refcap_VT[10]) V(xchip.NN_refcap_VT[9]) V(xchip.NN_refcap_VT[8])
+V(xchip.NN_refcap_VT[7]) V(xchip.NN_refcap_VT[6]) V(xchip.NN_refcap_VT[5])
+V(xchip.NN_refcap_VT[4]) V(xchip.NN_refcap_VT[3]) V(xchip.NN_refcap_VT[2])
+V(xchip.NN_refcap_VT[1]) V(xchip.NN_refcap_VT[0])
save V(IO_config_VS[7]) V(IO_config_VS[6]) V(IO_config_VS[5]) V(IO_config_VS[4])
+V(IO_config_VS[3]) V(IO_config_VS[2]) V(IO_config_VS[1]) V(IO_config_VS[0])


tran 50n 100m
write chip_top_tb.raw
.endc

"














































}
C {isource.sym} 510 -550 0 0 {name=Ilk value=4p}
C {simulator_commands_shown.sym} -540 -660 0 0 {name=lib_import
simulator=ngspice
only_toplevel=false 
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerCAP.lib cap_typ
.lib cornerRES.lib res_typ"
}
C {lab_pin.sym} 510 -500 0 0 {name=p37 sig_type=std_logic lab=NN_tau_VNI}
C {vsource.sym} -180 -580 0 0 {name=VDD1 value=1.2 savecurrent=false}
C {gnd.sym} -180 -470 0 0 {name=l7 lab=GND}
C {vdd.sym} -180 -610 0 0 {name=l8 lab=VDD}
C {isource.sym} 680 -550 0 0 {name=Iref value=100p}
C {vdd.sym} 680 -600 0 0 {name=l16 lab=VDD}
C {vdd.sym} 510 -600 0 0 {name=l20 lab=VDD}
C {ammeter.sym} -180 -500 0 0 {name=Vidd savecurrent=true spice_ignore=0}
C {sg13g2_pr/sg13_hv_nmos.sym} 530 -440 0 1 {name=M27
l=4u
w=4u
ng=2
m=4
model=sg13_hv_nmos
spiceprefix=X
}
C {gnd.sym} 510 -360 0 0 {name=l4 lab=GND}
C {capa.sym} 560 -410 0 0 {name=C2
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 680 -500 0 0 {name=p3 sig_type=std_logic lab=NN_ref_VNI}
C {sg13g2_pr/sg13_hv_nmos.sym} 700 -440 0 1 {name=M1
l=4u
w=4u
ng=2
m=4
model=sg13_hv_nmos
spiceprefix=X
}
C {gnd.sym} 680 -360 0 0 {name=l3 lab=GND}
C {capa.sym} 730 -410 0 0 {name=C1
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 310 -530 0 0 {name=p5 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_hv_pmos.sym} 350 -530 0 1 {name=M3
l=1u
w=4u
ng=1
m=4
model=sg13_hv_pmos
spiceprefix=X
}
C {vdd.sym} 330 -600 0 0 {name=l6 lab=VDD}
C {capa.sym} 380 -560 0 0 {name=C3
m=1
value=2p
footprint=1206
device="ceramic capacitor"}
C {isource.sym} 330 -420 0 0 {name=Ibias value=6n}
C {gnd.sym} 330 -360 0 0 {name=l9 lab=GND}
C {vsource.sym} 150 -400 0 0 {name=Vcm value=0.4 savecurrent=false}
C {gnd.sym} 150 -350 0 0 {name=l11 lab=GND}
C {lab_wire.sym} 150 -460 0 0 {name=p7 sig_type=std_logic lab=V2I_cm_VI}
C {vsource.sym} 150 -550 0 0 {name=Vin value="sine(0.4 50m 10)"}
C {gnd.sym} 150 -500 0 0 {name=l12 lab=GND}
C {lab_wire.sym} 150 -610 0 0 {name=p8 sig_type=std_logic lab=V2I_in_VI}
C {lab_wire.sym} 330 -470 0 0 {name=p13 sig_type=std_logic lab=V2I_bias_VPI}
C {capa.sym} 1130 250 0 0 {name=C4
m=1
value=20p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 1130 300 0 0 {name=l19 lab=GND}
C {lab_wire.sym} 1130 200 0 0 {name=p19 sig_type=std_logic lab=BUF_prob_VX1O}
C {inv.sym} 1180 -40 0 0 {name=xinv1[10:0]}
C {inv.sym} 1440 -40 0 0 {name=xinv2[10:0]}
C {vdd.sym} 1090 -120 0 0 {name=l21 lab=VDD}
C {vdd.sym} 1350 -120 0 0 {name=l22 lab=VDD}
C {gnd.sym} 1090 50 0 0 {name=l1 lab=GND}
C {gnd.sym} 1350 50 0 0 {name=l2 lab=GND}
C {lab_wire.sym} 1420 -40 0 1 {name=p1 sig_type=std_logic lab=NN_ack_VABI[10:0]}
C {chip_top.sym} 370 220 0 0 {name=xchip}
C {lab_wire.sym} 280 140 3 1 {name=p2 sig_type=std_logic lab=GND}
C {lab_wire.sym} 260 140 3 1 {name=p4 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 350 350 0 0 {name=p6 sig_type=std_logic lab=V2I_in_VI,V2I_bias_VPI,V2I_cm_VI,NN_tau_VNI,NN_ref_VNI,BUF_prob_VX1O}
C {noconn.sym} 320 100 1 0 {name=lnoconn1[7:0]}
C {lab_wire.sym} 320 140 3 1 {name=p9 sig_type=std_logic lab=IO_config_VS[7:0]}
C {lab_wire.sym} 340 140 3 1 {name=p10 sig_type=std_logic lab=NN_req_VABO[10:8],uio_out[4:0]}
C {lab_wire.sym} 360 140 3 1 {name=p11 sig_type=std_logic lab=NN_req_VABO[7:0]}
C {lab_wire.sym} 400 140 3 1 {name=p12 sig_type=std_logic lab=NN_ack_VABI[7:0]}
C {lab_wire.sym} 380 140 3 1 {name=p14 sig_type=std_logic lab=3*GND,NN_ack_VABI[10:8],MUX_sel1_VSI,MUX_sel0_VSI}
C {lab_wire.sym} 1290 -40 0 0 {name=p15 sig_type=std_logic lab=NN_req_VA[10:0]}
C {lab_wire.sym} 1030 -40 0 0 {name=p17 sig_type=std_logic lab=NN_req_VABO[10:0]}
C {noconn.sym} 650 200 2 0 {name=lnoconn2[2:0]}
C {lab_wire.sym} 640 200 0 0 {name=p18 sig_type=std_logic lab=uio_out[4:0]}
C {vsource.sym} -30 -400 0 0 {name=Vsel1 value=0}
C {gnd.sym} -30 -350 0 0 {name=l5 lab=GND}
C {lab_wire.sym} -30 -460 0 0 {name=p20 sig_type=std_logic lab=MUX_sel1_VSI}
C {vsource.sym} -30 -560 0 0 {name=Vsel0 value=1.2}
C {gnd.sym} -30 -510 0 0 {name=l10 lab=GND}
C {lab_wire.sym} -30 -620 0 0 {name=p21 sig_type=std_logic lab=MUX_sel0_VSI}

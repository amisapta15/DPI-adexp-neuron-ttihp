v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 -810 -560 -650 -560 {}
L 4 -810 -420 -650 -420 {}
L 4 -470 -560 -290 -560 {}
L 4 -650 -560 -650 -300 {}
L 4 -470 -460 -290 -460 {}
L 4 -650 -560 -650 -360 {}
L 4 -650 -560 -470 -560 {}
L 4 -470 -560 -470 -300 {}
L 4 -650 -300 -470 -300 {}
L 4 -290 -560 -290 -460 {}
L 4 -810 -560 -810 -420 {}
L 4 -810 -210 -310 -210 {}
L 4 -310 -210 -310 190 {}
L 4 -810 190 -310 190 {}
L 4 -810 -210 -810 190 {}
T {Power} -760 -550 0 0 0.4 0.4 {}
T {Analog} -420 -550 0 0 0.4 0.4 {}
T {Digital} -600 -550 0 0 0.4 0.4 {}
T {Bidirectional pins configurations:
uio[4:0] input
uio[7:5] output} -680 -200 0 0 0.3 0.3 {}
N 30 -380 30 -340 {lab=VGND}
N -160 -280 -110 -280 {lab=ua[5]}
N 10 -180 10 -110 {lab=ua[3]}
N 30 -180 30 -110 {lab=ua[4]}
N 50 -180 50 -110 {lab=ua[2]}
N 70 -180 70 -110 {lab=ua[1]}
N -160 -260 -110 -260 {lab=uio_in[4:2],ui_in[7:0]}
N 190 -260 260 -260 {lab=NN_mem_VNT[10:0]}
N 190 -240 260 -240 {lab=NN_refcap_VT[10:0]}
N 190 -280 260 -280 {lab=uio_out[7:5],uo_out[7:0]}
N 10 -380 10 -340 {lab=VDPWR}
N 120 -20 120 10 {lab=VDPWR}
N 100 -20 100 10 {lab=ua[4]}
N 120 150 120 180 {lab=VGND}
N 840 90 930 90 {lab=ua[0]}
N 230 80 290 80 {lab=buf2mux_VTX1[1:0]}
N 490 60 540 60 {lab=buf2mux_VTX1[0]}
N 490 80 540 80 {lab=buf2mux_VTX1[1]}
N 690 -10 690 30 {lab=VDPWR}
N 690 150 690 180 {lab=VGND}
N 570 150 570 180 {lab=uio_in[0]}
N 590 150 590 180 {lab=uio_in[1]}
N -660 -30 -600 -30 {lab=uio_oe[7:5]}
N -730 -120 -730 -80 {lab=VGND}
N -750 -120 -750 -80 {lab=VDPWR}
N -490 -120 -490 -80 {lab=VGND}
N -510 -120 -510 -80 {lab=VDPWR}
N -420 -30 -360 -30 {lab=uio_oe[4:0]}
N -490 30 -490 70 {lab=VGND}
N -510 30 -510 70 {lab=VDPWR}
N -420 120 -360 120 {lab=uio_out[4:0]}
N -750 120 -700 120 {lab=uio_in[7:5]}
N 530 -260 570 -260 {lab=NN_mem_VNT[10:1]}
N 530 -240 570 -240 {lab=NN_refcap_VT[10:1]}
N -40 80 10 80 {lab=NN_refcap_VT[0],NN_mem_VNT[0]}
N -380 -720 -380 -690 {lab=VGND}
N -380 -630 -380 -600 {lab=ua[4:1]}
N -740 -780 -740 -750 {lab=VGND}
N -740 -610 -740 -580 {lab=VDPWR}
N -690 -610 -590 -610 {lab=VDPWR}
N -590 -620 -590 -610 {lab=VDPWR}
N -690 -640 -690 -610 {lab=VDPWR}
N -740 -610 -690 -610 {lab=VDPWR}
N -790 -610 -740 -610 {lab=VDPWR}
N -790 -660 -790 -610 {lab=VDPWR}
N -890 -610 -790 -610 {lab=VDPWR}
N -890 -680 -890 -610 {lab=VDPWR}
N -790 -750 -740 -750 {lab=VGND}
N -890 -750 -890 -740 {lab=VGND}
N -790 -750 -790 -720 {lab=VGND}
N -890 -750 -790 -750 {lab=VGND}
N -740 -750 -690 -750 {lab=VGND}
N -690 -750 -690 -700 {lab=VGND}
N -690 -750 -590 -750 {lab=VGND}
N -590 -750 -590 -680 {lab=VGND}
C {neuron_row.sym} 40 -270 0 0 {name=xrow[10:0]}
C {lab_wire.sym} 30 -340 3 1 {name=p23 sig_type=std_logic lab=VGND}
C {lab_wire.sym} -110 -280 0 0 {name=p24 sig_type=std_logic lab=ua[5]}
C {lab_wire.sym} 10 -180 3 0 {name=p25 sig_type=std_logic lab=ua[3]}
C {lab_wire.sym} 30 -180 3 0 {name=p26 sig_type=std_logic lab=ua[4]}
C {lab_wire.sym} 50 -180 3 0 {name=p27 sig_type=std_logic lab=ua[2]}
C {lab_wire.sym} 70 -180 3 0 {name=p28 sig_type=std_logic lab=ua[1]}
C {lab_wire.sym} -110 -260 0 0 {name=p29 sig_type=std_logic lab=uio_in[4:2],ui_in[7:0]}
C {lab_wire.sym} 190 -280 0 1 {name=p30 sig_type=std_logic lab=uio_out[7:5],uo_out[7:0]}
C {lab_wire.sym} 190 -260 0 1 {name=p31 sig_type=std_logic lab=NN_mem_VNT[10:0]}
C {lab_wire.sym} 190 -240 0 1 {name=p32 sig_type=std_logic lab=NN_refcap_VT[10:0]}
C {lab_wire.sym} 10 -340 3 1 {name=p1 sig_type=std_logic lab=VDPWR}
C {analog_buffer.sym} 100 340 0 0 {name=xabuf[1:0]}
C {lab_wire.sym} 870 90 0 1 {name=p19 sig_type=std_logic lab=ua[0]}
C {mux21.sym} 690 90 0 0 {name=xmux}
C {lab_wire.sym} 540 60 0 0 {name=p4 sig_type=std_logic lab=buf2mux_VTX1[0]}
C {lab_wire.sym} 540 80 0 0 {name=p5 sig_type=std_logic lab=buf2mux_VTX1[1]}
C {lab_wire.sym} 690 30 3 1 {name=p6 sig_type=std_logic lab=VDPWR}
C {iopin.sym} -690 -500 2 0 {name=p8 lab=VDPWR}
C {iopin.sym} -690 -470 2 0 {name=p13 lab=VGND}
C {lab_wire.sym} 230 80 0 1 {name=p10 sig_type=std_logic lab=buf2mux_VTX1[1:0]}
C {lab_wire.sym} 100 10 3 1 {name=p14 sig_type=std_logic lab=ua[4]}
C {lab_wire.sym} 120 10 3 1 {name=p15 sig_type=std_logic lab=VDPWR}
C {lab_wire.sym} 120 150 3 0 {name=p16 sig_type=std_logic lab=VGND}
C {lab_wire.sym} 690 150 3 0 {name=p17 sig_type=std_logic lab=VGND}
C {lab_wire.sym} 570 150 3 0 {name=p18 sig_type=std_logic lab=uio_in[0]}
C {lab_wire.sym} 590 150 3 0 {name=p20 sig_type=std_logic lab=uio_in[1]}
C {ipin.sym} -520 -500 0 0 {name=p9 lab=ui_in[7:0]}
C {opin.sym} -620 -470 0 0 {name=p11 lab=uo_out[7:0]}
C {ipin.sym} -520 -440 0 0 {name=p12 lab=uio_in[7:0]}
C {opin.sym} -620 -410 0 0 {name=p21 lab=uio_out[7:0]}
C {opin.sym} -620 -380 0 0 {name=p22 lab=uio_oe[7:0]}
C {iopin.sym} -340 -500 2 0 {name=p33 lab=ua[5:0]}
C {lab_wire.sym} -660 -30 0 1 {name=p7 sig_type=std_logic lab=uio_oe[7:5]}
C {sg13g2_tiehi.sym} -810 -30 0 0 {name=xoehi[2:0]}
C {lab_wire.sym} -730 -80 3 1 {name=p35 sig_type=std_logic lab=VGND}
C {lab_wire.sym} -750 -80 3 1 {name=p36 sig_type=std_logic lab=VDPWR}
C {sg13g2_tielo.sym} -570 -30 0 0 {name=xoelo[4:0]}
C {lab_wire.sym} -490 -80 3 1 {name=p37 sig_type=std_logic lab=VGND}
C {lab_wire.sym} -510 -80 3 1 {name=p38 sig_type=std_logic lab=VDPWR}
C {lab_wire.sym} -420 -30 0 1 {name=p39 sig_type=std_logic lab=uio_oe[4:0]}
C {sg13g2_tielo.sym} -570 120 0 0 {name=xoelo1[4:0]}
C {lab_wire.sym} -490 70 3 1 {name=p34 sig_type=std_logic lab=VGND}
C {lab_wire.sym} -510 70 3 1 {name=p40 sig_type=std_logic lab=VDPWR}
C {lab_wire.sym} -420 120 0 1 {name=p41 sig_type=std_logic lab=uio_out[4:0]}
C {noconn.sym} -750 120 0 0 {name=lnoconn1[2:0]}
C {lab_wire.sym} -740 120 0 1 {name=p42 sig_type=std_logic lab=uio_in[7:5]}
C {noconn.sym} 570 -260 0 1 {name=lnoconn2[9:0]}
C {lab_wire.sym} 560 -260 0 0 {name=p43 sig_type=std_logic lab=NN_mem_VNT[10:1]}
C {noconn.sym} 570 -240 0 1 {name=lnoconn3[9:0]}
C {lab_wire.sym} 560 -240 0 0 {name=p44 sig_type=std_logic lab=NN_refcap_VT[10:1]}
C {lab_wire.sym} 10 80 0 0 {name=p47 sig_type=std_logic lab=NN_refcap_VT[0],NN_mem_VNT[0]}
C {sg13g2_pr/cap_cmim.sym} -380 -660 0 0 {name=Cadecap[3:0]
model=cap_cmim
w=75e-6
l=75e-6
m=1
spiceprefix=X}
C {lab_wire.sym} -380 -700 0 0 {name=p48 sig_type=std_logic lab=VGND}
C {lab_wire.sym} -380 -620 2 1 {name=p49 sig_type=std_logic lab=ua[4:1]}
C {sg13g2_pr/cap_cmim.sym} -690 -670 0 0 {name=Cdecap2
model=cap_cmim
w=75e-6
l=75e-6
m=5
spiceprefix=X}
C {lab_wire.sym} -740 -760 0 0 {name=Cadecap2[4:0] sig_type=std_logic lab=VGND}
C {lab_wire.sym} -740 -600 2 1 {name=Cadecap3[4:0] sig_type=std_logic lab=VDPWR}
C {sg13g2_pr/cap_cmim.sym} -790 -690 0 0 {name=Cdecap1
model=cap_cmim
w=30e-6
l=75e-6
m=3
spiceprefix=X}
C {sg13g2_pr/cap_cmim.sym} -590 -650 0 0 {name=Cdecap3
model=cap_cmim
w=75e-6
l=34e-6
m=3
spiceprefix=X}
C {sg13g2_pr/cap_cmim.sym} -890 -710 0 0 {name=Cdecap4
model=cap_cmim
w=30e-6
l=34e-6
m=1
spiceprefix=X}

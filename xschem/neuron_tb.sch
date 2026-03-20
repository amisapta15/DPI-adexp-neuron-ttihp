v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 5 -300 -420 740 -420 740 -200 -300 -200 -300 -420 {}
N 190 -370 190 -350 {lab=VDD}
N 270 -370 270 -350 {lab=VDD}
N -140 -290 -140 -270 {lab=I_in}
N 450 -310 450 -290 {lab=GND}
N 450 -400 450 -370 {lab=I_adapt}
N -140 -380 -140 -350 {lab=VDD}
N 270 -290 270 -270 {lab=I_lk}
N 190 -290 190 -270 {lab=I_thr}
N -250 -320 -250 -300 {lab=#net1}
N 350 -370 350 -350 {lab=VDD}
N 350 -290 350 -270 {lab=Iref}
N 580 -370 580 -350 {lab=VDD}
N 680 -370 680 -350 {lab=VDD}
N 580 -290 580 -260 {lab=I_thrahp}
N 680 -290 680 -260 {lab=I_lkahp}
N -30 -150 -30 -130 {lab=VDD}
N -210 -100 -180 -100 {lab=I_in}
N -530 -350 -530 -310 {lab=GND}
N -630 -290 -440 -290 {lab=I_lk}
N -610 -380 -430 -380 {lab=I_thr}
N -530 -260 -530 -220 {lab=GND}
N -530 -310 -490 -310 {lab=GND}
N -530 -220 -500 -220 {lab=GND}
N -530 -150 -530 -110 {lab=GND}
N -530 -110 -490 -110 {lab=GND}
N -620 -180 -450 -180 {lab=Iref}
N -530 40 -530 90 {lab=GND}
N -530 90 -470 90 {lab=GND}
N -600 10 -450 10 {lab=I_thrahp}
N -520 150 -520 200 {lab=GND}
N -520 200 -480 200 {lab=GND}
N -600 120 -450 120 {lab=I_lkahp}
N -320 -350 -320 -50 {lab=I_thr}
N -430 -350 -320 -350 {lab=I_thr}
N -440 -260 -340 -260 {lab=I_lk}
N -340 -260 -340 -30 {lab=I_lk}
N -450 -150 -370 -150 {lab=Iref}
N -370 -150 -370 50 {lab=Iref}
N -460 -60 -390 -60 {lab=I_adapt}
N -450 40 -410 40 {lab=I_thrahp}
N -450 150 -380 150 {lab=I_lkahp}
N -430 -380 -430 -350 {lab=I_thr}
N -490 -350 -430 -350 {lab=I_thr}
N -440 -290 -440 -260 {lab=I_lk}
N -490 -260 -440 -260 {lab=I_lk}
N -450 -180 -450 -150 {lab=Iref}
N -490 -150 -450 -150 {lab=Iref}
N -640 -90 -530 -90 {lab=VDD}
N -530 -20 -460 -20 {lab=I_adapt}
N -460 -60 -460 -20 {lab=I_adapt}
N -490 -60 -460 -60 {lab=I_adapt}
N -450 10 -450 40 {lab=I_thrahp}
N -490 40 -450 40 {lab=I_thrahp}
N -450 120 -450 150 {lab=I_lkahp}
N -480 150 -450 150 {lab=I_lkahp}
N -30 -130 150 -130 {lab=VDD}
N 120 -70 150 -70 {lab=VDD}
N -180 -100 -180 -70 {lab=I_in}
N -320 -50 -180 -50 {lab=I_thr}
N -340 -30 -180 -30 {lab=I_lk}
N -370 50 -180 50 {lab=Iref}
N -390 -10 -180 -10 {lab=I_adapt}
N -390 -60 -390 -10 {lab=I_adapt}
N -410 10 -410 40 {lab=I_thrahp}
N -410 10 -180 10 {lab=I_thrahp}
N -380 30 -380 150 {lab=I_lkahp}
N -380 30 -180 30 {lab=I_lkahp}
N 390 -10 420 -10 {lab=#net2}
N 560 -10 590 -10 {lab=ACK}
N 310 -130 480 -130 {lab=VDD}
N 480 -130 480 -50 {lab=VDD}
N 310 -130 310 -50 {lab=VDD}
N 150 -130 310 -130 {lab=VDD}
N 150 -130 150 -70 {lab=VDD}
N 190 -10 250 -10 {lab=REQ}
N 590 -10 590 110 {lab=ACK}
N -220 110 590 110 {lab=ACK}
N -220 70 -220 110 {lab=ACK}
N -220 70 -180 70 {lab=ACK}
N -30 90 -30 150 {lab=GND}
N 310 90 480 90 {lab=GND}
N 480 30 480 90 {lab=GND}
N 310 30 310 90 {lab=GND}
N 120 90 310 90 {lab=GND}
N 120 -30 190 -30 {lab=REQ}
N -530 -30 -530 -20 {lab=I_adapt}
N -620 -20 -530 -20 {lab=I_adapt}
N -530 -90 -530 -60 {lab=VDD}
N 120 -50 170 -50 {lab=vmem}
N 190 -30 190 -10 {lab=REQ}
N 120 -10 150 -10 {lab=CapAdap}
N 120 10 120 90 {lab=GND}
N -30 90 120 90 {lab=GND}
C {neuron.sym} -30 0 0 0 {name=Xneuron}
C {simulator_commands_shown.sym} -240 -700 0 0 {name=example_Simulator1
simulator=ngspice
only_toplevel=false 
value="
.param temp=27

.ic V(xneuron.vmem)=0 V(xneuron.xref.vref)=0 V(REQ)=0 V(ACK)=0 V(xneuron.xadap.CapAdapt)=0

.options gmin=1e-13
.control

save V(ACK) V(REQ) V(vmem) V(xneuron.xref.vref) V(CapAdap)
save V(xneuron.xfb.vmir) V(xneuron.xfb.vd) I(xneuron.xfb.vfb) V(xneuron.vfb)

tran 50n 10m
write neuron_tb.raw
.endc

"}
C {isource.sym} 190 -320 0 0 {name=Ithr value=16p}
C {isource.sym} 270 -320 0 0 {name=Ilk value=4p}
C {simulator_commands_shown.sym} -540 -660 0 0 {name=lib_import
simulator=ngspice
only_toplevel=false 
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt"
}
C {isource.sym} 450 -340 0 0 {name=Ispkthr value=4n}
C {gnd.sym} 450 -290 0 0 {name=l40 lab=GND}
C {isource.sym} -140 -320 0 0 {name=Iin value="dc 0 ac 0 pulse(0 1n 100u 20n 20n 5m 5m)"
}
C {lab_pin.sym} 450 -400 0 0 {name=p33 sig_type=std_logic lab=I_adapt}
C {lab_pin.sym} -140 -270 0 0 {name=p35 sig_type=std_logic lab=I_in}
C {lab_pin.sym} 270 -270 0 0 {name=p37 sig_type=std_logic lab=I_lk}
C {lab_pin.sym} 190 -270 0 0 {name=p39 sig_type=std_logic lab=I_thr}
C {vsource.sym} -250 -350 0 0 {name=VDD1 value=1.2 savecurrent=false}
C {gnd.sym} -250 -240 0 0 {name=l7 lab=GND}
C {vdd.sym} -250 -380 0 0 {name=l8 lab=VDD}
C {isource.sym} 350 -320 0 0 {name=Iref value=1n}
C {lab_pin.sym} 350 -270 0 0 {name=p1 sig_type=std_logic lab=Iref}
C {vdd.sym} 350 -370 0 0 {name=l16 lab=VDD}
C {vdd.sym} -140 -370 0 0 {name=l18 lab=VDD}
C {vdd.sym} 190 -370 0 0 {name=l19 lab=VDD}
C {vdd.sym} 270 -370 0 0 {name=l20 lab=VDD}
C {ammeter.sym} -250 -270 0 0 {name=Vidd savecurrent=true spice_ignore=0}
C {isource.sym} 680 -320 0 0 {name=Ilkahp value=100p}
C {isource.sym} 580 -320 0 0 {name=Ithrahp value=40p}
C {lab_pin.sym} 580 -260 0 0 {name=p41 sig_type=std_logic lab=I_thrahp}
C {lab_pin.sym} 680 -260 0 0 {name=p42 sig_type=std_logic lab=I_lkahp}
C {vdd.sym} 580 -370 0 0 {name=l9 lab=VDD}
C {vdd.sym} 680 -370 0 0 {name=l32 lab=VDD}
C {vdd.sym} -30 -150 0 0 {name=l1 lab=VDD}
C {gnd.sym} -30 150 0 0 {name=l2 lab=GND}
C {lab_pin.sym} -210 -100 0 0 {name=p2 sig_type=std_logic lab=I_in}
C {sg13g2_pr/sg13_hv_nmos.sym} -510 -350 0 1 {name=M26
l=4u
w=4u
ng=1
m=4
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_pin.sym} -610 -380 0 0 {name=p3 sig_type=std_logic lab=I_thr}
C {sg13g2_pr/sg13_hv_nmos.sym} -510 -260 0 1 {name=M27
l=5u
w=4u
ng=1
m=4
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_pin.sym} -630 -290 0 0 {name=p4 sig_type=std_logic lab=I_lk}
C {gnd.sym} -490 -310 3 0 {name=l3 lab=GND}
C {gnd.sym} -500 -220 3 0 {name=l4 lab=GND}
C {sg13g2_pr/sg13_hv_nmos.sym} -510 -150 0 1 {name=M15
l=4u
w=4u
ng=1
m=4
model=sg13_hv_nmos
spiceprefix=X
}
C {gnd.sym} -490 -110 3 0 {name=l5 lab=GND}
C {lab_pin.sym} -620 -180 0 0 {name=p5 sig_type=std_logic lab=Iref}
C {sg13g2_pr/sg13_hv_pmos.sym} -510 -60 0 1 {name=M22
l=4u
w=4u
ng=1
m=4
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_pin.sym} -620 -20 0 0 {name=p6 sig_type=std_logic lab=I_adapt}
C {sg13g2_pr/sg13_hv_nmos.sym} -510 40 0 1 {name=M31
l=4u
w=4u
ng=1
m=4
model=sg13_hv_nmos
spiceprefix=X
}
C {gnd.sym} -470 90 3 0 {name=l10 lab=GND}
C {lab_pin.sym} -600 10 0 0 {name=p7 sig_type=std_logic lab=I_thrahp}
C {sg13g2_pr/sg13_hv_nmos.sym} -500 150 0 1 {name=M32
l=5u
w=4u
ng=1
m=4
model=sg13_hv_nmos
spiceprefix=X
}
C {gnd.sym} -480 200 3 0 {name=l11 lab=GND}
C {lab_pin.sym} -600 120 0 0 {name=p8 sig_type=std_logic lab=I_lkahp}
C {lab_pin.sym} 590 80 2 1 {name=p9 sig_type=std_logic lab=ACK}
C {lab_pin.sym} 190 -10 1 1 {name=p10 sig_type=std_logic lab=REQ}
C {vdd.sym} -640 -90 0 0 {name=l6 lab=VDD}
C {inv.sym} 390 -10 0 0 {name=Xinv3}
C {inv.sym} 560 -10 0 0 {name=Xinv4}
C {capa.sym} -390 -320 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} -390 -290 0 0 {name=l12 lab=GND}
C {capa.sym} -400 -230 0 0 {name=C2
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} -400 -200 0 0 {name=l13 lab=GND}
C {capa.sym} -420 -120 0 0 {name=C3
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} -420 -90 0 0 {name=l14 lab=GND}
C {capa.sym} -440 -30 0 0 {name=C4
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} -440 0 0 0 {name=l15 lab=GND}
C {capa.sym} -420 70 0 0 {name=C5
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} -420 100 0 0 {name=l17 lab=GND}
C {capa.sym} -400 180 0 0 {name=C6
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} -400 210 0 0 {name=l21 lab=GND}
C {lab_pin.sym} 150 -10 3 0 {name=p11 sig_type=std_logic lab=CapAdap}
C {lab_pin.sym} 170 -50 2 0 {name=p12 sig_type=std_logic lab=vmem}

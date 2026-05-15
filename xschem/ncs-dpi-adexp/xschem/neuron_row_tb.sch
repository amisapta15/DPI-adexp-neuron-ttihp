v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 5 -60 -650 800 -650 800 -300 -60 -300 -60 -650 {}
N 510 -600 510 -580 {lab=VDD}
N 100 -520 100 -500 {lab=GND}
N 510 -520 510 -480 {lab=V_lk}
N -10 -550 -10 -530 {lab=#net1}
N 680 -600 680 -580 {lab=VDD}
N 680 -520 680 -480 {lab=V_ref}
N 510 -440 510 -380 {lab=GND}
N 100 -600 100 -580 {lab=VDD}
N 550 -440 560 -440 {lab=V_lk}
N 560 -480 560 -440 {lab=V_lk}
N 510 -480 560 -480 {lab=V_lk}
N 510 -480 510 -470 {lab=V_lk}
N 680 -440 680 -380 {lab=GND}
N 720 -440 730 -440 {lab=V_ref}
N 730 -480 730 -440 {lab=V_ref}
N 680 -480 730 -480 {lab=V_ref}
N 680 -480 680 -470 {lab=V_ref}
N 510 -380 560 -380 {lab=GND}
N 680 -380 730 -380 {lab=GND}
N 510 -380 510 -360 {lab=GND}
N 680 -380 680 -360 {lab=GND}
N 360 -490 360 -450 {lab=V_bias}
N 410 -530 410 -490 {lab=V_bias}
N 400 -530 410 -530 {lab=V_bias}
N 360 -490 410 -490 {lab=V_bias}
N 360 -500 360 -490 {lab=V_bias}
N 360 -590 410 -590 {lab=VDD}
N 360 -590 360 -560 {lab=VDD}
N 360 -600 360 -590 {lab=VDD}
N 360 -390 360 -360 {lab=GND}
N 340 -530 360 -530 {lab=VDD}
N 220 -370 220 -350 {lab=GND}
N 220 -460 220 -430 {lab=V_cm}
N 100 -370 100 -350 {lab=GND}
N 100 -460 100 -430 {lab=V_in}
N 980 -120 980 -90 {lab=VDD}
N 960 -120 960 -90 {lab=V_bias}
N 980 50 980 80 {lab=GND}
N 810 -20 870 -20 {lab=Vmem}
N 1090 -20 1150 -20 {lab=vmem_buf}
N 1150 -20 1150 0 {lab=vmem_buf}
N 1150 60 1150 80 {lab=GND}
N -30 -110 -30 -90 {lab=VDD}
N -10 -130 -10 -90 {lab=GND}
N 10 -120 10 -90 {lab=#net2}
N 30 -120 30 -90 {lab=#net3}
N -200 -30 -150 -30 {lab=V_in}
N -30 70 -30 140 {lab=V_cm}
N -10 70 -10 140 {lab=V_bias}
N 10 70 10 140 {lab=V_lk}
N 30 70 30 140 {lab=V_ref}
N -200 -10 -150 -10 {lab=ACK}
N 150 -30 270 -30 {lab=REQ}
N 150 -10 220 -10 {lab=Vmem}
N 150 10 220 10 {lab=Vrefcap}
N 410 -30 440 -30 {lab=#net4}
N 500 10 500 50 {lab=GND}
N 330 10 330 50 {lab=GND}
N 330 -100 330 -70 {lab=VDD}
N 500 -100 500 -70 {lab=VDD}
N 580 -30 620 -30 {lab=ACK}
C {simulator_commands_shown.sym} 930 -1070 0 0 {name=example_Simulator1
simulator=ngspice
only_toplevel=false 
value="
.param temp=27
.param Iin_amp=4n

.ic V(vmem)=0 V(vrefcap)=0 V(REQ)=1.2 V(ACK)=1.2

.options gmin=1e-13
.options method=gear
.control

save V(V_lk) V(V_in) V(V_ref)
save V(ACK) V(REQ) V(vmem) V(vmem_buf) V(vrefcap)
save V(V_in) V(V_cm)
save V(xbuffer.vb)


tran 50n 100m
write neuron_noahp_tb.raw
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
C {isource.sym} 100 -550 0 0 {name=Iin value="dc 0 ac 0 pulse(0 Iin_amp 0 20n 20n 1 1)"
}
C {lab_pin.sym} 510 -500 0 0 {name=p37 sig_type=std_logic lab=V_lk}
C {vsource.sym} -10 -580 0 0 {name=VDD1 value=1.2 savecurrent=false}
C {gnd.sym} -10 -470 0 0 {name=l7 lab=GND}
C {vdd.sym} -10 -610 0 0 {name=l8 lab=VDD}
C {isource.sym} 680 -550 0 0 {name=Iref value=100p}
C {vdd.sym} 680 -600 0 0 {name=l16 lab=VDD}
C {vdd.sym} 100 -600 0 0 {name=l18 lab=VDD}
C {vdd.sym} 510 -600 0 0 {name=l20 lab=VDD}
C {ammeter.sym} -10 -500 0 0 {name=Vidd savecurrent=true spice_ignore=0}
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
value=2p
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 680 -500 0 0 {name=p3 sig_type=std_logic lab=V_ref}
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
value=2p
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 340 -530 0 0 {name=p5 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_hv_pmos.sym} 380 -530 0 1 {name=M3
l=1u
w=4u
ng=1
m=4
model=sg13_hv_pmos
spiceprefix=X
}
C {vdd.sym} 360 -600 0 0 {name=l6 lab=VDD}
C {capa.sym} 410 -560 0 0 {name=C3
m=1
value=2p
footprint=1206
device="ceramic capacitor"}
C {isource.sym} 360 -420 0 0 {name=Ilk1 value=4n}
C {gnd.sym} 360 -360 0 0 {name=l9 lab=GND}
C {vsource.sym} 220 -400 0 0 {name=Vcm value=0.4 savecurrent=false}
C {gnd.sym} 220 -350 0 0 {name=l11 lab=GND}
C {lab_wire.sym} 220 -460 0 0 {name=p7 sig_type=std_logic lab=V_cm}
C {vsource.sym} 100 -400 0 0 {name=Vin value="sine(0.4 50m 10)"}
C {gnd.sym} 100 -350 0 0 {name=l12 lab=GND}
C {lab_wire.sym} 100 -460 0 0 {name=p8 sig_type=std_logic lab=V_in}
C {lab_wire.sym} 360 -470 0 0 {name=p13 sig_type=std_logic lab=V_bias}
C {lab_wire.sym} 100 -500 0 0 {name=p16 sig_type=std_logic lab=GND}
C {analog_buffer.sym} 960 240 0 0 {name=xbuffer}
C {vdd.sym} 980 -120 0 0 {name=l15 lab=VDD}
C {lab_wire.sym} 960 -120 0 0 {name=p17 sig_type=std_logic lab=V_bias}
C {gnd.sym} 980 80 0 0 {name=l17 lab=GND}
C {lab_wire.sym} 840 -20 0 0 {name=p18 sig_type=std_logic lab=Vmem}
C {capa.sym} 1150 30 0 0 {name=C4
m=1
value=20p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 1150 80 0 0 {name=l19 lab=GND}
C {lab_wire.sym} 1150 -20 0 0 {name=p19 sig_type=std_logic lab=vmem_buf}
C {neuron_row.sym} 0 -20 0 0 {name=xrow}
C {vdd.sym} -30 -110 0 0 {name=l13 lab=VDD}
C {lab_wire.sym} -10 -90 3 1 {name=p23 sig_type=std_logic lab=GND}
C {lab_wire.sym} -170 -30 0 0 {name=p24 sig_type=std_logic lab=V_in}
C {lab_wire.sym} -30 110 3 0 {name=p25 sig_type=std_logic lab=V_cm}
C {lab_wire.sym} -10 110 3 0 {name=p26 sig_type=std_logic lab=V_bias}
C {lab_wire.sym} 10 110 3 0 {name=p27 sig_type=std_logic lab=V_lk}
C {lab_wire.sym} 30 110 3 0 {name=p28 sig_type=std_logic lab=V_ref}
C {lab_wire.sym} -170 -10 0 0 {name=p29 sig_type=std_logic lab=ACK}
C {lab_wire.sym} 160 -30 0 1 {name=p30 sig_type=std_logic lab=REQ}
C {lab_wire.sym} 160 -10 0 1 {name=p31 sig_type=std_logic lab=Vmem}
C {lab_wire.sym} 160 10 0 1 {name=p32 sig_type=std_logic lab=Vrefcap}
C {inv.sym} 410 -30 0 0 {name=Xinv3}
C {inv.sym} 580 -30 0 0 {name=Xinv4}
C {vdd.sym} 330 -100 0 0 {name=l21 lab=VDD}
C {vdd.sym} 500 -100 0 0 {name=l22 lab=VDD}
C {gnd.sym} 330 50 0 0 {name=l1 lab=GND}
C {gnd.sym} 500 50 0 0 {name=l2 lab=GND}
C {lab_wire.sym} 590 -30 0 1 {name=p1 sig_type=std_logic lab=ACK}

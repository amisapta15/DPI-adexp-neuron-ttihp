v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 160 -460 160 -270 {lab=Vb}
N 60 -460 160 -460 {lab=Vb}
N 60 30 120 30 {lab=Vm}
N 60 -20 60 30 {lab=Vm}
N 0 30 60 30 {lab=Vm}
N -40 -20 60 -20 {lab=Vm}
N -60 30 -40 30 {lab=GND}
N 160 30 180 30 {lab=GND}
N 160 -100 160 0 {lab=out}
N 160 -100 400 -100 {lab=out}
N -40 -460 60 -460 {lab=Vb}
N -40 -210 -40 -20 {lab=Vm}
N -40 -20 -40 0 {lab=Vm}
N 160 -210 160 -100 {lab=out}
N 60 -620 100 -620 {lab=nwell}
N 100 -690 100 -620 {lab=nwell}
N 60 -590 60 -460 {lab=Vb}
N -190 -620 20 -620 {lab=Vbias}
N -40 -240 -10 -240 {lab=nwell}
N -100 -240 -80 -240 {lab=inp_cm}
N 140 -240 160 -240 {lab=nwell}
N 200 -240 280 -240 {lab=out}
N -40 -460 -40 -270 {lab=Vb}
N 60 -760 60 -650 {lab=VDD}
N -40 120 60 120 {lab=GND}
N 60 120 60 140 {lab=GND}
N 60 120 160 120 {lab=GND}
N -40 60 -40 120 {lab=GND}
N 160 60 160 120 {lab=GND}
N -690 -350 -690 -320 {lab=GND}
N -640 -350 -610 -350 {lab=GND}
N -640 -320 -640 -290 {lab=GND}
N -490 -350 -490 -320 {lab=GND}
N -490 -350 -480 -350 {lab=GND}
N -490 -320 -440 -320 {lab=GND}
N -440 -350 -410 -350 {lab=GND}
N -690 -350 -680 -350 {lab=GND}
N -690 -320 -640 -320 {lab=GND}
N -690 -530 -640 -530 {lab=Vb}
N -690 -530 -690 -500 {lab=Vb}
N -690 -500 -680 -500 {lab=Vb}
N -690 -500 -690 -470 {lab=Vb}
N -690 -470 -640 -470 {lab=Vb}
N -640 -500 -600 -500 {lab=nwell}
N -490 -530 -440 -530 {lab=Vb}
N -490 -530 -490 -500 {lab=Vb}
N -490 -500 -480 -500 {lab=Vb}
N -440 -500 -400 -500 {lab=nwell}
N -680 -730 -630 -730 {lab=VDD}
N -680 -730 -680 -700 {lab=VDD}
N -680 -700 -670 -700 {lab=VDD}
N -630 -700 -580 -700 {lab=nwell}
N -630 -770 -630 -730 {lab=VDD}
N -640 -580 -640 -530 {lab=Vb}
N -440 -580 -440 -530 {lab=Vb}
N -440 -320 -440 -290 {lab=GND}
N -490 -470 -440 -470 {lab=Vb}
N -490 -500 -490 -470 {lab=Vb}
N -690 -380 -690 -350 {lab=GND}
N -690 -380 -640 -380 {lab=GND}
N -490 -380 -490 -350 {lab=GND}
N -490 -380 -440 -380 {lab=GND}
N -630 -670 -630 -660 {lab=VDD}
N -680 -700 -680 -660 {lab=VDD}
N -680 -660 -630 -660 {lab=VDD}
C {sg13g2_pr/sg13_hv_pmos.sym} -60 -240 0 0 {name=M2
l=1u
w=4u
ng=1
m=4
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} -20 30 0 1 {name=M5
l=1u
w=4u
ng=1
m=4
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 40 -620 0 0 {name=M13
l=1u
w=4u
ng=1
m=40
model=sg13_hv_pmos
spiceprefix=X
}
C {ipin.sym} -100 -240 0 0 {name=inp_cm1
lab=inp_cm}
C {lab_wire.sym} 380 -100 0 0 {name=p6 sig_type=std_logic lab=out}
C {opin.sym} 400 -100 0 0 {name=p8 lab=out}
C {sg13g2_pr/sg13_hv_pmos.sym} 180 -240 0 1 {name=M3
l=1u
w=4u
ng=1
m=4
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 140 30 0 0 {name=M1
l=1u
w=4u
ng=1
m=4
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} 260 -240 0 0 {name=p7 sig_type=std_logic lab=out}
C {iopin.sym} 60 -760 3 0 {name=p10 lab=VDD}
C {iopin.sym} 60 140 1 0 {name=p1 lab=GND}
C {ipin.sym} -190 -620 0 0 {name=p5 lab=Vbias}
C {sg13g2_pr/sg13_hv_pmos.sym} -650 -700 0 0 {name=MDBIAS
l=1u
w=4u
ng=2
m=20
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} -660 -500 0 0 {name=MDdiffINP
l=1u
w=4u
ng=2
m=2
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} -460 -500 0 0 {name=MDdiffINN
l=1u
w=4u
ng=2
m=2
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} -660 -350 0 0 {name=MDNMIRA
l=1u
w=4u
ng=2
m=2
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} -460 -350 0 0 {name=MDNMIRB
l=1u
w=4u
ng=2
m=2
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} -630 -500 0 1 {name=p22 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -420 -500 0 1 {name=p23 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -640 -300 0 0 {name=p24 sig_type=std_logic lab=GND}
C {lab_wire.sym} -440 -300 0 0 {name=p25 sig_type=std_logic lab=GND}
C {lab_wire.sym} -630 -750 0 0 {name=p27 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -630 -350 2 0 {name=p30 sig_type=std_logic lab=GND}
C {lab_wire.sym} -430 -350 2 0 {name=p31 sig_type=std_logic lab=GND}
C {lab_wire.sym} -440 -550 0 0 {name=p36 sig_type=std_logic lab=Vb
}
C {lab_wire.sym} -640 -550 0 0 {name=p35 sig_type=std_logic lab=Vb
}
C {lab_wire.sym} -620 -700 0 1 {name=p28 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 100 -640 1 0 {name=p2 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 150 -240 0 0 {name=p3 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -20 -240 2 0 {name=p4 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -50 30 0 0 {name=p9 sig_type=std_logic lab=GND}
C {lab_wire.sym} 170 30 2 0 {name=p13 sig_type=std_logic lab=GND}
C {lab_wire.sym} 40 -460 0 0 {name=p12 sig_type=std_logic lab=Vb}
C {lab_wire.sym} 30 -20 0 0 {name=p14 sig_type=std_logic lab=Vm}

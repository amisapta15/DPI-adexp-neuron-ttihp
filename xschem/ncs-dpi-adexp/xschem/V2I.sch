v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -90 -320 -90 -270 {lab=Vb}
N 110 -320 110 -270 {lab=Vb}
N 10 -320 110 -320 {lab=Vb}
N 10 30 70 30 {lab=Vm}
N 10 -20 10 30 {lab=Vm}
N -50 30 10 30 {lab=Vm}
N -90 -20 10 -20 {lab=Vm}
N 110 -100 110 0 {lab=out}
N 110 -100 350 -100 {lab=out}
N -90 -320 10 -320 {lab=Vb}
N -90 -210 -90 -20 {lab=Vm}
N -90 -20 -90 0 {lab=Vm}
N 110 -210 110 -100 {lab=out}
N 10 -480 50 -480 {lab=VDD}
N 50 -550 50 -480 {lab=VDD}
N -140 -480 -30 -480 {lab=Vbias}
N 10 -450 10 -320 {lab=Vb}
N -90 -240 -60 -240 {lab=VDD}
N 150 -240 170 -240 {lab=inn_cm}
N -150 -240 -130 -240 {lab=inp_cm}
N 80 -240 110 -240 {lab=VDD}
N 10 -610 10 -510 {lab=VDD}
N -90 120 10 120 {lab=GND}
N 10 120 10 180 {lab=GND}
N 10 120 110 120 {lab=GND}
N 550 -300 590 -300 {lab=VDD}
N 590 -370 590 -300 {lab=VDD}
N 410 -300 510 -300 {lab=Vbias}
N 550 -270 550 -50 {lab=out}
N 550 -420 550 -330 {lab=VDD}
N -120 30 -90 30 {lab=psub}
N -90 60 -90 120 {lab=GND}
N 110 30 140 30 {lab=psub}
N 110 60 110 120 {lab=GND}
N -750 -200 -750 -170 {lab=GND}
N -700 -200 -670 -200 {lab=psub}
N -700 -170 -700 -140 {lab=GND}
N -550 -200 -550 -170 {lab=GND}
N -550 -200 -540 -200 {lab=GND}
N -550 -170 -500 -170 {lab=GND}
N -500 -200 -470 -200 {lab=psub}
N -750 -200 -740 -200 {lab=GND}
N -750 -170 -700 -170 {lab=GND}
N -750 -380 -700 -380 {lab=Vb}
N -750 -380 -750 -350 {lab=Vb}
N -750 -350 -740 -350 {lab=Vb}
N -750 -350 -750 -320 {lab=Vb}
N -750 -320 -700 -320 {lab=Vb}
N -700 -350 -660 -350 {lab=VDD}
N -550 -380 -500 -380 {lab=Vb}
N -550 -380 -550 -350 {lab=Vb}
N -550 -350 -540 -350 {lab=Vb}
N -500 -350 -460 -350 {lab=VDD}
N -740 -580 -690 -580 {lab=VDD}
N -740 -580 -740 -550 {lab=VDD}
N -740 -550 -730 -550 {lab=VDD}
N -690 -550 -640 -550 {lab=VDD}
N -550 -580 -500 -580 {lab=VDD}
N -500 -550 -450 -550 {lab=VDD}
N -550 -550 -540 -550 {lab=VDD}
N -550 -580 -550 -550 {lab=VDD}
N -690 -620 -690 -580 {lab=VDD}
N -500 -620 -500 -580 {lab=VDD}
N -700 -430 -700 -380 {lab=Vb}
N -500 -430 -500 -380 {lab=Vb}
N -500 -170 -500 -140 {lab=GND}
N -550 -320 -500 -320 {lab=Vb}
N -550 -350 -550 -320 {lab=Vb}
N -750 -230 -750 -200 {lab=GND}
N -750 -230 -700 -230 {lab=GND}
N -550 -230 -550 -200 {lab=GND}
N -550 -230 -500 -230 {lab=GND}
N -500 -520 -500 -510 {lab=VDD}
N -550 -510 -500 -510 {lab=VDD}
N -550 -550 -550 -510 {lab=VDD}
N -690 -520 -690 -510 {lab=VDD}
N -740 -550 -740 -510 {lab=VDD}
N -740 -510 -690 -510 {lab=VDD}
C {sg13g2_pr/sg13_hv_nmos.sym} -70 30 0 1 {name=MIRA
l=1u
w=4u
ng=2
m=4
model=sg13_hv_nmos
spiceprefix=X
}
C {ipin.sym} 170 -240 2 0 {name=inn_cm lab=inn_cm}
C {sg13g2_pr/sg13_hv_pmos.sym} -10 -480 0 0 {name=MBIAS
l=1u
w=4u
ng=2
m=4
model=sg13_hv_pmos
spiceprefix=X
}
C {ipin.sym} -150 -240 0 0 {name=inp_cm1
lab=inp_cm}
C {sg13g2_pr/sg13_hv_nmos.sym} 90 30 0 0 {name=MIRB
l=1u
w=4u
ng=2
m=4
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} 330 -100 0 0 {name=p6 sig_type=std_logic lab=out}
C {opin.sym} 350 -100 0 0 {name=p8 lab=out}
C {sg13g2_pr/sg13_hv_pmos.sym} 130 -240 0 1 {name=MdiffINN
l=1u
w=4u
ng=2
m=4
model=sg13_hv_pmos
spiceprefix=X
}
C {ipin.sym} -140 -480 0 0 {name=p5 lab=Vbias}
C {iopin.sym} 10 -610 3 0 {name=p10 lab=VDD}
C {iopin.sym} 10 180 1 0 {name=p7 lab=GND}
C {lab_wire.sym} 450 -300 0 0 {name=p1 sig_type=std_logic lab=Vbias}
C {lab_wire.sym} 550 -100 0 0 {name=p12 sig_type=std_logic lab=out}
C {lab_wire.sym} 550 -380 1 0 {name=p13 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 10 150 0 0 {name=p14 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_hv_pmos.sym} -710 -550 0 0 {name=MDBIAS
l=1u
w=4u
ng=2
m=2
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 530 -300 0 0 {name=MIDC
l=1u
w=3u
ng=2
m=4
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} -520 -550 0 0 {name=MDIDC
l=1u
w=3u
ng=2
m=2
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} -110 -240 0 0 {name=MdiffINP
l=1u
w=4u
ng=2
m=4
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} -720 -350 0 0 {name=MDdiffINP
l=1u
w=4u
ng=2
m=2
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} -520 -350 0 0 {name=MDdiffINN
l=1u
w=4u
ng=2
m=2
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} -720 -200 0 0 {name=MDNMIRA
l=1u
w=4u
ng=2
m=2
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} -520 -200 0 0 {name=MDNMIRB
l=1u
w=4u
ng=2
m=2
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} -690 -350 0 1 {name=p22 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -480 -350 0 1 {name=p23 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -700 -150 0 0 {name=p24 sig_type=std_logic lab=GND}
C {lab_wire.sym} -500 -150 0 0 {name=p25 sig_type=std_logic lab=GND}
C {lab_wire.sym} -500 -590 0 0 {name=p26 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -690 -600 0 0 {name=p27 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -690 -200 2 0 {name=p30 sig_type=std_logic lab=GND}
C {lab_wire.sym} -490 -200 2 0 {name=p31 sig_type=std_logic lab=GND}
C {lab_wire.sym} 10 -370 0 0 {name=p33 sig_type=std_logic lab=Vb
}
C {lab_wire.sym} -500 -400 0 0 {name=p36 sig_type=std_logic lab=Vb
}
C {lab_wire.sym} -700 -400 0 0 {name=p35 sig_type=std_logic lab=Vb
}
C {lab_wire.sym} 0 -20 0 0 {name=p17 sig_type=std_logic lab=Vm}
C {lab_wire.sym} -680 -550 0 1 {name=p28 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -490 -550 0 1 {name=p29 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 130 30 2 0 {name=p2 sig_type=std_logic lab=GND}
C {lab_wire.sym} -100 30 2 1 {name=p3 sig_type=std_logic lab=GND}
C {lab_wire.sym} -80 -240 2 0 {name=p4 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 100 -240 2 1 {name=p9 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 50 -520 2 0 {name=p20 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 590 -340 2 0 {name=p21 sig_type=std_logic lab=VDD}

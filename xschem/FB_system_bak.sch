v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -1470 -1430 -1470 -1400 {lab=out}
N -1550 -1370 -1510 -1370 {lab=V_mem}
N -1470 -1500 -1470 -1430 {lab=out}
N -1550 -1530 -1510 -1530 {lab=V_mem}
N -1550 -1530 -1550 -1370 {lab=V_mem}
N -1510 -1760 -1510 -1700 {lab=Vmir}
N -1510 -1700 -1470 -1700 {lab=Vmir}
N -1470 -1730 -1470 -1700 {lab=Vmir}
N -1620 -1760 -1510 -1760 {lab=Vmir}
N -1650 -1670 -1360 -1670 {lab=out}
N -1470 -1430 -1360 -1430 {lab=out}
N -1360 -1670 -1360 -1430 {lab=out}
N -1360 -1430 -1300 -1430 {lab=out}
N -1580 -2050 -1580 -2000 {lab=VDD}
N -1580 -2000 -1470 -2000 {lab=VDD}
N -1690 -1730 -1690 -1700 {lab=#net1}
N -1730 -1670 -1690 -1670 {lab=VDD}
N -1470 -1700 -1470 -1560 {lab=Vmir}
N -1470 -1370 -1440 -1370 {lab=GND}
N -1470 -1160 -1470 -1060 {lab=GND}
N -1470 -1530 -1440 -1530 {lab=VDD}
N -1690 -1370 -1550 -1370 {lab=V_mem}
N -1730 -1760 -1690 -1760 {lab=VDD}
N -1730 -1820 -1690 -1820 {lab=VDD}
N -1730 -1880 -1690 -1880 {lab=VDD}
N -1730 -1940 -1690 -1940 {lab=VDD}
N -1620 -1820 -1620 -1760 {lab=Vmir}
N -1650 -1760 -1620 -1760 {lab=Vmir}
N -1650 -1820 -1620 -1820 {lab=Vmir}
N -1620 -1880 -1620 -1820 {lab=Vmir}
N -1650 -1880 -1620 -1880 {lab=Vmir}
N -1620 -1940 -1620 -1880 {lab=Vmir}
N -1650 -1940 -1620 -1940 {lab=Vmir}
N -1690 -2000 -1690 -1970 {lab=VDD}
N -1470 -1760 -1430 -1760 {lab=VDD}
N -1470 -2000 -1470 -1790 {lab=VDD}
N -1470 -1310 -1440 -1310 {lab=GND}
N -1470 -1250 -1440 -1250 {lab=GND}
N -1470 -1190 -1440 -1190 {lab=GND}
N -1550 -1370 -1550 -1310 {lab=V_mem}
N -1550 -1310 -1510 -1310 {lab=V_mem}
N -1550 -1310 -1550 -1250 {lab=V_mem}
N -1550 -1250 -1510 -1250 {lab=V_mem}
N -1550 -1250 -1550 -1190 {lab=V_mem}
N -1550 -1190 -1510 -1190 {lab=V_mem}
N -1690 -2000 -1580 -2000 {lab=VDD}
N -1690 -1640 -1690 -1370 {lab=V_mem}
N -1770 -1370 -1690 -1370 {lab=V_mem}
C {sg13g2_pr/sg13_hv_pmos.sym} -1490 -1760 0 0 {name=Mmirr
l=2u
w=4u
ng=4
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} -1670 -1670 0 1 {name=Mfbsw
l=0.5u
w=1u
ng=2
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} -1670 -1760 0 1 {name=Mmirl4
l=2u
w=1u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} -1490 -1530 0 0 {name=Mthr
l=2u
w=4u
ng=4
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {opin.sym} -1300 -1430 0 0 {name=p1 lab=out}
C {iopin.sym} -1770 -1370 0 1 {name=p2 lab=V_mem
}
C {iopin.sym} -1580 -2050 0 0 {name=p3 lab=VDD}
C {iopin.sym} -1470 -1060 0 0 {name=p5 lab=GND}
C {sg13g2_pr/sg13_hv_nmos.sym} -1490 -1370 0 0 {name=Mmem1
l=2u
w=1u
ng=1
m=2
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} -1450 -1370 0 1 {name=p4 sig_type=std_logic lab=GND}
C {lab_wire.sym} -1580 -1760 0 0 {name=p6 sig_type=std_logic lab=Vmir}
C {lab_wire.sym} -1450 -1530 0 1 {name=p7 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -1720 -1670 0 0 {name=p8 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -1720 -1760 0 0 {name=p9 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_hv_pmos.sym} -1670 -1820 0 1 {name=Mmirl3
l=2u
w=1u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} -1720 -1820 0 0 {name=p10 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_hv_pmos.sym} -1670 -1880 0 1 {name=Mmirl2
l=2u
w=1u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} -1720 -1880 0 0 {name=p11 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_hv_pmos.sym} -1670 -1940 0 1 {name=Mmirl1
l=2u
w=1u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} -1720 -1940 0 0 {name=p12 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -1440 -1760 0 1 {name=p13 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_hv_nmos.sym} -1490 -1310 0 0 {name=Mmem2
l=2u
w=1u
ng=1
m=2
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} -1450 -1310 0 1 {name=p14 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_hv_nmos.sym} -1490 -1250 0 0 {name=Mmem3
l=2u
w=1u
ng=1
m=2
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} -1450 -1250 0 1 {name=p15 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_hv_nmos.sym} -1490 -1190 0 0 {name=Mmem4
l=2u
w=1u
ng=1
m=2
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} -1450 -1190 0 1 {name=p16 sig_type=std_logic lab=GND}

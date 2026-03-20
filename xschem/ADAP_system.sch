v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -430 470 -300 470 {lab=CapAdap}
N -300 470 -300 490 {lab=CapAdap}
N -320 570 -300 570 {lab=GND}
N -300 550 -300 570 {lab=GND}
N -840 320 -790 320 {lab=V_adapt}
N -750 130 -750 200 {lab=VDD}
N -710 200 -670 200 {lab=REQ}
N -750 350 -750 430 {lab=#net1}
N -750 430 -730 430 {lab=#net1}
N -300 470 -190 470 {lab=CapAdap}
N -300 570 -150 570 {lab=GND}
N -150 470 -150 570 {lab=GND}
N -150 370 -150 440 {lab=I_in}
N -650 130 -580 130 {lab=VDD}
N -650 100 -650 130 {lab=VDD}
N -700 130 -650 130 {lab=VDD}
N -320 570 -320 610 {lab=GND}
N -580 570 -320 570 {lab=GND}
N -810 500 -730 500 {lab=V_lkahp}
N -810 470 -730 470 {lab=V_thrahp}
N -580 520 -580 570 {lab=GND}
N -580 130 -580 420 {lab=VDD}
N -730 430 -730 450 {lab=#net1}
N -730 490 -730 500 {lab=V_lkahp}
N -300 310 -300 470 {lab=CapAdap}
N -300 310 -160 310 {lab=CapAdap}
N -750 230 -750 290 {lab=#net2}
N -750 320 -700 320 {lab=VDD}
N -700 130 -700 320 {lab=VDD}
N -750 130 -700 130 {lab=VDD}
C {sg13g2_pr/sg13_hv_pmos.sym} -730 200 0 1 {name=M19
l=0.5u
w=1u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} -770 320 0 0 {name=M21
l=4u
w=4u
ng=2
m=4
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} -170 470 0 0 {name=M18
l=4u
w=4u
ng=2
m=4
model=sg13_hv_nmos
spiceprefix=X
}
C {capa.sym} -300 520 0 0 {name=Cmem2
m=1
value=2p
footprint=1206
device="ceramic capacitor"}
C {DPI.sym} -580 470 0 0 {name=Xdpi2}
C {iopin.sym} -650 100 0 0 {name=p1 lab=VDD}
C {iopin.sym} -320 610 0 0 {name=p2 lab=GND}
C {ipin.sym} -670 200 0 1 {name=p3 lab=REQ}
C {ipin.sym} -840 320 2 1 {name=p4 lab=V_adapt}
C {ipin.sym} -810 470 2 1 {name=p5 lab=V_thrahp}
C {ipin.sym} -810 500 2 1 {name=p6 lab=V_lkahp}
C {ipin.sym} -150 370 2 0 {name=p7 lab=I_in}
C {opin.sym} -160 310 2 1 {name=p8 lab=CapAdap}

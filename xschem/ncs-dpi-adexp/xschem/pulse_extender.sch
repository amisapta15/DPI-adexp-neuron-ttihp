v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 40 0 60 0 {lab=VDD}
N 40 40 40 60 {lab=#net1}
N -20 -0 -0 -0 {lab=#net1}
N 40 -80 40 -30 {lab=VDD}
N -20 0 -20 40 {lab=#net1}
N -20 40 40 40 {lab=#net1}
N 40 30 40 40 {lab=#net1}
N 40 90 60 90 {lab=VDD}
N -20 90 0 90 {lab=in_VABI}
N -20 160 -20 230 {lab=in_VABI}
N 40 160 40 200 {lab=Vcap}
N 40 230 60 230 {lab=GND}
N 40 120 40 160 {lab=Vcap}
N 40 280 40 300 {lab=GND}
N -20 230 0 230 {lab=in_VABI}
N -80 160 -20 160 {lab=in_VABI}
N -20 90 -20 160 {lab=in_VABI}
N 140 220 140 280 {lab=GND}
N 40 260 40 280 {lab=GND}
N 280 90 300 90 {lab=VDD}
N 220 90 240 90 {lab=Vcap}
N 220 160 220 230 {lab=Vcap}
N 280 230 300 230 {lab=GND}
N 280 160 280 200 {lab=out_VAO}
N 220 230 240 230 {lab=Vcap}
N 220 90 220 160 {lab=Vcap}
N 40 160 220 160 {lab=Vcap}
N 40 280 140 280 {lab=GND}
N 280 0 280 60 {lab=VDD}
N 280 160 360 160 {lab=out_VAO}
N 280 120 280 160 {lab=out_VAO}
N 280 260 280 300 {lab=GND}
C {sg13g2_pr/sg13_hv_pmos.sym} 20 0 0 0 {name=Mstarve
l=4u
w=1u
ng=2
m=4
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} 50 0 0 1 {name=p1 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_hv_pmos.sym} 20 90 0 0 {name=Mp
l=4u
w=1u
ng=2
m=4
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} 50 90 0 1 {name=p2 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_hv_nmos.sym} 20 230 0 0 {name=Mn
l=1u
w=1u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {capa.sym} 140 190 0 0 {name=C1
m=1
value=200f
footprint=1206
device="ceramic capacitor"}
C {ipin.sym} -80 160 0 0 {name=p3 lab=in_VABI}
C {opin.sym} 360 160 0 0 {name=p4 lab=out_VABO}
C {lab_wire.sym} 50 230 0 1 {name=p6 sig_type=std_logic lab=GND}
C {iopin.sym} -160 -80 0 0 {name=p5 lab=VDD}
C {iopin.sym} -160 -60 0 0 {name=p7 lab=GND}
C {sg13g2_pr/sg13_hv_pmos.sym} 260 90 0 0 {name=Mp1
l=1u
w=1u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} 290 90 0 1 {name=p8 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_hv_nmos.sym} 260 230 0 0 {name=Mn1
l=1u
w=1u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} 290 230 0 1 {name=p9 sig_type=std_logic lab=GND}
C {lab_wire.sym} 280 0 0 0 {name=p10 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 280 300 0 0 {name=p11 sig_type=std_logic lab=GND}
C {lab_wire.sym} 40 300 0 0 {name=p12 sig_type=std_logic lab=GND}
C {lab_wire.sym} 40 -80 0 0 {name=p13 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 180 160 0 0 {name=p14 sig_type=std_logic lab=Vcap}

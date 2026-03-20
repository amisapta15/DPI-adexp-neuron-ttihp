v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 0 -10 40 -10 {lab=VDD}
N 40 -80 40 -10 {lab=VDD}
N -140 -10 -40 -10 {lab=Vbias}
N 0 130 0 240 {lab=out}
N 0 20 0 70 {lab=#net1}
N -0 -130 -0 -40 {lab=VDD}
C {lab_wire.sym} 40 -40 1 0 {name=p9 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -80 -10 0 0 {name=p10 sig_type=std_logic lab=Vbias}
C {ammeter.sym} 0 100 0 1 {name=Vbias3 savecurrent=true spice_ignore=0}
C {lab_wire.sym} 0 190 0 0 {name=p7 sig_type=std_logic lab=out}
C {iopin.sym} 0 -130 3 0 {name=p1 lab=VDD}
C {ipin.sym} -140 -10 0 0 {name=p5 lab=Vbias}
C {opin.sym} 0 240 1 0 {name=p8 lab=out}
C {sg13g2_pr/sg13_hv_pmos.sym} -20 -10 0 0 {name=M13
l=1u
w=4u
ng=1
m=3
model=sg13_hv_pmos
spiceprefix=X
}

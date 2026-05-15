v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 170 -220 220 -220 {
lab=VSS}
N 170 -320 220 -320 {
lab=VDD}
N 170 -270 170 -250 {
lab=out}
N 170 -420 170 -350 {
lab=VDD}
N 220 -420 220 -320 {
lab=VDD}
N 100 -220 130 -220 {
lab=in}
N 100 -320 130 -320 {
lab=in}
N 170 -270 300 -270 {
lab=out}
N 170 -420 220 -420 {
lab=VDD}
N 100 -270 100 -220 {
lab=in}
N 170 -290 170 -270 {
lab=out}
N 60 -270 100 -270 {lab=in}
N 100 -320 100 -270 {
lab=in}
N 170 -140 220 -140 {lab=VSS}
N 220 -220 220 -140 {lab=VSS}
N 170 -190 170 -140 {lab=VSS}
N 60 -140 170 -140 {lab=VSS}
N 60 -420 170 -420 {lab=VDD}
C {devices/title.sym} 170 -40 0 0 {name=l5 author="Sapta"}
C {sg13g2_pr/sg13_lv_nmos.sym} 150 -220 0 0 {name=M1
l=0.28u
w=2.0u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 150 -320 0 0 {name=M2
l=0.28u
w=2.0u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {iopin.sym} 60 -420 2 0 {name=p1 lab=VDD}
C {ipin.sym} 60 -270 0 0 {name=p2 lab=in}
C {iopin.sym} 60 -140 2 0 {name=p3 lab=VSS}
C {opin.sym} 300 -270 0 0 {name=p4 lab=out}

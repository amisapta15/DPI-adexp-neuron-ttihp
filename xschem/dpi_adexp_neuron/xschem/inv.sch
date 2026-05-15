v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 600 -230 650 -230 {
lab=VSS}
N 600 -330 650 -330 {
lab=VDD}
N 600 -280 600 -260 {
lab=out}
N 600 -430 600 -360 {
lab=VDD}
N 650 -430 650 -330 {
lab=VDD}
N 530 -230 560 -230 {
lab=in}
N 530 -330 560 -330 {
lab=in}
N 600 -280 730 -280 {
lab=out}
N 600 -430 650 -430 {
lab=VDD}
N 530 -280 530 -230 {
lab=in}
N 600 -300 600 -280 {
lab=out}
N 490 -280 530 -280 {lab=in}
N 530 -330 530 -280 {
lab=in}
N 600 -150 650 -150 {lab=VSS}
N 650 -230 650 -150 {lab=VSS}
N 600 -200 600 -150 {lab=VSS}
N 490 -150 600 -150 {lab=VSS}
N 490 -430 600 -430 {lab=VDD}
C {devices/title.sym} 170 -40 0 0 {name=l5 author="Sapta"}
C {sg13g2_pr/sg13_lv_nmos.sym} 580 -230 0 0 {name=M1
l=0.28u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 580 -330 0 0 {name=M2
l=0.28u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {iopin.sym} 490 -430 2 0 {name=p1 lab=VDD}
C {ipin.sym} 490 -280 0 0 {name=p2 lab=in}
C {iopin.sym} 490 -150 2 0 {name=p3 lab=VSS}
C {opin.sym} 730 -280 0 0 {name=p4 lab=out}

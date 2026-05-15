v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 400 -250 450 -250 {
lab=VSS}
N 400 -350 450 -350 {
lab=VDD}
N 400 -450 400 -380 {
lab=VDD}
N 450 -450 450 -350 {
lab=VDD}
N 330 -250 360 -250 {
lab=in}
N 330 -350 360 -350 {
lab=in}
N 400 -450 450 -450 {
lab=VDD}
N 330 -300 330 -250 {
lab=in}
N 400 -300 400 -280 {
lab=#net1}
N 290 -300 330 -300 {lab=in}
N 330 -350 330 -300 {
lab=in}
N 400 -170 450 -170 {lab=VSS}
N 450 -250 450 -170 {lab=VSS}
N 400 -220 400 -170 {lab=VSS}
N 290 -170 400 -170 {lab=VSS}
N 290 -450 400 -450 {lab=VDD}
N 570 -300 570 -280 {lab=out}
N 490 -350 530 -350 {lab=#net1}
N 490 -300 490 -250 {lab=#net1}
N 490 -250 530 -250 {lab=#net1}
N 400 -300 490 -300 {lab=#net1}
N 400 -320 400 -300 {
lab=#net1}
N 490 -350 490 -300 {lab=#net1}
N 570 -300 700 -300 {lab=out}
N 570 -320 570 -300 {lab=out}
N 570 -250 650 -250 {lab=VSS}
N 650 -250 650 -170 {lab=VSS}
N 570 -170 650 -170 {lab=VSS}
N 570 -220 570 -170 {lab=VSS}
N 450 -170 570 -170 {lab=VSS}
N 570 -350 640 -350 {lab=VDD}
N 640 -450 640 -350 {lab=VDD}
N 570 -450 640 -450 {lab=VDD}
N 570 -450 570 -380 {lab=VDD}
N 450 -450 570 -450 {lab=VDD}
C {sg13g2_pr/sg13_lv_nmos.sym} 380 -250 0 0 {name=M1
l=0.28u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 380 -350 0 0 {name=M2
l=0.28u
w=2.4u
ng=2
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {iopin.sym} 290 -450 2 0 {name=p1 lab=VDD}
C {ipin.sym} 290 -300 0 0 {name=p2 lab=in}
C {iopin.sym} 290 -170 2 0 {name=p3 lab=VSS}
C {opin.sym} 700 -300 0 0 {name=p4 lab=out}
C {sg13g2_pr/sg13_lv_nmos.sym} 550 -250 0 0 {name=M4
l=0.28u
w=3.0u
ng=4
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 550 -350 0 0 {name=M5
l=0.28u
w=6.0u
ng=4
m=1
model=sg13_lv_pmos
spiceprefix=X
}

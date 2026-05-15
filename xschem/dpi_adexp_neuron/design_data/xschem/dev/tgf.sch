v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -1100 -410 -1050 -410 {
lab=VSS}
N -1100 -510 -1050 -510 {
lab=VDD}
N -1100 -460 -1100 -440 {
lab=#net1}
N -1100 -610 -1100 -540 {
lab=VDD}
N -1050 -610 -1050 -510 {
lab=VDD}
N -1170 -410 -1140 -410 {
lab=C}
N -1170 -510 -1140 -510 {
lab=C}
N -1100 -460 -970 -460 {
lab=#net1}
N -1080 -610 -1050 -610 {
lab=VDD}
N -1170 -450 -1170 -410 {
lab=C}
N -1100 -480 -1100 -460 {
lab=#net1}
N -910 -690 -870 -690 {lab=A}
N -910 -530 -910 -380 {lab=A}
N -910 -380 -860 -380 {lab=A}
N -940 -530 -910 -530 {lab=A}
N -910 -690 -910 -530 {lab=A}
N -810 -690 -770 -690 {lab=B}
N -800 -380 -770 -380 {lab=B}
N -770 -530 -770 -380 {lab=B}
N -770 -530 -760 -530 {lab=B}
N -770 -690 -770 -530 {lab=B}
N -1210 -730 -840 -730 {lab=C}
N -1210 -730 -1210 -450 {lab=C}
N -1220 -730 -1210 -730 {lab=C}
N -1210 -450 -1170 -450 {lab=C}
N -1170 -510 -1170 -450 {
lab=C}
N -970 -340 -830 -340 {lab=#net1}
N -970 -460 -970 -340 {lab=#net1}
N -1270 -750 -1080 -750 {lab=VDD}
N -1080 -750 -1080 -610 {lab=VDD}
N -1100 -610 -1080 -610 {
lab=VDD}
N -1230 -310 -1100 -310 {lab=VSS}
N -1100 -380 -1100 -310 {lab=VSS}
N -1050 -410 -1050 -310 {lab=VSS}
N -1100 -310 -1050 -310 {lab=VSS}
N -830 -410 -830 -380 {lab=VSS}
N -1050 -310 -710 -310 {lab=VSS}
N -710 -410 -710 -310 {lab=VSS}
N -830 -410 -710 -410 {lab=VSS}
N -1080 -750 -710 -750 {lab=VDD}
N -710 -750 -710 -670 {lab=VDD}
N -840 -670 -710 -670 {lab=VDD}
N -840 -690 -840 -670 {lab=VDD}
C {devices/title.sym} -1360 -150 0 0 {name=l5 author="Sapta"}
C {sg13g2_pr/sg13_lv_nmos.sym} -1120 -410 0 0 {name=M1
l=0.28u
w=2.0u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -1120 -510 0 0 {name=M2
l=0.28u
w=2.0u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -830 -360 3 0 {name=M3
l=0.28u
w=2.0u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -840 -710 1 0 {name=M4
l=0.28u
w=2.0u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {ipin.sym} -940 -530 0 0 {name=p1 lab=A}
C {opin.sym} -760 -530 0 0 {name=p2 lab=B}
C {ipin.sym} -1220 -730 0 0 {name=p3 lab=C}
C {iopin.sym} -1270 -750 2 0 {name=p4 lab=VDD}
C {iopin.sym} -1230 -310 2 0 {name=p5 lab=VSS}

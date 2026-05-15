v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -490 -440 -490 -430 {lab=VDD}
N -560 -400 -490 -400 {lab=VDD}
N -560 -440 -560 -400 {lab=VDD}
N -490 -460 -490 -440 {lab=VDD}
N -490 -370 -490 -340 {lab=#net1}
N -450 -400 -420 -400 {lab=vg}
N -790 -380 -790 -350 {lab=vg}
N -580 -170 -490 -170 {lab=VDD}
N -580 -440 -580 -170 {lab=VDD}
N -560 -440 -490 -440 {lab=VDD}
N -580 -440 -560 -440 {lab=VDD}
N -490 -200 -490 -170 {lab=VDD}
N -490 -280 -490 -260 {lab=#net2}
C {sg13g2_pr/sg13_lv_pmos.sym} -470 -400 0 1 {name=M6
l=0.45u
w=1.0u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {vdd.sym} -490 -460 0 0 {name=l6 lab=VDD}
C {devices/vsource.sym} -660 -390 0 0 {name=Vdd value=1.2}
C {vdd.sym} -660 -420 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} -660 -360 0 0 {name=l8 lab=GND}
C {devices/ammeter.sym} -490 -310 0 0 {name=VDS}
C {devices/code_shown.sym} -330 50 0 0 {name=NGSPICE only_toplevel=true 
value="

.options savecurrents
.include Csource.save

.param temp=27
.control
save all 

op

write Csourceraw
set appendwrite

dc VT 0 0.5 0.01 VT1 0 3.3 0.1

plot i(VDS)

write Csource.raw
.endc
"}
C {devices/code_shown.sym} -660 70 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {sg13g2_pr/annotate_fet_params.sym} -760 -260 0 0 {name=annot2 ref=M6}
C {devices/vsource.sym} -790 -410 0 0 {name=VT value=0.060068}
C {lab_pin.sym} -790 -350 2 0 {name=p5 sig_type=std_logic lab=vg
}
C {lab_pin.sym} -420 -400 2 0 {name=p1 sig_type=std_logic lab=vg
}
C {vdd.sym} -790 -440 0 0 {name=l3 lab=VDD}
C {devices/vsource.sym} -490 -230 2 0 {name=VT1 value=0}

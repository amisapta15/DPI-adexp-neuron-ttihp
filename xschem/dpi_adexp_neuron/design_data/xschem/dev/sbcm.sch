v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -130 -850 -130 -840 {lab=VDD}
N -130 -780 -130 -760 {lab=GND}
N 250 -850 250 -820 {lab=VDD}
N 110 -850 110 -820 {lab=VDD}
N 110 -850 250 -850 {lab=VDD}
N 170 -790 210 -790 {lab=#net1}
N 110 -620 110 -580 {lab=#net1}
N 250 -760 250 -680 {lab=#net2}
N 150 -790 170 -790 {lab=#net1}
N 190 -650 210 -650 {lab=#net3}
N 110 -760 110 -680 {lab=#net4}
N 170 -790 170 -580 {lab=#net1}
N 50 -420 50 -400 {lab=GND}
N 480 -510 480 -420 {lab=ibias}
N 480 -420 530 -420 {lab=ibias}
N 590 -420 610 -420 {lab=GND}
N 50 -490 50 -480 {lab=#net3}
N 50 -580 50 -560 {lab=#net1}
N 50 -580 110 -580 {lab=#net1}
N 10 -850 10 -530 {lab=VDD}
N 10 -850 110 -850 {lab=VDD}
N 110 -580 170 -580 {lab=#net1}
N 50 -500 50 -490 {lab=#net3}
N 190 -650 190 -490 {lab=#net3}
N 150 -650 190 -650 {lab=#net3}
N 50 -490 190 -490 {lab=#net3}
N 420 -850 420 -760 {lab=VDD}
N 250 -850 420 -850 {lab=VDD}
N 420 -700 420 -550 {lab=#net5}
N 250 -620 250 -510 {lab=ibias}
N 250 -510 480 -510 {lab=ibias}
C {devices/code_shown.sym} 150 -360 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.include diodes.lib
.include sg13g2_bondpad.lib
"}
C {devices/code_shown.sym} -590 -650 0 0 {name=NGSPICE only_toplevel=true 
value="
.options savecurrents
.include sbcm.save
.param temp=27
.control
set wr_singlescale
set noaskquit
*set appendwrite
set hcopypscolor=1

*Save node voltages and device currents if desired
save all

*Baseline operating point at current deck values
op
write sbcm.raw
*dc Vload 0 5.0 0.1
tran 100p 1u
write sbcm.raw
*plot -i(Vload)
plot v(ibias)/50
*quit
.endc
"}
C {simulator_commands_shown.sym} 150 -180 0 0 {
name=Libs_Ngspice
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
"

"
      }
C {devices/vsource.sym} -130 -810 0 0 {name=Vdd1 value=1.8}
C {devices/gnd.sym} -130 -760 0 0 {name=l23 lab=GND}
C {vdd.sym} -130 -850 0 0 {name=l24 lab=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} 230 -790 0 0 {name=M6
l=0.5u
w=15.0u
ng=5
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {vdd.sym} 180 -850 0 1 {name=l4 lab=VDD}
C {lab_pin.sym} 110 -790 0 0 {name=p8 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 250 -790 0 1 {name=p9 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} 130 -790 0 1 {name=M9
l=0.5u
w=15.0u
ng=5
m=10
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 230 -650 0 0 {name=M1
l=0.5u
w=15.0u
ng=5
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 110 -650 0 0 {name=p1 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 250 -650 0 1 {name=p2 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} 130 -650 0 1 {name=M2
l=0.5u
w=15.0u
ng=5
m=10
model=sg13_lv_pmos
spiceprefix=X
}
C {isource.sym} 50 -450 0 0 {name=IREF value=300n}
C {devices/gnd.sym} 50 -400 0 0 {name=l29 lab=GND}
C {res.sym} 560 -420 3 0 {name=R1
value=50
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 610 -420 0 0 {name=l1 lab=GND}
C {lab_wire.sym} 500 -420 1 0 {name=p3 sig_type=std_logic lab=ibias}
C {sg13g2_pr/sg13_lv_nmos.sym} 30 -530 0 0 {name=M23
l=0.5u
w=21.0u
ng=7
m=10
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 50 -530 0 1 {name=p4 sig_type=std_logic lab=GND}
C {devices/vsource.sym} 420 -730 0 0 {name=Vload value=0}
C {noconn.sym} 420 -550 0 0 {name=l2}

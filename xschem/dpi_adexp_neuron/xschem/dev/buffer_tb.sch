v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
P 4 1 -760 -150 {}
N -680 -610 -680 -440 {lab=#net1}
N -680 -380 -680 -330 {lab=GND}
N -430 -610 -430 -490 {lab=#net1}
N -680 -610 -430 -610 {lab=#net1}
N -430 -410 -430 -350 {lab=GND}
N -590 -390 -590 -330 {lab=GND}
N -590 -450 -470 -450 {lab=in}
N -430 -610 -280 -610 {lab=#net1}
N -390 -450 -320 -450 {lab=out}
N -240 -450 -100 -450 {lab=outB}
N -280 -610 -280 -480 {lab=#net1}
N -280 -420 -280 -350 {lab=GND}
C {devices/vsource.sym} -680 -410 0 0 {name=Vdd value=1.65}
C {devices/gnd.sym} -680 -330 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} -590 -420 0 0 {name=Vin value="dc 0 ac 0 pulse(0, 1.65, 0, 100p, 100p, 2n, 4n ) "}
C {devices/code_shown.sym} -1010 -590 0 0 {name=NGSPICE only_toplevel=true 
value="
.param temp=27

.control
save all
tran 50p 20n

* plot waveforms
plot v(in) v(out) v(outB)
.endc

"}
C {devices/code_shown.sym} -1010 -160 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib $::SG13G2_MODELS/cornerMOSlv.lib mos_tt
.lib $::SG13G2_MODELS/cornerRES.lib res_typ_stat
"}
C {devices/gnd.sym} -590 -330 0 0 {name=l2 lab=GND}
C {inv.sym} -450 -450 0 0 {name=xinv1}
C {devices/gnd.sym} -430 -350 0 0 {name=l3 lab=GND}
C {devices/lab_pin.sym} -550 -450 1 0 {name=p2 sig_type=std_logic lab=in}
C {devices/lab_pin.sym} -160 -450 1 0 {name=p1 sig_type=std_logic lab=outB}
C {buff.sym} -320 -480 0 0 {name=xbuff1}
C {noconn.sym} -100 -450 2 0 {name=l4}
C {devices/gnd.sym} -280 -350 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} -360 -450 1 0 {name=p3 sig_type=std_logic lab=out}

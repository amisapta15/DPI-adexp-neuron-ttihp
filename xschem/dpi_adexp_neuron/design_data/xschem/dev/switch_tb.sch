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
N -140 -540 -70 -540 {lab=rstn}
N -430 -410 -430 -350 {lab=GND}
N -590 -390 -590 -330 {lab=GND}
N -590 -450 -470 -450 {lab=in}
N -590 -550 -200 -550 {lab=in}
N -590 -550 -590 -450 {lab=in}
N -290 -540 -200 -540 {lab=#net1}
N -290 -610 -290 -540 {lab=#net1}
N -430 -610 -290 -610 {lab=#net1}
N -140 -440 -70 -440 {lab=rst}
N -170 -410 -170 -380 {lab=GND}
N -260 -280 -260 -270 {lab=GND}
N -390 -450 -200 -450 {lab=out1}
N -260 -440 -200 -440 {lab=#net2}
N -260 -440 -260 -340 {lab=#net2}
N -170 -510 -170 -500 {lab=GND}
C {tgf.sym} -200 -570 0 0 {name=xtg1}
C {devices/vsource.sym} -680 -410 0 0 {name=Vdd value=1.8}
C {devices/gnd.sym} -680 -330 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} -590 -420 0 0 {name=Vin value="dc 0 ac 0 pulse(0, 1.8, 0, 100p, 100p, 2n, 4n ) "}
C {devices/code_shown.sym} -1010 -590 0 0 {name=NGSPICE only_toplevel=true 
value="
.param temp=27

.control
save all
tran 50p 20n

* plot waveforms
plot v(in) v(out1)
plot v(in) v(rst)
plot v(in) v(rstn)

write tran_tgf_test.raw
.endc

"}
C {devices/code_shown.sym} -1010 -160 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib $::SG13G2_MODELS/cornerMOSlv.lib mos_tt
.lib $::SG13G2_MODELS/cornerRES.lib res_typ_stat
"}
C {devices/gnd.sym} -590 -330 0 0 {name=l2 lab=GND}
C {devices/gnd.sym} -170 -380 0 0 {name=l4 lab=GND}
C {noconn.sym} -70 -540 2 0 {name=l5}
C {inv.sym} -450 -450 0 0 {name=xinv1}
C {devices/gnd.sym} -430 -350 0 0 {name=l3 lab=GND}
C {devices/lab_pin.sym} -550 -450 1 0 {name=p2 sig_type=std_logic lab=in}
C {devices/lab_pin.sym} -90 -540 1 0 {name=p3 sig_type=std_logic lab=rstn}
C {devices/lab_pin.sym} -340 -450 1 0 {name=p1 sig_type=std_logic lab=out1}
C {tgf.sym} -200 -470 0 0 {name=xtg2}
C {devices/lab_pin.sym} -100 -440 1 0 {name=p4 sig_type=std_logic lab=rst}
C {devices/vsource.sym} -260 -310 0 0 {name=Vc value=0.2}
C {devices/gnd.sym} -260 -270 0 0 {name=l7 lab=GND}
C {devices/gnd.sym} -170 -500 0 0 {name=l8 lab=GND}
C {noconn.sym} -70 -440 2 0 {name=l6}

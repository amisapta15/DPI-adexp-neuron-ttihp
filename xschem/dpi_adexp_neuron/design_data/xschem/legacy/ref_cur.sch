v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 310 -470 340 -470 {lab=#net1}
N 310 -390 340 -390 {lab=#net1}
N 380 -440 380 -420 {lab=#net2}
N 310 -430 310 -390 {lab=#net1}
N 280 -430 310 -430 {lab=#net1}
N 310 -470 310 -430 {lab=#net1}
N 380 -360 380 -340 {lab=#net3}
N 310 -550 340 -550 {lab=#net4}
N 310 -510 380 -510 {lab=#net4}
N 380 -510 380 -500 {lab=#net4}
N 310 -550 310 -510 {lab=#net4}
N 380 -520 380 -510 {lab=#net4}
N 380 -600 380 -580 {lab=#net5}
N -380 -580 -380 -550 {lab=GND}
N -160 -690 -130 -690 {lab=CLK1}
N -160 -610 -130 -610 {lab=CLK1}
N -90 -660 -90 -640 {lab=#net6}
N -160 -650 -160 -610 {lab=CLK1}
N -90 -580 -90 -560 {lab=#net7}
N -380 -640 -160 -650 {lab=CLK1}
N -160 -690 -160 -650 {lab=CLK1}
C {devices/code_shown.sym} -790 -260 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.include diodes.lib
.include sg13g2_bondpad.lib
"}
C {devices/code_shown.sym} -790 -160 0 0 {name=NGSPICE only_toplevel=true 
value="
.param temp=127
.control
save all 
tran 500p 2000n
write tran_neuron.raw
plot vp VLK
plot REQ RST ACK vmem
.endc
"}
C {simulator_commands_shown.sym} -790 -400 0 0 {
name=Libs_Ngspice
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
"
      }
C {devices/vsource.sym} -290 -330 0 0 {name=Vdd value=1.65}
C {devices/gnd.sym} 110 -170 0 0 {name=l3 lab=GND}
C {sg13g2_pr/sg13_lv_pmos.sym} 360 -470 0 0 {name=M7
l=0.15u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 380 -470 0 1 {name=p29 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_nmos.sym} 360 -390 0 0 {name=M12
l=0.15u
w=0.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 380 -390 0 1 {name=p30 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} 360 -310 0 0 {name=M19
l=0.15u
w=0.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 380 -310 0 1 {name=p31 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_lv_pmos.sym} 360 -550 0 0 {name=M20
l=0.15u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 380 -550 0 1 {name=p33 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} 360 -630 0 0 {name=M21
l=0.15u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 380 -630 0 1 {name=p34 sig_type=std_logic lab=VDD}
C {vdd.sym} 380 -660 0 0 {name=l14 lab=VDD}
C {capa.sym} 110 -370 0 0 {name=C3
m=1
value=0.5p
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} -380 -640 1 0 {name=p38 sig_type=std_logic lab=CLK1}
C {devices/vsource.sym} -380 -610 0 0 {name=clks value="PULSE(0 1.65 0 1ns 1ns 50ns 1s)"}
C {devices/gnd.sym} -380 -550 0 0 {name=l16 lab=GND}
C {sg13g2_pr/sg13_lv_pmos.sym} -110 -690 0 0 {name=M1
l=0.15u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} -90 -690 0 1 {name=p1 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_nmos.sym} -110 -610 0 0 {name=M2
l=0.15u
w=0.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} -90 -610 0 1 {name=p2 sig_type=std_logic lab=GND}

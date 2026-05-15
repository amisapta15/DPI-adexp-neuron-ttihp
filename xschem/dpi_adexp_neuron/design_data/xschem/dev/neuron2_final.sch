v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 40 -760 840 -360 {flags=graph,unlocked
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
divx=5
subdivx=1
dataset=-1
unitx=1
logx=0
logy=0
autoload=1
sim_type=tran
rawfile=$netlist_dir/tran_neuron.raw
color="5 15 9 9"
node="vmem
vn1
vlk
vthr"
rainbow=1
y1=0
x1=7.1808361e-08
x2=1.0871808e-05
y2=1}
B 2 40 -1170 840 -770 {flags=graph
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
divx=5
subdivx=1
dataset=-1
unitx=1
logx=0
logy=0
rawfile=$netlist_dir/tran_neuron.raw
sim_type=tran
color="4 5"
node="out
vmem"
y2=1.9477697
x2=4.9816678e-06
y1=0
x1=-1.042983e-07}
T {ITHR goes 
from 5/10u to 60u } -250 -10 0 0 0.4 0.4 {}
T {ILK goes 
from 1n to 0.1u 
from high to low firing rate} 240 210 0 0 0.4 0.4 {}
T {IREF goes 
from 0.05u to 0.5u } 40 220 0 0 0.4 0.4 {}
N 610 50 610 80 {lab=vn1}
N 760 160 760 190 {lab=vmem}
N 610 50 760 50 {lab=vn1}
N 610 10 610 50 {lab=vn1}
N 760 50 760 80 {lab=vn1}
N 610 -80 610 -50 {lab=VDD}
N 820 110 920 110 {lab=vmem}
N 820 110 820 160 {lab=vmem}
N 800 110 820 110 {lab=vmem}
N 760 160 820 160 {lab=vmem}
N 760 140 760 160 {lab=vmem}
N 760 310 760 340 {lab=GND}
N 920 240 920 340 {lab=GND}
N 610 140 610 310 {lab=GND}
N 610 310 760 310 {lab=GND}
N 760 250 760 310 {lab=GND}
N 920 110 920 180 {lab=vmem}
N 690 220 720 220 {lab=VLK}
N 550 110 570 110 {lab=VTHR}
N 440 -200 440 -190 {lab=VDD}
N 440 -130 440 -110 {lab=GND}
N 330 130 350 130 {lab=VLK}
N 290 80 290 100 {lab=VLK}
N 350 80 350 130 {lab=VLK}
N 290 80 350 80 {lab=VLK}
N 130 70 130 110 {lab=VREF}
N 190 140 210 140 {lab=VREF}
N 190 70 190 140 {lab=VREF}
N 170 140 190 140 {lab=VREF}
N 130 70 190 70 {lab=VREF}
N 130 40 130 70 {lab=VREF}
N 130 170 130 180 {lab=GND}
N 130 -30 130 -20 {lab=VDD}
N 290 -10 290 0 {lab=VDD}
N 290 60 290 80 {lab=VLK}
N 350 130 380 130 {lab=VLK}
N 290 160 290 180 {lab=GND}
N 1120 300 1120 390 {lab=GND}
N 1260 -60 1260 -40 {lab=#net1}
N 1120 -150 1120 -120 {lab=VDD}
N 1260 -150 1260 -120 {lab=VDD}
N 1120 -150 1260 -150 {lab=VDD}
N 1190 -90 1220 -90 {lab=#net1}
N 1190 -90 1190 -40 {lab=#net1}
N 1190 -40 1260 -40 {lab=#net1}
N 1160 -90 1190 -90 {lab=#net1}
N 1120 -60 1120 -30 {lab=#net2}
N 1120 110 1120 240 {lab=vmem}
N 1190 40 1220 40 {lab=vmem}
N 1260 80 1260 90 {lab=REQ}
N 1260 160 1260 170 {lab=#net3}
N 1260 230 1260 390 {lab=GND}
N 1260 -40 1260 10 {lab=#net1}
N 1190 80 1190 120 {lab=vmem}
N 1190 120 1220 120 {lab=vmem}
N 1190 160 1260 160 {lab=#net3}
N 1260 150 1260 160 {lab=#net3}
N 1190 160 1190 200 {lab=#net3}
N 1190 200 1220 200 {lab=#net3}
N 1120 80 1190 80 {lab=vmem}
N 1120 30 1120 80 {lab=vmem}
N 1190 40 1190 80 {lab=vmem}
N 1260 70 1260 80 {lab=REQ}
N 1160 0 1170 0 {lab=REQ}
N 1410 40 1440 40 {lab=REQ}
N 1480 80 1480 90 {lab=#net4}
N 1410 120 1440 120 {lab=REQ}
N 1480 70 1480 80 {lab=#net4}
N 1410 80 1410 120 {lab=REQ}
N 1380 80 1410 80 {lab=REQ}
N 1410 40 1410 80 {lab=REQ}
N 1480 150 1480 170 {lab=#net5}
N 1480 230 1480 390 {lab=GND}
N 1410 -40 1440 -40 {lab=#net6}
N 1410 0 1480 0 {lab=#net6}
N 1480 0 1480 10 {lab=#net6}
N 1410 -40 1410 0 {lab=#net6}
N 1480 -10 1480 0 {lab=#net6}
N 1480 -90 1480 -70 {lab=#net7}
N 1420 200 1440 200 {lab=VREF}
N 1380 -120 1440 -120 {lab=REQ}
N 1480 -370 1480 -350 {lab=VDD}
N 1740 -320 1740 -290 {lab=OUT}
N 1520 -320 1550 -320 {lab=#net8}
N 1630 -320 1740 -320 {lab=OUT}
N 1590 -370 1590 -360 {lab=VDD}
N 1170 -20 1170 0 {lab=REQ}
N 1380 -20 1380 80 {lab=REQ}
N 1170 -20 1380 -20 {lab=REQ}
N 1120 80 1120 110 {lab=vmem}
N 1260 80 1380 80 {lab=REQ}
N -30 50 -30 90 {lab=VTHR}
N 30 120 50 120 {lab=VTHR}
N 30 50 30 120 {lab=VTHR}
N 10 120 30 120 {lab=VTHR}
N -30 50 30 50 {lab=VTHR}
N -30 20 -30 50 {lab=VTHR}
N -30 150 -30 160 {lab=GND}
N -30 -50 -30 -40 {lab=VDD}
N 1380 -120 1380 -20 {lab=REQ}
N 1790 40 1820 40 {lab=#net4}
N 1860 80 1860 90 {lab=#net9}
N 1790 120 1820 120 {lab=#net4}
N 1860 70 1860 80 {lab=#net9}
N 1790 80 1790 120 {lab=#net4}
N 1790 40 1790 80 {lab=#net4}
N 1860 150 1860 170 {lab=GND}
N 1860 80 2040 80 {lab=#net9}
N 1790 -40 1820 -40 {lab=#net10}
N 1790 0 1860 0 {lab=#net10}
N 1860 0 1860 10 {lab=#net10}
N 1790 -40 1790 0 {lab=#net10}
N 1860 -10 1860 0 {lab=#net10}
N 1860 -90 1860 -70 {lab=VDD}
N 1480 80 1790 80 {lab=#net4}
N 2040 40 2070 40 {lab=#net9}
N 2110 80 2110 90 {lab=RST}
N 2040 120 2070 120 {lab=#net9}
N 2110 70 2110 80 {lab=RST}
N 2110 150 2110 170 {lab=GND}
N 2330 80 2550 80 {lab=RST}
N 2040 -40 2070 -40 {lab=#net11}
N 2040 0 2110 0 {lab=#net11}
N 2110 0 2110 10 {lab=#net11}
N 2110 -10 2110 0 {lab=#net11}
N 2110 -90 2110 -70 {lab=VDD}
N 2040 -40 2040 -0 {lab=#net11}
N 2040 80 2040 120 {lab=#net9}
N 2040 40 2040 80 {lab=#net9}
N 1160 270 2550 270 {lab=RST}
N 1380 -320 1380 -120 {lab=REQ}
N 1380 -320 1440 -320 {lab=REQ}
N 1590 -280 1590 -240 {lab=GND}
N 1480 -290 1480 -260 {lab=GND}
N 920 110 1120 110 {lab=vmem}
N 2330 80 2330 120 {lab=RST}
N 2110 80 2330 80 {lab=RST}
N 2330 180 2330 210 {lab=GND}
N 2550 80 2550 270 {lab=RST}
C {devices/code_shown.sym} -630 -360 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.include diodes.lib
.include sg13g2_bondpad.lib
"}
C {devices/code_shown.sym} -640 -1040 0 0 {name=NGSPICE only_toplevel=true 
value="
.options savecurrents
.include neuron_buff_test.save
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
write tran_neuron.raw

*alter Vdd1 dc 1.7
*alter Vthr dc 0.9
*alter Vlk dc 0.3
*alter vahp1 dc 1.0
tran 10n 10u
write tran_neuron.raw
*Example plots (uncomment inside ngspice if you want autoplots)
plot vmem vn1 Vthr Vlk
plot vmem out
*quit
.endc
"}
C {simulator_commands_shown.sym} -630 -180 0 0 {
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
C {isource.sym} 610 -20 0 0 {name=Iin value=0.6u}
C {sg13g2_pr/sg13_lv_nmos.sym} 740 220 0 0 {name=M3
l=3.0u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 590 110 0 0 {name=M1
l=0.75u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 780 110 0 1 {name=M4
l=0.75u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {devices/gnd.sym} 760 340 0 0 {name=l3 lab=GND}
C {vdd.sym} 610 -80 0 0 {name=l1 lab=VDD}
C {lab_wire.sym} 870 110 0 0 {name=p1 sig_type=std_logic lab=vmem}
C {lab_pin.sym} 760 110 0 0 {name=p2 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 610 110 0 1 {name=p3 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 760 220 0 1 {name=p4 sig_type=std_logic lab=GND}
C {lab_wire.sym} 720 50 0 0 {name=p5 sig_type=std_logic lab=vn1}
C {lab_wire.sym} 690 220 0 0 {name=p17 sig_type=std_logic lab=VLK}
C {devices/gnd.sym} 920 340 0 0 {name=l17 lab=GND}
C {devices/launcher.sym} 130 -300 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/tran_neuron.raw tran"
}
C {lab_wire.sym} 550 110 1 0 {name=p18 sig_type=std_logic lab=VTHR}
C {sg13g2_pr/cap_cmim.sym} 920 210 0 0 {name=C5
model=cap_cmim
w=10.0e-6
l=10.0e-6
m=8
spiceprefix=X}
C {devices/vsource.sym} 440 -160 0 0 {name=Vdd1 value=1.8}
C {devices/gnd.sym} 440 -110 0 0 {name=l23 lab=GND}
C {vdd.sym} 440 -200 0 0 {name=l24 lab=VDD}
C {lab_wire.sym} 50 120 1 0 {name=p45 sig_type=std_logic lab=VTHR}
C {sg13g2_pr/sg13_lv_nmos.sym} 310 130 0 1 {name=M23
l=3.0u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {isource.sym} 290 30 0 0 {name=ILK value=10n}
C {vdd.sym} 290 -10 0 0 {name=l26 lab=VDD}
C {lab_pin.sym} 290 130 2 1 {name=p40 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} 150 140 0 1 {name=M24
l=3.0u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {isource.sym} 130 10 0 0 {name=IVREF value=0.5u}
C {vdd.sym} 130 -30 0 0 {name=l25 lab=VDD}
C {lab_pin.sym} 210 140 1 0 {name=p38 sig_type=std_logic lab=VREF}
C {lab_pin.sym} 130 140 2 1 {name=p37 sig_type=std_logic lab=GND}
C {devices/gnd.sym} 130 180 0 0 {name=l11 lab=GND}
C {devices/gnd.sym} 290 180 0 0 {name=l31 lab=GND}
C {lab_wire.sym} 380 130 0 1 {name=p35 sig_type=std_logic lab=VLK}
C {sg13g2_pr/sg13_lv_nmos.sym} 1140 270 0 1 {name=M5
l=0.28u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 1120 270 0 0 {name=p7 sig_type=std_logic lab=GND}
C {devices/gnd.sym} 1120 390 0 0 {name=l2 lab=GND}
C {sg13g2_pr/sg13_lv_pmos.sym} 1140 -90 0 1 {name=M6
l=3.0u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {vdd.sym} 1190 -150 0 0 {name=l4 lab=VDD}
C {lab_pin.sym} 1260 -90 0 1 {name=p8 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1120 -90 0 0 {name=p9 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} 1140 0 0 1 {name=M8
l=0.28u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 1120 0 0 0 {name=p10 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} 1240 -90 0 0 {name=M9
l=3.0u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1240 40 0 0 {name=M10
l=0.28u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 1260 40 0 1 {name=p11 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_nmos.sym} 1240 120 0 0 {name=M11
l=0.28u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 1260 120 0 1 {name=p12 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} 1240 200 0 0 {name=M25
l=3.0u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 1260 200 0 1 {name=p14 sig_type=std_logic lab=GND}
C {devices/gnd.sym} 1260 390 0 0 {name=l6 lab=GND}
C {sg13g2_pr/sg13_lv_pmos.sym} 1460 40 0 0 {name=M26
l=0.28u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 1480 40 0 1 {name=p15 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_nmos.sym} 1460 120 0 0 {name=M27
l=0.28u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 1480 120 0 1 {name=p16 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} 1460 200 0 0 {name=M28
l=3.0u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 1480 200 0 1 {name=p25 sig_type=std_logic lab=GND}
C {devices/gnd.sym} 1480 390 0 0 {name=l9 lab=GND}
C {lab_wire.sym} 1390 270 0 0 {name=p26 sig_type=std_logic lab=RST}
C {sg13g2_pr/sg13_lv_pmos.sym} 1460 -40 0 0 {name=M29
l=3.0u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 1480 -40 0 1 {name=p28 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} 1460 -120 0 0 {name=M30
l=0.28u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 1480 -120 0 1 {name=p41 sig_type=std_logic lab=VDD}
C {vdd.sym} 1480 -150 0 0 {name=l15 lab=VDD}
C {lab_pin.sym} 1420 200 0 0 {name=p42 sig_type=std_logic lab=VREF}
C {buff.sym} 1440 -350 0 0 {name=xbuff2}
C {vdd.sym} 1480 -370 0 0 {name=l27 lab=VDD}
C {lab_wire.sym} 1740 -320 2 0 {name=p43 sig_type=std_logic lab=OUT}
C {devices/gnd.sym} 1590 -240 0 0 {name=l28 lab=GND}
C {inv.sym} 1570 -320 0 0 {name=xinv2}
C {vdd.sym} 1590 -370 0 0 {name=l29 lab=VDD}
C {lab_wire.sym} 1380 -80 2 0 {name=p44 sig_type=std_logic lab=REQ}
C {noconn.sym} 1740 -290 2 0 {name=l33}
C {sg13g2_pr/sg13_lv_nmos.sym} -10 120 0 1 {name=M2
l=3.0u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {isource.sym} -30 -10 0 0 {name=ITHR value=0.9u}
C {vdd.sym} -30 -50 0 0 {name=l5 lab=VDD}
C {lab_pin.sym} -30 120 2 1 {name=p13 sig_type=std_logic lab=GND}
C {devices/gnd.sym} -30 160 0 0 {name=l7 lab=GND}
C {sg13g2_pr/cap_cmim.sym} 2330 150 0 0 {name=C2
model=cap_cmim
w=10.0e-6
l=10.0e-6
m=8
spiceprefix=X}
C {devices/gnd.sym} 2330 210 0 0 {name=l10 lab=GND}
C {sg13g2_pr/sg13_lv_pmos.sym} 1840 40 0 0 {name=M7
l=0.28u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 1860 40 0 1 {name=p6 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_nmos.sym} 1840 120 0 0 {name=M12
l=0.28u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 1860 120 0 1 {name=p19 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_lv_pmos.sym} 1840 -40 0 0 {name=M14
l=3.0u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 1860 -40 0 1 {name=p22 sig_type=std_logic lab=VDD}
C {vdd.sym} 1860 -90 0 0 {name=l12 lab=VDD}
C {devices/gnd.sym} 1860 170 0 0 {name=l8 lab=GND}
C {sg13g2_pr/sg13_lv_pmos.sym} 2090 40 0 0 {name=M13
l=0.28u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 2110 40 0 1 {name=p20 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_nmos.sym} 2090 120 0 0 {name=M15
l=0.28u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 2110 120 0 1 {name=p21 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_lv_pmos.sym} 2090 -40 0 0 {name=M16
l=3.0u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 2110 -40 0 1 {name=p23 sig_type=std_logic lab=VDD}
C {vdd.sym} 2110 -90 0 0 {name=l13 lab=VDD}
C {devices/gnd.sym} 2110 170 0 0 {name=l14 lab=GND}
C {devices/gnd.sym} 1480 -260 0 0 {name=l16 lab=GND}

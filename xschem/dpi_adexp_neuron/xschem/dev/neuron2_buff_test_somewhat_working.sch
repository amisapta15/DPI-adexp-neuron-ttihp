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
y2=1.5
x1=0
x2=2.0e-6}
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
x2=2.0859661e-06
y1=0
x1=0}
T {ILK goes 
from 0.01u to 0.1u 
from high to low firing rate} 240 410 0 0 0.4 0.4 {}
T {IAHP goes 
from 5n to 13n 
from high to low firing rate} 1140 -690 0 0 0.4 0.4 {}
T {IREF goes 
from 3u to 10u } 40 420 0 0 0.4 0.4 {}
T {ITHR goes 
from 5/10u to 60u } 130 -130 0 0 0.4 0.4 {}
T {Iin goes 
from 0.8u to 10u
from low to very high firing rate } 640 -120 0 0 0.4 0.4 {}
T {HIGH is on for AHP
LOW is off for AHP} 350 160 0 0 0.4 0.4 {}
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
N 1480 240 1480 330 {lab=GND}
N 1150 440 1150 450 {lab=GND}
N 1270 440 1270 450 {lab=GND}
N 1150 450 1270 450 {lab=GND}
N 1080 380 1080 450 {lab=GND}
N 1080 450 1150 450 {lab=GND}
N 1120 350 1150 350 {lab=vp}
N 1150 350 1150 380 {lab=vp}
N 1270 350 1270 380 {lab=vp}
N 1150 350 1270 350 {lab=vp}
N 1310 50 1330 50 {lab=vp}
N 1080 80 1080 100 {lab=GND}
N 1330 50 1330 100 {lab=vp}
N 1270 100 1330 100 {lab=vp}
N 1180 -40 1180 -20 {lab=#net1}
N 1080 -20 1080 20 {lab=#net1}
N 1270 -20 1270 20 {lab=#net1}
N 1180 -20 1270 -20 {lab=#net1}
N 1080 -20 1180 -20 {lab=#net1}
N 920 140 920 180 {lab=vmem}
N 1180 -120 1180 -100 {lab=#net2}
N 1180 -210 1180 -180 {lab=VDD}
N 1620 -120 1620 -100 {lab=#net3}
N 1480 -210 1480 -180 {lab=VDD}
N 1620 -210 1620 -180 {lab=VDD}
N 1480 -210 1620 -210 {lab=VDD}
N 1550 -150 1580 -150 {lab=#net3}
N 1550 -150 1550 -100 {lab=#net3}
N 1550 -100 1620 -100 {lab=#net3}
N 1520 -150 1550 -150 {lab=#net3}
N 1480 -120 1480 -90 {lab=#net4}
N 1480 20 1480 140 {lab=vmem}
N 1480 140 1480 180 {lab=vmem}
N 1550 -20 1580 -20 {lab=vmem}
N 1620 20 1620 30 {lab=REQ}
N 1620 100 1620 110 {lab=#net5}
N 1620 170 1620 330 {lab=GND}
N 1620 -100 1620 -50 {lab=#net3}
N 1550 20 1550 60 {lab=vmem}
N 1550 60 1580 60 {lab=vmem}
N 1550 100 1620 100 {lab=#net5}
N 1620 90 1620 100 {lab=#net5}
N 1550 100 1550 140 {lab=#net5}
N 1550 140 1580 140 {lab=#net5}
N 1480 20 1550 20 {lab=vmem}
N 1480 -30 1480 20 {lab=vmem}
N 1550 -20 1550 20 {lab=vmem}
N 1620 20 1740 20 {lab=REQ}
N 1620 10 1620 20 {lab=REQ}
N 1520 -60 1530 -60 {lab=REQ}
N 1770 -20 1800 -20 {lab=REQ}
N 1840 20 1840 30 {lab=RST}
N 1770 60 1800 60 {lab=REQ}
N 1930 20 1960 20 {lab=RST}
N 1840 10 1840 20 {lab=RST}
N 1770 20 1770 60 {lab=REQ}
N 1740 20 1770 20 {lab=REQ}
N 1770 -20 1770 20 {lab=REQ}
N 1840 90 1840 110 {lab=#net6}
N 1840 170 1840 330 {lab=GND}
N 1520 210 1930 210 {lab=RST}
N 1930 20 1930 210 {lab=RST}
N 1840 20 1930 20 {lab=RST}
N 1960 110 1960 330 {lab=GND}
N 1960 20 1960 50 {lab=RST}
N 1770 -100 1800 -100 {lab=#net7}
N 1770 -60 1840 -60 {lab=#net7}
N 1840 -60 1840 -50 {lab=#net7}
N 1770 -100 1770 -60 {lab=#net7}
N 1840 -70 1840 -60 {lab=#net7}
N 1840 -150 1840 -130 {lab=#net8}
N 1780 140 1800 140 {lab=VREF}
N 920 240 920 340 {lab=GND}
N 610 140 610 310 {lab=GND}
N 610 310 760 310 {lab=GND}
N 760 250 760 310 {lab=GND}
N 1730 -180 1800 -180 {lab=REQ}
N 1730 -250 1730 -180 {lab=REQ}
N 2080 -300 2080 -280 {lab=VDD}
N 2340 -250 2340 -220 {lab=OUT}
N 2080 -220 2080 -200 {lab=GND}
N 2120 -250 2150 -250 {lab=#net9}
N 2230 -250 2340 -250 {lab=OUT}
N 2190 -300 2190 -290 {lab=VDD}
N 2190 -210 2190 -200 {lab=GND}
N 1530 -80 1530 -60 {lab=REQ}
N 450 10 450 20 {lab=VDD}
N 450 80 450 100 {lab=GND}
N 920 110 920 140 {lab=vmem}
N 330 330 350 330 {lab=VLK}
N 290 280 290 300 {lab=VLK}
N 350 280 350 330 {lab=VLK}
N 290 280 350 280 {lab=VLK}
N 130 270 130 310 {lab=VREF}
N 190 340 210 340 {lab=VREF}
N 190 270 190 340 {lab=VREF}
N 170 340 190 340 {lab=VREF}
N 130 270 190 270 {lab=VREF}
N 990 -560 990 -550 {lab=VDD}
N 990 -490 990 -480 {lab=VLKAHP}
N 990 -420 990 -400 {lab=GND}
N 1030 -450 1070 -450 {lab=VLKAHP}
N 1070 -490 1070 -450 {lab=VLKAHP}
N 990 -490 1070 -490 {lab=VLKAHP}
N 990 -500 990 -490 {lab=VLKAHP}
N 1430 -450 1430 -430 {lab=VTHRAHP}
N 1490 -500 1490 -450 {lab=VTHRAHP}
N 1470 -500 1490 -500 {lab=VTHRAHP}
N 1430 -450 1490 -450 {lab=VTHRAHP}
N 1430 -470 1430 -450 {lab=VTHRAHP}
N 1490 -500 1540 -500 {lab=VTHRAHP}
N 1430 -540 1430 -530 {lab=VDD}
N 1230 -450 1230 -430 {lab=VAHP}
N 1290 -500 1290 -450 {lab=VAHP}
N 1270 -500 1290 -500 {lab=VAHP}
N 1230 -450 1290 -450 {lab=VAHP}
N 1230 -470 1230 -450 {lab=VAHP}
N 1290 -500 1340 -500 {lab=VAHP}
N 1230 -540 1230 -530 {lab=VDD}
N 1430 -370 1430 -360 {lab=GND}
N 1230 -370 1230 -360 {lab=GND}
N 130 240 130 270 {lab=VREF}
N 130 370 130 380 {lab=GND}
N 130 170 130 180 {lab=VDD}
N 290 190 290 200 {lab=VDD}
N 290 260 290 280 {lab=VLK}
N 690 220 720 220 {lab=VLK}
N 350 330 380 330 {lab=VLK}
N 290 360 290 380 {lab=GND}
N 200 60 200 80 {lab=VTHR}
N 260 10 260 60 {lab=VTHR}
N 240 10 260 10 {lab=VTHR}
N 200 60 260 60 {lab=VTHR}
N 200 40 200 60 {lab=VTHR}
N 200 -30 200 -20 {lab=VDD}
N 200 140 200 150 {lab=GND}
N 260 10 270 10 {lab=VTHR}
N 550 110 570 110 {lab=VTHR}
N 1990 -250 2040 -250 {lab=REQ}
N 1730 -250 1990 -250 {lab=REQ}
N 1740 -80 1740 20 {lab=REQ}
N 1740 -80 1990 -80 {lab=REQ}
N 1990 -250 1990 -80 {lab=REQ}
N 1530 -80 1740 -80 {lab=REQ}
N 1530 -100 1530 -80 {lab=REQ}
N 1220 -150 1220 -100 {lab=REQ}
N 1220 -100 1530 -100 {lab=REQ}
N 1080 140 1480 140 {lab=vmem}
N 1080 450 1080 480 {lab=GND}
N 1270 100 1270 350 {lab=vp}
N 1270 80 1270 100 {lab=vp}
N 1120 230 1130 230 {lab=#net10}
N 1170 170 1170 190 {lab=VDD}
N 1170 270 1170 280 {lab=GND}
N 1080 140 1080 200 {lab=vmem}
N 920 140 1080 140 {lab=vmem}
N 1080 260 1080 320 {lab=#net11}
N 1210 230 1240 230 {lab=enNeuAHP}
N 350 80 350 100 {lab=GND}
N 290 50 290 100 {lab=GND}
N 350 -30 350 20 {lab=enNeuAHP}
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
tran 500p 2u
write tran_neuron.raw
*Example plots (uncomment inside ngspice if you want autoplots)
plot vmem vn1 Vthr Vlk
plot vmem out
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
C {isource.sym} 610 -20 0 0 {name=Iin value=0.8u}
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
C {sg13g2_pr/sg13_lv_nmos.sym} 1500 210 0 1 {name=M2
l=0.28u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 1480 210 0 0 {name=p6 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} 1100 350 0 1 {name=M5
l=3.0u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1290 410 0 1 {name=M6
l=3.0u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1290 50 0 1 {name=M8
l=0.75u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 1270 50 0 0 {name=p7 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1080 50 0 1 {name=p8 sig_type=std_logic lab=VDD}
C {devices/gnd.sym} 1080 100 0 0 {name=l2 lab=GND}
C {sg13g2_pr/sg13_lv_pmos.sym} 1060 50 0 0 {name=M9
l=0.75u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 1180 -70 0 1 {name=p9 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} 1160 -70 0 0 {name=M10
l=3.0u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {devices/gnd.sym} 1080 480 0 0 {name=l4 lab=GND}
C {devices/gnd.sym} 1480 330 0 0 {name=l5 lab=GND}
C {lab_pin.sym} 1080 350 0 0 {name=p10 sig_type=std_logic lab=GND}
C {lab_pin.sym} 1270 410 0 0 {name=p11 sig_type=std_logic lab=GND}
C {lab_pin.sym} 1180 -150 0 0 {name=p12 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} 1200 -150 0 1 {name=M11
l=0.28u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {vdd.sym} 1180 -210 0 0 {name=l6 lab=VDD}
C {lab_pin.sym} 1140 -70 0 0 {name=p14 sig_type=std_logic lab=VAHP}
C {lab_pin.sym} 1040 50 0 0 {name=p15 sig_type=std_logic lab=VTHRAHP}
C {lab_pin.sym} 1310 410 0 1 {name=p16 sig_type=std_logic lab=VLKAHP}
C {lab_wire.sym} 690 220 0 0 {name=p17 sig_type=std_logic lab=VLK}
C {sg13g2_pr/sg13_lv_pmos.sym} 1500 -150 0 1 {name=M13
l=3.0u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {vdd.sym} 1550 -210 0 0 {name=l7 lab=VDD}
C {lab_pin.sym} 1620 -150 0 1 {name=p19 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1480 -150 0 0 {name=p20 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} 1500 -60 0 1 {name=M14
l=0.28u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 1480 -60 0 0 {name=p21 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} 1600 -150 0 0 {name=M15
l=3.0u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1600 -20 0 0 {name=M16
l=0.28u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 1620 -20 0 1 {name=p13 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_nmos.sym} 1600 60 0 0 {name=M17
l=0.28u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 1620 60 0 1 {name=p22 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} 1600 140 0 0 {name=M18
l=3.0u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 1620 140 0 1 {name=p23 sig_type=std_logic lab=GND}
C {devices/gnd.sym} 1620 330 0 0 {name=l8 lab=GND}
C {lab_wire.sym} 1190 350 0 0 {name=p28 sig_type=std_logic lab=vp}
C {sg13g2_pr/sg13_lv_pmos.sym} 1820 -20 0 0 {name=M7
l=0.28u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 1840 -20 0 1 {name=p29 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_nmos.sym} 1820 60 0 0 {name=M12
l=0.28u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 1840 60 0 1 {name=p30 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} 1820 140 0 0 {name=M19
l=3.0u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 1840 140 0 1 {name=p31 sig_type=std_logic lab=GND}
C {devices/gnd.sym} 1840 330 0 0 {name=l12 lab=GND}
C {devices/gnd.sym} 1960 330 0 0 {name=l13 lab=GND}
C {lab_wire.sym} 1750 210 0 0 {name=p32 sig_type=std_logic lab=RST}
C {sg13g2_pr/sg13_lv_pmos.sym} 1820 -100 0 0 {name=M20
l=3.0u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 1840 -100 0 1 {name=p33 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} 1820 -180 0 0 {name=M21
l=0.28u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 1840 -180 0 1 {name=p34 sig_type=std_logic lab=VDD}
C {vdd.sym} 1840 -210 0 0 {name=l14 lab=VDD}
C {lab_pin.sym} 1780 140 0 0 {name=p36 sig_type=std_logic lab=VREF}
C {devices/gnd.sym} 920 340 0 0 {name=l17 lab=GND}
C {buff.sym} 2040 -280 0 0 {name=xbuff1}
C {vdd.sym} 2080 -300 0 0 {name=l19 lab=VDD}
C {lab_wire.sym} 2340 -250 2 0 {name=p39 sig_type=std_logic lab=OUT}
C {devices/gnd.sym} 2080 -200 0 0 {name=l21 lab=GND}
C {inv.sym} 2170 -250 0 0 {name=xinv1}
C {vdd.sym} 2190 -300 0 0 {name=l16 lab=VDD}
C {devices/gnd.sym} 2190 -200 0 0 {name=l22 lab=GND}
C {devices/vsource.sym} 450 50 0 0 {name=Vdd1 value=1.8}
C {devices/gnd.sym} 450 100 0 0 {name=l23 lab=GND}
C {vdd.sym} 450 10 0 0 {name=l24 lab=VDD}
C {devices/launcher.sym} 130 -300 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/tran_neuron.raw tran"
}
C {lab_wire.sym} 550 110 1 0 {name=p18 sig_type=std_logic lab=VTHR}
C {sg13g2_pr/sg13_lv_nmos.sym} 310 330 0 1 {name=M23
l=3.0u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {isource.sym} 290 230 0 0 {name=ILK value=0.1u}
C {vdd.sym} 290 190 0 0 {name=l26 lab=VDD}
C {lab_pin.sym} 290 330 2 1 {name=p40 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} 150 340 0 1 {name=M24
l=3.0u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {isource.sym} 130 210 0 0 {name=IVREF value=5u}
C {vdd.sym} 130 170 0 0 {name=l25 lab=VDD}
C {lab_pin.sym} 210 340 1 0 {name=p38 sig_type=std_logic lab=VREF}
C {lab_pin.sym} 130 340 2 1 {name=p37 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} 1010 -450 0 1 {name=M25
l=3.0u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {devices/gnd.sym} 990 -400 0 0 {name=l15 lab=GND}
C {isource.sym} 990 -530 0 0 {name=ILKAHP value=5p}
C {vdd.sym} 990 -560 0 0 {name=l27 lab=VDD}
C {lab_pin.sym} 1070 -450 0 1 {name=p41 sig_type=std_logic lab=VLKAHP}
C {lab_pin.sym} 990 -450 0 0 {name=p25 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_lv_pmos.sym} 1450 -500 0 1 {name=M26
l=0.75u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {vdd.sym} 1430 -540 0 0 {name=l9 lab=VDD}
C {lab_pin.sym} 1430 -500 0 0 {name=p42 sig_type=std_logic lab=VDD}
C {isource.sym} 1430 -400 0 0 {name=ITHAHP value=390u}
C {lab_pin.sym} 1540 -500 1 0 {name=p44 sig_type=std_logic lab=VTHRAHP}
C {devices/gnd.sym} 1430 -360 0 0 {name=l28 lab=GND}
C {sg13g2_pr/sg13_lv_pmos.sym} 1250 -500 0 1 {name=M27
l=3.0u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {vdd.sym} 1230 -540 0 0 {name=l10 lab=VDD}
C {lab_pin.sym} 1230 -500 0 0 {name=p26 sig_type=std_logic lab=VDD}
C {isource.sym} 1230 -400 0 0 {name=IAHP value=5n}
C {devices/gnd.sym} 1230 -360 0 0 {name=l29 lab=GND}
C {lab_pin.sym} 1340 -500 1 0 {name=p43 sig_type=std_logic lab=VAHP}
C {devices/gnd.sym} 130 380 0 0 {name=l11 lab=GND}
C {devices/gnd.sym} 290 380 0 0 {name=l31 lab=GND}
C {lab_wire.sym} 380 330 0 1 {name=p35 sig_type=std_logic lab=VLK}
C {sg13g2_pr/sg13_lv_pmos.sym} 220 10 0 1 {name=M22
l=0.75u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {vdd.sym} 200 -30 0 0 {name=l18 lab=VDD}
C {lab_pin.sym} 200 10 0 0 {name=p27 sig_type=std_logic lab=VDD}
C {isource.sym} 200 110 0 0 {name=ITHR value=500.0u}
C {devices/gnd.sym} 200 150 0 0 {name=l30 lab=GND}
C {lab_wire.sym} 270 10 1 0 {name=p45 sig_type=std_logic lab=VTHR}
C {lab_wire.sym} 1990 -80 2 0 {name=p24 sig_type=std_logic lab=REQ}
C {sg13g2_pr/cap_cmim.sym} 920 210 0 0 {name=C5
model=cap_cmim
w=10.0e-6
l=10.0e-6
m=8
spiceprefix=X}
C {sg13g2_pr/cap_cmim.sym} 1960 80 0 0 {name=C1
model=cap_cmim
w=10.0e-6
l=10.0e-6
m=8
spiceprefix=X}
C {sg13g2_pr/cap_cmim.sym} 1150 410 0 0 {name=C2
model=cap_cmim
w=10.0e-6
l=10.0e-6
m=8
spiceprefix=X}
C {inv.sym} 1190 230 0 1 {name=xinv2}
C {sg13g2_pr/sg13_lv_pmos.sym} 1100 230 0 1 {name=M28
l=0.75u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 1170 170 0 1 {name=p46 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1170 280 2 0 {name=p47 sig_type=std_logic lab=GND}
C {lab_pin.sym} 1080 230 2 1 {name=p48 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 1240 230 1 0 {name=p49 sig_type=std_logic lab=enNeuAHP}
C {devices/vsource.sym} 350 50 0 0 {name=Vdd2 value=1.8}
C {devices/gnd.sym} 350 100 0 0 {name=l32 lab=GND}
C {noconn.sym} 2340 -220 2 0 {name=l20}
C {devices/gnd.sym} 290 100 0 0 {name=l33 lab=GND}
C {noconn.sym} 290 50 2 0 {name=l34}
C {lab_wire.sym} 350 -30 2 0 {name=p50 sig_type=std_logic lab=enNeuAHP}

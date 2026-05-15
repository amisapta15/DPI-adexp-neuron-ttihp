v {xschem version=3.4.8RC file_version=1.2}
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
x2=9.091746e-06
y2=1
x1=-3.3972144e-06}
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
y1=11.2
x2=1.9402235e-05
y2=13.2
x1=3.4022354e-06}
T {ITHR goes 
from 5/10u to 60u } -250 -10 0 0 0.4 0.4 {}
T {IREF goes 
from 0.05u to 0.5u } 40 220 0 0 0.4 0.4 {}
T {ILK goes 
from 1n to 0.1u 
from high to low firing rate} 2410 -560 0 0 0.4 0.4 {}
N 610 50 610 80 {lab=vn1}
N 760 160 760 190 {lab=vmem}
N 760 50 760 80 {lab=vn1}
N 820 110 920 110 {lab=vmem}
N 820 110 820 160 {lab=vmem}
N 800 110 820 110 {lab=vmem}
N 760 160 820 160 {lab=vmem}
N 760 140 760 160 {lab=vmem}
N 760 310 760 340 {lab=GND}
N 960 250 960 340 {lab=GND}
N 610 140 610 310 {lab=GND}
N 610 310 760 310 {lab=GND}
N 760 250 760 310 {lab=GND}
N 920 110 920 180 {lab=vmem}
N 690 220 720 220 {lab=VLK}
N 550 110 570 110 {lab=VTHR}
N 440 -200 440 -190 {lab=VDD}
N 440 -130 440 -110 {lab=GND}
N 130 70 130 110 {lab=VREF}
N 190 140 210 140 {lab=VREF}
N 190 70 190 140 {lab=VREF}
N 170 140 190 140 {lab=VREF}
N 130 70 190 70 {lab=VREF}
N 130 40 130 70 {lab=VREF}
N 130 170 130 180 {lab=GND}
N 130 -30 130 -20 {lab=VDD}
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
N 1620 -520 1620 -500 {lab=VDD}
N 2030 -360 2030 -330 {lab=OUT}
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
N 1860 80 1860 90 {lab=#net8}
N 1790 120 1820 120 {lab=#net4}
N 1860 70 1860 80 {lab=#net8}
N 1790 80 1790 120 {lab=#net4}
N 1790 40 1790 80 {lab=#net4}
N 1860 150 1860 170 {lab=GND}
N 1860 80 2040 80 {lab=#net8}
N 1790 -40 1820 -40 {lab=#net9}
N 1790 0 1860 0 {lab=#net9}
N 1860 0 1860 10 {lab=#net9}
N 1790 -40 1790 0 {lab=#net9}
N 1860 -10 1860 0 {lab=#net9}
N 1860 -90 1860 -70 {lab=VDD}
N 1480 80 1790 80 {lab=#net4}
N 2040 40 2070 40 {lab=#net8}
N 2110 80 2110 90 {lab=RST}
N 2040 120 2070 120 {lab=#net8}
N 2110 70 2110 80 {lab=RST}
N 2110 150 2110 170 {lab=GND}
N 2330 80 2550 80 {lab=RST}
N 2040 -40 2070 -40 {lab=#net10}
N 2040 0 2110 0 {lab=#net10}
N 2110 0 2110 10 {lab=#net10}
N 2110 -10 2110 0 {lab=#net10}
N 2110 -90 2110 -70 {lab=VDD}
N 2040 -40 2040 -0 {lab=#net10}
N 2040 80 2040 120 {lab=#net8}
N 2040 40 2040 80 {lab=#net8}
N 1380 -320 1380 -120 {lab=REQ}
N 1620 -430 1620 -400 {lab=GND}
N 920 110 1120 110 {lab=vmem}
N 2110 80 2330 80 {lab=RST}
N 2550 80 2550 430 {lab=RST}
N 1530 -320 1580 -320 {lab=#net11}
N 1380 -320 1450 -320 {lab=REQ}
N 1490 -360 1490 -350 {lab=VDD}
N 1490 -290 1490 -280 {lab=GND}
N 890 220 890 250 {lab=GND}
N 950 250 960 250 {lab=GND}
N 920 220 920 250 {lab=GND}
N 890 250 920 250 {lab=GND}
N 950 220 950 250 {lab=GND}
N 920 250 950 250 {lab=GND}
N 1190 270 1190 430 {lab=RST}
N 1160 270 1190 270 {lab=RST}
N 1190 430 2550 430 {lab=RST}
N 2370 280 2370 370 {lab=GND}
N 2300 250 2300 280 {lab=GND}
N 2360 280 2370 280 {lab=GND}
N 2330 250 2330 280 {lab=GND}
N 2300 280 2330 280 {lab=GND}
N 2360 250 2360 280 {lab=GND}
N 2330 280 2360 280 {lab=GND}
N 2330 80 2330 210 {lab=RST}
N 1800 -430 1800 -400 {lab=GND}
N 1640 -300 1640 -280 {lab=VDD}
N 1640 -210 1640 -180 {lab=GND}
N 1800 -310 1800 -290 {lab=VDD}
N 1800 -220 1800 -190 {lab=GND}
N 1840 -360 1840 -260 {lab=OUT}
N 1580 -320 1580 -250 {lab=#net11}
N 1580 -250 1600 -250 {lab=#net11}
N 1840 -360 2030 -360 {lab=OUT}
N 1840 -470 1840 -360 {lab=OUT}
N 1580 -470 1580 -320 {lab=#net11}
N 1680 -250 1690 -250 {lab=#net12}
N 1660 -470 1690 -470 {lab=#net12}
N 1690 -350 1690 -250 {lab=#net12}
N 1730 -470 1760 -470 {lab=#net12}
N 1730 -260 1760 -260 {lab=#net12}
N 1730 -350 1730 -260 {lab=#net12}
N 1690 -350 1730 -350 {lab=#net12}
N 1690 -470 1690 -350 {lab=#net12}
N 1730 -470 1730 -350 {lab=#net12}
N 1830 -1270 1830 -1250 {lab=GND}
N 1910 -1270 1910 -1250 {lab=GND}
N 1990 -1260 1990 -1240 {lab=GND}
N 2060 -1250 2060 -1230 {lab=GND}
N 1830 -1350 1830 -1330 {lab=DB0}
N 1910 -1360 1910 -1330 {lab=DB1}
N 1990 -1340 1990 -1320 {lab=DB2}
N 2060 -1330 2060 -1310 {lab=DB3}
N 1890 -950 1890 -930 {lab=CSen2}
N 1850 -930 1890 -930 {lab=CSen2}
N 1870 -970 1890 -970 {lab=DB3}
N 1870 -970 1870 -960 {lab=DB3}
N 1850 -960 1870 -960 {lab=DB3}
N 1850 -990 1890 -990 {lab=DB2}
N 1870 -1010 1890 -1010 {lab=DB1}
N 1870 -1020 1870 -1010 {lab=DB1}
N 1850 -1020 1870 -1020 {lab=DB1}
N 1890 -1050 1890 -1030 {lab=DB0}
N 1850 -1050 1890 -1050 {lab=DB0}
N 1950 -910 1950 -880 {lab=GND}
N 1950 -1070 1950 -1060 {lab=VDD}
N 710 50 760 50 {lab=vn1}
N 1770 -1130 1770 -1110 {lab=GND}
N 1770 -1210 1770 -1190 {lab=CSen2}
N 2090 -870 2090 -840 {lab=#net13}
N 2090 -740 2090 -700 {lab=#net14}
N 2090 -640 2090 -610 {lab=GND}
N 2090 -610 2240 -610 {lab=GND}
N 2240 -650 2240 -610 {lab=GND}
N 2170 -680 2200 -680 {lab=#net14}
N 2170 -680 2170 -670 {lab=#net14}
N 2130 -670 2170 -670 {lab=#net14}
N 2160 -800 2200 -800 {lab=#net13}
N 2160 -810 2160 -800 {lab=#net13}
N 2130 -810 2160 -810 {lab=#net13}
N 2240 -770 2240 -710 {lab=#net15}
N 2170 -740 2170 -680 {lab=#net14}
N 2090 -740 2170 -740 {lab=#net14}
N 2090 -780 2090 -740 {lab=#net14}
N 2160 -870 2160 -810 {lab=#net13}
N 2090 -870 2160 -870 {lab=#net13}
N 2240 -900 2240 -830 {lab=#net16}
N 2300 -960 2350 -960 {lab=#net16}
N 2300 -960 2300 -900 {lab=#net16}
N 2280 -960 2300 -960 {lab=#net16}
N 2240 -900 2300 -900 {lab=#net16}
N 2240 -930 2240 -900 {lab=#net16}
N 2300 -1080 2350 -1080 {lab=#net17}
N 2320 -1120 2320 -1110 {lab=VDD}
N 2240 -1110 2320 -1110 {lab=VDD}
N 2300 -1080 2300 -1020 {lab=#net17}
N 2280 -1080 2300 -1080 {lab=#net17}
N 2240 -1020 2300 -1020 {lab=#net17}
N 2240 -1050 2240 -1020 {lab=#net17}
N 2240 -1020 2240 -990 {lab=#net17}
N 2390 -1050 2390 -990 {lab=#net18}
N 2430 -680 2450 -680 {lab=VLK}
N 2390 -730 2390 -710 {lab=VLK}
N 2450 -730 2450 -680 {lab=VLK}
N 2390 -730 2450 -730 {lab=VLK}
N 2450 -680 2480 -680 {lab=VLK}
N 2390 -650 2390 -630 {lab=GND}
N 710 -30 710 -20 {lab=VDD}
N 710 40 710 50 {lab=vn1}
N 610 50 710 50 {lab=vn1}
N 2090 -980 2090 -950 {lab=#net19}
N 2090 -890 2090 -870 {lab=#net13}
N 2390 -930 2390 -870 {lab=#net20}
N 2390 -810 2390 -730 {lab=VLK}
N 320 70 320 110 {lab=ob1}
N 380 140 400 140 {lab=ob1}
N 380 70 380 140 {lab=ob1}
N 360 140 380 140 {lab=ob1}
N 320 70 380 70 {lab=ob1}
N 320 40 320 70 {lab=ob1}
N 320 170 320 180 {lab=GND}
N 320 -30 320 -20 {lab=VDD}
N 2320 -1110 2390 -1110 {lab=VDD}
N 2030 -980 2090 -980 {lab=#net19}
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

alter Ven dc 1.8
alter ven6 dc 1.8
alter ven7 dc 0.0
alter ven8 dc 0.0
alter ven9 dc 0.0

tran 1u 100u 
write tran_neuron.raw
*Example plots (uncomment inside ngspice if you want autoplots)
plot vmem vn1 Vthr Vlk
plot vmem out
plot vmeas1#branch vmeas2#branch vmeas3#branch vmeas4#branch
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
C {lab_wire.sym} 870 110 0 0 {name=p1 sig_type=std_logic lab=vmem}
C {lab_pin.sym} 760 110 0 0 {name=p2 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 610 110 0 1 {name=p3 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 760 220 0 1 {name=p4 sig_type=std_logic lab=GND}
C {lab_wire.sym} 690 220 0 0 {name=p17 sig_type=std_logic lab=VLK}
C {devices/gnd.sym} 960 340 0 0 {name=l17 lab=GND}
C {devices/launcher.sym} 130 -300 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/tran_neuron.raw tran"
}
C {lab_wire.sym} 550 110 1 0 {name=p18 sig_type=std_logic lab=VTHR}
C {devices/vsource.sym} 440 -160 0 0 {name=Vdd1 value=1.8}
C {devices/gnd.sym} 440 -110 0 0 {name=l23 lab=GND}
C {vdd.sym} 440 -200 0 0 {name=l24 lab=VDD}
C {sg13g2_pr/sg13_lv_nmos.sym} 150 140 0 1 {name=M24
l=3.0u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {isource.sym} 130 10 0 0 {name=IVREF value=700nA}
C {vdd.sym} 130 -30 0 0 {name=l25 lab=VDD}
C {lab_pin.sym} 130 140 2 1 {name=p37 sig_type=std_logic lab=GND}
C {devices/gnd.sym} 130 180 0 0 {name=l11 lab=GND}
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
C {lab_wire.sym} 1380 430 0 0 {name=p26 sig_type=std_logic lab=RST}
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
C {vdd.sym} 1620 -520 0 0 {name=l27 lab=VDD}
C {devices/gnd.sym} 1490 -280 0 0 {name=l28 lab=GND}
C {inv.sym} 1600 -470 0 0 {name=xinv2}
C {vdd.sym} 1490 -360 0 0 {name=l29 lab=VDD}
C {lab_wire.sym} 1380 -80 2 0 {name=p44 sig_type=std_logic lab=REQ}
C {noconn.sym} 2030 -330 2 0 {name=l33}
C {sg13g2_pr/sg13_lv_nmos.sym} -10 120 0 1 {name=M2
l=3.0u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {isource.sym} -30 -10 0 0 {name=ITHR value=300n}
C {vdd.sym} -30 -50 0 0 {name=l5 lab=VDD}
C {lab_pin.sym} -30 120 2 1 {name=p13 sig_type=std_logic lab=GND}
C {devices/gnd.sym} -30 160 0 0 {name=l7 lab=GND}
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
C {devices/gnd.sym} 1620 -400 0 0 {name=l16 lab=GND}
C {lab_wire.sym} 2030 -360 2 0 {name=p43 sig_type=std_logic lab=OUT}
C {sg13g2_pr/sg13_lv_pmos.sym} 920 200 3 1 {name=M17
l=10.0u
w=5.0u
ng=6
m=10
model=sg13_lv_pmos
spiceprefix=X
}
C {devices/gnd.sym} 2370 370 0 0 {name=l10 lab=GND}
C {sg13g2_pr/sg13_lv_pmos.sym} 2330 230 3 1 {name=M18
l=10.0u
w=5.0u
ng=6
m=10
model=sg13_lv_pmos
spiceprefix=X
}
C {inv.sym} 1470 -320 0 0 {name=xinv1}
C {inv.sym} 1780 -470 0 0 {name=xinv3}
C {devices/gnd.sym} 1800 -400 0 0 {name=l19 lab=GND}
C {vdd.sym} 1640 -300 0 0 {name=l20 lab=VDD}
C {inv.sym} 1620 -250 0 0 {name=xinv4}
C {devices/gnd.sym} 1640 -180 0 0 {name=l21 lab=GND}
C {vdd.sym} 1800 -310 0 0 {name=l22 lab=VDD}
C {inv.sym} 1780 -260 0 0 {name=xinv5}
C {devices/gnd.sym} 1800 -190 0 0 {name=l30 lab=GND}
C {lab_pin.sym} 1850 -1050 2 1 {name=p47 sig_type=std_logic lab=DB0}
C {devices/gnd.sym} 1950 -880 0 0 {name=l41 lab=GND}
C {vsource.sym} 1830 -1300 0 0 {name=Ven6 value=1.8
"}
C {devices/gnd.sym} 1830 -1250 0 0 {name=l42 lab=GND}
C {vsource.sym} 1910 -1300 0 0 {name=Ven7 value=0}
C {devices/gnd.sym} 1910 -1250 0 0 {name=l43 lab=GND}
C {vsource.sym} 1990 -1290 0 0 {name=Ven8 value=0}
C {devices/gnd.sym} 1990 -1240 0 0 {name=l44 lab=GND}
C {vsource.sym} 2060 -1280 0 0 {name=Ven9 value=0
"}
C {devices/gnd.sym} 2060 -1230 0 0 {name=l45 lab=GND}
C {trimmer.sym} 1950 -980 0 0 {name=x2}
C {lab_pin.sym} 1850 -1020 2 1 {name=p48 sig_type=std_logic lab=DB1}
C {lab_pin.sym} 1850 -990 2 1 {name=p49 sig_type=std_logic lab=DB2}
C {lab_pin.sym} 1850 -960 2 1 {name=p50 sig_type=std_logic lab=DB3}
C {lab_pin.sym} 1850 -930 2 1 {name=p51 sig_type=std_logic lab=CSen2}
C {vdd.sym} 1950 -1070 0 0 {name=l46 lab=VDD}
C {lab_pin.sym} 1830 -1350 2 1 {name=p52 sig_type=std_logic lab=DB0}
C {lab_pin.sym} 1910 -1360 2 1 {name=p53 sig_type=std_logic lab=DB1}
C {lab_pin.sym} 1990 -1340 2 1 {name=p54 sig_type=std_logic lab=DB2}
C {lab_pin.sym} 2060 -1330 2 1 {name=p55 sig_type=std_logic lab=DB3}
C {lab_wire.sym} 650 50 0 0 {name=p59 sig_type=std_logic lab=vn1}
C {vsource.sym} 1770 -1160 0 0 {name=Ven5 value=1.8}
C {devices/gnd.sym} 1770 -1110 0 0 {name=l40 lab=GND}
C {lab_pin.sym} 1770 -1210 2 1 {name=p64 sig_type=std_logic lab=CSen2}
C {sg13g2_pr/sg13_lv_nmos.sym} 2110 -810 0 1 {name=M35
l=3.0u
w=1.2u
ng=1
m=10
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 2220 -800 0 0 {name=M36
l=3.0u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 2110 -670 0 1 {name=M37
l=3.0u
w=1.2u
ng=1
m=10
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 2220 -680 0 0 {name=M38
l=3.0u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 2260 -960 0 1 {name=M39
l=3.0u
w=2.4u
ng=1
m=10
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 2370 -960 0 0 {name=M40
l=3.0u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 2090 -810 2 1 {name=p65 sig_type=std_logic lab=GND}
C {lab_pin.sym} 2090 -670 2 1 {name=p66 sig_type=std_logic lab=GND}
C {devices/gnd.sym} 2170 -610 0 0 {name=l48 lab=GND}
C {lab_pin.sym} 2240 -800 0 1 {name=p67 sig_type=std_logic lab=GND}
C {lab_pin.sym} 2240 -680 0 1 {name=p68 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_lv_pmos.sym} 2260 -1080 0 1 {name=M41
l=3.0u
w=2.4u
ng=1
m=10
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 2370 -1080 0 0 {name=M42
l=3.0u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {vdd.sym} 2320 -1120 0 0 {name=l49 lab=VDD}
C {lab_pin.sym} 2390 -1080 0 1 {name=p70 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 2390 -960 0 1 {name=p71 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 2240 -960 2 1 {name=p72 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 2240 -1080 2 1 {name=p73 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_nmos.sym} 2410 -680 0 1 {name=M23
l=3.0u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 2390 -680 2 1 {name=p40 sig_type=std_logic lab=GND}
C {devices/gnd.sym} 2390 -630 0 0 {name=l31 lab=GND}
C {lab_wire.sym} 2480 -680 0 1 {name=p35 sig_type=std_logic lab=VLK}
C {isource.sym} 710 10 0 0 {name=IVREF1 value=30nA}
C {vdd.sym} 710 -30 0 0 {name=l1 lab=VDD
value=30nA}
C {ammeter.sym} 2090 -920 0 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {ammeter.sym} 2390 -840 0 0 {name=Vmeas1 savecurrent=true spice_ignore=0}
C {sg13g2_pr/sg13_lv_nmos.sym} 340 140 0 1 {name=M33
l=3.0u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {isource.sym} 320 10 0 0 {name=ILK value=3nA}
C {vdd.sym} 320 -30 0 0 {name=l34 lab=VDD}
C {lab_pin.sym} 320 140 2 1 {name=p34 sig_type=std_logic lab=GND}
C {devices/gnd.sym} 320 180 0 0 {name=l35 lab=GND}
C {noconn.sym} 400 140 2 0 {name=l36}
C {lab_pin.sym} 390 140 1 0 {name=p33 sig_type=std_logic lab=ob1}
C {lab_pin.sym} 210 140 1 0 {name=p24 sig_type=std_logic lab=VREF}
C {lab_wire.sym} 50 120 1 0 {name=p5 sig_type=std_logic lab=VTHR}

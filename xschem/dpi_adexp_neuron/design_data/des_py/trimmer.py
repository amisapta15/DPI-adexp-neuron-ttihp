from gdsfactory.read.import_gds import import_gds

from glayout import MappedPDK, sky130 , gf180 , ihp130
#from gdsfactory.cell import cell
from gdsfactory import Component
from gdsfactory.components import text_freetype, rectangle

from glayout import resistor
from glayout import two_pfet_interdigitized
from glayout import nmos, pmos
from glayout import via_stack, via_array
from glayout import rename_ports_by_orientation
from glayout import tapring
from glayout import mimcap_array, mimcap
from glayout.util.comp_utils import evaluate_bbox, prec_center, prec_ref_center, align_comp_to_port, prec_array, movey
from glayout.util.port_utils import add_ports_perimeter,print_ports
from glayout.util.snap_to_grid import component_snap_to_grid
from glayout.spice.netlist import Netlist

from glayout.routing.straight_route import straight_route
from glayout.routing.c_route import c_route
from glayout.routing.L_route import L_route

###### Only Required for IIC-OSIC Docker
import os
import subprocess

# Run a shell, source .bashrc, then printenv
cmd = 'bash -c "source ~/.bashrc && printenv"'
result = subprocess.run(cmd, shell=True, text=True, capture_output=True)
env_vars = {}
for line in result.stdout.splitlines():
    if '=' in line:
        key, value = line.split('=', 1)
        env_vars[key] = value

# Now, update os.environ with these
os.environ.update(env_vars)

import sys
from inv import inverter
sys.path.append('../../../../elementary/diff_pair/')
from diff_pair import diff_pair, diff_pair_generic, diff_pair_netlist, add_df_labels
sys.path.append('../../../../elementary/current_mirror/')
from current_mirror import current_mirror,add_cm_labels


def trimmer(
        pdk: MappedPDK,
        multipliers: tuple[int,int] = (1,1),
        dummy_1: tuple[bool,bool] = (True,True),
        dummy_2: tuple[bool,bool] = (True,True),
        tie_layers1: tuple[str,str] = ("met2","met1"),
        tie_layers2: tuple[str,str] = ("met2","met1"),
        ) -> Component:

    pdk.activate()
    
    #top level component
    top_level = Component(name="trimmer")
    viam2m3 = via_stack(pdk, "met2", "met3", centered=True) #met2 is the bottom layer. met3 is the top layer.

    
    
    pfet_2 = pmos(pdk, length=2.0,width=2.0, fingers=1, multipliers=2, with_dummy=True, dnwell=False,  with_substrate_tap=False)
    pfet_1 = pmos(pdk, length=2.0,width=2.0, fingers=1, multipliers=1, with_dummy=True, dnwell=False,  with_substrate_tap=False)
    pfet_3 = pmos(pdk, length=0.28,width=2.0, fingers=1, multipliers=2, with_dummy=True, dnwell=False,  with_substrate_tap=False)
    pfet_4 = pmos(pdk, length=0.28,width=2.0, fingers=1, multipliers=1, with_dummy=True, dnwell=False,  with_substrate_tap=False)
    pfet_5 = pmos(pdk, length=8.0,width=0.28, fingers=1, multipliers=1, with_dummy=True, dnwell=False,  with_substrate_tap=False)

    ##################################################################
    mp19_ref = prec_ref_center(pfet_4)
    top_level.add(mp19_ref)
    mp1_2=resistor(pdk,width=0.28,length=8.0,num_series=2,with_tie=True,with_dummy=True)
    mp1_2_ref=prec_ref_center(mp1_2)
    mp1_2_ref.movey(top_level.ymin - (evaluate_bbox(mp1_2)[1]/2) - pdk.util_max_metal_seperation())
    top_level.add(mp1_2_ref)
    ncm12 = current_mirror(pdk,numcols=1,width=0.28,length=8.0,device='nfet',with_tie=True)
    ncm12_ref= prec_ref_center(ncm12)
    ncm12_ref.movey(top_level.ymin - (evaluate_bbox(ncm12)[1]/2) - pdk.util_max_metal_seperation())
    ncm12_ref.movex(top_level.xmin + (evaluate_bbox(ncm12)[0]/2) + pdk.util_max_metal_seperation())
    top_level.add(ncm12_ref)
    nfet_1 = nmos(pdk, length=0.28,width=2.0, fingers=1, multipliers=1, with_dummy=True, with_dnwell=False,  with_substrate_tap=False)
    mn5_ref = prec_ref_center(nfet_1)
    mn5_ref.movey(top_level.ymin - (evaluate_bbox(nfet_1)[1]/2) - pdk.util_max_metal_seperation())
    mn5_ref.movex(top_level.xmin + (evaluate_bbox(nfet_1)[0]/2) - pdk.util_max_metal_seperation())
    top_level.add(mn5_ref)
    

    vdd_via1 = top_level << viam2m3
    vdd_via1.move(mp19_ref.ports["source_N"].center).movey(10)
    top_level << straight_route(pdk, vdd_via1.ports["top_met_S"],mp19_ref.ports["source_N"], glayer1="met3",fullbottom=True )
    top_level << straight_route(pdk, vdd_via1.ports["bottom_met_S"],mp19_ref.ports["tie_N_top_met_N"],glayer1=tie_layers2[1], fullbottom=True )
    
    en_via = top_level << viam2m3
    en_via.move(mp19_ref.ports["gate_W"].center).movex(-5)
    top_level << straight_route(pdk, en_via.ports["bottom_met_E"],mp19_ref.ports["gate_W"],glayer1=tie_layers2[0], fullbottom=True )

    top_level << c_route(pdk, mp19_ref.ports["drain_E"],mp1_2_ref.ports["port2_source_E"], fullbottom=True,extension=4* pdk.util_max_metal_seperation())

    top_level << c_route(pdk, mp1_2_ref.ports["pfet_0_drain_W"],ncm12_ref.ports["fet_A_drain_W"], fullbottom=True )

    
    top_level << c_route(pdk, ncm12_ref.ports["fet_A_gate_W"], mn5_ref.ports["drain_W"],fullbottom=True )
    top_level << c_route(pdk, en_via.ports["bottom_met_W"], mn5_ref.ports["gate_W"],fullbottom=True,extension= pdk.util_max_metal_seperation())

    vss_via1 = top_level << viam2m3
    vss_via1.move(mn5_ref.ports["source_N"].center).movey(-10)
    top_level << c_route(pdk, vss_via1.ports["bottom_met_E"],mn5_ref.ports["source_E"], fullbottom=True )
    top_level << straight_route(pdk, vss_via1.ports["bottom_met_N"],mn5_ref.ports["tie_S_top_met_S"], fullbottom=True)



    vss_via = top_level << viam2m3
    vss_via.move(ncm12_ref.ports["welltie_S_top_met_S"].center).movey(-15)
    top_level << straight_route(pdk, vss_via.ports["top_met_N"],ncm12_ref.ports["welltie_S_top_met_S"], fullbottom=True)
    top_level << L_route(pdk, vss_via.ports["bottom_met_W"],vss_via1.ports["bottom_met_S"], fullbottom=True)


    
    ##################################################################
    mp20_ref = prec_ref_center(pfet_4)
    mp20_ref.movex(top_level.xmax - (evaluate_bbox(pfet_4)[0]/2) -  pdk.util_max_metal_seperation()+2)
    
    
    mp3_ref = prec_ref_center(pfet_1)
    mp4_ref = prec_ref_center(pfet_3)
    mp3_ref.movex(top_level.xmax - (evaluate_bbox(pfet_1)[0]/2) - pdk.util_max_metal_seperation()+2)
    mp3_ref.movey(- 2* (evaluate_bbox(pfet_1)[1]/2) - 2* pdk.util_max_metal_seperation())
    
    mp4_ref.movex(top_level.xmax - (evaluate_bbox(pfet_3)[0]/2) - pdk.util_max_metal_seperation())
    mp4_ref.movey(- 4.1* (evaluate_bbox(pfet_3)[1]/2) - 4.1* pdk.util_max_metal_seperation())
    

    top_level.add(mp20_ref)
    top_level.add(mp3_ref)
    top_level.add(mp4_ref)
    

    vdd_via2 = top_level << viam2m3
    vdd_via2.move(mp20_ref.ports["source_N"].center).movey(10)
    top_level << straight_route(pdk, vdd_via2.ports["top_met_S"],mp20_ref.ports["source_N"], glayer1="met3",fullbottom=True )
    top_level << straight_route(pdk, vdd_via2.ports["bottom_met_S"],mp20_ref.ports["tie_N_top_met_N"],glayer1=tie_layers2[1], fullbottom=True )
    
    top_level << straight_route(pdk, en_via.ports["top_met_E"],mp20_ref.ports["gate_W"] ,glayer1=tie_layers2[0],fullbottom=True )

    top_level << c_route(pdk, mp20_ref.ports["drain_E"],mp3_ref.ports["source_E"],fullbottom=True,extension=pdk.util_max_metal_seperation())
    
    top_level << c_route(pdk, mp3_ref.ports["drain_E"],mp4_ref.ports["source_E"], fullbottom=True,extension= 3* pdk.util_max_metal_seperation())
    top_level << c_route(pdk, mp4_ref.ports["multiplier_1_drain_E"], ncm12_ref.ports["fet_B_drain_E"],fullbottom=True )

    #top_level << c_route(pdk, vdd_via2.ports["bottom_met_E"],mp3_ref.ports["tie_W_top_met_E"],fullbottom=True )
    #top_level << c_route(pdk, vdd_via2.ports["bottom_met_E"],mp4_ref.ports["tie_W_top_met_E"],fullbottom=True )

    ##################################################################
    mp9_ref=prec_ref_center(pfet_5)
    mp9_ref.movey(top_level.center[1] - (2*evaluate_bbox(pfet_5)[1]/2) - 2* pdk.util_max_metal_seperation() -0.5)
    mp9_ref.movex(top_level.xmax + (evaluate_bbox(pfet_5)[0]/2) + pdk.util_max_metal_seperation())
    top_level.add(mp9_ref)

    vdd_via3 = top_level << viam2m3
    vdd_via3.move(mp9_ref.ports["source_N"].center).movey(20)
    top_level << straight_route(pdk, vdd_via3.ports["top_met_S"],mp9_ref.ports["source_N"], glayer1="met3",fullbottom=True )
    top_level << straight_route(pdk, vdd_via3.ports["bottom_met_S"],mp9_ref.ports["tie_N_top_met_N"], glayer1= tie_layers2[1],fullbottom=True )
    
    top_level << c_route(pdk, mp9_ref.ports["gate_E"], ncm12_ref.ports["fet_B_drain_E"],fullbottom=True )
    ##################################################################################
    mp18_ref = prec_ref_center(pfet_3)
    mp18_ref.movex(top_level.xmax - (4*evaluate_bbox(pfet_3)[0]/2) - 4* pdk.util_max_metal_seperation()+2)
    mp18_ref.movey(top_level.ymax - (evaluate_bbox(pfet_3)[1]/2) - pdk.util_max_metal_seperation()+2)

    #################################################################
    mp17_ref = prec_ref_center(pfet_3)
    mp17_ref.movex(top_level.xmax + (2*evaluate_bbox(pfet_3)[0]/2) + 2*pdk.util_max_metal_seperation()+2)
    mp17_ref.movey(top_level.ymax - ( evaluate_bbox(pfet_3)[1]/2) - 2* pdk.util_max_metal_seperation()+2)
    ################################################
    
    mp5_ref = prec_ref_center(pfet_2) 
    mp6_ref = prec_ref_center(pfet_3) 
    
    mp5_ref.movey(top_level.center[1] + (evaluate_bbox(pfet_2)[1]/2) + pdk.util_max_metal_seperation())
    mp5_ref.movex(top_level.xmax - (evaluate_bbox(pfet_2)[0]/2) - pdk.util_max_metal_seperation())

    mp6_ref.movey(top_level.center[1]- (2 * evaluate_bbox(pfet_2)[1]/2) - 2* pdk.util_max_metal_seperation()-1.2)
    mp6_ref.movex(top_level.xmax - (evaluate_bbox(pfet_2)[0]/2) - pdk.util_max_metal_seperation())

    ###########
    top_level.add(mp17_ref)
    ###############
    top_level.add(mp18_ref)
    top_level.add(mp5_ref)
    top_level.add(mp6_ref)

    vdd_via4 = top_level << viam2m3
    vdd_via4.move(mp18_ref.ports["source_N"].center).movey(10)
    top_level << straight_route(pdk, vdd_via4.ports["top_met_S"],mp18_ref.ports["multiplier_1_source_N"], glayer1="met3",fullbottom=True )
    top_level << straight_route(pdk, vdd_via4.ports["bottom_met_S"],mp18_ref.ports["tie_N_top_met_N"],glayer1=tie_layers2[1], fullbottom=True )
    top_level << c_route(pdk, en_via.ports["bottom_met_W"],mp18_ref.ports["gate_W"],fullbottom=True )


    top_level << c_route(pdk, mp18_ref.ports["drain_E"],mp5_ref.ports["multiplier_1_source_E"],fullbottom=True,extension=2* pdk.util_max_metal_seperation())
    top_level << c_route(pdk, mp5_ref.ports["drain_E"],mp6_ref.ports["multiplier_1_source_E"], fullbottom=True,extension= 4* pdk.util_max_metal_seperation())
    top_level << c_route(pdk, mp6_ref.ports["multiplier_1_drain_W"],mp9_ref.ports["drain_W"],fullbottom=True )

    ###########################################################################################################
    mn6_ref = prec_ref_center(nfet_1)
    mn6_ref.movex(top_level.xmax - ( 10* evaluate_bbox(nfet_1)[0]/2) - 10*pdk.util_max_metal_seperation())
    mn6_ref.movey(top_level.ymin + ( evaluate_bbox(nfet_1)[1]/2) +  pdk.util_max_metal_seperation())
   

    
    ncm34 = current_mirror(pdk,numcols=1,width=0.28,length=8.0,device='nfet',with_tie=True)
    ncm34_ref= prec_ref_center(ncm34)
    ncm34_ref.movey(top_level.ymin - (2*evaluate_bbox(ncm34)[1]/2) - 2* pdk.util_max_metal_seperation() +1)
    ncm34_ref.movex(top_level.xmin + (4*evaluate_bbox(ncm34)[0]/2) + 4*pdk.util_max_metal_seperation())

    top_level.add(mn6_ref)
    top_level.add(ncm34_ref)

    top_level << c_route(pdk, mp6_ref.ports["multiplier_0_drain_W"], ncm34_ref.ports["fet_A_drain_W"],fullbottom=True,extension=8* pdk.util_max_metal_seperation())
    #top_level << c_route(pdk, mp6_ref.ports["multiplier_0_gate_E"], ncm34_ref.ports["fet_B_drain_E"],fullbottom=True,extension=pdk.util_max_metal_seperation())
    
    top_level << c_route(pdk, mn6_ref.ports["drain_W"], ncm34_ref.ports["fet_A_gate_W"],fullbottom=True)
    top_level << c_route(pdk, en_via.ports["bottom_met_W"], mn6_ref.ports["gate_W"],fullbottom=True,extension=10* pdk.util_max_metal_seperation())
   
    vss_via2 = top_level << viam2m3
    vss_via2.move(mn6_ref.ports["source_N"].center).movey(-15)
    top_level << c_route(pdk, vss_via2.ports["bottom_met_W"],mn6_ref.ports["source_W"], fullbottom=True,extension=5* pdk.util_max_metal_seperation())
    top_level << c_route(pdk, vss_via2.ports["bottom_met_W"],mn6_ref.ports["tie_W_top_met_W"], fullbottom=True,extension=5* pdk.util_max_metal_seperation())
    
    top_level << c_route(pdk, vss_via2.ports["bottom_met_S"],ncm34_ref.ports["welltie_S_top_met_S"], fullbottom=True )

    ###################################

    #mp17_ref = prec_ref_center(pfet_3)
    mp16_ref = prec_ref_center(pfet_4)
    xinv2=inverter(ihp130,width=(2.4,1.2),length=(0.28,0.28),fingers=(1,1))
    xinv2_ref= prec_ref_center(xinv2)
    
    #mp17_ref.movex(top_level.xmax - (7* evaluate_bbox(pfet_3)[0]/2) - 7* pdk.util_max_metal_seperation()+2)
    #mp17_ref.movey(top_level.ymax - ( evaluate_bbox(pfet_3)[1]/2) - 2* pdk.util_max_metal_seperation()+2)

    mp16_ref.movex(top_level.xmax - (4*evaluate_bbox(pfet_4)[0]/2) - 4*pdk.util_max_metal_seperation()+2)
    mp16_ref.movey(top_level.ymax - (2*evaluate_bbox(pfet_4)[1]/2) - 2*pdk.util_max_metal_seperation())

    xinv2_ref.movex(top_level.xmax + ( evaluate_bbox(pfet_3)[0]/2) + pdk.util_max_metal_seperation()+2)
    xinv2_ref.movey(top_level.ymax - (2* evaluate_bbox(pfet_3)[1]/2) - 2* pdk.util_max_metal_seperation())
    
    
    mp7_ref = prec_ref_center(pfet_2)
    mp8_ref = prec_ref_center(pfet_3)
    
    mp7_ref.movey(top_level.center[1] + (1.5*evaluate_bbox(pfet_2)[1]/2) + 1.5* pdk.util_max_metal_seperation())
    mp7_ref.movex(top_level.xmax - (2* evaluate_bbox(pfet_2)[0]/2) - 2* pdk.util_max_metal_seperation())

    mp8_ref.movey(top_level.center[1] - (1* evaluate_bbox(pfet_3)[1]/2) - 1* pdk.util_max_metal_seperation()-1)
    mp8_ref.movex(top_level.xmax - (2* evaluate_bbox(pfet_3)[0]/2) - 2* pdk.util_max_metal_seperation())

    #top_level.add(mp17_ref)
    top_level.add(mp16_ref)
    
    top_level.add(xinv2_ref)
    
    top_level.add(mp7_ref)
    top_level.add(mp8_ref)

    vdd_via5 = top_level << viam2m3
    vdd_via5.move(mp17_ref.ports["source_N"].center).movey(10)
    top_level << straight_route(pdk, vdd_via5.ports["top_met_S"],mp17_ref.ports["multiplier_1_source_N"], glayer1="met3",fullbottom=True )
    top_level << straight_route(pdk, vdd_via5.ports["bottom_met_S"],mp17_ref.ports["tie_N_top_met_N"],glayer1=tie_layers2[1], fullbottom=True )
    
    top_level << L_route(pdk, mp18_ref.ports["multiplier_1_gate_E"],mp17_ref.ports["multiplier_1_gate_N"],fullbottom=True)

    vdd_via6 = top_level << viam2m3
    vdd_via6.move(mp16_ref.ports["source_N"].center).movey(10)
    top_level << straight_route(pdk, vdd_via6.ports["top_met_S"],mp16_ref.ports["multiplier_0_source_N"], glayer1="met3",fullbottom=True )
    top_level << straight_route(pdk, vdd_via6.ports["bottom_met_S"],mp16_ref.ports["tie_N_top_met_N"],glayer1=tie_layers2[1], fullbottom=True )


    ex_via4 = top_level << viam2m3
    ex_via4.move(xinv2_ref.ports["in_via_top_met_S"].center).movey(-6)
    top_level << straight_route(pdk,xinv2_ref.ports["in_via_bottom_met_S"],ex_via4.ports["bottom_met_N"],fullbottom=True)

    ex_via5 = top_level << viam2m3
    ex_via5.move(mp17_ref.ports["multiplier_0_gate_W"].center).movex(-5)
    top_level << straight_route(pdk, mp17_ref.ports["multiplier_0_gate_W"],ex_via5.ports["bottom_met_E"],fullbottom=True)

  
    
    
    top_level << L_route(pdk,ex_via5.ports["bottom_met_S"],ex_via4.ports["bottom_met_E"],fullbottom=True)
    #'pdk', 'edge1', 'edge2', 'extension', 'width1', 'width2', 'cwidth', 'e1glayer', 'e2glayer', 'cglayer', 'viaoffset', 'fullbottom', 'extra_vias', 'debug'
    top_level << L_route(pdk, mp16_ref.ports["gate_S"],xinv2_ref.ports["out_via_bottom_met_E"],fullbottom=True)

    top_level << c_route(pdk, mp17_ref.ports["drain_W"],mp7_ref.ports["multiplier_1_source_W"],fullbottom=True,extension=8* pdk.util_max_metal_seperation())
    top_level << c_route(pdk, mp7_ref.ports["drain_E"],mp8_ref.ports["multiplier_1_source_E"], fullbottom=True,extension= 4* pdk.util_max_metal_seperation())

    top_level << c_route(pdk, mp16_ref.ports["drain_W"],mp8_ref.ports["multiplier_1_gate_W"],fullbottom=True,extension=20* pdk.util_max_metal_seperation())


    ex_via3 = top_level << viam2m3
    ex_via3.move(mp8_ref.ports["multiplier_0_gate_E"].center).movex(-10)
    top_level << straight_route(pdk, mp8_ref.ports["multiplier_0_gate_E"],ex_via3.ports["bottom_met_W"],fullbottom=True)
    top_level << L_route(pdk, mp6_ref.ports["multiplier_0_gate_E"],ex_via3.ports["bottom_met_S"],fullbottom=True)

    
    top_level << c_route(pdk, mp4_ref.ports["multiplier_0_gate_W"],mp6_ref.ports["multiplier_1_gate_W"],fullbottom=True)
    top_level << c_route(pdk, mp8_ref.ports["multiplier_0_gate_E"], ncm34_ref.ports["fet_B_drain_E"],fullbottom=True,extension=pdk.util_max_metal_seperation())
    top_level << straight_route(pdk, mp5_ref.ports["multiplier_0_gate_E"],mp7_ref.ports["multiplier_0_gate_E"],fullbottom=True)
    
    
    ex_via1 = top_level << viam2m3
    ex_via1.move(mp3_ref.ports["multiplier_0_gate_E"].center).movex(5)
    top_level << straight_route(pdk, mp3_ref.ports["multiplier_0_gate_E"],ex_via1.ports["bottom_met_W"],fullbottom=True)
    
    ex_via2 = top_level << viam2m3
    ex_via2.move(mp5_ref.ports["multiplier_0_gate_W"].center).movex(-15)
    top_level << straight_route(pdk, mp5_ref.ports["multiplier_0_gate_W"],ex_via2.ports["bottom_met_E"],fullbottom=True)
    top_level << L_route(pdk,ex_via1.ports["bottom_met_N"],ex_via2.ports["bottom_met_E"],fullbottom=True)

    top_level << L_route(pdk,mp7_ref.ports["multiplier_0_gate_S"],mp8_ref.ports["multiplier_1_drain_W"],fullbottom=True)

    
    vdd_via7 = top_level << viam2m3
    vdd_via7.move(xinv2_ref.ports["vdd_via_top_met_N"].center).movey(10)
    top_level << straight_route(pdk, vdd_via7.ports["top_met_S"],xinv2_ref.ports["vdd_via_top_met_N"], glayer1="met3",fullbottom=True )
   
    top_level << c_route(pdk,vss_via2.ports["bottom_met_S"],xinv2_ref.ports["vss_via_top_met_S"],fullbottom=True)


    vbp_via = top_level << viam2m3
    vbp_via.move(mp7_ref.ports["multiplier_0_gate_E"].center).movex(25)
    top_level << straight_route(pdk, mp7_ref.ports["multiplier_0_gate_E"],vbp_via.ports["bottom_met_E"],fullbottom=True)

    vbpC_via = top_level << viam2m3
    vbpC_via.move(mp8_ref.ports["multiplier_0_gate_E"].center).movex(20)
    top_level << straight_route(pdk,mp8_ref.ports["multiplier_0_gate_E"],vbpC_via.ports["bottom_met_E"],fullbottom=True)

    XR1_via1 = top_level << viam2m3
    XR1_via1.move(mp8_ref.ports["multiplier_0_drain_E"].center).movex(10)
    top_level << straight_route(pdk,mp8_ref.ports["multiplier_0_drain_E"],XR1_via1.ports["bottom_met_E"],fullbottom=True)

    XR1_via2 = top_level << viam2m3
    XR1_via2.move(ncm34_ref.ports["fet_B_drain_E"].center).movex(15)
    top_level << straight_route(pdk,ncm34_ref.ports["fet_B_drain_E"],XR1_via2.ports["bottom_met_E"],fullbottom=True)

    XR2_via1 = top_level << viam2m3
    XR2_via1.move(ncm34_ref.ports["fet_B_source_E"].center).movex(15)
    top_level << straight_route(pdk,ncm34_ref.ports["fet_B_source_E"],XR2_via1.ports["bottom_met_E"],fullbottom=True)

    
    XR2_via = top_level << viam2m3
    XR2_via.move(ncm34_ref.ports["fet_B_gate_E"].center).movex(15)

    
   
    return component_snap_to_grid(rename_ports_by_orientation(top_level))
                     

    

if __name__ == "__main__":
	comp = trimmer(ihp130)

	# comp.pprint_ports()
	#comp = add_fvf_labels(comp, ihp130)
	comp.name = "TRIM"
	#comp.write_gds('out_FVF.gds')
	comp.show()

	#print("...Running DRC...")
	#drc_result = ihp130.drc(comp,comp.name)

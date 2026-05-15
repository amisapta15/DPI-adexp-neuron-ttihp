from glayout import MappedPDK, sky130 , gf180 , ihp130
#from gdsfactory.cell import cell
from gdsfactory import Component
from gdsfactory.components import text_freetype, rectangle
from glayout import resistor
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
sys.path.append('../../../../elementary/current_mirror/')
from current_mirror import current_mirror,add_cm_labels

def dpi_inv1(pdk: MappedPDK,
        multipliers: tuple[int,int] = (1,1),
        dummy_1: tuple[bool,bool] = (True,True),
        dummy_2: tuple[bool,bool] = (True,True),
        tie_layers1: tuple[str,str] = ("met2","met1"),
        tie_layers2: tuple[str,str] = ("met2","met1"),
    ) -> Component:
    pdk.activate()
    top_level = Component(name="dpi_inv1")
    viam2m3 = via_stack(pdk, "met2", "met3", centered=True) #met2 is the bottom layer. met3 is the top layer.

    width=(2.4,1.2);length=(0.28,0.28);fingers=(1,1);
    fet_P = pmos(pdk, width=width[0], fingers=fingers[0], length=length[0], tie_layers=tie_layers1,multipliers=multipliers[0], with_dummy=True, with_substrate_tap=False, dnwell=False)
    fet_N = nmos(pdk, width=width[1], fingers=fingers[1], multipliers=multipliers[1],length=length[1], tie_layers=tie_layers2, with_dummy=True, with_substrate_tap=False, with_dnwell=False)
    
    fet_P_ref = prec_ref_center(fet_P)
    fet2_P_ref = prec_ref_center(fet_P)
    fet_N_ref = prec_ref_center(fet_N) 
    fet2_N_ref = prec_ref_center(fet_N)

    
    fet_P_ref.movey(top_level.ymin - evaluate_bbox(fet_P)[1]/2 - pdk.util_max_metal_seperation())
    fet2_P_ref.movey(top_level.ymin - evaluate_bbox(fet_P)[1]/2 - pdk.util_max_metal_seperation())
    fet2_P_ref.movex(top_level.xmin - 2*evaluate_bbox(fet_P)[0]/2 - 2*pdk.util_max_metal_seperation())
    top_level.add(fet_P_ref)
    
     
    fet_N_ref.movey(top_level.ymin - evaluate_bbox(fet_N)[1]/2 - pdk.util_max_metal_seperation())
    fet2_N_ref.movey(top_level.ymin - evaluate_bbox(fet_N)[1]/2 - pdk.util_max_metal_seperation())
    fet2_N_ref.movex(top_level.xmin - evaluate_bbox(fet_N)[0]/2 - pdk.util_max_metal_seperation())
    top_level.add(fet_N_ref)
    top_level.add(fet2_P_ref)
    top_level.add(fet2_N_ref)
    
    #####################################################33
    in_via = top_level << viam2m3
    out_via = top_level << viam2m3
    in_via.move(fet_P_ref.ports["multiplier_0_gate_E"].center).movex(4)
    out_via.move(fet_N_ref.ports["multiplier_0_drain_W"].center).movex(-4.5)
    
    ################################################################
    
    vss_via1 = top_level << viam2m3
    vss_via1.move(fet_N_ref.ports["multiplier_0_source_W"].center).movex(-3.5)
   
    vdd_via1 = top_level << viam2m3
    vdd_via1.move(fet_P_ref.ports["multiplier_0_source_E"].center).movex(3)
    

    pcm69 = current_mirror(pdk,numcols=1,width=2.4,length=3.0,device='pfet',with_tie=True)
    pcm69_ref= prec_ref_center(pcm69)
    pcm69_ref.movey(top_level.ymax + evaluate_bbox(pcm69)[1]/2 - pdk.util_max_metal_seperation())
    top_level.add(pcm69_ref)

    vdd_via2 = top_level << viam2m3
    vdd_via2.move(pcm69_ref.ports["fet_A_source_E"].center).movex(3)
   
    
    nm25= nmos(pdk, width=1.2, length=3.0, with_substrate_tap=False, with_tie=True, with_dnwell=False,multipliers=1, substrate_tap_layers=False, tie_layers=tie_layers1, with_dummy=True)
    nm25_ref=prec_ref_center(nm25)
    nm25_ref.movey(top_level.ymin - evaluate_bbox(nm25)[1]/2 - pdk.util_max_metal_seperation())
    top_level.add(nm25_ref)

    vss_via2 = top_level << viam2m3
    vss_via2.move(nm25_ref.ports["multiplier_0_source_W"].center).movex(-3)

    REQ_via=top_level << viam2m3
    REQ_via.move(fet2_P_ref.ports["gate_W"].center).movex(-5)

    RST_via=top_level << viam2m3
    RST_via.move(fet2_N_ref.ports["gate_W"].center).movex(-5)
    
    top_level << c_route(pdk, fet_P_ref.ports["multiplier_0_drain_W"], fet_N_ref.ports["multiplier_0_drain_W"],viaoffset=True, fullbottom=True)
    
    top_level << c_route(pdk, fet_P_ref.ports["multiplier_0_gate_E"], fet_N_ref.ports["multiplier_0_gate_E"],viaoffset=True, fullbottom=True)  
    
    
    top_level << straight_route(pdk, fet_P_ref.ports["multiplier_0_gate_E"], in_via.ports["bottom_met_W"])
    top_level << c_route(pdk, fet2_P_ref.ports["multiplier_0_drain_E"], fet2_N_ref.ports["multiplier_0_drain_E"],fullbottom=True)
    top_level << straight_route(pdk, fet2_N_ref.ports["multiplier_0_drain_W"], in_via.ports["bottom_met_E"], fullbottom=True)
    top_level << straight_route(pdk, fet_N_ref.ports["multiplier_0_drain_W"], out_via.ports["bottom_met_W"])
    
    top_level << straight_route(pdk, vss_via1.ports["bottom_met_E"],fet_N_ref.ports["tie_W_top_met_W"],glayer1=tie_layers2[1], fullbottom=True )
    
    top_level << straight_route(pdk, vdd_via1.ports["bottom_met_W"],fet_P_ref.ports["tie_E_top_met_E"],glayer1=tie_layers2[1], fullbottom=True )
    
    top_level << c_route(pdk,pcm69_ref.ports["fet_B_drain_E"],fet_P_ref.ports["multiplier_0_source_E"],fullbottom=True,extension=0.5* pdk.util_max_metal_seperation())

    top_level << c_route(pdk,nm25_ref.ports['gate_W'], nm25_ref.ports['drain_W'])
    top_level << c_route(pdk,fet_N_ref.ports["multiplier_0_source_W"], nm25_ref.ports['drain_W'])
    top_level << straight_route(pdk, vss_via2.ports["bottom_met_E"],nm25_ref.ports["tie_W_top_met_W"],glayer1=tie_layers2[1], fullbottom=True )
    top_level << straight_route(pdk, vss_via2.ports["bottom_met_E"],nm25_ref.ports["source_W"],glayer1=tie_layers2[1], fullbottom=True )
    


    top_level << straight_route(pdk, fet2_P_ref.ports["gate_W"], REQ_via.ports["bottom_met_E"])
    top_level << straight_route(pdk, fet2_N_ref.ports["gate_W"], RST_via.ports["bottom_met_E"])



    
    return component_snap_to_grid(rename_ports_by_orientation(top_level))
    


if __name__ == "__main__":
    comp = dpi_inv1(ihp130)
    # comp.pprint_ports()
    #comp = add_inv_labels(comp, ihp130)
    comp.name = "DPINV1"
    #comp.write_gds('out_INV.gds')
    comp.show()
    #print("...Running DRC...")
    #drc_result = gf180.drc_magic(comp, "INV")
    #drc_result = gf180.drc(comp)
    
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


def neuron(
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

    difp =diff_pair(pdk,width= 1.2,fingers= 1,length=0.75,device = 'pfet')
    difp_ref= prec_ref_center(difp)

    top_level.add(difp_ref)

    in_via = top_level << viam2m3
    in_via.move(difp_ref.ports["source_routeE_con_N"].center).movey(10)
    top_level << straight_route(pdk,in_via.ports["bottom_met_S"],difp_ref.ports["source_routeE_con_N"], glayer1="met2",fullbottom=True)

    vmem_via = top_level << viam2m3
    vmem_via.move(difp_ref.ports["MINUSgateroute_E_con_N"].center).movey(5)
    top_level << straight_route(pdk,vmem_via.ports["bottom_met_S"],difp_ref.ports["MINUSgateroute_E_con_N"], glayer1="met2",fullbottom=True)
    top_level << L_route(pdk,vmem_via.ports["top_met_W"],difp_ref.ports["drain_routeTL_BR_con_N"],fullbottom=True)
    
    
    
    vthr_via = top_level << viam2m3
    vthr_via.move(difp_ref.ports["PLUSgateroute_W_con_N"].center).movey(5)
    top_level << straight_route(pdk,vthr_via.ports["top_met_N"],difp_ref.ports["PLUSgateroute_W_con_N"],fullbottom=True)

    
    ncmlk = current_mirror(pdk,numcols=1,width=1.2,length=3.0,device='nfet',with_tie=True)
    ncmlk_ref= prec_ref_center(ncmlk)
    #ncmlk_ref.movey(top_level.ymin - (evaluate_bbox(ncmlk)[1]/2) - pdk.util_max_metal_seperation())
    ncmlk_ref.movex(top_level.xmin - (evaluate_bbox(ncmlk)[0]/2) - pdk.util_max_metal_seperation())
    top_level.add(ncmlk_ref)

 
    
    vthr_via2 = top_level << viam2m3
    vthr_via2.move(ncmlk.ports["fet_B_drain_N"].center).movey(5)
    #top_level << L_route(pdk,ncmlk.ports["fet_B_drain_N"],vthr_via2.ports["bottom_met_W"],fullbottom=True)

    mp17 = pmos(pdk, length=10.0,width=1.2, fingers=5, multipliers=10, with_dummy=True, with_substrate_tap=False,dnwell=False)
    mp17_ref= prec_ref_center(mp17)

    mp17_ref.movey(top_level.ymin - (evaluate_bbox(mp17)[1]/2) - pdk.util_max_metal_seperation())
    mp17_ref.movex(top_level.xmax + (evaluate_bbox(mp17)[0]/2) - pdk.util_max_metal_seperation())
    top_level.add(mp17_ref)
    top_level << straight_route(pdk,mp17.ports["multiplier_9_source_W"],mp17.ports["tie_W_top_met_W"],fullbottom=True)


    cap_via = top_level << viam2m3
    cap_via.move(mp17_ref.ports["multiplier_9_gate_N"].center).movey(10)
    for i in range(0,10):
        top_level << L_route(pdk,cap_via.ports["top_met_S"],mp17_ref.ports[f"multiplier_{i}_gate_E"],fullbottom=True)

    top_level << L_route(pdk,cap_via.ports["bottom_met_N"],vmem_via.ports["bottom_met_E"],fullbottom=True)
    
    
    vss_via2=cap_via = top_level << viam2m3
    vss_via2.move(mp17_ref.ports["multiplier_0_gate_S"].center).movey(-10)
    top_level << straight_route(pdk, vss_via2.ports["top_met_N"],mp17_ref.ports["tie_S_top_met_S"], fullbottom=True)
    top_level << c_route(pdk, vss_via2.ports["bottom_met_S"],mp17_ref.ports["tie_br_top_met_S"], fullbottom=True)
    top_level << c_route(pdk, vss_via2.ports["bottom_met_S"],mp17_ref.ports["tie_bl_top_met_S"], fullbottom=True)



    # for absc in mp17.ports.keys():
    #     if len(absc.split("_")) <= 6:
    #         #if set(["bottom","cm","dummy","B","gsdcon"]).issubset(set(absc.split("_"))):
    #             print(absc+"\n")



    return component_snap_to_grid(rename_ports_by_orientation(top_level))
                     
# │ source_routeE_con_N                                                      │ 0.2   │ [3.79, 2.775]    │ 90.0        │ [30, 0] │ electrical │
# │ source_routeE_con_S                                                      │ 0.2   │ [3.79, -3.595]   │ 270.0       │ [30, 0] │ electrical │
# │ source_routeW_con_N                                                      │ 0.2   │ [-3.79, 2.775]   │ 90.0        │ [30, 0] │ electrical │
# │ source_routeW_con_S                                                      │ 0.2   │ [-3.79, -3.595]  │ 270.0       │ [30, 0] │ electrical │
# │ drain_routeTR_BL_con_N                                                   │ 0.2   │ [4.2, 3.185]     │ 90.0        │ [30, 0] │ electrical │
# │ drain_routeTR_BL_con_S                                                   │ 0.2   │ [4.2, -4.825]    │ 270.0       │ [30, 0] │ electrical │
# │ drain_routeTL_BR_con_N                                                   │ 0.2   │ [-4.2, 3.185]    │ 90.0        │ [30, 0] │ electrical │
# │ drain_routeTL_BR_con_S                                                   │ 0.2   │ [-4.2, -5.235]   │ 270.0       │ [30, 0] │ electrical │
# │ MINUSgateroute_W_con_N                                                   │ 0.2   │ [-5.7, 5.475]    │ 90.0        │ [30, 0] │ electrical │
# │ MINUSgateroute_W_con_S                                                   │ 0.2   │ [-5.7, -1.425]   │ 270.0       │ [30, 0] │ electrical │
# │ MINUSgateroute_E_con_N                                                   │ 0.2   │ [5.29, 5.475]    │ 90.0        │ [30, 0] │ electrical │
# │ MINUSgateroute_E_con_S                                                   │ 0.2   │ [5.29, 0.405]    │ 270.0       │ [30, 0] │ electrical │
# │ PLUSgateroute_W_con_N                                                    │ 0.2   │ [-5.29, 5.065]   │ 90.0        │ [30, 0] │ electrical │
# │ PLUSgateroute_W_con_S                                                    │ 0.2   │ [-5.29, 0.405]   │ 270.0       │ [30, 0] │ electrical │
# │ PLUSgateroute_E_con_N                                                    │ 0.2   │ [5.7, 5.065]     │ 90.0        │ [30, 0] │ electrical │
# │ PLUSgateroute_E_con_S
    

if __name__ == "__main__":
	comp = neuron(ihp130)

	# comp.pprint_ports()
	#comp = add_fvf_labels(comp, ihp130)
	comp.name = "DPI"
	#comp.write_gds('out_FVF.gds')
	comp.show()

	#print("...Running DRC...")
	#drc_result = ihp130.drc(comp,comp.name)
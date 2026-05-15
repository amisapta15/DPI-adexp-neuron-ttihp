from gdsfactory.read.import_gds import import_gds

from glayout import MappedPDK, sky130 , gf180 , ihp130
#from gdsfactory.cell import cell
from gdsfactory import Component
from gdsfactory.components import text_freetype, rectangle

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
sys.path.append('../../../../elementary/diff_pair/')
from diff_pair import diff_pair, diff_pair_generic, diff_pair_netlist, add_df_labels
sys.path.append('../../../../elementary/current_mirror/')
from current_mirror import current_mirror,add_cm_labels

# def __add_mimcap_arr(pdk: MappedPDK, opamp_top: Component, mim_cap_size, mim_cap_rows, ymin: float, n_to_p_output_route) -> tuple[Component, Netlist]:
#     mim_cap_size = pdk.snap_to_2xgrid(mim_cap_size, return_type="float")
#     max_metalsep = pdk.util_max_metal_seperation()
#     mimcaps_ref = opamp_top << mimcap_array(pdk,mim_cap_rows,2,size=mim_cap_size,rmult=6)
#     if int(mim_cap_rows) < 1:
#         raise ValueError("mim_cap_rows should be a positive integer")
#     mimcap_netlist = mimcaps_ref.info['netlist']

#     displace_fact = max(max_metalsep,pdk.get_grule("capmet")["min_separation"])
#     mimcaps_ref.movex(pdk.snap_to_2xgrid(opamp_top.xmax + displace_fact + mim_cap_size[0]/2))
#     mimcaps_ref.movey(pdk.snap_to_2xgrid(ymin + mim_cap_size[1]/2))
#     # connect mimcap to gnd
#     port1 = opamp_top.ports["pcomps_mimcap_connection_con_N"]
#     port2 = mimcaps_ref.ports["row"+str(int(mim_cap_rows)-1)+"_col0_bottom_met_N"]
#     cref2_extension = max_metalsep + opamp_top.ymax - max(port1.center[1], port2.center[1])
#     opamp_top << c_route(pdk,port1,port2, extension=cref2_extension, fullbottom=True)
#     intermediate_output = set_port_orientation(n_to_p_output_route.ports["con_S"],"E")
#     opamp_top << L_route(pdk, mimcaps_ref.ports["row0_col0_top_met_S"], intermediate_output, hwidth=3)
#     opamp_top.add_ports(mimcaps_ref.get_ports_list(),prefix="mimcap_")
#     # add the cs output as a port
#     opamp_top.add_port(name="commonsource_output_E", port=intermediate_output)
#     return opamp_top, mimcap_netlist

    
def top(pdk: MappedPDK) -> Component:

    pdk.activate()
    
    #top level component
    top_level = Component(name="dpi_neu")

    comp =diff_pair(pdk,width= 1.2,fingers= 1,length=0.75,device = 'pfet')
    comp = component_snap_to_grid(comp)
    comp.name = "dpi_gen" 
    top_level << comp

    fetN_M3 = nmos(pdk, length=3.0,width=1.2, fingers=1, multipliers=1, with_dummy=True, with_substrate_tap=False,with_dnwell=False)
    #cap_1 = device(pdk, width=width[1], fingers=fingers[1], multipliers=multipliers[1], with_dummy=dummy_2, with_substrate_tap=False, length=length[1], tie_layers=tie_layers2, sd_rmult=sd_rmult, **kwargs)
    well = "pwell" 
    top_level.info.update({"fetN_M3": fetN_M3}) #for later access in other functions

    fetN_M3_ref = top_level << fetN_M3
    #fet_2_ref = top_level << fet_2
    fetN_M3_ref.name = "fetN_M3_ref"
    #fet_2_ref.name = "fet2_ref"

    #Relative move
    ref_dimensions = evaluate_bbox(fetN_M3)
    fetN_M3_ref.movex(top_level.xmax + ref_dimensions[0]/2 + pdk.util_max_metal_seperation()+1)


    # mim_cap_size = pdk.snap_to_2xgrid((10,10), return_type="float")
    # max_metalsep = pdk.util_max_metal_seperation()
    # mimcaps_ref = top_level << mimcap_array(pdk,4,2,size=mim_cap_size,rmult=6)

    # ref_dimensions = evaluate_bbox(mimcaps_ref)
    # mimcaps_ref.movey(top_level.ymax + ref_dimensions[0]/2 + pdk.util_max_metal_seperation()+1)
    

    return top_level

# comp.pprint_ports()
comp =top(ihp130)
print("Printing_netlist")
# comp.info['netlist'].generate_netlist()
comp.name = "DiffPair"
comp.show()
from gdsfactory.read.import_gds import import_gds

from glayout import MappedPDK, sky130 , gf180 , ihp130
#from gdsfactory.cell import cell
from gdsfactory import Component
from gdsfactory.components import text_freetype, rectangle

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
sys.path.append('../../../../elementary/diff_pair/')
from diff_pair import diff_pair, diff_pair_generic, diff_pair_netlist, add_df_labels
sys.path.append('../../../../elementary/current_mirror/')
from current_mirror import current_mirror,add_cm_labels

# def __add_mimcap_arr(pdk: MappedPDK, opamp_top: Component, mim_cap_size, mim_cap_rows, ymin: float, n_to_p_output_route) -> tuple[Component, Netlist]:
#     mim_cap_size = pdk.snap_to_2xgrid(mim_cap_size, return_type="float")
#     max_metalsep = pdk.util_max_metal_seperation()
#     mimcaps_ref = opamp_top << mimcap_array(pdk,mim_cap_rows,2,size=mim_cap_size,rmult=6)
#     if int(mim_cap_rows) < 1:
#         raise ValueError("mim_cap_rows should be a positive integer")
#     mimcap_netlist = mimcaps_ref.info['netlist']

#     displace_fact = max(max_metalsep,pdk.get_grule("capmet")["min_separation"])
#     mimcaps_ref.movex(pdk.snap_to_2xgrid(opamp_top.xmax + displace_fact + mim_cap_size[0]/2))
#     mimcaps_ref.movey(pdk.snap_to_2xgrid(ymin + mim_cap_size[1]/2))
#     # connect mimcap to gnd
#     port1 = opamp_top.ports["pcomps_mimcap_connection_con_N"]
#     port2 = mimcaps_ref.ports["row"+str(int(mim_cap_rows)-1)+"_col0_bottom_met_N"]
#     cref2_extension = max_metalsep + opamp_top.ymax - max(port1.center[1], port2.center[1])
#     opamp_top << c_route(pdk,port1,port2, extension=cref2_extension, fullbottom=True)
#     intermediate_output = set_port_orientation(n_to_p_output_route.ports["con_S"],"E")
#     opamp_top << L_route(pdk, mimcaps_ref.ports["row0_col0_top_met_S"], intermediate_output, hwidth=3)
#     opamp_top.add_ports(mimcaps_ref.get_ports_list(),prefix="mimcap_")
#     # add the cs output as a port
#     opamp_top.add_port(name="commonsource_output_E", port=intermediate_output)
#     return opamp_top, mimcap_netlist

    
def top(pdk: MappedPDK) -> Component:

    pdk.activate()
    
    #top level component
    top_level = Component(name="dpi_neu")

    comp =diff_pair(pdk,width= 1.2,fingers= 1,length=0.75,device = 'pfet')
    comp = component_snap_to_grid(comp)
    comp.name = "dpi_gen" 
    top_level << comp

    fetN_M3 = nmos(pdk, length=3.0,width=1.2, fingers=1, multipliers=1, with_dummy=True, with_substrate_tap=False,with_dnwell=False)
    #cap_1 = device(pdk, width=width[1], fingers=fingers[1], multipliers=multipliers[1], with_dummy=dummy_2, with_substrate_tap=False, length=length[1], tie_layers=tie_layers2, sd_rmult=sd_rmult, **kwargs)
    well = "pwell" 
    top_level.info.update({"fetN_M3": fetN_M3}) #for later access in other functions

    fetN_M3_ref = top_level << fetN_M3
    #fet_2_ref = top_level << fet_2
    fetN_M3_ref.name = "fetN_M3_ref"
    #fet_2_ref.name = "fet2_ref"

    #Relative move
    ref_dimensions = evaluate_bbox(fetN_M3)
    fetN_M3_ref.movex(top_level.xmax + ref_dimensions[0]/2 + pdk.util_max_metal_seperation()+1)


    # mim_cap_size = pdk.snap_to_2xgrid((10,10), return_type="float")
    # max_metalsep = pdk.util_max_metal_seperation()
    # mimcaps_ref = top_level << mimcap_array(pdk,4,2,size=mim_cap_size,rmult=6)

    # ref_dimensions = evaluate_bbox(mimcaps_ref)
    # mimcaps_ref.movey(top_level.ymax + ref_dimensions[0]/2 + pdk.util_max_metal_seperation()+1)
    

    return top_level

# comp.pprint_ports()
comp =top(ihp130)
print("Printing_netlist")
# comp.info['netlist'].generate_netlist()
comp.name = "DiffPair"
comp.show()

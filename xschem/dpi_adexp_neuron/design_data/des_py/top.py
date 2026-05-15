from gdsfactory.read.import_gds import import_gds

from glayout import MappedPDK, sky130 , gf180 , ihp130
#from gdsfactory.cell import cell
from gdsfactory import Component
from gdsfactory.components import text_freetype, rectangle

from glayout import nmos, pmos
from glayout import via_stack, via_array
from glayout import rename_ports_by_orientation
from glayout import tapring

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

## Creating a Transistor
# def sky130_add_lvt_layer(opamp_in: Component) -> Component:
# 	global __NO_LVT_GLOBAL_
# 	if __NO_LVT_GLOBAL_:
# 		return opamp_in
# 	opamp_in.unlock()
# 	# define layers
# 	lvt_layer = (125,44)
# 	# define geometry over pmos components and add lvt
# 	SW_S_edge = opamp_in.ports["commonsource_Pamp_L_multiplier_0_plusdoped_S"]
# 	SW_W_edge = opamp_in.ports["commonsource_Pamp_L_multiplier_0_dummy_L_plusdoped_W"]
# 	NE_N_edge = opamp_in.ports["commonsource_Pamp_R_multiplier_2_plusdoped_N"]
# 	NE_E_edge = opamp_in.ports["commonsource_Pamp_R_multiplier_2_dummy_R_plusdoped_E"]
# 	SW_S_center = SW_S_edge.center
# 	SW_W_center = SW_W_edge.center
# 	NE_N_center = NE_N_edge.center
# 	NE_E_center = NE_E_edge.center
# 	SW_corner = [SW_W_center[0], SW_S_center[1]]
# 	NE_corner = [NE_E_center[0], NE_N_center[1]]
# 	middle_top_y = opamp_in.ports["pcomps_ptopAB_L_plusdoped_N"].center[1]
# 	middle_bottom_y = opamp_in.ports["pcomps_pbottomAB_R_plusdoped_S"].center[1]
# 	max_y = max(middle_top_y, NE_corner[1])
# 	min_y = min(middle_bottom_y, SW_corner[1])
# 	abs_center = (SW_corner[0] + (NE_corner[0] - SW_corner[0])/2, min_y + (max_y - min_y)/2)
# 	# draw lvt rectangle
# 	LVT_rectangle = rectangle(layer=lvt_layer, size=(abs(NE_corner[0] - SW_corner[0]), abs(max_y - min_y)+0.36), centered=True)
# 	LVT_rectangle_ref = opamp_in << LVT_rectangle
# 	# align lvt rectangle to the plusdoped_N region
# 	LVT_rectangle_ref.move(origin=(0, 0), destination=abs_center)
# 	# define geometry over output amplfier and add lvt
# 	outputW = opamp_in.ports["outputstage_amp_multiplier_0_dummy_L_plusdoped_W"]
# 	outputE = opamp_in.ports["outputstage_amp_multiplier_0_dummy_R_plusdoped_E"]
# 	width = abs(outputE.center[0]-outputW.center[0])
# 	hieght = outputW.width+0.36
# 	center = (outputW.center[0] + width/2, outputW.center[1])
# 	lvtref = opamp_in << rectangle(size=(width,hieght),layer=lvt_layer,centered=True)
# 	lvtref.move(destination=center)
# 	return opamp_in
    
def sky130_opamp_add_pads(opamp_in: Component,  pdk: MappedPDK, flatten=False) -> Component:
    """adds the MPW-5 pads and nano pads to opamp.
    Also adds text labels and pin layers so that extraction is nice
    this function does not need to be used with sky130_add_opamp_labels
    """
    opamp_wpads = opamp_in.copy()
    opamp_wpads = movey(opamp_wpads, destination=0)
    
    pad = import_gds("pads/Manhattan120umPad.gds")
    pad.name = "Manhattan120umPad"
    
    pad = add_ports_perimeter(pad, pdk.get_glayer("met4"),prefix="pad_")
    
    pad_array = prec_array(pad, rows=2, columns=(4+1), spacing=(120,120))
    pad_array_ref = prec_ref_center(pad_array)
    opamp_wpads.add(pad_array_ref)

    opamp_wpads.pprint_ports()
    
    # add via_array to vdd pin
    vddarray = via_array(pdk, "met4","met5",size=(opamp_wpads.ports["pin_vdd_N"].width,opamp_wpads.ports["pin_vdd_E"].width))
 #    via_array_ref = opamp_wpads << vddarray
 #    align_comp_to_port(via_array_ref,opamp_wpads.ports["pin_vdd_N"],alignment=('c','b'))
 #    # route to the pads
 #    leftroutelayer="met4"
 #    opamp_wpads << L_route(pdk, opamp_wpads.ports["pin_plus_W"],pad_array_ref.ports["row1_col1_pad_S"], hwidth=3, vglayer=leftroutelayer)
 #    opamp_wpads << L_route(pdk, opamp_wpads.ports["pin_minus_W"],pad_array_ref.ports["row0_col1_pad_N"],hwidth=3, vglayer=leftroutelayer)
 #    opamp_wpads << straight_route(pdk, pad_array_ref.ports["row1_col2_pad_S"],opamp_wpads.ports["pin_vdd_S"], width=4,glayer1="met5")
 #    opamp_wpads << straight_route(pdk, opamp_wpads.ports["pin_diffpairibias_S"],pad_array_ref.ports["row0_col2_pad_N"])
 #    opamp_wpads << L_route(pdk, opamp_wpads.ports["pin_gnd_E"],pad_array_ref.ports["row0_col3_pad_N"], vglayer="met4",hwidth=3)
 #    opamp_wpads << L_route(pdk, opamp_wpads.ports["pin_commonsourceibias_E"],pad_array_ref.ports["row0_col4_pad_N"],hwidth=3)
 #    opamp_wpads << L_route(pdk, opamp_wpads.ports["pin_outputibias_E"],pad_array_ref.ports["row1_col4_pad_S"], hwidth=3)
 #    opamp_wpads << c_route(pdk, opamp_wpads.ports["pin_output_route_E"],pad_array_ref.ports["row1_col3_pad_E"], extension=1, cglayer="met3", cwidth=4)
 #    # add pin layer and text labels for LVS
 #    text_pin_labels = list()
 #    met5pin = rectangle(size=(5,5),layer=(72,16), centered=True)
 #    for name in ["minus","diffpairibias","gnd","commonsourceibias","plus","vdd","output","outputibias"]:
 #        pin_w_label = met5pin.copy()
 #        pin_w_label.add_label(text=name,layer=(72,5),magnification=4)
 #        text_pin_labels.append(pin_w_label)
 #    for row in range(2):
 #        for col_u in range(4):
 #            col = col_u + 1# left most are for nano pads
 #            port_name = "row"+str(row)+"_col"+str(col)+"_pad_S"
 #            pad_array_port = pad_array_ref.ports[port_name]
 #            pin_ref = opamp_wpads << text_pin_labels[4*row + col_u]
 #            align_comp_to_port(pin_ref,pad_array_port,alignment=('c','t'))
	# # # import nano pad and add to opamp
	# nanopad = import_gds("pads/sky130_nano_pad.gds")
	# nanopad.name = "nanopad"
	# nanopad = add_ports_perimeter(nanopad, pdk.get_glayer(leftroutelayer),prefix="nanopad_")
	# nanopad_array = prec_array(nanopad, rows=2, columns=2, spacing=(10,10))
	# nanopad_array_ref = nanopad_array.ref_center()
	# opamp_wpads.add(nanopad_array_ref)
	# nanopad_array_ref.movex(opamp_wpads.xmin+nanopad_array.xmax)
	# # route nano pad connections
	# opamp_wpads << straight_route(pdk, nanopad_array_ref.ports["row1_col0_nanopad_N"],pad_array_ref.ports["row1_col0_pad_S"],width=3,glayer2=leftroutelayer)
	# opamp_wpads << straight_route(pdk, nanopad_array_ref.ports["row0_col0_nanopad_S"],pad_array_ref.ports["row0_col0_pad_N"],width=3,glayer2=leftroutelayer)
	# opamp_wpads << straight_route(pdk, nanopad_array_ref.ports["row0_col1_nanopad_E"],pad_array_ref.ports["row0_col1_pad_N"],width=3,glayer2=leftroutelayer)
	# opamp_wpads << straight_route(pdk, nanopad_array_ref.ports["row1_col1_nanopad_E"],pad_array_ref.ports["row1_col1_pad_S"],width=3,glayer2=leftroutelayer)
	# # add the extra pad for the CS output
	# cspadref = opamp_wpads << pad
	# if not small_pad:
	# 	cspadref.movex(720).movey(120)
	# else:
	# 	cspadref.movex(300).movey(90)
	# opamp_wpads << L_route(pdk, cspadref.ports["pad_S"], opamp_wpads.ports["commonsource_output_E"],hwidth=3, hglayer="met5",vglayer="met5")
	# #opamp_wpads << nanopad
    if flatten:
        return opamp_wpads.flatten()
    else:
        return opamp_wpads


def top(
        pdk: MappedPDK,
        #device_type: str = "nmos", 
        #placement: str = "horizontal",
        #width: tuple[float,float] = (3,3),
        #length: tuple[float,float] = (None,None),
        #fingers: tuple[int,int] = (1,1),
        #multipliers: tuple[int,int] = (1,1),
        #with_substrate_tap: bool = False,
        #dummy_1: tuple[bool,bool] = (True,True),
        #dummy_2: tuple[bool,bool] = (True,True),
        #tie_layers1: tuple[str,str] = ("met2","met1"),
        #tie_layers2: tuple[str,str] = ("met2","met1"),
        #sd_rmult: int=1,
        #**kwargs
        ) -> Component:

    pdk.activate()
    
    #top level component
    top_level = Component(name="dpi_neu")

    comp = sky130_opamp_add_pads(top_level, pdk, flatten=False)
    comp = component_snap_to_grid(comp)
    comp.name = "opamp_1" 
    top_level << comp

    return top_level
                     

    

if __name__ == "__main__":
	comp = top(sky130)

	# comp.pprint_ports()
	#comp = add_fvf_labels(comp, ihp130)
	comp.name = "DPI"
	#comp.write_gds('out_FVF.gds')
	comp.show()

	#print("...Running DRC...")
	#drc_result = ihp130.drc(comp,comp.name)
from gdsfactory.read.import_gds import import_gds

from glayout import MappedPDK, sky130 , gf180 , ihp130
#from gdsfactory.cell import cell
from gdsfactory import Component
from gdsfactory.components import text_freetype, rectangle

from glayout import nmos, pmos
from glayout import via_stack, via_array
from glayout import rename_ports_by_orientation
from glayout import tapring

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

## Creating a Transistor
# def sky130_add_lvt_layer(opamp_in: Component) -> Component:
# 	global __NO_LVT_GLOBAL_
# 	if __NO_LVT_GLOBAL_:
# 		return opamp_in
# 	opamp_in.unlock()
# 	# define layers
# 	lvt_layer = (125,44)
# 	# define geometry over pmos components and add lvt
# 	SW_S_edge = opamp_in.ports["commonsource_Pamp_L_multiplier_0_plusdoped_S"]
# 	SW_W_edge = opamp_in.ports["commonsource_Pamp_L_multiplier_0_dummy_L_plusdoped_W"]
# 	NE_N_edge = opamp_in.ports["commonsource_Pamp_R_multiplier_2_plusdoped_N"]
# 	NE_E_edge = opamp_in.ports["commonsource_Pamp_R_multiplier_2_dummy_R_plusdoped_E"]
# 	SW_S_center = SW_S_edge.center
# 	SW_W_center = SW_W_edge.center
# 	NE_N_center = NE_N_edge.center
# 	NE_E_center = NE_E_edge.center
# 	SW_corner = [SW_W_center[0], SW_S_center[1]]
# 	NE_corner = [NE_E_center[0], NE_N_center[1]]
# 	middle_top_y = opamp_in.ports["pcomps_ptopAB_L_plusdoped_N"].center[1]
# 	middle_bottom_y = opamp_in.ports["pcomps_pbottomAB_R_plusdoped_S"].center[1]
# 	max_y = max(middle_top_y, NE_corner[1])
# 	min_y = min(middle_bottom_y, SW_corner[1])
# 	abs_center = (SW_corner[0] + (NE_corner[0] - SW_corner[0])/2, min_y + (max_y - min_y)/2)
# 	# draw lvt rectangle
# 	LVT_rectangle = rectangle(layer=lvt_layer, size=(abs(NE_corner[0] - SW_corner[0]), abs(max_y - min_y)+0.36), centered=True)
# 	LVT_rectangle_ref = opamp_in << LVT_rectangle
# 	# align lvt rectangle to the plusdoped_N region
# 	LVT_rectangle_ref.move(origin=(0, 0), destination=abs_center)
# 	# define geometry over output amplfier and add lvt
# 	outputW = opamp_in.ports["outputstage_amp_multiplier_0_dummy_L_plusdoped_W"]
# 	outputE = opamp_in.ports["outputstage_amp_multiplier_0_dummy_R_plusdoped_E"]
# 	width = abs(outputE.center[0]-outputW.center[0])
# 	hieght = outputW.width+0.36
# 	center = (outputW.center[0] + width/2, outputW.center[1])
# 	lvtref = opamp_in << rectangle(size=(width,hieght),layer=lvt_layer,centered=True)
# 	lvtref.move(destination=center)
# 	return opamp_in
    
def sky130_opamp_add_pads(opamp_in: Component,  pdk: MappedPDK, flatten=False) -> Component:
    """adds the MPW-5 pads and nano pads to opamp.
    Also adds text labels and pin layers so that extraction is nice
    this function does not need to be used with sky130_add_opamp_labels
    """
    opamp_wpads = opamp_in.copy()
    opamp_wpads = movey(opamp_wpads, destination=0)
    
    pad = import_gds("pads/Manhattan120umPad.gds")
    pad.name = "Manhattan120umPad"
    
    pad = add_ports_perimeter(pad, pdk.get_glayer("met4"),prefix="pad_")
    
    pad_array = prec_array(pad, rows=2, columns=(4+1), spacing=(120,120))
    pad_array_ref = prec_ref_center(pad_array)
    opamp_wpads.add(pad_array_ref)

    opamp_wpads.pprint_ports()
    
    # add via_array to vdd pin
    vddarray = via_array(pdk, "met4","met5",size=(opamp_wpads.ports["pin_vdd_N"].width,opamp_wpads.ports["pin_vdd_E"].width))
 #    via_array_ref = opamp_wpads << vddarray
 #    align_comp_to_port(via_array_ref,opamp_wpads.ports["pin_vdd_N"],alignment=('c','b'))
 #    # route to the pads
 #    leftroutelayer="met4"
 #    opamp_wpads << L_route(pdk, opamp_wpads.ports["pin_plus_W"],pad_array_ref.ports["row1_col1_pad_S"], hwidth=3, vglayer=leftroutelayer)
 #    opamp_wpads << L_route(pdk, opamp_wpads.ports["pin_minus_W"],pad_array_ref.ports["row0_col1_pad_N"],hwidth=3, vglayer=leftroutelayer)
 #    opamp_wpads << straight_route(pdk, pad_array_ref.ports["row1_col2_pad_S"],opamp_wpads.ports["pin_vdd_S"], width=4,glayer1="met5")
 #    opamp_wpads << straight_route(pdk, opamp_wpads.ports["pin_diffpairibias_S"],pad_array_ref.ports["row0_col2_pad_N"])
 #    opamp_wpads << L_route(pdk, opamp_wpads.ports["pin_gnd_E"],pad_array_ref.ports["row0_col3_pad_N"], vglayer="met4",hwidth=3)
 #    opamp_wpads << L_route(pdk, opamp_wpads.ports["pin_commonsourceibias_E"],pad_array_ref.ports["row0_col4_pad_N"],hwidth=3)
 #    opamp_wpads << L_route(pdk, opamp_wpads.ports["pin_outputibias_E"],pad_array_ref.ports["row1_col4_pad_S"], hwidth=3)
 #    opamp_wpads << c_route(pdk, opamp_wpads.ports["pin_output_route_E"],pad_array_ref.ports["row1_col3_pad_E"], extension=1, cglayer="met3", cwidth=4)
 #    # add pin layer and text labels for LVS
 #    text_pin_labels = list()
 #    met5pin = rectangle(size=(5,5),layer=(72,16), centered=True)
 #    for name in ["minus","diffpairibias","gnd","commonsourceibias","plus","vdd","output","outputibias"]:
 #        pin_w_label = met5pin.copy()
 #        pin_w_label.add_label(text=name,layer=(72,5),magnification=4)
 #        text_pin_labels.append(pin_w_label)
 #    for row in range(2):
 #        for col_u in range(4):
 #            col = col_u + 1# left most are for nano pads
 #            port_name = "row"+str(row)+"_col"+str(col)+"_pad_S"
 #            pad_array_port = pad_array_ref.ports[port_name]
 #            pin_ref = opamp_wpads << text_pin_labels[4*row + col_u]
 #            align_comp_to_port(pin_ref,pad_array_port,alignment=('c','t'))
	# # # import nano pad and add to opamp
	# nanopad = import_gds("pads/sky130_nano_pad.gds")
	# nanopad.name = "nanopad"
	# nanopad = add_ports_perimeter(nanopad, pdk.get_glayer(leftroutelayer),prefix="nanopad_")
	# nanopad_array = prec_array(nanopad, rows=2, columns=2, spacing=(10,10))
	# nanopad_array_ref = nanopad_array.ref_center()
	# opamp_wpads.add(nanopad_array_ref)
	# nanopad_array_ref.movex(opamp_wpads.xmin+nanopad_array.xmax)
	# # route nano pad connections
	# opamp_wpads << straight_route(pdk, nanopad_array_ref.ports["row1_col0_nanopad_N"],pad_array_ref.ports["row1_col0_pad_S"],width=3,glayer2=leftroutelayer)
	# opamp_wpads << straight_route(pdk, nanopad_array_ref.ports["row0_col0_nanopad_S"],pad_array_ref.ports["row0_col0_pad_N"],width=3,glayer2=leftroutelayer)
	# opamp_wpads << straight_route(pdk, nanopad_array_ref.ports["row0_col1_nanopad_E"],pad_array_ref.ports["row0_col1_pad_N"],width=3,glayer2=leftroutelayer)
	# opamp_wpads << straight_route(pdk, nanopad_array_ref.ports["row1_col1_nanopad_E"],pad_array_ref.ports["row1_col1_pad_S"],width=3,glayer2=leftroutelayer)
	# # add the extra pad for the CS output
	# cspadref = opamp_wpads << pad
	# if not small_pad:
	# 	cspadref.movex(720).movey(120)
	# else:
	# 	cspadref.movex(300).movey(90)
	# opamp_wpads << L_route(pdk, cspadref.ports["pad_S"], opamp_wpads.ports["commonsource_output_E"],hwidth=3, hglayer="met5",vglayer="met5")
	# #opamp_wpads << nanopad
    if flatten:
        return opamp_wpads.flatten()
    else:
        return opamp_wpads


def top(
        pdk: MappedPDK,
        #device_type: str = "nmos", 
        #placement: str = "horizontal",
        #width: tuple[float,float] = (3,3),
        #length: tuple[float,float] = (None,None),
        #fingers: tuple[int,int] = (1,1),
        #multipliers: tuple[int,int] = (1,1),
        #with_substrate_tap: bool = False,
        #dummy_1: tuple[bool,bool] = (True,True),
        #dummy_2: tuple[bool,bool] = (True,True),
        #tie_layers1: tuple[str,str] = ("met2","met1"),
        #tie_layers2: tuple[str,str] = ("met2","met1"),
        #sd_rmult: int=1,
        #**kwargs
        ) -> Component:

    pdk.activate()
    
    #top level component
    top_level = Component(name="dpi_neu")

    comp = sky130_opamp_add_pads(top_level, pdk, flatten=False)
    comp = component_snap_to_grid(comp)
    comp.name = "opamp_1" 
    top_level << comp

    return top_level
                     

    

if __name__ == "__main__":
	comp = top(sky130)

	# comp.pprint_ports()
	#comp = add_fvf_labels(comp, ihp130)
	comp.name = "DPI"
	#comp.write_gds('out_FVF.gds')
	comp.show()

	#print("...Running DRC...")
	#drc_result = ihp130.drc(comp,comp.name)

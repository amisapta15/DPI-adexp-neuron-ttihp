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
from glayout.util.comp_utils import evaluate_bbox, prec_center, prec_ref_center, align_comp_to_port, prec_array, movey, movex
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

def poly_resistor_rhigh(
    pdk: MappedPDK,
    length: float = 1.65,
    width: float = 0.35,
    fingers: int = 1,
    is_snake: bool = True
) -> Component:
    
    poly_res = (28,0)
    p_res = Component()
    contact_length = 2.2
    separation = 0.21 + width
    #Extend poly for contacts
    ex_length = length + 2*contact_length
    for i in range(0,fingers):
        #poly resistor rectangle
        p_rect = rectangle(size=(width,ex_length), layer=pdk.get_glayer("poly"), centered=True)
        p_rect_ref = prec_ref_center(p_rect)
        p_res.add(p_rect_ref)
        movex(p_rect_ref, (i)*separation)
        #Add li layer on top and bottom contacts
        li_top = rectangle(size=(width,contact_length), layer=pdk.get_glayer("met1"), centered=True)
        li_top_ref = prec_ref_center(li_top)
        p_res.add(li_top_ref)
        movey(li_top_ref, contact_length/2 + length/2)
        movex(li_top_ref, (i)*separation)

        li_bot = rectangle(size=(width,contact_length), layer=pdk.get_glayer("met1"), centered=True)
        li_bot_ref = prec_ref_center(li_bot)
        p_res.add(li_bot_ref)
        movey(li_bot_ref, - contact_length/2 - length/2)
        movex(li_bot_ref, (i)*separation)

        #Place poly to li via contact
        licon1 = via_array(pdk, "poly", "met1", size=(width,contact_length))
        licon1_ref = prec_ref_center(licon1)
        #p_res.add(licon1_ref)
        #movey(licon1_ref, contact_length/2 + length/2)

        licon2 = via_array(pdk, "poly", "met1", size=(width,contact_length))
        licon2_ref = prec_ref_center(licon2)
        p_res.add(licon2_ref)
        movey(licon2_ref, - contact_length/2 - length/2)
        movex(licon2_ref, (i)*separation)

        licon3 = via_array(pdk, "poly", "met1", size=(width,contact_length))
        licon3_ref = prec_ref_center(licon3)
        p_res.add(licon3_ref)
        movey(licon3_ref, contact_length/2 + length/2)
        movex(licon3_ref, (i)*separation)

        # place metal 1 layer on contacts
        met1_top = rectangle(size=(width,contact_length), layer=pdk.get_glayer("met2"), centered=True)
        met1_top_ref = prec_ref_center(met1_top)
        p_res.add(met1_top_ref)
        movey(met1_top_ref, contact_length/2 + length/2)
        movex(met1_top_ref, (i)*separation)

        met1_bot = rectangle(size=(width,contact_length), layer=pdk.get_glayer("met2"), centered=True)
        met1_bot_ref = prec_ref_center(met1_bot)
        p_res.add(met1_bot_ref)
        movey(met1_bot_ref, - contact_length/2 - length/2)
        movex(met1_bot_ref, (i)*separation)
        #place li to metal vias
        met1con1 = via_array(pdk, "met1", "met2", size=(width,contact_length))
        met1con1_ref = prec_ref_center(met1con1)
        p_res.add(met1con1_ref)
        movey(met1con1_ref, contact_length/2 + length/2)
        movex(met1con1_ref, (i)*separation)

        met1con2 = via_array(pdk, "met1", "met2", size=(width,contact_length))
        met1con2_ref = prec_ref_center(met1con2)
        p_res.add(met1con2_ref)
        movey(met1con2_ref, - contact_length/2 - length/2)
        movex(met1con2_ref, (i)*separation)

        con_offset = (separation)/2
        if is_snake == True:
            if i > 0:
                met1_connect = rectangle(size=(width+separation,contact_length), layer=pdk.get_glayer("met2"),centered= True)
                met1_con_ref = prec_ref_center(met1_connect)
                p_res.add(met1_con_ref)
                if i%2 == 0:
                    movey(met1_con_ref, - contact_length/2 - length/2)
                    movex(met1_con_ref, (i-1)*separation+con_offset)
                else:
                    movey(met1_con_ref, contact_length/2 + length/2)
                    movex(met1_con_ref, (i-1)*separation+con_offset)

        if i == 0:
            p_res.add_ports(met1_bot_ref.get_ports_list(), prefix="MINUS_")

    #print(i)
    if i%2 == 0:
        p_res.add_ports(met1_top_ref.get_ports_list(), prefix="PLUS_")
    else:
        p_res.add_ports(met1_bot_ref.get_ports_list(), prefix="PLUS_")

    # p_res.info['netlist'] = poly_resistor_netlist(
    #     circuit_name="POLY_RES",
    #     model= 'sky130_fd_pr__res_high_po',
    #     width=width,
    #     length=length,
    # )
    #print(p_res.get_ports_list())
    return p_res

def add_polyres_labels(pdk: MappedPDK, p_res: Component, length, width, fingers):
    p_res.unlock()
    met1_label = pdk.get_glayer("met1_label")
    met1_pin = pdk.get_glayer("met1_pin")
    move_info = list()
    separation = 0.21 + width
    contact_length = 2.2
    p_pin = p_res << rectangle(size=(0.1,0.1),layer=pdk.get_glayer("met2"),centered=True)
    if fingers%2 == 0:
        movey(p_pin, -contact_length/2 - length/2)
        movex(p_pin, (fingers-1)*separation)
    else:
        movey(p_pin, contact_length/2 + length/2)
        movex(p_pin, (fingers-1)*separation)

    m_pin = p_res << rectangle(size=(0.1,0.1),layer=pdk.get_glayer("met2"),centered=True)
    movey(m_pin, -contact_length/2 - length/2)

    #plus label
    p_label = rectangle(layer=met1_pin, size=(0.1,0.1), centered=True).copy()
    p_label.add_label(text="PLUS",layer=met1_label)
    move_info.append((p_label,p_pin.ports["e1"],None))

    m_label = rectangle(layer=met1_pin, size=(0.1,0.1), centered=True).copy()
    m_label.add_label(text="MINUS",layer=met1_label)
    move_info.append((m_label,m_pin.ports["e1"],None))

    for comp, prt, alignment in move_info:
        alignment = ('c','b') if alignment is None else alignment
        compref = align_comp_to_port(comp, prt, alignment=alignment)
        p_res.add(compref)
    return p_res.flatten()




if __name__ == "__main__":
	resistor = add_polyres_labels(ihp130,poly_resistor_rhigh(ihp130, 4, 0.35, 3, True), 4, 0.35, 3)

	# comp.pprint_ports()
	#comp = add_fvf_labels(comp, ihp130)
	resistor.name = "RES"
	#comp.write_gds('out_FVF.gds')
	resistor.show()

	#print("...Running DRC...")
	#drc_result = ihp130.drc(comp,comp.name)
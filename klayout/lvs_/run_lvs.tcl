# LVS script for chip_top in IIC-OSIC-TOOLS

set PDK_ROOT /foss/pdks
set PDK ihp-sg13g2

set pdklib ${PDK_ROOT}/${PDK}
set techlibs ${pdklib}/libs.tech
set reflibs ${pdklib}/libs.ref

set setupfile ${techlibs}/netgen/${PDK}_setup.tcl
set sclib ${reflibs}/gf180mcu_fd_sc_mcu9t5v0/spice/gf180mcu_fd_sc_mcu9t5v0.spice

# Read layout netlist (extracted from GDS)
set circuit1 [readnet spice chip_top_layout.spice]

# Read schematic netlist
set circuit2 [readnet spice chip_top.spice]

# Run LVS
lvs "$circuit1 chip_top" "$circuit2 chip_top" $setupfile chip_top_comp.out

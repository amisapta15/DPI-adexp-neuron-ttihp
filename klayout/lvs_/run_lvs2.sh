#!/bin/bash
#
# LVS script for running layout vs schematic verification
# Usage: ./run_lvs_2.sh <cell_name>
# Updated for IIC-OSIC-TOOLS Docker environment with GF180MCU PDK
# Assumes running inside container started with ./start_x.sh or similar
# PDK_ROOT=/usr/share/pdk, PDK=gf180mcuD (default; override with env vars)
# Mount your designs to /foss/designs

# Check command line arguments
if [ $# -ne 1 ]; then
    echo "Usage: $0 <cell_name>"
    echo "Example: $0 my_cell"
    exit 1
fi

CELL_NAME="$1"

# Use IIC-OSIC-TOOLS defaults; override with env vars if needed
PDK_ROOT="${PDK_ROOT:-/usr/share/pdk}"
PDK="${PDK:-gf180mcuD}"

echo "Running LVS for cell: $CELL_NAME"
echo "PDK_ROOT: $PDK_ROOT"
echo "PDK: $PDK"

# Check if required input files exist
if [ ! -f "${CELL_NAME}.gds" ]; then
    echo "Error: ${CELL_NAME}.gds not found in $(pwd)"
    exit 1
fi

if [ ! -f "${CELL_NAME}.spice" ]; then
    echo "Error: ${CELL_NAME}.spice not found in $(pwd)"
    exit 1
fi

#-------------------------------------------
# Extract layout for LVS from magic (GDS -> SPICE)
#-------------------------------------------

magic -dnull -noconsole -rcfile $PDK_ROOT/$PDK/libs.tech/magic/$PDK.magicrc << EOF
gds read $CELL_NAME
load $CELL_NAME
select top cell
extract path extfiles
extract all
ext2spice lvs
ext2spice -p extfiles -o ${CELL_NAME}_layout.spice
quit -noprompt
EOF

if [ ! -f "${CELL_NAME}_layout.spice" ]; then
    echo "Error: Magic extraction failed. Check magic output above."
    exit 1
fi

#-------------------------------------------
# Run netgen for LVS
#-------------------------------------------

# Construct standard setup file path for IIC-OSIC-TOOLS
setupfile="${PDK_ROOT}/${PDK}/libs.tech/netgen/${PDK}_setup.tcl"

if [ ! -f "$setupfile" ]; then
    echo "Error: Netgen setup file not found: $setupfile"
    echo "Available setups:"
    find $PDK_ROOT -name "*setup.tcl" 2>/dev/null | head -10 || true
    exit 1
fi

echo "Using netgen setup: $setupfile"

cat > run_lvs.tcl << EOF
# LVS script for $CELL_NAME in IIC-OSIC-TOOLS

set PDK_ROOT $PDK_ROOT
set PDK $PDK

set pdklib \${PDK_ROOT}/\${PDK}
set techlibs \${pdklib}/libs.tech
set reflibs \${pdklib}/libs.ref

set setupfile \${techlibs}/netgen/\${PDK}_setup.tcl
set sclib \${reflibs}/gf180mcu_fd_sc_mcu9t5v0/spice/gf180mcu_fd_sc_mcu9t5v0.spice

# Read layout netlist (extracted from GDS)
set circuit1 [readnet spice ${CELL_NAME}_layout.spice]

# Read schematic netlist
set circuit2 [readnet spice $CELL_NAME.spice]

# Run LVS
lvs "\$circuit1 $CELL_NAME" "\$circuit2 $CELL_NAME" \$setupfile ${CELL_NAME}_comp.out
EOF

netgen -batch source run_lvs.tcl | tee netgen.log

# Check LVS result
if grep -q "LVS succeeded." ${CELL_NAME}_comp.out 2>/dev/null; then
    echo "LVS PASSED for $CELL_NAME!"
elif grep -q "LVS failed." ${CELL_NAME}_comp.out 2>/dev/null; then
    echo "LVS FAILED for $CELL_NAME. See ${CELL_NAME}_comp.out and netgen.log"
else
    echo "LVS status unclear. Check ${CELL_NAME}_comp.out and netgen.log"
fi

#-------------------------------------------
# Clean up (uncomment if desired)
#-------------------------------------------
# rm -rf extfiles
# rm run_lvs.tcl

echo "Done with LVS!"
exit 0

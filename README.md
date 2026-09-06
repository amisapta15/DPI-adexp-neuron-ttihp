![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# tt_um_dpi_adexp — AdExp DPI Neuron Network (TTIHP-26b)

A digital spiking-neuron network for the IHP SG13G2 shuttle: AdEx (adaptive
exponential integrate-and-fire) dynamics with DPI (differential-pair
integrator) style synapses, implemented with **shift/add/subtract arithmetic
only** — no multipliers, no dividers, no LUTs.

Baseline: four neuron blocks forming two E/I pairs with reciprocal inhibition.
Each block is a population primitive with one membrane prime plus two
fast-positive and three slow-negative adaptation units on coprime power-of-two
time constants. A three-pair stretch with an excitatory ring (E0→E1→E2→E0) is
parameterisable (`N_PAIRS=3`).

- [Full project documentation / datasheet](docs/info.md)
- Author: Saptarshi Ghosh

## Pin map (baseline)

- `ui_in[0..3]` — PWM input currents for E0, I0, E1, I1
- `uo_out[0..3]` — spikes E0, I0, E1, I1 (one-cycle pulses)
- `uo_out[4]` — any-spike aggregate
- `uio[2:0]` — SPI mode-0 bus (CS_N, SCLK, MOSI), write-only runtime config
  (see below); all uio output enables stay low
- `clk` / `rst_n` — clock and active-low reset; `ui_in[7:4]` and `ena` unused
  (tie low / leave unconnected)

## Runtime configuration (SPI, write-only)

A 32-bit, SPI mode-0 (MSB first) write-only bank sets per-neuron firing
thresholds and global dynamics:

- singleton WRITE frame: `[31:28]=0xA [27:24]=target [23:20]=field [19:4]=value`
- COMMIT frame: `[31:28]=0xC [27:0]=0` copies the whole shadow bank to the
  active bank on one edge
- targets 0..3 select E0, I0, E1, I1; target `0xF` selects global fields
- per-neuron fields: `0`=VTH_Q, `1`=IEXT_Q
- global fields: `0`=VTRIG_Q, `1`=VSTEP_Q, `2`=FINC0, `3`=FINC1,
  `4`=WBUMP_Q, `5`=INH_AMT_Q
- require SCLK ≤ clk/8 and CS_N stable for ≥2 clk cycles around a frame

## Bring-up in one minute

1. Release `rst_n` after ≥5 clock cycles.
2. Drive `ui_in[3:0]` high (constant PWM = constant input current).
3. Watch `uo_out[4]`: it pulses whenever any block fires. E blocks fire faster
   than I blocks; E0's inter-spike interval grows over time (adaptation).

## Source layout

```
src/project.v          top wrapper (tt_um_dpi_adexp), baseline pin map
src/adex_network.v     two-pair baseline / three-pair stretch, E-ring
src/adex_pair.v        one E/I pair, reciprocal inhibition
src/adex_block.v       population primitive: 1 prime + 2 fast + 3 slow units
src/adex_config.v      SPI mode-0 shadow/commit configuration bank (write-only)
src/adex_neuron_system_tt_lut32.v   deprecated LUT core, kept for reference
test/                  cocotb suite (14 tests, green: `make -B` in test/)
```

## Verification status (final pre-tapeout run, 2026-08-20)

Cocotb **14/14 PASS** at RTL (`TESTS=14 PASS=14 FAIL=0 SKIP=0`; Icarus Verilog
13.0 + cocotb 2.0.1 on Python 3.11, in the `tt` mamba env). Tests cover reset
state, directed block arithmetic vs. a Python fixed-point reference, SPI
shadow/commit, silence, spiking + aggregate OR, adaptation ratio, F/I response,
fast-spiking, inhibition suppression, E/I isolation and non-locking, phase
alternation, bursting pattern and burst length vs. WBUMP. `verilator
--lint-only -Wall` (Verilator 5.050) on the five active sources is
**warning-clean — zero warnings**. See `docs/info.md` for the full metrics.

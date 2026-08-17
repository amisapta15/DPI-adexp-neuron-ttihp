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
- [Implementation plan (spec)](src/implementation_plan.md)
- Author: Saptarshi Ghosh

## Pin map (baseline)

- `ui_in[0..3]` — PWM input currents for E0, I0, E1, I1
- `uo_out[0..3]` — spikes E0, I0, E1, I1 (one-cycle pulses)
- `uo_out[4]` — any-spike aggregate
- `clk` / `rst_n` — clock and active-low reset; `uio` and `ui_in[7:4]` unused (tie low)

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
src/adex_neuron_system_tt_lut32.v   deprecated LUT core, kept for reference
test/                  cocotb suite (9 tests, green: `make -B` in test/)
```

## Verification status (2026-08-13)

Cocotb 9/9 PASS at RTL (iverilog 13.0, cocotb 2.0.1). Tests cover reset state,
directed block arithmetic vs. Python reference, SPI shadow/commit, silence,
spiking + aggregate OR, adaptation ratio, inhibition suppression, pair
isolation, and E/I lock check. See `docs/info.md` for details.

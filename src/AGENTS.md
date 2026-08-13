# AGENTS.md

Project conventions for coding agents working in this repository.

## What this is

Tiny Tapeout IHP-26b submission `tt_um_dpi_adexp`: a multipurpose neuromorphic
core that emulates adaptive-exponential (AdEx) spiking neuron dynamics with
shift/add/subtract arithmetic only. No multiplies, no divides, no LUTs.

The authoritative specification is `src/implementation_plan.md`. Read it
before changing architecture. Milestones in the plan: M0 single block, M1
regime validation, M2 E/I pair, M3 two-pair baseline, M4 three-pair stretch.
Current status (2026-08-13): the five active modules include a baseline
write-only SPI configuration bank and counter-driven slow decay. The current
working tree has not been simulated, linted, synthesised, or placed and routed
since those changes; do not report historical pass counts for it.

## Hierarchy

```
src/project.v          top wrapper (tt_um_dpi_adexp), baseline pin map
src/adex_config.v      write-only SPI mode-0 shadow/commit configuration bank
src/adex_network.v     N_PAIRS=2 baseline / 3 stretch, E0->E1->E2->E0 ring
src/adex_pair.v        one E/I pair, reciprocal inhibition via inh_in
src/adex_block.v       population primitive: 1 prime + 2 fast + 3 slow units
src/adex_neuron_system_tt_lut32.v   DEPRECATED old Q8.7 LUT core, superseded
src/implementation_plan.md          implementation specification
test/                  cocotb harness, 9 tests (run required after current changes)
info.yaml              TT metadata: source_files, pinout, tiles (2x2)
docs/info.md           project datasheet (keep in sync with the design)
```

## Fixed-point and arithmetic rules

- Prime potential `v` is Q4.12, 16-bit signed, 1.0 = 4096.
- Fast-positive units are 10-bit signed; slow-negative units are 12-bit signed.
- Every update is a shift, add, or subtract, plus saturation. Saturating
  helpers `sat16/sat10/sat12` live in `adex_block.v`. Use the leading-literal
  width trick (`16'sd0 + a + b`) to force expression widths; do not introduce
  `*` or `/` anywhere.
- Runtime controls are held by `adex_config`: per-neuron VTH/IEXT, and global
  VTRIG/VSTEP/FINC0/FINC1/WBUMP/INH_AMT. Keep shift counts static; making them
  runtime values infers area- and timing-costly variable shifters.
- The 12-bit slow states relax by one eighth at each per-unit period-counter
  tick. Coprime slow-period triples per block (plan section 5): pair 0 E(5,7,11)
  I(13,17,19); pair 1 E(23,29,31) I(37,41,43); pair 2 E(47,53,59) I(61,67,71).
- PITFALL (fixed 2026-08-08): the KS/period parameters were originally
  declared `[3:0]` and every period >= 16 truncated silently (13,17,19 became
  13,1,3), inverting the E/I rate balance. KS params are now `[6:0]` (periods
  up to 71). Rule: any period parameter that can hold a value >= 16 must
  be declared at least 7 bits wide; iverilog only warns on truncation, it does
  not error.
- PITFALL (fixed 2026-08-08): Verilator treats ANY comment whose text begins
  with the word "verilator" (both `//` and `/*` forms, case-insensitive) as a
  lint pragma; an unrecognised one aborts with BADVLTPRAGMA / "Unknown
  verilator comment", and the error message renders line comments in canonical
  `/*...*/` form, which is misleading. Never start a comment with that word.
  Local lint: `/home/sapta/miniforge3/envs/ccotb/bin/verilator --lint-only
  -Wall --top-module tt_um_dpi_adexp src/project.v src/adex_config.v src/adex_block.v
  src/adex_pair.v src/adex_network.v` (verilator 5.050 in the ccotb env).

## Pin map (baseline)

ui_in[0..3] = PWM E0, I0, E1, I1 (binary input current).
uo_out[0..3] = spikes E0, I0, E1, I1. uo_out[4] = any-spike aggregate.
uio[0]=SPI_CS_N, uio[1]=SPI_SCLK, uio[2]=SPI_MOSI. The SPI mode-0 inputs are
synchronised into `clk`: require SCLK <= clk/8 and CS_N stable for at least
two clk cycles around a frame. It is write-only; all uio output enables stay
low. `ena` is unused.

## Testing

Run from `test/` with `make -B` (cocotb; use the `ccotb` mamba env: export
`PATH=/home/sapta/miniforge3/envs/ccotb/bin:$PATH` — `conda activate` is broken
in non-interactive shells on this machine). `test.py` has 9 tests: reset state,
exact block arithmetic with period-counter wrap, SPI shadow/commit behavior,
silence, spiking+OR aggregate, adaptation, inhibition suppression, pair
isolation, and in-phase lock check. Three RTL-hierarchy tests log and return
when a gate-level netlist flattens the relevant modules. The current test
reference model matches the counter-driven slow decay. Rerun RTL, gate-level,
lint, synthesis, and P&R before recording behavioural or area results.

## Working rules

- Do not install tools, compile, run simulations, or make network calls unless
  the user explicitly asks. Present code and ask before executing. This is a
  standing preference for this project.
- Be economical with tool calls: the provider has a strict ~15 requests/minute
  limit; batch independent reads, serialise dependent ones.
- Do not commit, push, or rewrite history unless asked. The active branch is
  `main-submitted-to-ttihp26b`.
- Match existing Verilog style: `default_nettype none` at the top of each
  module file, named port connections, comments referencing plan sections.
- Old LUT32 file is deprecated; do not re-add it to `info.yaml` source_files.

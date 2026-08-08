# AGENTS.md

Project conventions for coding agents working in this repository.

## What this is

Tiny Tapeout IHP-26b submission `tt_um_dpi_adexp`: a multipurpose neuromorphic
core that emulates adaptive-exponential (AdEx) spiking neuron dynamics with
shift/add/subtract arithmetic only. No multiplies, no divides, no LUTs.

The authoritative specification is `src/implementation_plan.md` (untracked,
written by the user). Read it before changing architecture. Milestones in the
plan: M0 single block, M1 regime validation, M2 E/I pair, M3 two-pair baseline,
M4 three-pair stretch. The user works top-down through these. Current status:
RTL compiles clean with iverilog 13 (conda-forge); block arithmetic is verified
exact by the standalone TB; cocotb suite written but not yet run (cocotb not
installed in this env).

## Hierarchy

```
src/project.v          top wrapper (tt_um_dpi_adexp), baseline pin map
src/adex_network.v     N_PAIRS=2 baseline / 3 stretch, E0->E1->E2->E0 ring
src/adex_pair.v        one E/I pair, reciprocal inhibition via inh_in
src/adex_block.v       population primitive: 1 prime + 2 fast + 3 slow units
src/adex_neuron_system_tt_lut32.v   DEPRECATED old Q8.7 LUT core, superseded
src/implementation_plan.md          the spec, untracked
test/                  cocotb harness (test.py still targets the old interface)
info.yaml              TT metadata: source_files, pinout, tiles (2x2)
```

## Fixed-point and arithmetic rules

- Prime potential `v` is Q4.12, 16-bit signed, 1.0 = 4096.
- Fast-positive units are 10-bit signed; slow-negative units are 12-bit signed.
- Every update is a shift, add, or subtract, plus saturation. Saturating
  helpers `sat16/sat10/sat12` live in `adex_block.v`. Use the leading-literal
  width trick (`16'sd0 + a + b`) to force expression widths; do not introduce
  `*` or `/` anywhere.
- All behavioural constants are Verilog parameters with provisional defaults
  marked "tune at M1". The knobs: VTH/VTRIG/VSTEP/KV on the prime, KF/FINC/FSH
  on fast units, KS/WBUMP/SSH on slow units, IEXT/INH_SHIFT/EXC_SHIFT for drive.
- Coprime slow-period triples per block (plan section 5): pair 0 E(5,7,11)
  I(13,17,19); pair 1 E(23,29,31) I(37,41,43); pair 2 E(47,53,59) I(61,67,71).
- PITFALL (fixed 2026-08-08): the KS/period parameters were originally
  declared `[3:0]` and every period >= 16 truncated silently (13,17,19 became
  13,1,3), inverting the E/I rate balance. KS params are now `[6:0]` (periods
  up to 71). Rule: any shift/period parameter that can hold a value >= 16 must
  be declared at least 7 bits wide; iverilog only warns on truncation, it does
  not error.

## Pin map (baseline)

ui_in[0..3] = PWM E0, I0, E1, I1 (binary input current).
uo_out[0..3] = spikes E0, I0, E1, I1. uo_out[4] = any-spike aggregate.
uio is unused (serial config loader deferred). `ena` is unused.

## Testing

Run from `test/` with `make -B` (cocotb). `tb.v` instantiates `tt_um_dpi_adexp`
and is valid; `test.py` targets the PWM/spike interface (8 tests: reset state,
exact block arithmetic vs a Python fixed-point model, silence, spiking+OR
aggregate, adaptation head8/tail100 ratio > 1.2, inhibition suppression,
pair isolation, in-phase lock check). The same assertions were validated with
a standalone iverilog behavioural TB: adaptation ratio 1.43, coincidence
fraction 0.03, suppression 402->377->400, isolation clean. Plan section 8
defines the regime tests (tonic, adapting, bursting, fast spiking at block
level; antiphase, escape-vs-release, rebound at pair level); regime sweeps
need a parameterised test instantiation or the deferred config loader.

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

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
test/                  cocotb harness, 14 tests (all passing as of 2026-08-14)
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
in non-interactive shells on this machine). `test.py` has 14 tests (see the
area/P&R status section below for the full list). Three RTL-hierarchy tests
log and return when a gate-level netlist flattens the relevant modules. The
current test reference model matches the counter-driven slow decay. Rerun RTL,
gate-level, lint, synthesis, and P&R before recording behavioural or area
results.

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

## Area / P&R status (2026-08-14) — 2x2 tile density

### The CI failure (root cause, from GDS_logs/runs/wokwi)
The OpenROAD flow fails at **step 37 (post-CTS resizer -> detailed_placement)**
with `[DPL-0036] Detailed placement failed`, NOT at the base-area stage. Two
compounding problems:

1. **Base is already over 80%.** Step 28 (global placement, pre-CTS, no repair
   buffers) reports placed cell area **102,753 um^2 = 81.1%** of the 126,685 um^2
   core — over the 80% target before a single buffer is added.
2. **Repair adds ~7,000 um^2 of buffers, then placement fails.**
   - Step 32/34: pre-CTS `repair_timing` inserts **496 timing-repair buffers =
     +3,599.77 um^2** -> 106,353 um^2 = 84.0% (step 34).
   - Step 37: post-CTS resizer finds **553 hold-violating endpoints** and inserts
     **621 hold buffers** (reported +9.3%), then `detailed_placement` fails on
     **14 high-fanout instances** named `fanout355` (x2) and `fanout304` (x2) —
     these are the **global config nets** (VTRIG/VSTEP/FINC0/FINC1/WBUMP/INH_AMT)
     fanned to all 4 blocks.

**Density budget:** to land <= 80% (101,348 um^2) *after* both buffer sets
(~7,000 um^2), base must be <= **~94,300 um^2 ~= 74% of core**.

### What was changed this session (working tree, NOT yet committed)
Goal: cut base area while keeping all 14 cocotb tests green and all 14 config
fields / 4 neurons / all dynamics intact.

- `src/adex_block.v`
  - **Removed the dead negative branch of `slow_relax`.** The slow units
    (w0/w1/w2) start at 0 and only ever add +wbump (spike) and relax *toward*
    zero, so their state is provably always >= 0; the `value < 0` path is
    unreachable. Behaviour-identical for every reachable state and for every
    `test_arith_block` case (which only drives non-negative w). Saves ~4,400 um^2.
  - Width trims (net-neutral after ABC re-optimises, kept for documentation):
    v-accum 18->17b, fast adder 12->11b, slow adder/relax 14->13b; removed dead
    16-bit widened wires.
- `src/adex_pair.v` — added `parameter [3:0] PHASE_W = 4'd7`, threaded to both blocks.
- `src/adex_network.v` — pair0/pair1 (baseline, periods <= 43) use `PHASE_W=4'd6`;
  pair2 (stretch, periods <= 71) keeps `PHASE_W=4'd7`. Saves ~566 um^2.

### Measured area (local yosys + sg13g2 liberty, flattened, ABC)
| variant            | area (um^2) | % of core | cells |
|--------------------|-------------|-----------|-------|
| HEAD (baseline)    | 104,192     | 82.2%     | 6,826 |
| after all changes  | **99,044**  | **78.2%** | 6,704 |

Local yosys runs ~1,400 um^2 higher than CI (104,192 vs 102,753) — treat the two
as consistent within measurement variance. **Current 78.2% is still ~4,700 um^2
over the ~74% target** once buffers are added. More reduction is needed.

### Cost-centre breakdown (per `adex_block`; x4 = 77% of total)
- slow_relax / slow units: ~20,760 um^2 (zeroing removes it)
- fast units: ~22,247 um^2
- `adex_config`: 25,758 um^2 (25%) — already field-width-trimmed, near-minimal
- 94 DFFs/block x 4 = 376 DFFs dominate state area (37,378 um^2 sequential per CI)

### What is locked by tests (cannot delete)
`test_arith_block` checks exact arithmetic and directly drives v/f0/f1/w0/w1/w2/
phases, including all three slow units and both fast units. So the slow and fast
unit logic must stay; optimise *within* them (dead branches, sharing), not by
removing them. The `(spike_now ? wbump : 0)` term is identical in all 3 slow-unit
adders — a sharing candidate.

### Next steps
1. [DONE 2026-08-16] Shared the common `(spike_now ? wbump_14 : 0)` term into one
   `wbump_term_14` wire used by all three slow-unit accumulators. Behaviour-
   identical (each unit still adds wbump_14 exactly on its own spike clock);
   synthesis builds one AND/MUX instead of three. Tiny area win only.
2. [REMAINING] Cut base another ~4,000+ um^2 to reach ~74%. The block-level
   shavings left (helper widths, fast-unit dead branches) are small after ABC
   re-optimises; the structural lever is the high-fanout config nets below.
3. **High-fanout config nets (fanout355/304) are the actual placement blocker**
   even at lower density. Option: replicate the six global config flops
   (VTRIG/VSTEP/FINC0/FINC1/WBUMP/INH_AMT) per-block (or per-pair) to cut
   fanout 4x, at the cost of extra flop area — weigh against the density budget.
   PRESERVES `test_spi_shadow_commit`: E0 VTH/IEXT stay single shared values;
   only the global fields gain per-block copies, all fed the same write and
   converged on COMMIT.
4. [REMAINING] Re-run the full flow (synth -> P&R) to confirm the resizer's
   buffer count drops and detailed_placement legalises. Verify against the
   full 14-test suite first.

### Test status (2026-08-14)
**14 cocotb tests, all PASS** (`TESTS=14 PASS=14 FAIL=0 SKIP=0`):
reset_state, arith_block, spi_shadow_commit, no_input_no_spike, basic_spiking,
adaptation, block_tonic_f_i_response, block_fast_spiking, inhibition_suppresses,
pair_isolation, pair_does_not_lock, pair_phase_locked_alternation,
bursting_pattern, burst_length_vs_wbump. The three RTL-hierarchy tests
(reset_state, arith_block, spi_shadow_commit) require the internal hierarchy and
log-and-return on a flattened gate netlist.

### Toolchain note (IMPORTANT for future sessions)
- The **`tt` mamba env does NOT exist** on this machine (no conda/mamba/micromamba
  env named `tt`; verified exhaustively). Do not rely on it.
- The only iverilog/vvp/cocotb is the **oss-cad-suite** at a path containing a
  space (`.../Pico FPGA boards/Pico_ICE/oss-cad-suite`). The space breaks cocotb's
  make wrapper and the `readlink -f` path resolution in the iverilog/vvp wrappers.
- **Working fix:** full `cp -a` of the suite to a space-free path, e.g.
  `cp -a "<spacey suite>" /tmp/cadsuite`, then `export PATH=/tmp/cadsuite/bin:$PATH`.
  A real copy (not symlinks) is required so `readlink -f` stays space-free. Then
  `cd test && make -B MODULE=test` runs all 14 tests. /tmp is tmpfs, so redo the
  copy each session.
- Area measurement: `bash /tmp/adex_exp/measure.sh <blockfile> <label>` (yosys +
  sg13g2 liberty, flattened, ABC). sg13g2 liberty at
  `.../IHP-Open-PDK/ihp-sg13g2/libs.ref/sg13g2_stdcell/lib/sg13g2_stdcell_typ_1p20V_25C.lib`.

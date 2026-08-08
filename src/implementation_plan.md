# Implementation plan: multipurpose neuromorphic core, Tiny Tapeout ihp25b

## 1. Background and goal

Last year's submission (`tt_um_dpi_adexp`, #259) implemented both AdEx ODEs directly in Q8.7 fixed point, with a 32-entry exponential LUT and, more importantly, four signed multiplies plus two full non-power-of-two divisions computed combinationally every cycle. That arithmetic, not the LUT, was almost certainly the real area cost. It spikes in testing but the documented adapting/bursting/fast-spiking regimes were never exercised, since the cocotb harness only checks for one spike under strong bias.

This year's tile is 2x2, roughly 200x150 µm per 1x1 tile (~120,000 µm² total), about four times last year's footprint.

Goal: a shift-only, multiply/divide-free, LUT-free core built from one small reusable population primitive, meaningful on its own as an AdEx-emulating spiking neuron, and reusable unmodified as a node in a coupled network. Three experimentally distinct, independently defensible levels:

1. **Block → AdEx-like neuron** (regime match against published AdEx parameter sets)
2. **Pair → half-centre / resonant dynamical system** (reciprocal inhibition between two blocks)
3. **Network → interacting neuromorphic system** (two or three coupled pairs)

## 2. Frozen architecture specification

| Parameter | Value | Status |
|---|---|---|
| Units per block | 1 prime + 2 fast-positive + 3 slow-negative = 6 | Frozen |
| Arithmetic | Shift/add/subtract only, no multiply, no divide, no LUT | Frozen |
| Prime state width | 16-bit, Q4.12 | Provisional — confirm at M0 (see §7) |
| Fast-positive state width | ~10-bit | Provisional |
| Slow-negative state width | ~12-bit | Provisional |
| Prime reset | Subtractive (`V -= Vstep`) + bump into one slow-negative unit (`W += Wbump`) | Frozen |
| E/I coupling within a pair | Reciprocal inhibition between prime spike outputs | Frozen |
| Slow-negative periods | Distinct coprime triple per pair (see §4) | Frozen |
| Baseline network size | 2 pairs / 4 blocks / 24 units | Primary target |
| Stretch network size | 3 pairs / 6 blocks / 36 units | Stretch, pending M3 measurement |
| Cross-pair coupling (stretch) | Sparse hardwired excitatory ring (E0→E1→E2→E0), not a full matrix | Frozen |
| Programmable synaptic crossbar | Not in baseline | Deferred |
| On-chip PWM/duty-cycle generator | Not in baseline | Deferred, revisit only if pin pressure demands it |
| 4-pair network | Ruled out | Area and pin budget don't support it |

## 3. Hierarchy

```
                    NETWORK (2 pairs baseline, 3 stretch)
                       |
             +---------+---------+-----------------+
             |                   |                 |
           PAIR 0              PAIR 1          PAIR 2 (stretch)
          reciprocal          reciprocal       reciprocal
          inhibition          inhibition       inhibition
             |                   |                 |
         E0     I0           E1     I1         E2     I2
         |       |            |       |          |       |
      prime    prime       prime    prime     prime    prime
      +2 fast  +2 fast     +2 fast  +2 fast   +2 fast  +2 fast
      +3 slow  +3 slow     +3 slow  +3 slow   +3 slow  +3 slow
```

Each block is independently meaningful and independently testable, standalone as a neuron or wired into a pair.

## 4. Update equations (specification, not RTL)

**Prime**, per cycle, no spike:
```
V[n+1] = V[n] - (V[n] >> kV) + fast_drive - slow_drive + Iext[n] - crossblock_inhibition[n]
```
On `V[n] > Vth`:
```
V[n+1] = V[n] - Vstep          (subtractive reset)
W_bumped[n+1] = W_bumped[n] + Wbump   (one designated slow-negative unit)
```

**Fast-positive unit** (x2 per block): injects a fixed increment into the prime for a short window once `V` approaches threshold, decaying over a short period, providing the regenerative upstroke. No independent leak register, no PWM port.

**Slow-negative unit** (x3 per block):
```
W_i[n+1] = W_i[n] - (W_i[n] >> k_i)
```
incremented on the block's own spike; `k_i` set by the block's assigned coprime period; combined (shift-scaled) output subtracts from the prime's next update.

**Pair coupling** (reciprocal inhibition):
```
prime_E's spike subtracts (shift-scaled) into prime_I's V
prime_I's spike subtracts (shift-scaled) into prime_E's V
```

**Network coupling** (stretch, sparse ring):
```
prime_E0's spike adds (shift-scaled) into prime_E1's V
prime_E1's spike adds (shift-scaled) into prime_E2's V
prime_E2's spike adds (shift-scaled) into prime_E0's V
```

No closed-form stability analysis applies once the population is nested this way; a bare two-unit linear E/I pair has an exact discrete eigenvalue criterion, this system does not. Characterisation is by simulation and spike-train metrics throughout (§8).

## 5. Coprime period and precision assignment

| Pair | Slow-negative periods (E block) | Slow-negative periods (I block) |
|---|---|---|
| Pair 0 | 5, 7, 11 | 13, 17, 19 |
| Pair 1 (baseline) | 23, 29, 31 | 37, 41, 43 |
| Pair 2 (stretch only) | 47, 53, 59 | 61, 67, 71 |

No two blocks anywhere in the network share a period, avoiding unintended phase-locking within a pair or across pairs.

## 6. IO and pin map

Tiny Tapeout provides 24 general-purpose pins (`ui_in[7:0]`, `uo_out[7:0]`, `uio[7:0]`) regardless of tile size. `clk`, `rst_n`, and `ena` are separate dedicated ports, not part of the 24, so none of the general-purpose pins need to be spent on reset.

**Baseline (2 pairs, 4 blocks):**

```
ui_in[0] – PWM E0        uo_out[0] – spike E0
ui_in[1] – PWM I0        uo_out[1] – spike I0
ui_in[2] – PWM E1        uo_out[2] – spike E1
ui_in[3] – PWM I1        uo_out[3] – spike I1
ui_in[4..7] – spare       uo_out[4..7] – spare / debug / aggregate
uio – config clock, data, load strobe, select
```

**Stretch (3 pairs, 6 blocks):**

```
ui_in[0..5] – PWM E0,I0,E1,I1,E2,I2      uo_out[0..5] – spike E0,I0,E1,I1,E2,I2
ui_in[6..7] – spare                       uo_out[6..7] – spare / debug / aggregate
uio – config clock, data, load strobe, select
```

Dedicated pins fit comfortably at both sizes; a loadable input register (shared serial-loaded register file, each block generating its own PWM internally from a stored duty-cycle value) is a documented fallback if more configuration margin or a fourth pair is wanted later, trading input timing precision on non-driver blocks for pin headroom.

## 7. Development milestones

- [ ] **M0 — single primitive.** Build one block (prime + 2 fast + 3 slow) with real widths, shift-based leak, reset/bump, spike generation, period counters, fixed-point semantics. Synthesise. Record `G_block` (gate/area count). Explicitly check in simulation whether Q4.12 produces a visible zero-input limit-cycle artefact (leak term underflowing to zero before the state reaches zero) at the shift values actually used — widen to Q4.20 only if this shows up, not pre-emptively.
- [ ] **M1 — validated block.** Test the single block against standalone AdEx regime targets (§8, block level). Confirms the primitive is behaviourally correct before it's composed into anything larger.
- [ ] **M2 — one E/I pair.** Add reciprocal inhibition. Measure `G_pair`. Validate against half-centre signatures (§8, pair level). First genuinely useful architectural measurement — everything above this point was still an estimate.
- [ ] **M3 — two-pair network (primary target).** Add inter-pair wiring and configuration. Measure `G_2pair`, real P&R utilisation, routing congestion. This is the fallback-safe submission candidate.
- [ ] **M4 — three-pair network (stretch).** Same hierarchical instancing, the third pair is an additional instance, not architecturally special. Measure `G_3pair`, utilisation, congestion. Validate against network-level tests (§8, network level).

**Go/no-go at M4:** if three pairs land at roughly 8,000–9,000 gates (or the equivalent µm² figure from the actual synthesis report) at under ~75–80% utilisation, keep it as the submission. If it lands above that, drop the third pair and submit the M3 two-pair version. Don't decide this from hand estimates; every number in this section gets replaced with the real synthesis report as soon as it exists.

## 8. Test plan by level

**Block level** (M1): regime match against published AdEx parameter sets (Naud, Marcille, Clopath & Gerstner) using inter-spike-interval ratio, burst count, and adaptation ratio, one cocotb test per regime rather than one generic spike test — tonic, adapting, bursting, fast spiking at minimum.

**Pair level** (M2): stable antiphase alternation between the two blocks; the escape-versus-release transition as inhibition strength varies; rebound spiking after a single isolated inhibitory pulse, the litmus test a non-oscillatory, non-adapting system cannot produce.

**Network level** (M3/M4): isolated-pair oscillation as a baseline, pair-to-pair entrainment, travelling activity across the ring, competition between pairs, synchronisation versus desynchronisation, frequency-dependent coupling, transient propagation and recovery after inhibition. This tier is only meaningfully demonstrable with three pairs — two pairs shows coupling exists, three shows genuine multi-population network dynamics.

## 9. Explicitly out of scope for the baseline

- Full 4x4 (or 6x6) programmable synaptic crossbar — turns this from a compact dynamical system into a configurable network fabric, a different project.
- On-chip PWM/duty-cycle generation — only add if the register-based input scheme (§6) becomes necessary.
- Q4.20 prime width — only if M0 simulation shows a real underflow problem.
- A fourth pair — ruled out on both area and pin grounds at this tile size.

## 10. Open decisions, resolved by measurement not further discussion

- **Two pairs vs three pairs as primary target** — resolve from `G_2pair` and `G_3pair` at M3/M4, weighed against remaining time before the submission deadline.
- **Q4.12 sufficiency** — resolve from the M0 fixed-point simulation.
- **Dedicated pins vs loadable input register** — dedicated pins fit for both 2 and 3 pairs; only revisit if configuration pin count turns out tighter than expected once the actual loader protocol is designed.

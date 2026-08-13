# ============================================================================
# Cocotb testbench for tt_um_dpi_adexp (TTIHP-26b neuromorphic core)
# ----------------------------------------------------------------------------
# Interface under test (implementation plan section 6):
#   ui_in[0..3] = PWM E0, I0, E1, I1   (binary input current)
#   uo_out[0..3] = spikes E0, I0, E1, I1
#   uo_out[4]   = any-spike aggregate
#
# Runtime configuration uses write-only SPI mode 0 on uio_in[2:0]:
# CS_N, SCLK, MOSI. The SPI inputs are synchronised into the core clock, so
# this test intentionally runs SCLK at clk/8.
# What is testable from the pins today:
#   1. exact block arithmetic vs a Python fixed-point reference model
#   2. spiking / silence / adaptation / inhibition / pair isolation
# ============================================================================

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, ReadOnly, RisingEdge, Timer

# ----------------------------------------------------------------------------
# Fixed-point reference model (mirrors adex_block.v exactly)
# ----------------------------------------------------------------------------
# Prime is Q4.12 (16-bit signed, 1.0 = 4096); fast units 10-bit; slow units
# 12-bit, and each slow unit has a 7-bit period counter. Defaults below MUST
# stay in sync with adex_config.v and adex_block.v.

BLOCK = dict(
    VINIT=-2048, VTH=4096, VTRIG=3072, VSTEP=4096, KV=4,
    KF0=1, KF1=2, FINC0=128, FINC1=192, FSH0=1, FSH1=1,
    KS0=5, KS1=7, KS2=11, WBUMP=256, SLOW_DECAY_SHIFT=3,
    SSH0=3, SSH1=3, SSH2=3, IEXT=1024, INH=4096 >> 3, EXC=4096 >> 3,
)


def sat(x, bits):
    lo, hi = -(1 << (bits - 1)), (1 << (bits - 1)) - 1
    return max(lo, min(hi, x))


def slow_relax(value, p):
    """Counter-ticked, signed relaxation used by adex_block."""
    magnitude = abs(value) >> p["SLOW_DECAY_SHIFT"]
    if value > 0:
        return -max(1, magnitude)
    if value < 0:
        return max(1, magnitude)
    return 0


def phase_step(phase, period):
    """Return the next phase and whether this cycle is a decay tick."""
    tick = phase == period - 1
    return (0 if tick else phase + 1), tick


def block_step(v, f0, f1, w0, w1, w2, phase0, phase1, phase2,
               ext, inh, exc, p=BLOCK):
    """One update of adex_block, same equations and same saturation."""
    spike = 1 if v > p["VTH"] else 0
    trig = 1 if v > p["VTRIG"] else 0
    fast = (f0 >> p["FSH0"]) + (f1 >> p["FSH1"])
    slow = (w0 >> p["SSH0"]) + (w1 >> p["SSH1"]) + (w2 >> p["SSH2"])
    if spike:
        vn = sat(v - p["VSTEP"], 16)
    else:
        vn = sat(v - (v >> p["KV"]) + fast - slow
                 + (p["IEXT"] if ext else 0)
                 - (p["INH"] if inh else 0)
                 + (p["EXC"] if exc else 0), 16)
    fn0 = sat(f0 - (f0 >> p["KF0"]) + (p["FINC0"] if trig else 0), 10)
    fn1 = sat(f1 - (f1 >> p["KF1"]) + (p["FINC1"] if trig else 0), 10)
    phase0n, tick0 = phase_step(phase0, p["KS0"])
    phase1n, tick1 = phase_step(phase1, p["KS1"])
    phase2n, tick2 = phase_step(phase2, p["KS2"])
    wn0 = sat(w0 + (slow_relax(w0, p) if tick0 else 0)
              + (p["WBUMP"] if spike else 0), 12)
    wn1 = sat(w1 + (slow_relax(w1, p) if tick1 else 0)
              + (p["WBUMP"] if spike else 0), 12)
    wn2 = sat(w2 + (slow_relax(w2, p) if tick2 else 0)
              + (p["WBUMP"] if spike else 0), 12)
    return vn, fn0, fn1, wn0, wn1, wn2, phase0n, phase1n, phase2n, spike


# ----------------------------------------------------------------------------
# Helpers
# ----------------------------------------------------------------------------

def signed_of(sig):
    """Return a resolved signal as a signed integer."""
    value = sig.value
    assert all(bit in "01" for bit in value.binstr), \
        f"{sig._name} has an unresolved value: {value.binstr}"
    return int(value.signed_integer)


def start_clock(dut):
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())


def resolved_uo_out(dut):
    """Read the output bus, failing instead of treating X/Z as silence."""
    value = dut.uo_out.value
    assert all(bit in "01" for bit in value.binstr), \
        f"uo_out has an unresolved value: {value.binstr}"
    return int(value)


async def next_uo_out(dut):
    """Sample outputs after sequential logic and continuous assigns settle."""
    await RisingEdge(dut.clk)
    await ReadOnly()
    value = resolved_uo_out(dut)
    # Return in a writable phase so callers can safely change drive/reset.
    await Timer(1, units="ps")
    return value


async def reset_dut(dut, cycles=10):
    dut.rst_n.value = 0
    dut.ui_in.value = 0
    dut.uio_in.value = 0b00000001  # SPI idle: CS_N=1, SCLK=0, MOSI=0
    await ClockCycles(dut.clk, cycles)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 5)


def spi_write_frame(target, field, value):
    """Construct one 32-bit shadow-register write frame."""
    return ((0xA << 28) | (target << 24) | (field << 20)
            | ((value & 0xFFFF) << 4))


async def spi_send_frame(dut, frame):
    """Send an MSB-first SPI mode-0 frame at one eighth of the core clock."""
    dut.uio_in.value = 0b00000001  # idle before selecting the peripheral
    await Timer(30, units="ns")
    dut.uio_in.value = 0b00000000  # CS_N=0, SCLK=0, MOSI=0
    await Timer(30, units="ns")
    for bit_index in range(31, -1, -1):
        mosi = (frame >> bit_index) & 1
        dut.uio_in.value = mosi << 2
        await Timer(20, units="ns")
        dut.uio_in.value = (mosi << 2) | 0b00000010
        await Timer(40, units="ns")
        dut.uio_in.value = mosi << 2
        await Timer(40, units="ns")
    dut.uio_in.value = 0b00000001
    await Timer(40, units="ns")


async def count_spikes(dut, bit, cycles):
    """Count rising edges on uo_out[bit] over `cycles`."""
    prev = 0
    count = 0
    for _ in range(cycles):
        val = await next_uo_out(dut)
        cur = (val >> bit) & 1
        if cur and not prev:
            count += 1
        prev = cur
    return count


async def collect_spike_times(dut, bit, cycles):
    """Cycle indices of rising edges on uo_out[bit]."""
    prev = 0
    times = []
    for i in range(cycles):
        val = await next_uo_out(dut)
        cur = (val >> bit) & 1
        if cur and not prev:
            times.append(i)
        prev = cur
    return times


async def collect_spikes_dual(dut, bits, cycles):
    """Simultaneous spike-time trains for two output bits."""
    trains = {b: [] for b in bits}
    prev = {b: 0 for b in bits}
    for i in range(cycles):
        val = await next_uo_out(dut)
        for b in bits:
            cur = (val >> b) & 1
            if cur and not prev[b]:
                trains[b].append(i)
            prev[b] = cur
    return trains


async def count_spikes_multi(dut, bits, cycles):
    """Count rising edges on several outputs over one shared observation window."""
    counts = {bit: 0 for bit in bits}
    prev = {bit: 0 for bit in bits}
    for _ in range(cycles):
        val = await next_uo_out(dut)
        for bit in bits:
            cur = (val >> bit) & 1
            if cur and not prev[bit]:
                counts[bit] += 1
            prev[bit] = cur
    return [counts[bit] for bit in bits]


# ----------------------------------------------------------------------------
# Tests
# ----------------------------------------------------------------------------

def _block(dut):
    """pair0's E block handle, or None if the internal hierarchy is not
    reachable (the gate-level netlist flattens it away)."""
    try:
        return dut.net.pair0.e_block
    except AttributeError:
        return None


@cocotb.test()
async def test_reset_state(dut):
    """Internal state is exactly VINIT / 0 and outputs are 0 while in reset."""
    start_clock(dut)
    dut.rst_n.value = 0
    dut.ui_in.value = 0
    dut.uio_in.value = 0b00000001
    await ClockCycles(dut.clk, 5)
    await ReadOnly()

    b = _block(dut)
    if b is None:
        dut._log.info("internal hierarchy not present (gate-level netlist); checking outputs only")
    else:
        assert signed_of(b.v) == -2048, f"v after reset = {signed_of(b.v)}"
        for name in ("f0", "f1", "w0", "w1", "w2"):
            assert signed_of(getattr(b, name)) == 0, f"{name} after reset != 0"
        for name in ("w0_phase", "w1_phase", "w2_phase"):
            assert int(getattr(b, name).value) == 0, f"{name} after reset != 0"
    assert resolved_uo_out(dut) == 0, "uo_out not zero in reset"

        await Timer(1, units="ps")
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 2)


@cocotb.test()
async def test_arith_block(dut):
    """Exact E0 block check with its controllable external-drive input.

    Baseline E0 has no ring input, and an undriven I0 cannot emit an
    inhibitory spike. Pair-level tests exercise reciprocal inhibition.
    """
    start_clock(dut)
    dut.rst_n.value = 0
    dut.ui_in.value = 0
    dut.uio_in.value = 0b00000001
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 2)

    b = _block(dut)
    if b is None:
        # Gate-level netlists flatten the internal hierarchy, so this
        # RTL-only check cannot run there; the pin-level tests still cover
        # behaviour. (cocotb 1.9 has no runtime skip, so log and return.)
        dut._log.warning("internal hierarchy not reachable (gate-level netlist); "
                         "skipping block-arithmetic exact check")
        return
    cases = [
        # (v, f0, f1, w0, w1, w2, phase0, phase1, phase2, ext, note)
        (1000, 0, 0, 0, 0, 0, 0, 0, 0, 1, "leak+drive"),
        (4200, 0, 0, 0, 0, 0, 4, 6, 10, 1, "spike: reset, bump, and period wrap"),
        (-2048, 300, 200, 1500, 800, 1200, 4, 6, 10, 1,
         "fast/slow state contributions with all decay ticks"),
        (-100, -100, 50, 0, 0, 0, 0, 0, 0, 0, "negative floor shifts"),
        (1, 1, 1, 1, 1, 1, 4, 6, 10, 0, "minimum signed slow relaxation"),
        (4200, 0, 0, 2000, 0, 0, 4, 6, 10, 0, "w0 saturation at 2047"),
        (4096, 0, 0, 0, 0, 0, 0, 0, 0, 1, "strict > threshold (no spike at ==)"),
        (30000, 400, 400, 0, 0, 0, 0, 0, 0, 1, "high v"),
        (-32000, 0, 0, 0, 0, 0, 0, 0, 0, 0, "low v"),
    ]
    for idx, (v, f0, f1, w0, w1, w2, phase0, phase1, phase2, ex, note) in enumerate(cases):
        dut.ui_in.value = ex
        b.v.value = v & 0xFFFF
        b.f0.value = f0 & 0x3FF
        b.f1.value = f1 & 0x3FF
        b.w0.value = w0 & 0xFFF
        b.w1.value = w1 & 0xFFF
        b.w2.value = w2 & 0xFFF
         b.w0_phase.value = phase0
         b.w1_phase.value = phase1
         b.w2_phase.value = phase2
         await RisingEdge(dut.clk)
         await ReadOnly()
        got = (signed_of(b.v), signed_of(b.f0), signed_of(b.f1),
               signed_of(b.w0), signed_of(b.w1), signed_of(b.w2),
             int(b.w0_phase.value), int(b.w1_phase.value), int(b.w2_phase.value),
             resolved_uo_out(dut) & 1)
         want = block_step(v, f0, f1, w0, w1, w2, phase0, phase1, phase2,
                     ex, 0, 0)
        assert got == want, f"case {idx} ({note}): got {got}, want {want}"
         await Timer(1, units="ps")

    dut._log.info("block arithmetic: all cases match the Python fixed-point model")


@cocotb.test()
async def test_spi_shadow_commit(dut):
    """SPI writes remain inactive until COMMIT, then reach E0 atomically."""
    start_clock(dut)
    await reset_dut(dut)

    try:
        config = dut.config
        block = dut.net.pair0.e_block
    except AttributeError:
        dut._log.warning("runtime configuration hierarchy is unavailable in this netlist; skipping")
        return

    new_vth = 5000
    await spi_send_frame(dut, spi_write_frame(0, 0, new_vth))
    await ClockCycles(dut.clk, 5)
    assert signed_of(config.cfg_vth0_q) == BLOCK["VTH"], \
        "shadow write changed the active threshold before COMMIT"

    await spi_send_frame(dut, 0xC0000000)
    await ClockCycles(dut.clk, 5)
    assert signed_of(config.cfg_vth0_q) == new_vth, "COMMIT did not update VTH_E0"
    assert signed_of(block.cfg_vth_q) == new_vth, "active VTH_E0 did not reach the block"


@cocotb.test()
async def test_no_input_no_spike(dut):
    """With no drive the network stays silent."""
    start_clock(dut)
    await reset_dut(dut)
    counts = await count_spikes_multi(dut, range(4), 2000)
    assert all(c == 0 for c in counts), f"spikes without drive: {counts}"


@cocotb.test()
async def test_basic_spiking(dut):
    """All four blocks spike under constant PWM; aggregate OR is correct."""
    start_clock(dut)
    await reset_dut(dut)
    dut.ui_in.value = 0b00001111
    counts = [0, 0, 0, 0]
    or_ok = True
    for _ in range(6000):
        val = await next_uo_out(dut)
        for bit in range(4):
            counts[bit] += (val >> bit) & 1
        if ((val & 0x0F) != 0) != ((val >> 4) & 1):
            or_ok = False
    dut._log.info(f"spike counts: E0={counts[0]} I0={counts[1]} E1={counts[2]} I1={counts[3]}")
    assert all(c > 0 for c in counts), f"expected spikes on all outputs: {counts}"
    assert or_ok, "uo_out[4] is not the OR of uo_out[0..3]"


@cocotb.test()
async def test_adaptation(dut):
    """Spike-frequency adaptation: ISI grows as slow-negative units accumulate."""
    start_clock(dut)
    await reset_dut(dut)
    dut.ui_in.value = 0b00000001  # drive E0 only
    times = await collect_spike_times(dut, 0, 8000)
    dut._log.info(f"E0 fired {len(times)} times")
    assert len(times) >= 109, f"not enough spikes for non-overlapping ISI windows: {len(times)}"

    isi = [times[i + 1] - times[i] for i in range(len(times) - 1)]
    # Compare disjoint early and late windows, not overlapping thirds.
    head = isi[:8]
    tail = isi[-100:]
    avg_first = sum(head) / len(head)
    avg_last = sum(tail) / len(tail)
    dut._log.info(f"avg ISI head8={avg_first:.1f}, tail100={avg_last:.1f}")
    assert avg_last > avg_first * 1.2, \
        f"weak adaptation: {avg_first:.1f} -> {avg_last:.1f} (measured ratio 1.43 in iverilog TB)"


@cocotb.test()
async def test_inhibition_suppresses(dut):
    """E0's firing rate drops while I0 is active and recovers after (escape/
    release behaviour, plan section 8, tested directionally from the pins)."""
    start_clock(dut)
    await reset_dut(dut)

    dut.ui_in.value = 0b00000001            # window 1: E0 alone
    c1 = await count_spikes(dut, 0, 4000)

    # Start the inhibited comparison from the same reset state so adaptation
    # accumulated during window 1 cannot be mistaken for inhibition.
    await reset_dut(dut)
    dut.ui_in.value = 0b00000011            # window 2: E0 + I0 (both firing)
    ce2, ci2 = await count_spikes_multi(dut, (0, 1), 4000)

    dut.ui_in.value = 0b00000001            # window 3: E0 alone again
    c3 = await count_spikes(dut, 0, 4000)

    dut._log.info(f"E0 spikes: alone={c1}, with-I0={ce2}, after={c3}; I0 spikes={ci2}")
    assert ci2 > 10, f"I0 barely fired ({ci2}); inhibition was not exercised"
    assert ce2 < c1 * 0.98, f"inhibition did not suppress E0: {c1} -> {ce2}"
    assert c3 >= ce2, f"E0 did not recover after I0 stopped: {ce2} -> {c3}"


@cocotb.test()
async def test_pair_isolation(dut):
    """Baseline has no cross-pair coupling: pair 1 stays silent."""
    start_clock(dut)
    await reset_dut(dut)
    dut.ui_in.value = 0b00000011  # drive pair 0 only
    counts = await count_spikes_multi(dut, range(4), 3000)
    dut._log.info(f"counts E0 I0 E1 I1 = {counts}")
    assert counts[0] > 0 and counts[1] > 0, f"pair 0 should fire: {counts}"
    assert counts[2] == 0 and counts[3] == 0, \
        f"pair 1 spiked without drive (coupling leak?): {counts}"


@cocotb.test()
async def test_pair_does_not_lock(dut):
    """E and I blocks (different slow-period triples) fire at distinct rates
    and do not lock into sustained simultaneous spiking."""
    start_clock(dut)
    await reset_dut(dut)
    dut.ui_in.value = 0b00000011
    trains = await collect_spikes_dual(dut, (0, 1), 6000)
    te, ti = trains[0], trains[1]

    coinc = 0
    j = 0
    for t in ti:
        while j < len(te) and te[j] < t - 1:
            j += 1
        if j < len(te) and abs(te[j] - t) <= 1:
            coinc += 1
    frac = coinc / len(ti) if ti else 1.0

    dut._log.info(f"E0 spikes={len(te)}, I0 spikes={len(ti)}, coincident fraction={frac:.2f}")
    assert len(te) > 10 and len(ti) > 10, "both blocks should fire"
    # measured coincidence fraction is 0.03 in the iverilog TB; keep margin
    assert frac < 0.2, f"E/I appear locked in-phase (coincidence {frac:.2f})"

# ============================================================================
# Cocotb testbench for tt_um_dpi_adexp (TTIHP-26b neuromorphic core)
# ----------------------------------------------------------------------------
# Interface under test (implementation plan section 6):
#   ui_in[0..3] = PWM E0, I0, E1, I1   (binary input current)
#   uo_out[0..3] = spikes E0, I0, E1, I1
#   uo_out[4]   = any-spike aggregate
#
# The plan's regime tests (section 8) need per-regime AdEx parameter sets,
# which are compile-time parameters in this design. That sweep is a separate
# step once a parameterised test instantiation or the config loader exists.
# What is testable from the pins today:
#   1. exact block arithmetic vs a Python fixed-point reference model
#   2. spiking / silence / adaptation / inhibition / pair isolation
# ============================================================================

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge

# ----------------------------------------------------------------------------
# Fixed-point reference model (mirrors adex_block.v exactly)
# ----------------------------------------------------------------------------
# Prime is Q4.12 (16-bit signed, 1.0 = 4096); fast units 10-bit; slow units
# 12-bit. Python '>>' on negative ints is floor division by 2**k, which is
# exactly Verilog's arithmetic '>>>', so the model can reuse it directly.
# Defaults below MUST stay in sync with the adex_block.v parameter defaults.

BLOCK = dict(
    VINIT=-2048, VTH=4096, VTRIG=3072, VSTEP=4096, KV=4,
    KF0=1, KF1=2, FINC0=128, FINC1=192, FSH0=1, FSH1=1,
    KS0=5, KS1=7, KS2=11, WBUMP0=256, WBUMP1=256, WBUMP2=256,
    SSH0=3, SSH1=3, SSH2=3, IEXT=1024, INH=4096 >> 3, EXC=4096 >> 3,
)


def sat(x, bits):
    lo, hi = -(1 << (bits - 1)), (1 << (bits - 1)) - 1
    return max(lo, min(hi, x))


def block_step(v, f0, f1, w0, w1, w2, ext, inh, exc, p=BLOCK):
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
    wn0 = sat(w0 - (w0 >> p["KS0"]) + (p["WBUMP0"] if spike else 0), 12)
    wn1 = sat(w1 - (w1 >> p["KS1"]) + (p["WBUMP1"] if spike else 0), 12)
    wn2 = sat(w2 - (w2 >> p["KS2"]) + (p["WBUMP2"] if spike else 0), 12)
    return vn, fn0, fn1, wn0, wn1, wn2, spike


# ----------------------------------------------------------------------------
# Helpers
# ----------------------------------------------------------------------------

def signed_of(sig):
    """Signed integer value of a signal (0 on X/Z)."""
    try:
        return int(sig.value.signed_integer)
    except (ValueError, AttributeError):
        return 0


def start_clock(dut):
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())


async def reset_dut(dut, cycles=10):
    dut.rst_n.value = 0
    dut.ui_in.value = 0
    await ClockCycles(dut.clk, cycles)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 5)


async def count_spikes(dut, bit, cycles):
    """Count rising edges on uo_out[bit] over `cycles`."""
    prev = 0
    count = 0
    for _ in range(cycles):
        await RisingEdge(dut.clk)
        try:
            val = int(dut.uo_out.value)
        except ValueError:
            val = 0
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
        await RisingEdge(dut.clk)
        try:
            val = int(dut.uo_out.value)
        except ValueError:
            val = 0
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
        await RisingEdge(dut.clk)
        try:
            val = int(dut.uo_out.value)
        except ValueError:
            val = 0
        for b in bits:
            cur = (val >> b) & 1
            if cur and not prev[b]:
                trains[b].append(i)
            prev[b] = cur
    return trains


# ----------------------------------------------------------------------------
# Tests
# ----------------------------------------------------------------------------

@cocotb.test()
async def test_reset_state(dut):
    """Internal state is exactly VINIT / 0 and outputs are 0 while in reset."""
    start_clock(dut)
    dut.rst_n.value = 0
    dut.ui_in.value = 0
    await ClockCycles(dut.clk, 5)

    b = dut.net.pair0.e_block
    assert signed_of(b.v) == -2048, f"v after reset = {signed_of(b.v)}"
    for name in ("f0", "f1", "w0", "w1", "w2"):
        assert signed_of(getattr(b, name)) == 0, f"{name} after reset != 0"
    assert int(dut.uo_out.value) == 0, "uo_out not zero in reset"

    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 2)


@cocotb.test()
async def test_arith_block(dut):
    """Exact check of the block update equations against the Python model."""
    start_clock(dut)
    dut.rst_n.value = 0
    dut.ui_in.value = 0
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 2)

    b = dut.net.pair0.e_block
    cases = [
        # (v, f0, f1, w0, w1, w2, ext, inh, exc, note)
        (1000, 0, 0, 0, 0, 0, 1, 0, 0, "leak+drive"),
        (4200, 0, 0, 0, 0, 0, 1, 0, 0, "spike: subtractive reset + bump"),
        (-2048, 300, 200, 1500, 800, 1200, 1, 1, 1, "all drives active"),
        (-100, -100, 50, 0, 0, 0, 0, 0, 0, "negative floor shifts"),
        (1, 1, 1, 1, 1, 1, 0, 0, 0, "sticky floor (limit cycle)"),
        (4200, 0, 0, 2000, 0, 0, 0, 0, 0, "w0 saturation at 2047"),
        (4096, 0, 0, 0, 0, 0, 1, 0, 0, "strict > threshold (no spike at ==)"),
        (30000, 400, 400, 0, 0, 0, 1, 1, 1, "high v"),
        (-32000, 0, 0, 0, 0, 0, 0, 1, 1, "low v"),
    ]
    for idx, (v, f0, f1, w0, w1, w2, ex, ih, ec, note) in enumerate(cases):
        b.v.value = v & 0xFFFF
        b.f0.value = f0 & 0x3FF
        b.f1.value = f1 & 0x3FF
        b.w0.value = w0 & 0xFFF
        b.w1.value = w1 & 0xFFF
        b.w2.value = w2 & 0xFFF
        await ClockCycles(dut.clk, 1)
        got = (signed_of(b.v), signed_of(b.f0), signed_of(b.f1),
               signed_of(b.w0), signed_of(b.w1), signed_of(b.w2),
               int(b.spike.value))
        want = block_step(v, f0, f1, w0, w1, w2, ex, ih, ec)
        assert got == want, f"case {idx} ({note}): got {got}, want {want}"

    dut._log.info("block arithmetic: all cases match the Python fixed-point model")


@cocotb.test()
async def test_no_input_no_spike(dut):
    """With no drive the network stays silent."""
    start_clock(dut)
    await reset_dut(dut)
    counts = [await count_spikes(dut, bit, 2000) for bit in range(4)]
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
        await RisingEdge(dut.clk)
        try:
            val = int(dut.uo_out.value)
        except ValueError:
            val = 0
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
    assert len(times) > 10, f"not enough spikes: {len(times)}"

    isi = [times[i + 1] - times[i] for i in range(len(times) - 1)]
    # The adaptation transient is short (first ~8 ISIs) and then plateaus,
    # so compare the early head against the late tail, not thirds.
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

    dut.ui_in.value = 0b00000011            # window 2: E0 + I0 (both firing)
    ce2 = ci2 = 0
    pe = pi = 0
    for _ in range(4000):
        await RisingEdge(dut.clk)
        try:
            val = int(dut.uo_out.value)
        except ValueError:
            val = 0
        e = (val >> 0) & 1
        i = (val >> 1) & 1
        if e and not pe:
            ce2 += 1
        if i and not pi:
            ci2 += 1
        pe, pi = e, i

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
    counts = [await count_spikes(dut, bit, 3000) for bit in range(4)]
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

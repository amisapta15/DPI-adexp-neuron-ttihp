# ============================================================================
# Cocotb Testbench for AdEx Neuron System (LUT32, Q8.7)
# ============================================================================
# CI-compatible tests for the Tiny Tapeout GitHub Actions workflow.
# Simulator: Icarus Verilog via cocotb 1.9.2 (see requirements.txt)
#
# Tests:
#   1. test_basic_spiking      - regular spiking under strong bias
#   2. test_bursting            - clustered spikes separated by gaps
#   3. test_spike_adaptation    - ISIs increase over time (SFA)
# ============================================================================

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles


# ======================== Helper Functions ========================

def encode_signed(real_value):
    """Encode a signed real value for the nibble loader.

    The core maps byte 128 -> 0.0 via u8_to_signed_q:
        byte = clamp(real_value + 128, 0, 255)
    """
    v = int(round(real_value + 128))
    return max(0, min(255, v))


def encode_unsigned(real_value):
    """Encode an unsigned real value for the nibble loader.

    The core maps byte directly via u8_to_q_unsigned:
        byte = clamp(real_value, 0, 255)
    """
    v = int(round(real_value))
    return max(0, min(255, v))


async def reset_dut(dut, cycles=10):
    """Assert active-low reset for 'cycles' clocks, then release."""
    dut.rst_n.value = 0
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    await ClockCycles(dut.clk, cycles)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 5)


async def load_nibble(dut, nibble):
    """Strobe one 4-bit nibble into the parameter loader FSM.

    Protocol (matches the Verilog FSM in adex_neuron_system_tt_lut32.v):
      1. Set uio_in[3:0] = nibble, ui_in[4]=1 (load_mode), ui_in[3]=1 (strobe)
      2. Wait one rising edge (FSM latches the nibble)
      3. De-assert strobe (ui_in[3]=0), keep load_mode
      4. Wait one rising edge (gap cycle to avoid double-latch)
    """
    dut.uio_in.value = nibble & 0xF
    dut.ui_in.value = (1 << 4) | (1 << 3)  # load_mode + load_strobe
    await RisingEdge(dut.clk)
    dut.ui_in.value = (1 << 4)              # load_mode only, strobe off
    await RisingEdge(dut.clk)


async def load_parameters(dut, params):
    """Load all 8 parameters via the nibble interface.

    Each parameter is sent as two 4-bit nibbles (high nibble first).
    The FSM auto-increments param_index after each full byte.
    No footer nibble is needed.

    Args:
        params: dict with keys DeltaT, TauW, a, b, Vreset, VT, Ibias, C
    """
    order = ["DeltaT", "TauW", "a", "b", "Vreset", "VT", "Ibias", "C"]
    for name in order:
        val = params.get(name, 0) & 0xFF
        hi = (val >> 4) & 0xF
        lo = val & 0xF
        await load_nibble(dut, hi)
        await load_nibble(dut, lo)
    # Exit load mode to reset the nibble FSM for future use
    dut.ui_in.value = 0
    await ClockCycles(dut.clk, 5)


def safe_spike_bit(dut):
    """Read uo_out[0] safely, treating X/Z as 0."""
    try:
        return int(dut.uo_out.value) & 0x1
    except ValueError:
        return 0


async def monitor_spikes(dut, cycles):
    """Run for 'cycles' clocks, return list of cycle indices where a
    rising edge on uo_out[0] (spike) is detected."""
    spikes = []
    prev = 0
    for i in range(cycles):
        await RisingEdge(dut.clk)
        val = safe_spike_bit(dut)
        if val and not prev:
            spikes.append(i)
        prev = val
    return spikes


# ======================== Test 1: Basic Spiking ========================

@cocotb.test()
async def test_basic_spiking(dut):
    """Verify the neuron produces at least one spike under strong bias."""

    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())
    await reset_dut(dut)

    params = {
        "DeltaT": encode_signed(5),       # moderate exponential sharpness
        "TauW":   encode_unsigned(200),    # slow adaptation time constant
        "a":      encode_unsigned(1),      # small subthreshold adaptation
        "b":      encode_unsigned(2),      # small spike-triggered adaptation
        "Vreset": encode_signed(-65),      # deep reset
        "VT":     encode_signed(-55),      # threshold
        "Ibias":  encode_signed(122),      # strong supra-threshold current
        "C":      encode_unsigned(10),     # small capacitance, fast dynamics
    }
    await load_parameters(dut, params)

    # Enable the neuron core (ui_in[2])
    dut.ui_in.value = (1 << 2)
    await ClockCycles(dut.clk, 50)

    spikes = await monitor_spikes(dut, cycles=12000)
    dut._log.info("test_basic_spiking: detected %d spikes at cycles %s",
                  len(spikes), str(spikes[:20]))

    assert len(spikes) > 0, "FAIL: Neuron did not produce any spike within 12000 cycles"


# ======================== Test 2: Bursting ========================

@cocotb.test()
async def test_bursting(dut):
    """Verify bursting: clusters of spikes separated by silent gaps.

    A burst is a group of >=2 spikes with short ISI, followed by a gap
    significantly longer than the intra-burst ISI.
    """

    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())
    await reset_dut(dut)

    # Bursting parameters:
    #   - Strong subthreshold adaptation (a=4)
    #   - No spike-triggered adaptation (b=0)
    #   - Less-negative Vreset keeps V closer to threshold
    params = {
        "DeltaT": encode_signed(2),
        "TauW":   encode_unsigned(150),
        "a":      encode_unsigned(4),
        "b":      encode_unsigned(0),
        "Vreset": encode_signed(-50),
        "VT":     encode_signed(-50),
        "Ibias":  encode_signed(122),
        "C":      encode_unsigned(10),
    }
    await load_parameters(dut, params)

    # Enable the neuron core
    dut.ui_in.value = (1 << 2)
    await ClockCycles(dut.clk, 50)

    # Run for a long window to capture multiple bursts
    spikes = await monitor_spikes(dut, cycles=80000)
    dut._log.info("test_bursting: detected %d spikes", len(spikes))
    dut._log.info("  spike times (first 30): %s", str(spikes[:30]))

    assert len(spikes) >= 4, \
        "FAIL: Need >=4 spikes for burst analysis, got %d" % len(spikes)

    # Compute inter-spike intervals (ISI)
    isi = [spikes[i + 1] - spikes[i] for i in range(len(spikes) - 1)]
    dut._log.info("  ISIs (first 30): %s", str(isi[:30]))

    # Detect burst boundaries: ISI > 3x median indicates a gap
    sorted_isi = sorted(isi)
    median_isi = sorted_isi[len(sorted_isi) // 2]
    gap_threshold = max(median_isi * 3, 50)

    burst_count = 1
    for interval in isi:
        if interval > gap_threshold:
            burst_count += 1

    dut._log.info("  median ISI=%d, gap threshold=%d, bursts=%d",
                  median_isi, gap_threshold, burst_count)

    assert burst_count >= 2, \
        "FAIL: Expected >=2 bursts but detected %d" % burst_count


# ======================== Test 3: Spike-Frequency Adaptation ========================

@cocotb.test()
async def test_spike_adaptation(dut):
    """Verify SFA: average ISI in second half >= first half.

    Non-zero b (spike-triggered adaptation) increases w after each spike,
    making subsequent spikes harder to trigger.
    """

    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())
    await reset_dut(dut)

    params = {
        "DeltaT": encode_signed(2),
        "TauW":   encode_unsigned(150),
        "a":      encode_unsigned(2),
        "b":      encode_unsigned(8),      # spike-triggered adaptation
        "Vreset": encode_signed(-65),
        "VT":     encode_signed(-50),
        "Ibias":  encode_signed(122),
        "C":      encode_unsigned(10),
    }
    await load_parameters(dut, params)

    # Enable the neuron core
    dut.ui_in.value = (1 << 2)
    await ClockCycles(dut.clk, 50)

    spikes = await monitor_spikes(dut, cycles=80000)
    dut._log.info("test_spike_adaptation: detected %d spikes", len(spikes))
    dut._log.info("  spike times (first 20): %s", str(spikes[:20]))

    assert len(spikes) >= 6, \
        "FAIL: Need >=6 spikes for adaptation analysis, got %d" % len(spikes)

    isi = [spikes[i + 1] - spikes[i] for i in range(len(spikes) - 1)]
    dut._log.info("  ISIs (first 20): %s", str(isi[:20]))

    mid = len(isi) // 2
    avg_first = sum(isi[:mid]) / mid
    avg_second = sum(isi[mid:]) / len(isi[mid:])

    dut._log.info("  Avg ISI first half = %.1f, second half = %.1f",
                  avg_first, avg_second)

    assert avg_second >= avg_first, \
        "FAIL: No adaptation. Avg ISI first=%.1f >= second=%.1f" % (avg_first, avg_second)

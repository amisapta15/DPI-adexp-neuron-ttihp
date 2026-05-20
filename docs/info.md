<!---
This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## 🧠 AdEx Spiking Neuron Core

This project is a digital hardware implementation of the Adaptive Exponential (AdEx) Integrate-and-Fire neuron model, targeting the Tiny Tapeout ASIC shuttle. A single datapath solves two coupled ordinary differential equations — one for the membrane potential and one for the adaptation current — using forward-Euler integration on every clock cycle. The exponential nonlinearity is approximated by a 32-entry lookup table. The core is configurable via 8 run-time parameters, allowing it to reproduce regular spiking, bursting, and fast spiking firing patterns.

## How it works ⚙️

The system has two functional blocks inside a single module: a **Nibble Loader** for parameter configuration and a **Neuron Datapath** for real-time ODE integration.

### 1. Arithmetic Format

All state variables and parameters use **Q8.7 signed fixed-point** arithmetic (15-bit signed: 1 sign + 7 integer + 7 fractional bits).

| Property         | Value                          |
| :---             | :---                           |
| Word width       | 15-bit signed (`[14:0]`)       |
| Format           | Q8.7                           |
| Scale factor     | 1.0 → 128                      |
| Range            | −128.0 to +127.9921875         |
| Intermediates    | 32-bit signed for multiply/divide |

### 2. Exponential LUT

The exponential term `exp((V − V_T) / Δ_T)` is evaluated via a 32-entry lookup table.

| Property       | Value                                    |
| :---           | :---                                     |
| Entries        | 32                                       |
| Format         | Q8.7 (15-bit signed)                     |
| Domain         | [−4.5, +4.5] (Q8.7: [−576, +576])       |
| Sampling       | `linspace(-4.5, 4.5, 32)` — inclusive endpoints, step = 9/31 |
| Max entry      | 11 522 (e^4.5 × 128) — fits 15-bit signed (max 16 383) |
| Clamping       | Inputs outside domain map to `lut[0]` or `lut[31]` |

### 3. The Neuron Datapath

A single `always @(posedge clk)` block solves two coupled differential equations using forward-Euler integration:

```math
\frac{dV}{dt} = \frac{-g_L(V - E_L) + g_L\Delta_T\exp\left(\frac{V - V_T}{\Delta_T}\right) - w + I}{C}
```
```math
\frac{dw}{dt} = \frac{a(V - E_L) - w}{\tau_w}
```

When the membrane potential `V` exceeds the threshold `VT`, the core:
1. Outputs a digital **spike** on `uo_out[0]` ⚡
2. Resets `V` to `Vreset`
3. Increments `w` by `b` (spike-triggered adaptation)

Hard-coded constants (not user-configurable):
*   `E_L` = −70 (leak reversal), Q8.7 value = −8960
*   `g_L` = 10 (leak conductance), Q8.7 value = 1280

### 4. The Parameter Loader 📥

Eight user-configurable parameters are loaded serially via a 4-bit nibble interface. **No footer nibble is required** — parameters commit immediately as each byte is assembled.

The parameters are loaded in order:

| Index | Parameter | Type     | Encoding                              |
| :---: | :-------: | :---:    | :---                                  |
|   0   | `DeltaT`  | signed   | `(real_value + 128) & 0xFF`           |
|   1   |  `TauW`   | unsigned | `real_value & 0xFF`                   |
|   2   |    `a`    | unsigned | `real_value & 0xFF`                   |
|   3   |    `b`    | unsigned | `real_value & 0xFF`                   |
|   4   | `Vreset`  | signed   | `(real_value + 128) & 0xFF`           |
|   5   |   `VT`    | signed   | `(real_value + 128) & 0xFF`           |
|   6   |  `Ibias`  | signed   | `(real_value + 128) & 0xFF`           |
|   7   |    `C`    | unsigned | `real_value & 0xFF`                   |

Loading protocol:
1.  Assert `ui_in[4]` (load\_mode) high.
2.  Place the **high nibble** of a parameter byte on `uio_in[3:0]`, then pulse `ui_in[3]` (load\_strobe) high for one clock cycle.
3.  Place the **low nibble** on `uio_in[3:0]`, then pulse `ui_in[3]` high again. The full byte is written to `params[index]` and `index` auto-increments.
4.  Repeat for all 8 parameters (16 strobes total).
5.  De-assert `ui_in[4]` to exit load mode (resets the nibble FSM for next use).

### Inputs and Outputs

*   **Inputs**:
    *   `clk`: Main clock signal (active rising edge).
    *   `rst_n`: Active-low reset. Initialises V = −65 (Q8.7: −8320), w = 0, outputs = 0.
    *   `ui_in[4]` (`load_mode`): Hold high during parameter loading.
    *   `ui_in[3]` (`load_strobe`): Pulse high to latch a 4-bit nibble from `uio_in[3:0]`.
    *   `ui_in[2]` (`enable`): Set high to run the neuron simulation.
    *   `uio_in[3:0]`: 4-bit nibble data bus.
*   **Outputs**:
    *   `uo_out[0]` (**`spike`**): High for one clock cycle when the neuron fires.
    *   `uo_out[7:1]`: Unused (driven to 0).

## Firing Modes and How to Trigger Them 🧠⚡️

The AdEx model reproduces multiple neural firing patterns by varying `a`, `b`, `τ_w`, `I`, `Vreset`, and `C`.

*Note: For signed parameters (`DeltaT`, `Vreset`, `VT`, `Ibias`), the 8-bit encoding is `real_value + 128`. For unsigned parameters (`TauW`, `a`, `b`, `C`), the encoding is the raw value.*

---
### 📈 Regular Spiking (Adapting)
The firing rate is initially high and slows as the adaptation current `w` accumulates.

*   **Mechanism**: Non-zero spike-triggered adaptation (`b`) increases `w` with each spike.

*   **Parameter Values**:
| Parameter | Real-World Value | 8-bit Encoded Value | Hex Value |
| :---      | :---             | :---                | :---      |
| `DeltaT`  | 5                | `133`               | `0x85`    |
| `TauW`    | 100              | `100`               | `0x64`    |
| `a`       | 1                | `1`                 | `0x01`    |
| `b`       | 2                | `2`                 | `0x02`    |
| `Vreset`  | -65 mV           | `63`                | `0x3F`    |
| `VT`      | -55 mV           | `73`                | `0x49`    |
| `Ibias`   | 122 (strong)     | `250`               | `0xFA`    |
| `C`       | 10               | `10`                | `0x0A`    |

---
### 💥 Bursting
Clusters of high-frequency spikes separated by silent intervals.

*   **Mechanism**: Strong subthreshold adaptation (`a`) and a less-negative `Vreset` allow w to build up and suppress firing, then decay permits the next burst.

*   **Parameter Values**:
| Parameter | Real-World Value | 8-bit Encoded Value | Hex Value |
| :---      | :---             | :---                | :---      |
| `DeltaT`  | 2                | `130`               | `0x82`    |
| `TauW`    | 120              | `120`               | `0x78`    |
| `a`       | 4                | `4`                 | `0x04`    |
| `b`       | 0                | `0`                 | `0x00`    |
| `Vreset`  | -50 mV           | `78`                | `0x4E`    |
| `VT`      | -50 mV           | `78`                | `0x4E`    |
| `Ibias`   | 122 (strong)     | `250`               | `0xFA`    |
| `C`       | 10               | `10`                | `0x0A`    |

---
### 💨 Fast Spiking
Sustained high-frequency firing with no adaptation.

*   **Mechanism**: Both adaptation terms (`a`, `b`) are zero, so w stays constant.

*   **Parameter Values**:
| Parameter | Real-World Value | 8-bit Encoded Value | Hex Value |
| :---      | :---             | :---                | :---      |
| `DeltaT`  | 5                | `133`               | `0x85`    |
| `TauW`    | 100              | `100`               | `0x64`    |
| `a`       | 0                | `0`                 | `0x00`    |
| `b`       | 0                | `0`                 | `0x00`    |
| `Vreset`  | -65 mV           | `63`                | `0x3F`    |
| `VT`      | -55 mV           | `73`                | `0x49`    |
| `Ibias`   | 80               | `208`               | `0xD0`    |
| `C`       | 10               | `10`                | `0x0A`    |

---

## How to test 🧪

The cocotb testbench (`test/test.py`) with Verilog wrapper (`test/tb.v`) verifies three firing modes:

1.  **Reset**: Assert `rst_n` low for 10 clock cycles to initialise.
2.  **Load Parameters**: Enter load mode (`ui_in[4]=1`), send 16 nibbles (8 parameters × 2 nibbles each), then exit load mode (`ui_in[4]=0`).
3.  **Enable & Monitor**: Assert `ui_in[2]` to start simulation, then monitor `uo_out[0]` for spike pulses.

### Test 1 — Basic Spiking
Loads regular-spiking parameters and asserts at least one spike within 12 000 cycles.

### Test 2 — Bursting Detection
Loads bursting parameters and verifies clustered spike groups separated by silent intervals.

### Test 3 — Spike-Frequency Adaptation
Loads adaptation parameters with non-zero `b` and verifies that inter-spike intervals increase over time.

## External hardware

N/A. This project is a self-contained digital core and requires no external components.
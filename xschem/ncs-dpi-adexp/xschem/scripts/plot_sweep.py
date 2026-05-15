import struct
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import os

def read_ngspice_raw(filepath):
    with open(filepath, 'rb') as f:
        content = f.read()
    text = content.decode('ascii', errors='replace')
    variables = []
    in_variables = False
    n_vars = 0
    n_points = 0
    data_offset = 0
    for line in text.split('\n'):
        ls = line.strip()
        if ls.startswith('No. Variables:'):
            n_vars = int(ls.split(':')[1].strip())
        elif ls.startswith('No. Points:'):
            n_points = int(ls.split(':')[1].strip())
        elif ls.startswith('Variables:'):
            in_variables = True
            continue
        elif ls.startswith('Binary:'):
            marker = b'Binary:\n'
            if marker not in content:
                marker = b'Binary:\r\n'
            data_offset = content.index(marker) + len(marker)
            break
        if in_variables and ls:
            parts = ls.split()
            if len(parts) >= 3 and parts[0].isdigit():
                variables.append(parts[1])
    values = {v: [] for v in variables}
    data = content[data_offset:]
    for p in range(n_points):
        offset = p * n_vars * 8
        for vi, v in enumerate(variables):
            val = struct.unpack('d', data[offset + vi*8 : offset + (vi+1)*8])[0]
            values[v].append(val)
    return variables, values, n_points

filepath = r"C:\Users\Chenxi Wen\eda\designs\adex_neuron\ttihp26a-adex-neuron-ncs\xschem\simulations\neuron_iin_sweep.raw"
variables, values, n_points = read_ngspice_raw(filepath)

# Filter out the bad last point (unitvec leftover)
iin = values['iin_values']
freq = values['firing_rates']
# Remove points where iin_values > 10e-9 (clearly invalid)
valid = [(i, f) for i, f in zip(iin, freq) if i <= 5e-9]
iin_clean = [v[0] * 1e12 for v in valid]  # convert to pA
freq_clean = [v[1] for v in valid]         # Hz

# Plot
fig, ax = plt.subplots(figsize=(8, 5))
ax.plot(iin_clean, freq_clean, 'o-', color='#2196F3', linewidth=2, markersize=6)
ax.set_xlabel('Iin (pA)', fontsize=13)
ax.set_ylabel('Firing Rate (Hz)', fontsize=13)
ax.set_title('AdEx Neuron F-I Curve', fontsize=15, fontweight='bold')
ax.grid(True, alpha=0.3)
ax.set_xlim(left=0)
ax.set_ylim(bottom=0)
fig.tight_layout()

outpath = r"C:\Users\Chenxi Wen\.gemini\antigravity\brain\224e5535-1cb3-4e08-b2be-e21ddf8fd69a\fi_curve.png"
os.makedirs(os.path.dirname(outpath), exist_ok=True)
fig.savefig(outpath, dpi=150)
print(f"Plot saved to {outpath}")

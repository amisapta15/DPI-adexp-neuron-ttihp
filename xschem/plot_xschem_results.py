import os
import re
import numpy as np
import pandas as pd
from tkinter import Tk, filedialog

from dash import Dash, dcc, html, Input, Output, State, callback_context, no_update
import plotly.graph_objects as go


# ---------- RAW reader ----------
def read_ngspice_raw(raw_path: str):
    """Read ngspice .raw file (binary 'Binary:' section, Flags: real)."""
    with open(raw_path, "rb") as f:
        blob = f.read()

    m = re.search(br"\nBinary:\s*\n", blob)
    if not m:
        raise ValueError("No 'Binary:' section found (this reader expects ngspice binary RAW).")

    header = blob[:m.start()].decode("latin1", errors="replace")
    data_bytes = blob[m.end():]

    def get_int_field(key):
        mm = re.search(rf"^{re.escape(key)}\s*:\s*(\d+)\s*$", header, flags=re.MULTILINE)
        return int(mm.group(1)) if mm else None

    n_vars = get_int_field("No. Variables")
    n_pts = get_int_field("No. Points")
    if n_vars is None or n_pts is None:
        raise ValueError("Could not parse 'No. Variables' / 'No. Points' from header.")

    names, types = [], []
    in_vars = False
    for line in header.splitlines():
        if line.strip() == "Variables:":
            in_vars = True
            continue
        if in_vars:
            parts = line.strip().split()
            if len(parts) >= 2 and parts[0].isdigit():
                names.append(parts[1])
                types.append(parts[2] if len(parts) >= 3 else "")
                if len(names) == n_vars:
                    break

    expected = n_pts * n_vars * 8
    if len(data_bytes) != expected:
        raise ValueError(
            f"Binary size mismatch: got {len(data_bytes)} bytes, expected {expected} bytes."
        )

    arr = np.frombuffer(data_bytes, dtype=np.float64).reshape((n_pts, n_vars))
    df = pd.DataFrame(arr, columns=names)

    meta = {"n_points": n_pts, "n_vars": n_vars, "var_types": dict(zip(names, types))}
    return meta, df


# ---------- Helpers ----------
def is_voltage(name: str) -> bool:
    return name.startswith("v(")

def is_current(name: str) -> bool:
    return name.startswith("i(")

def make_options(options_list):
    return [{"label": x, "value": x} for x in options_list]


# ---------- Global mutable data ----------
DEFAULT_RAW_PATH = r"/Users/pigna/eda/designs/ttihp26a-adex-neuron-ncs/xschem/simulations/neuron_tb.raw"

current_data = {
    "meta": None,
    "df": pd.DataFrame(),
    "cols": [],
    "voltage_cols": [],
    "current_cols": [],
    "path": "",
}


def load_raw_file(path: str):
    """Load a .raw file and update the global current_data dict."""
    meta, df = read_ngspice_raw(path)
    cols = list(df.columns)
    current_data.update({
        "meta": meta,
        "df": df,
        "cols": cols,
        "voltage_cols": [c for c in cols if is_voltage(c)],
        "current_cols": [c for c in cols if is_current(c)],
        "path": path,
    })


# Initial load
load_raw_file(DEFAULT_RAW_PATH)

initial_cols = list(current_data["cols"])
initial_x = initial_cols[0] if initial_cols else ""
initial_y = initial_cols[1:4] if len(initial_cols) >= 4 else initial_cols[1:]


# ---------- Dash app ----------
app = Dash(__name__)
app.title = "ngspice .raw viewer"

app.layout = html.Div(
    style={"height": "100vh", "margin": "0", "padding": "0", "display": "flex"},
    children=[
        # Sidebar
        html.Div(
            style={
                "width": "280px",
                "padding": "10px 10px 10px 10px",
                "borderRight": "1px solid #ddd",
                "boxSizing": "border-box",
                "fontFamily": "sans-serif",
                "overflowY": "auto",
            },
            children=[
                html.Div(
                    "ngspice .raw viewer",
                    style={"fontWeight": "700", "marginBottom": "8px"},
                ),

                # ---- File browser section ----
                html.Div("RAW file", style={"fontSize": "12px", "marginTop": "6px"}),
                dcc.Input(
                    id="file-input",
                    type="text",
                    value=DEFAULT_RAW_PATH,
                    debounce=True,
                    style={"fontSize": "11px", "width": "100%", "boxSizing": "border-box",
                           "wordBreak": "break-all"},
                ),
                html.Div(
                    style={"display": "flex", "gap": "6px", "marginTop": "4px"},
                    children=[
                        html.Button("Browse…", id="btn-browse", n_clicks=0, style={"flex": "1", "fontSize": "11px"}),
                        html.Button("Load", id="btn-load", n_clicks=0, style={"flex": "1", "fontSize": "11px"}),
                    ],
                ),
                html.Div(id="file-status",
                         style={"fontSize": "11px", "color": "#555", "marginTop": "4px", "wordBreak": "break-all"}),
                # Store to signal that new data has been loaded (value = loaded path)
                dcc.Store(id="file-store", data=DEFAULT_RAW_PATH),

                html.Hr(),

                # ---- Axis controls ----
                html.Div("X axis", style={"fontSize": "12px", "marginTop": "6px"}),
                dcc.Dropdown(
                    id="x-dropdown",
                    options=make_options(initial_cols),
                    value=initial_x,
                    clearable=False,
                    searchable=True,
                    style={"fontSize": "12px"},
                ),

                html.Div("Filter Y list", style={"fontSize": "12px", "marginTop": "10px"}),
                dcc.RadioItems(
                    id="y-filter",
                    options=[
                        {"label": "All", "value": "all"},
                        {"label": "Voltages", "value": "v"},
                        {"label": "Currents", "value": "i"},
                    ],
                    value="all",
                    inline=True,
                    style={"fontSize": "12px"},
                ),

                html.Div("Y variables", style={"fontSize": "12px", "marginTop": "6px"}),
                dcc.Dropdown(
                    id="y-dropdown",
                    options=make_options(initial_cols),
                    value=initial_y,
                    multi=True,
                    searchable=True,
                    style={"fontSize": "12px"},
                ),

                html.Hr(),

                dcc.Checklist(
                    id="logy-toggle",
                    options=[{"label": "Log Y (auto clip ≤0)", "value": "log"}],
                    value=[],
                    style={"fontSize": "12px"},
                ),
                dcc.Checklist(
                    id="hover-toggle",
                    options=[{"label": "Show hover values", "value": "hover"}],
                    value=[],
                    style={"fontSize": "12px", "marginTop": "6px"},
                ),
                dcc.Checklist(
                    id="measure-toggle",
                    options=[{"label": "Measure Δ (click points)", "value": "measure"}],
                    value=["measure"],
                    style={"fontSize": "12px", "marginTop": "6px"},
                ),

                html.Div(
                    style={"display": "flex", "gap": "8px", "marginTop": "10px"},
                    children=[
                        html.Button("Clear Y", id="btn-clear-y", n_clicks=0, style={"flex": "1"}),
                        html.Button("Clear marks", id="btn-clear-marks", n_clicks=0, style={"flex": "1"}),
                    ],
                ),

                html.Div(id="status", style={"fontSize": "12px", "marginTop": "10px", "color": "#333"}),
                html.Div(id="measure-out", style={"fontSize": "12px", "marginTop": "8px"}),
                # Store for clicked points
                dcc.Store(id="marks-store", data=[]),
            ],
        ),

        # Main plot
        html.Div(
            style={"flex": "1", "padding": "0", "margin": "0"},
            children=[
                dcc.Graph(
                    id="graph",
                    style={"height": "100vh"},
                    config={
                        "displaylogo": False,
                        "scrollZoom": True,
                    },
                )
            ],
        ),
    ],
)


# ===================== CALLBACKS =====================

# Browse button → open native file dialog, update input field
@app.callback(
    Output("file-input", "value"),
    Input("btn-browse", "n_clicks"),
    State("file-input", "value"),
    prevent_initial_call=True,
)
def browse_file(_n, current_path):
    initial_dir = os.path.dirname(current_path) if current_path else ""
    # Suppress C-level libpng warnings (iCCP/cHRM) from tkinter by
    # temporarily redirecting the low-level stderr file descriptor.
    old_stderr_fd = os.dup(2)
    devnull_fd = os.open(os.devnull, os.O_WRONLY)
    os.dup2(devnull_fd, 2)
    os.close(devnull_fd)
    try:
        root = Tk()
        root.withdraw()
        root.wm_attributes("-topmost", 1)
        chosen = filedialog.askopenfilename(
            title="Select ngspice .raw file",
            initialdir=initial_dir or ".",
            filetypes=[("ngspice RAW", "*.raw"), ("All files", "*.*")],
        )
        root.destroy()
    finally:
        os.dup2(old_stderr_fd, 2)
        os.close(old_stderr_fd)
    if not chosen:
        return no_update
    return chosen


# Load button (or input Enter) → load the file → update file-store + x-dropdown
@app.callback(
    Output("file-store", "data"),
    Output("x-dropdown", "options"),
    Output("x-dropdown", "value"),
    Output("file-status", "children"),
    Input("btn-load", "n_clicks"),
    Input("file-input", "value"),      # fires on Enter (debounce=True)
    State("file-input", "value"),
    prevent_initial_call=True,
)
def load_file(_n_load, _file_input_val, path):
    if not path or not os.path.isfile(path):
        return no_update, no_update, no_update, f"⚠ File not found: {path}"
    try:
        load_raw_file(path)
    except Exception as e:
        return no_update, no_update, no_update, f"⚠ Error: {e}"

    cols = current_data["cols"]
    new_x = cols[0] if cols else ""
    return path, make_options(cols), new_x, f"✓ Loaded {os.path.basename(path)} ({current_data['meta']['n_points']} pts, {current_data['meta']['n_vars']} vars)"


# Update Y dropdown options when filter changes, Clear-Y is pressed, OR a new file is loaded
@app.callback(
    Output("y-dropdown", "options"),
    Output("y-dropdown", "value"),
    Input("y-filter", "value"),
    Input("btn-clear-y", "n_clicks"),
    Input("file-store", "data"),
    State("y-dropdown", "value"),
)
def update_y_options(filter_value, _clear_clicks, _file_path, current_selection):
    ctx = callback_context
    triggered = ctx.triggered[0]["prop_id"] if ctx.triggered else ""

    cols = current_data["cols"]
    voltage_cols = current_data["voltage_cols"]
    current_cols = current_data["current_cols"]

    if filter_value == "v":
        options = voltage_cols
    elif filter_value == "i":
        options = current_cols
    else:
        options = cols

    # If the clear-Y button was pressed, return empty selection
    if triggered.startswith("btn-clear-y"):
        return make_options(options), []

    # If a new file was just loaded, pick sensible defaults
    if triggered.startswith("file-store"):
        return make_options(options), options[:3]

    current_selection = current_selection or []
    kept = [y for y in current_selection if y in options]
    if not kept:
        kept = options[:3]
    return make_options(options), kept


# Capture clicks from the graph to store up to 2 points, or clear marks
@app.callback(
    Output("marks-store", "data"),
    Output("measure-out", "children"),
    Input("graph", "clickData"),
    Input("btn-clear-marks", "n_clicks"),
    State("marks-store", "data"),
    State("measure-toggle", "value"),
    prevent_initial_call=True,
)
def handle_click(clickData, _clear_clicks, marks, measure_toggle):
    ctx = callback_context
    if ctx.triggered and ctx.triggered[0]["prop_id"].startswith("btn-clear-marks"):
        return [], ""

    marks = marks or []
    measure_enabled = "measure" in (measure_toggle or [])
    if (not measure_enabled) or (clickData is None):
        return marks, no_update

    pt = clickData["points"][0]
    x = float(pt["x"])
    y = float(pt["y"])
    trace_name = pt.get("data", {}).get("name", f"trace{pt.get('curveNumber', 0)}")

    marks.append({"x": x, "y": y, "trace": trace_name})
    if len(marks) > 2:
        marks = marks[-2:]

    if len(marks) == 1:
        msg = f"P1: x={marks[0]['x']:.6g}, y={marks[0]['y']:.6g} (trace: {marks[0]['trace']})"
        return marks, msg

    p1, p2 = marks[0], marks[1]
    dx = p2["x"] - p1["x"]
    dy = p2["y"] - p1["y"]
    return marks, html.Div([
        html.Div(f"P1: x={p1['x']:.6g}, y={p1['y']:.6g} (trace: {p1['trace']})"),
        html.Div(f"P2: x={p2['x']:.6g}, y={p2['y']:.6g} (trace: {p2['trace']})"),
        html.Div([html.B("Δ: "), f"dx={dx:.6g}, dy={dy:.6g}"]),
    ])


# Build the figure
@app.callback(
    Output("graph", "figure"),
    Output("status", "children"),
    Input("x-dropdown", "value"),
    Input("y-dropdown", "value"),
    Input("logy-toggle", "value"),
    Input("hover-toggle", "value"),
    Input("marks-store", "data"),
    State("graph", "relayoutData"),
)
def update_graph(x, ys, logy_value, hover_value, marks, relayout_data):
    meta = current_data["meta"]
    df = current_data["df"]

    ys = ys or []
    logy = "log" in (logy_value or [])
    hover_on = "hover" in (hover_value or [])

    fig = go.Figure()

    if not ys or x not in df.columns:
        fig.update_layout(
            template="plotly_white",
            title="(No Y selected)" if not ys else f"(X column '{x}' not found)",
            height=900,
            margin=dict(l=60, r=30, t=60, b=60),
        )
        n_pts = meta["n_points"] if meta else 0
        return fig, f"Points: {n_pts} | Traces: 0"

    for y in ys:
        if y not in df.columns:
            continue
        ydata = df[y]
        if logy:
            ydata = ydata.where(ydata > 0)

        fig.add_trace(go.Scattergl(
            x=df[x],
            y=ydata,
            mode="lines",
            name=y,
            hoverinfo="x+y" if hover_on else "skip",
        ))

    hovermode = "x unified" if hover_on else False

    fig.update_layout(
        template="plotly_white",
        title=f"{', '.join(ys)} vs {x}",
        xaxis_title=x,
        yaxis_title="Value",
        yaxis_type="log" if logy else "linear",
        hovermode=hovermode,
        height=900,
        margin=dict(l=60, r=30, t=60, b=60),
        legend=dict(orientation="v", yanchor="top", y=1, xanchor="left", x=1.01),
        uirevision="constant",
    )

    fig.update_xaxes(
        tickformat="~e",
        exponentformat="e",
        showexponent="all",
        showline=True,
    )
    fig.update_yaxes(showline=True)

    # Draw measurement lines if marks exist
    shapes = []
    annotations = []
    if marks:
        for idx, p in enumerate(marks):
            label = "P1" if idx == 0 else "P2"
            shapes.append(dict(
                type="line",
                x0=p["x"], x1=p["x"],
                y0=0, y1=1,
                xref="x", yref="paper",
                line=dict(width=1, dash="dot"),
            ))
            annotations.append(dict(
                x=p["x"], y=1,
                xref="x", yref="paper",
                text=label,
                showarrow=False,
                yanchor="bottom",
            ))
    fig.update_layout(shapes=shapes, annotations=annotations)

    # Restore zoom / pan from previous relayoutData
    if relayout_data:
        if "xaxis.range[0]" in relayout_data and "xaxis.range[1]" in relayout_data:
            fig.update_xaxes(range=[relayout_data["xaxis.range[0]"], relayout_data["xaxis.range[1]"]])
        if "yaxis.range[0]" in relayout_data and "yaxis.range[1]" in relayout_data:
            fig.update_yaxes(range=[relayout_data["yaxis.range[0]"], relayout_data["yaxis.range[1]"]])

    return fig, f"Points: {meta['n_points']} | Traces: {len(ys)}"


if __name__ == "__main__":
    # Install deps: pip install dash plotly pandas numpy
    app.run(debug=True)
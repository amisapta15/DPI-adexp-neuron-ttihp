// ============================================================================
// adex_config: write-only runtime configuration bank for the baseline network
// ----------------------------------------------------------------------------
// SPI mode 0, MSB first. Inputs are synchronised into clk, so SCLK must run
// no faster than clk/8 and CS_N must be stable for at least two clk cycles
// before and after a frame. A write updates a shadow field; COMMIT copies the
// complete shadow bank into the active bank on one clk edge.
//
// 32-bit frames:
//   WRITE:  [31:28]=0xA [27:24]=target [23:20]=field [19:4]=value [3:0]=0
//   COMMIT: [31:28]=0xC [27:0]=0
// Targets 0..3 select E0, I0, E1, I1. Target 0xF selects global fields.
// Per-neuron fields: 0=VTH_Q, 1=IEXT_Q.
// Global fields: 0=VTRIG_Q, 1=VSTEP_Q, 2=FINC0, 3=FINC1,
//                4=WBUMP_Q, 5=INH_AMT_Q.
// ============================================================================
`default_nettype none

module adex_config #(
    parameter signed [15:0] DEFAULT_VTH_Q     = 16'sd4096,
    parameter signed [15:0] DEFAULT_IEXT_Q    = 16'sd1024,
    parameter signed [15:0] DEFAULT_VTRIG_Q   = 16'sd3072,
    parameter signed [15:0] DEFAULT_VSTEP_Q   = 16'sd4096,
    parameter        [8:0]  DEFAULT_FINC0     = 9'd128,
    parameter        [8:0]  DEFAULT_FINC1     = 9'd192,
    parameter        [10:0] DEFAULT_WBUMP_Q   = 11'd256,
    parameter        [14:0] DEFAULT_INH_AMT_Q = 15'd512
) (
    input  wire               clk,
    input  wire               rst_n,
    input  wire               spi_cs_n,
    input  wire               spi_sclk,
    input  wire               spi_mosi,

    output reg signed [15:0] cfg_vth0_q,
    output reg signed [15:0] cfg_vth1_q,
    output reg signed [15:0] cfg_vth2_q,
    output reg signed [15:0] cfg_vth3_q,
    output reg signed [15:0] cfg_iext0_q,
    output reg signed [15:0] cfg_iext1_q,
    output reg signed [15:0] cfg_iext2_q,
    output reg signed [15:0] cfg_iext3_q,
    output reg signed [15:0] cfg_vtrig_q,
    output reg signed [15:0] cfg_vstep_q,
    output reg        [8:0]  cfg_finc0,
    output reg        [8:0]  cfg_finc1,
    output reg        [10:0] cfg_wbump_q,
    output reg        [14:0] cfg_inh_amt_q
);

    reg signed [15:0] shadow_vth0_q, shadow_vth1_q;
    reg signed [15:0] shadow_vth2_q, shadow_vth3_q;
    reg signed [15:0] shadow_iext0_q, shadow_iext1_q;
    reg signed [15:0] shadow_iext2_q, shadow_iext3_q;
    reg signed [15:0] shadow_vtrig_q, shadow_vstep_q;
    reg        [8:0]  shadow_finc0, shadow_finc1;
    reg        [10:0] shadow_wbump_q;
    reg        [14:0] shadow_inh_amt_q;

    reg        spi_cs_meta, spi_cs_sync;
    reg        spi_sclk_meta, spi_sclk_sync, spi_sclk_prev;
    reg        spi_mosi_meta, spi_mosi_sync;
    reg [4:0]  spi_bit_count;
    // After each sampled bit, the next frame is formed by appending MOSI.
    // The old MSB is never observed, so retain only the preceding 31 bits.
    reg [30:0] spi_shift;

    wire        spi_sclk_rise = spi_sclk_sync & ~spi_sclk_prev;
    wire [31:0] spi_frame = {spi_shift, spi_mosi_sync};

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cfg_vth0_q      <= DEFAULT_VTH_Q;
            cfg_vth1_q      <= DEFAULT_VTH_Q;
            cfg_vth2_q      <= DEFAULT_VTH_Q;
            cfg_vth3_q      <= DEFAULT_VTH_Q;
            cfg_iext0_q     <= DEFAULT_IEXT_Q;
            cfg_iext1_q     <= DEFAULT_IEXT_Q;
            cfg_iext2_q     <= DEFAULT_IEXT_Q;
            cfg_iext3_q     <= DEFAULT_IEXT_Q;
            cfg_vtrig_q     <= DEFAULT_VTRIG_Q;
            cfg_vstep_q     <= DEFAULT_VSTEP_Q;
            cfg_finc0       <= DEFAULT_FINC0;
            cfg_finc1       <= DEFAULT_FINC1;
            cfg_wbump_q     <= DEFAULT_WBUMP_Q;
            cfg_inh_amt_q   <= DEFAULT_INH_AMT_Q;

            shadow_vth0_q   <= DEFAULT_VTH_Q;
            shadow_vth1_q   <= DEFAULT_VTH_Q;
            shadow_vth2_q   <= DEFAULT_VTH_Q;
            shadow_vth3_q   <= DEFAULT_VTH_Q;
            shadow_iext0_q  <= DEFAULT_IEXT_Q;
            shadow_iext1_q  <= DEFAULT_IEXT_Q;
            shadow_iext2_q  <= DEFAULT_IEXT_Q;
            shadow_iext3_q  <= DEFAULT_IEXT_Q;
            shadow_vtrig_q  <= DEFAULT_VTRIG_Q;
            shadow_vstep_q  <= DEFAULT_VSTEP_Q;
            shadow_finc0    <= DEFAULT_FINC0;
            shadow_finc1    <= DEFAULT_FINC1;
            shadow_wbump_q  <= DEFAULT_WBUMP_Q;
            shadow_inh_amt_q <= DEFAULT_INH_AMT_Q;

            spi_cs_meta     <= 1'b1;
            spi_cs_sync     <= 1'b1;
            spi_sclk_meta   <= 1'b0;
            spi_sclk_sync   <= 1'b0;
            spi_sclk_prev   <= 1'b0;
            spi_mosi_meta   <= 1'b0;
            spi_mosi_sync   <= 1'b0;
            spi_bit_count   <= 5'd0;
            spi_shift       <= 31'd0;
        end else begin
            spi_cs_meta   <= spi_cs_n;
            spi_cs_sync   <= spi_cs_meta;
            spi_sclk_meta <= spi_sclk;
            spi_sclk_sync <= spi_sclk_meta;
            spi_sclk_prev <= spi_sclk_sync;
            spi_mosi_meta <= spi_mosi;
            spi_mosi_sync <= spi_mosi_meta;

            if (spi_cs_sync) begin
                spi_bit_count <= 5'd0;
                spi_shift     <= 31'd0;
            end else if (spi_sclk_rise) begin
                if (spi_bit_count == 5'd31) begin
                    spi_bit_count <= 5'd0;
                    spi_shift     <= 31'd0;

                    if ((spi_frame[31:28] == 4'hA) && (spi_frame[3:0] == 4'd0)) begin
                        case (spi_frame[27:24])
                            4'd0: begin
                                case (spi_frame[23:20])
                                    4'd0: shadow_vth0_q  <= $signed(spi_frame[19:4]);
                                    4'd1: shadow_iext0_q <= $signed(spi_frame[19:4]);
                                    default: begin end
                                endcase
                            end
                            4'd1: begin
                                case (spi_frame[23:20])
                                    4'd0: shadow_vth1_q  <= $signed(spi_frame[19:4]);
                                    4'd1: shadow_iext1_q <= $signed(spi_frame[19:4]);
                                    default: begin end
                                endcase
                            end
                            4'd2: begin
                                case (spi_frame[23:20])
                                    4'd0: shadow_vth2_q  <= $signed(spi_frame[19:4]);
                                    4'd1: shadow_iext2_q <= $signed(spi_frame[19:4]);
                                    default: begin end
                                endcase
                            end
                            4'd3: begin
                                case (spi_frame[23:20])
                                    4'd0: shadow_vth3_q  <= $signed(spi_frame[19:4]);
                                    4'd1: shadow_iext3_q <= $signed(spi_frame[19:4]);
                                    default: begin end
                                endcase
                            end
                            4'hF: begin
                                case (spi_frame[23:20])
                                    4'd0: shadow_vtrig_q   <= $signed(spi_frame[19:4]);
                                    4'd1: shadow_vstep_q   <= $signed(spi_frame[19:4]);
                                    4'd2: shadow_finc0     <= spi_frame[12:4];
                                    4'd3: shadow_finc1     <= spi_frame[12:4];
                                    4'd4: shadow_wbump_q   <= spi_frame[14:4];
                                    4'd5: shadow_inh_amt_q <= spi_frame[18:4];
                                    default: begin end
                                endcase
                            end
                            default: begin end
                        endcase
                    end else if ((spi_frame[31:28] == 4'hC) && (spi_frame[27:0] == 28'd0)) begin
                        cfg_vth0_q    <= shadow_vth0_q;
                        cfg_vth1_q    <= shadow_vth1_q;
                        cfg_vth2_q    <= shadow_vth2_q;
                        cfg_vth3_q    <= shadow_vth3_q;
                        cfg_iext0_q   <= shadow_iext0_q;
                        cfg_iext1_q   <= shadow_iext1_q;
                        cfg_iext2_q   <= shadow_iext2_q;
                        cfg_iext3_q   <= shadow_iext3_q;
                        cfg_vtrig_q   <= shadow_vtrig_q;
                        cfg_vstep_q   <= shadow_vstep_q;
                        cfg_finc0     <= shadow_finc0;
                        cfg_finc1     <= shadow_finc1;
                        cfg_wbump_q   <= shadow_wbump_q;
                        cfg_inh_amt_q <= shadow_inh_amt_q;
                    end
                end else begin
                    spi_bit_count <= spi_bit_count + 5'd1;
                    spi_shift     <= spi_frame[30:0];
                end
            end
        end
    end

endmodule

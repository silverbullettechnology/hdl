
`define C_S_AXI_DATA_WIDTH 32
`define C_S_AXI_ADDR_WIDTH 5

module vita49_clk
(
  ////////////////////////////////////////////////////////////////////////////
  // AXI-LITE

  input wire S_AXI_ACLK,
  input wire S_AXI_ARESETN,
  input  wire [`C_S_AXI_ADDR_WIDTH - 1:0] S_AXI_AWADDR,
  input  wire                          S_AXI_AWVALID,
  output wire                          S_AXI_AWREADY,
  input  wire [`C_S_AXI_DATA_WIDTH-1:0] S_AXI_WDATA,
  input  wire [`C_S_AXI_DATA_WIDTH/8-1:0] S_AXI_WSTRB,
  input  wire                          S_AXI_WVALID,
  output wire                          S_AXI_WREADY,
  output wire [1:0]                    S_AXI_BRESP,
  output wire                          S_AXI_BVALID,
  input  wire                          S_AXI_BREADY,
  input  wire [`C_S_AXI_ADDR_WIDTH - 1:0] S_AXI_ARADDR,
  input  wire                          S_AXI_ARVALID,
  output wire                          S_AXI_ARREADY,
  output wire [`C_S_AXI_DATA_WIDTH-1:0] S_AXI_RDATA,
  output wire [1:0]                    S_AXI_RRESP,
  output wire                          S_AXI_RVALID,
  input  wire                          S_AXI_RREADY,

  // input clocks
  input wire pps_clk,
  input wire samp_clk_0,
  input wire samp_clk_1,
  
  //  output counters
  output wire [31:0] tsi_0,
  output wire [31:0] tsi_1,
  output wire [63:0] tsf_0,
  output wire [63:0] tsf_1
 );

wire [31:0] ctrl;
wire [31:0] status;
wire [31:0] tsi_prog;
  
wire [31:0] tsi_0_up;
wire [31:0] tsf_0_hi_up;
wire [31:0] tsf_0_lo_up;
wire [31:0] tsi_1_up;
wire [31:0] tsf_1_hi_up;
wire [31:0] tsf_1_lo_up;
  
vita49_clk_if vita49_clk_if (
  .S_AXI_ACLK    (S_AXI_ACLK),
  .S_AXI_ARESETN (S_AXI_ARESETN),
  .S_AXI_AWADDR  (S_AXI_AWADDR),
  .S_AXI_AWVALID (S_AXI_AWVALID),
  .S_AXI_AWREADY (S_AXI_AWREADY),
  .S_AXI_WDATA   (S_AXI_WDATA),
  .S_AXI_WSTRB   (S_AXI_WSTRB),
  .S_AXI_WVALID  (S_AXI_WVALID),
  .S_AXI_WREADY  (S_AXI_WREADY),
  .S_AXI_BRESP   (S_AXI_BRESP),
  .S_AXI_BVALID  (S_AXI_BVALID),
  .S_AXI_BREADY  (S_AXI_BREADY),
  .S_AXI_ARADDR  (S_AXI_ARADDR),
  .S_AXI_ARVALID (S_AXI_ARVALID),
  .S_AXI_ARREADY (S_AXI_ARREADY),
  .S_AXI_RDATA   (S_AXI_RDATA),
  .S_AXI_RRESP   (S_AXI_RRESP),
  .S_AXI_RVALID  (S_AXI_RVALID),
  .S_AXI_RREADY  (S_AXI_RREADY),
  .ctrl          (ctrl),
  .status        (status),
  .tsi_prog      (tsi_prog),
  .tsi_0_up      (tsi_0_up),
  .tsf_0_hi_up   (tsf_0_hi_up),
  .tsf_0_lo_up   (tsf_0_lo_up),
  .tsi_1_up      (tsi_1_up),
  .tsf_1_hi_up   (tsf_1_hi_up),
  .tsf_1_lo_up   (tsf_1_lo_up)
);
  
vita49_clk_logic  vita49_clk_logic
(
  .ARESETN (S_AXI_ARESETN),
  .pps_clk(pps_clk),
  .samp_clk_0(samp_clk_0),
  .samp_clk_1(samp_clk_1),
 
  // from procesor 
  .ctrl          (ctrl),
  .status        (status),
  .tsi_prog      (tsi_prog),
  .tsi_0_up      (tsi_0_up),
  .tsf_0_hi_up   (tsf_0_hi_up),
  .tsf_0_lo_up   (tsf_0_lo_up),
  .tsi_1_up      (tsi_1_up),
  .tsf_1_hi_up   (tsf_1_hi_up),
  .tsf_1_lo_up   (tsf_1_lo_up),
  
  // from timing unit
  .tsi_0(tsi_0),
  .tsi_1(tsi_1),
  .tsf_0(tsf_0),
  .tsf_1(tsf_1)
 );

  
endmodule

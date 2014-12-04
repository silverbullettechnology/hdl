
`define C_S_AXI_DATA_WIDTH 32
`define C_S_AXI_ADDR_WIDTH 5

module dsrc_rep
#(
  parameter integer C_M_AXIS_TDATA_NUM_BYTES = 4,
  parameter  C_REP_CONTINUOUS = 1
) (
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

  /////////
  //AXIS
  input wire AXIS_ACLK,
  input wire AXIS_ARESETN,
  output wire M_AXIS_TVALID,
  output wire [(C_M_AXIS_TDATA_NUM_BYTES*8)-1:0] M_AXIS_TDATA,
  output wire [C_M_AXIS_TDATA_NUM_BYTES-1:0] M_AXIS_TSTRB,
  output wire M_AXIS_TLAST,
  input wire M_AXIS_TREADY
);

wire [31:0] cmd;
wire        new_cmd;
wire [31:0] stat;
wire [31:0] num_bytes;
wire [31:0] data_type;
wire [31:0] num_pkts;
wire [31:0] rx_cnt;
wire [31:0] rx_rep_cnt;

dsrc_rep_if dsrc_rep_if (
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
  .cmd           (cmd),
  .new_cmd       (new_cmd),
  .stat          (stat),
  .num_bytes     (num_bytes),
  .data_type     (data_type),
  .num_pkts      (num_pkts),
  .rx_cnt        (rx_cnt),
  .rx_rep_cnt    (rx_rep_cnt)
);

axis_dsrc_rep
#(
  .C_M_AXIS_TDATA_NUM_BYTES (C_M_AXIS_TDATA_NUM_BYTES),
  .C_REP_CONTINUOUS (C_REP_CONTINUOUS)
) 
axis_dsrc_rep(
  .S_AXI_ACLK    (S_AXI_ACLK),
  .AXIS_ACLK     (AXIS_ACLK),
  .AXIS_ARESETN  (AXIS_ARESETN),
  .M_AXIS_TVALID (M_AXIS_TVALID),
  .M_AXIS_TDATA  (M_AXIS_TDATA),
  .M_AXIS_TSTRB  (M_AXIS_TSTRB),
  .M_AXIS_TLAST  (M_AXIS_TLAST),
  .M_AXIS_TREADY (M_AXIS_TREADY),
  .cmd           (cmd),
  .new_cmd       (new_cmd),
  .stat          (stat),
  .num_bytes     (num_bytes),
  .data_type     (data_type),
  .num_pkts      (num_pkts),
  .rx_cnt        (rx_cnt),
  .rx_rep_cnt    (rx_rep_cnt));
  
endmodule


`define C_S_AXI_DATA_WIDTH 32
`define C_S_AXI_ADDR_WIDTH 5

module dsnk
#(
  parameter integer C_S_AXIS_TDATA_NUM_BYTES = 4
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
  output wire S_AXIS_TREADY,
  input wire [(C_S_AXIS_TDATA_NUM_BYTES*8)-1:0] S_AXIS_TDATA,
  input wire [C_S_AXIS_TDATA_NUM_BYTES-1:0] S_AXIS_TSTRB,
  input wire S_AXIS_TLAST,
  input wire S_AXIS_TVALID
);

wire [31:0] cmd;
wire        new_cmd;
wire [31:0] stat;
wire [31:0] recv_bytes;
wire [63:0] checksum;

dsnk_if dsnk_if (
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
  .recv_bytes    (recv_bytes),
  .checksum      (checksum)
);

axis_dsnk 
#(
  .C_S_AXIS_TDATA_NUM_BYTES (C_S_AXIS_TDATA_NUM_BYTES)
) 
axis_dsnk(
  .S_AXI_ACLK    (S_AXI_ACLK),
  .AXIS_ACLK     (AXIS_ACLK),
  .AXIS_ARESETN  (AXIS_ARESETN),
  .S_AXIS_TREADY (S_AXIS_TREADY),
  .S_AXIS_TDATA  (S_AXIS_TDATA),
  .S_AXIS_TSTRB  (S_AXIS_TSTRB),
  .S_AXIS_TLAST  (S_AXIS_TLAST),
  .S_AXIS_TVALID (S_AXIS_TVALID),
  .cmd           (cmd),
  .new_cmd       (new_cmd),
  .stat          (stat),
  .recv_bytes    (recv_bytes),
  .checksum      (checksum)
);
endmodule

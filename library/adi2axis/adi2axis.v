
`define C_S_AXI_DATA_WIDTH 32
`define C_S_AXI_ADDR_WIDTH 5

module adi2axis
#(
  parameter integer C_M_AXIS_TDATA_NUM_BYTES = 8
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
  // ADI FIFO
  input wire [(C_M_AXIS_TDATA_NUM_BYTES*8)-1:0] ddata,
  input wire dvalid,
  input wire dsync,
  output wire ovf,
  
  /////////
  //AXIS
  input wire AXIS_ACLK,
  input wire AXIS_ARESETN,
  output wire M_AXIS_TVALID,
  output wire [(C_M_AXIS_TDATA_NUM_BYTES*8)-1:0] M_AXIS_TDATA,
  output wire [C_M_AXIS_TDATA_NUM_BYTES-1:0] M_AXIS_TSTRB,
  output wire M_AXIS_TLAST,
  input wire M_AXIS_TREADY,
  
  input wire trig
);

wire [31:0] ctrl;
wire [31:0] stat;
wire [31:0] num_bytes;

adi2axis_if adi2axis_if (
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
  .stat          (stat),
  .num_bytes     (num_bytes)
);

adi2axis_conv
#(
  .C_M_AXIS_TDATA_NUM_BYTES (C_M_AXIS_TDATA_NUM_BYTES)
) 
adi2axis_conv(
  .S_AXI_ACLK    (S_AXI_ACLK),
  .AXIS_ACLK     (AXIS_ACLK),
  .AXIS_ARESETN  (AXIS_ARESETN),
  .M_AXIS_TVALID (M_AXIS_TVALID),
  .M_AXIS_TDATA  (M_AXIS_TDATA),
  .M_AXIS_TSTRB  (M_AXIS_TSTRB),
  .M_AXIS_TLAST  (M_AXIS_TLAST),
  .M_AXIS_TREADY (M_AXIS_TREADY),
  
  .ddata  (ddata),
  .dvalid (dvalid),
  .dsync  (dsync),
  .ovf    (ovf),
  
  .ctrl          (ctrl),
  .stat          (stat),
  .num_bytes     (num_bytes),
  
  .trig (trig)
  );
  
endmodule

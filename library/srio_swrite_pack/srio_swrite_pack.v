
`define C_S_AXI_DATA_WIDTH 32
`define C_S_AXI_ADDR_WIDTH 5

module srio_swrite_pack
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

  /////////
  //AXIS
  input wire AXIS_ACLK,
  input wire AXIS_ARESETN,

  output wire S_AXIS_TREADY,
  input wire [63:0] S_AXIS_TDATA,
  input wire S_AXIS_TLAST,
  input wire S_AXIS_TVALID,
 
  output wire M_AXIS_TVALID,
  output wire [63:0] M_AXIS_TDATA,
  output wire M_AXIS_TLAST,
  output wire [31:0] M_AXIS_TUSER,
  input wire M_AXIS_TREADY,
  
  //////
  // DEBUG
  output wire dbug_m_rdy,
  output wire dbug_m_vld,
  output wire dbug_s_rdy,
  output wire dbug_s_vld
);

wire [31:0] cmd;
wire [31:0] addr;
wire [31:0] srcdest;

assign dbug_m_rdy = M_AXIS_TREADY;
assign dbug_m_vld = M_AXIS_TVALID;
assign dbug_s_rdy = S_AXIS_TREADY;
assign dbug_s_vld = S_AXIS_TVALID;

srio_swrite_pack_if srio_swrite_pack_if (
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
  .cmd	         (cmd),
  .addr          (addr),
  .srcdest       (srcdest)
  );

srio_swrite_pack_logic srio_swrite_pack_logic (
	.AXIS_ACLK (AXIS_ACLK),
	.AXIS_ARESETN (AXIS_ARESETN),
	.S_AXIS_TREADY (S_AXIS_TREADY),
	.S_AXIS_TDATA (S_AXIS_TDATA),
	.S_AXIS_TVALID (S_AXIS_TVALID),
	.S_AXIS_TLAST (S_AXIS_TLAST),
	.M_AXIS_TVALID (M_AXIS_TVALID),
	.M_AXIS_TDATA (M_AXIS_TDATA),
	.M_AXIS_TLAST (M_AXIS_TLAST),
	.M_AXIS_TUSER (M_AXIS_TUSER),
	.M_AXIS_TREADY (M_AXIS_TREADY),
	
	.cmd           (cmd),
	.addr          (addr),
	.srcdest       (srcdest)
	);
	  
  
  
endmodule

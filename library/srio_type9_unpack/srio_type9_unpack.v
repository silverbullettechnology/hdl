
`define C_S_AXI_DATA_WIDTH 32
`define C_S_AXI_ADDR_WIDTH 5

module srio_type9_unpack
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
//  output wire M_AXIS_TUSER,
  output wire M_AXIS_TID,
  output wire [3:0] M_AXIS_TDEST, 
  input wire M_AXIS_TREADY
  
//  output wire type9_start_dbg,
//  output wire type9_end_dbg,
//  output wire pdu_start_dbug,
//  output wire [3:0] mstate_dbug
);


wire [31:0] srio_streamID_if;
wire [31:0] cmd;

srio_type9_unpack_if srio_type9_unpack_if (
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
  .cmd              (cmd),
  .srio_streamID_if (srio_streamID_if)
  );

srio_type9_unpack_logic srio_type9_unpack_logic (
	.AXIS_ACLK (AXIS_ACLK),
	.AXIS_ARESETN (AXIS_ARESETN),
	.S_AXIS_TREADY (S_AXIS_TREADY),
	.S_AXIS_TDATA (S_AXIS_TDATA),
	.S_AXIS_TVALID (S_AXIS_TVALID),
	.S_AXIS_TLAST (S_AXIS_TLAST),
	
	.M_AXIS_TVALID (M_AXIS_TVALID),
	.M_AXIS_TDATA (M_AXIS_TDATA),
	.M_AXIS_TLAST (M_AXIS_TLAST),
//	.M_AXIS_TUSER (M_AXIS_TUSER),
	.M_AXIS_TID   (M_AXIS_TID),
	.M_AXIS_TDEST (M_AXIS_TDEST),
	.M_AXIS_TREADY (M_AXIS_TREADY),
	.cmd              (cmd),
	.srio_streamID_if (srio_streamID_if)
	
//	.type9_start_dbg (type9_start_dbg),
//	.type9_end_dbg (type9_end_dbg),
//	.pdu_start_dbug (pdu_start_dbug),
//	.mstate_dbug (mstate_dbug)
	);
	  
  
  
endmodule

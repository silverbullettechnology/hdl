
`define C_S_AXI_DATA_WIDTH 32
`define C_S_AXI_ADDR_WIDTH 6

module axis_vita49_unpack
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
  input wire [31:0] S_AXIS_TDATA,
  input wire S_AXIS_TLAST,
  input wire S_AXIS_TVALID,
 
  output wire M_AXIS_TVALID,
  output wire [31:0] M_AXIS_TDATA,
  output wire M_AXIS_TLAST,
  input wire M_AXIS_TREADY,

  input wire trig,
  ///////////
  // timing control  
  input wire [31:0] timestamp_sec,
  input wire [63:0] timestamp_fsec,
  
  // debug
  output wire [31:0] ext_stat,
  output wire irq,
  output wire [3:0] Mstate_dbg,
  output wire tlast_reg_dbg,
  output wire [15:0] payload_cnt_dbg
);

wire [31:0] ctrl;
wire [31:0] status;
wire [31:0] streamID;
  
// stat counters 
wire [31:0] pkt_recv;
wire [31:0] pkt_dropped;
// error counters
wire [31:0] pkt_size_err;
wire [31:0] pkt_type_err;
wire [31:0] pkt_order_err;
wire [31:0] ts_order_err;
wire [31:0] strm_id_err;
wire [31:0] trailer_err;

vita49_unpack_if #(.C_S_AXI_ADDR_WIDTH(`C_S_AXI_ADDR_WIDTH)) vita49_unpack_if (
//vita49_unpack_if vita49_unpack_if (
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
  .streamID      (streamID),
  .pkt_recv      (pkt_recv),
  .pkt_dropped   (pkt_dropped),
  .pkt_size_err  (pkt_size_err),
  .pkt_type_err  (pkt_type_err),
  .pkt_order_err (pkt_order_err),
  .ts_order_err  (ts_order_err),
  .strm_id_err   (strm_id_err),
  .trailer_err   (trailer_err)
);

vita49_unpack vita49_unpack (
	.AXIS_ACLK (AXIS_ACLK),
	.AXIS_ARESETN (AXIS_ARESETN),
	.S_AXIS_TREADY (S_AXIS_TREADY),
	.S_AXIS_TDATA (S_AXIS_TDATA),
	.S_AXIS_TVALID (S_AXIS_TVALID),
	.S_AXIS_TLAST  (S_AXIS_TLAST),
	.M_AXIS_TVALID (M_AXIS_TVALID),
	.M_AXIS_TDATA (M_AXIS_TDATA),
	.M_AXIS_TLAST (M_AXIS_TLAST),
	.M_AXIS_TREADY (M_AXIS_TREADY),
	.trig (trig),
	
	.ctrl (ctrl),
	.status (status),
	.streamID (streamID),
    .pkt_recv      (pkt_recv),
    .pkt_dropped   (pkt_dropped),
    .pkt_size_err  (pkt_size_err),
    .pkt_type_err  (pkt_type_err),
    .pkt_order_err (pkt_order_err),
    .ts_order_err  (ts_order_err),
    .strm_id_err   (strm_id_err),
    .trailer_err   (trailer_err),
    	
	.timestamp_sec (timestamp_sec),
	.timestamp_fsec (timestamp_fsec),

    .Mstate_dbg(Mstate_dbg),
    .tlast_reg_dbg(tlast_reg_dbg),
    .payload_cnt_dbg(payload_cnt_dbg)
	);
	  
assign ext_stat = status;
assign irq = |status[7:0];  
  
endmodule

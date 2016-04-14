

module top_tb();

wire reset_n;

// Clock generator
wire axi_clk;
wire axi_aresetn;
wire axis_clk;
wire axis_aresetn;
wire pps_clk;
wire samp_clk;

// time registers
reg [31:0] tsi;
reg [63:0] tsf;
reg pps_clk_r;
initial begin
	tsi = 0;
	tsf = 0;
end
always @(posedge samp_clk) begin
	pps_clk_r <= pps_clk;
	tsi <= (pps_clk & ~pps_clk_r)? tsi+1: tsi;
	tsf <= (pps_clk & ~pps_clk_r)? 1: tsf + 1;
end

// axi streaming
  wire [31:0] SRC_TDATA;
  wire SRC_TVALID;
  wire SRC_TREADY;
  wire SRC_TLAST;

// axi streaming
//  wire [63:0] CONV_TDATA;
//  wire CONV_TVALID;
//  wire CONV_TREADY;
//  wire CONV_TLAST;
    
// dsrc rep
  reg [31:0] dsrc_cmd;
  reg [31:0] dsrc_num_bytes;
  reg [31:0] dsrc_data_type;
  reg [31:0] dsrc_num_pkts;
  reg        dsrc_new_cmd;
  
// vita 49 pack
  wire [31:0] VITA_TDATA;
  wire VITA_TVALID;
  wire VITA_TLAST;
  reg VITA_TREADY;
  reg [31:0] vita_ctrl;
  wire [31:0] vita_status;
  reg [31:0] vita_streamID;
  reg [15:0] vita_pkt_size;
  reg [31:0] trailer;
  
// clock generator
clk_gen clk_gen (
	.reset_n(reset_n),
	.axi_clk(axi_clk),
	.axi_aresetn(axi_aresetn),
	.axis_clk(axis_clk),
	.axis_aresetn(axis_aresetn),
	.pps_clk(pps_clk),
	.samp_clk(samp_clk)
	);

axis_dsrc_rep axis_dsrc_rep (
	.S_AXI_ACLK (axi_clk),
	.AXIS_ACLK (axis_clk),
	.AXIS_ARESETN (axis_aresetn),
	.M_AXIS_TVALID (SRC_TVALID),
	.M_AXIS_TDATA (SRC_TDATA),
	.M_AXIS_TREADY (SRC_TREADY),
	.M_AXIS_TLAST  (SRC_TLAST),
	.cmd(dsrc_cmd),
	.num_bytes(dsrc_num_bytes),
	.data_type (dsrc_data_type),
	.num_pkts (dsrc_num_pkts),
	.new_cmd (dsrc_new_cmd)
	);

//axis_32to64 axis_32to64 (
//	.AXIS_ACLK (axis_clk),
//    .AXIS_ARESETN (axis_aresetn),
//    .S_AXIS_TREADY (SRC_TREADY),
//    .S_AXIS_TDATA (SRC_TDATA),
//    .S_AXIS_TVALID (SRC_TVALID),
//    .S_AXIS_TLAST (0),
//	.M_AXIS_TVALID (CONV_TVALID),
//    .M_AXIS_TDATA (CONV_TDATA),
//    .M_AXIS_TLAST (CONV_TLAST),
//    .M_AXIS_TREADY (CONV_TREADY)
//    );
    
vita49_pack vita49_pack (
	.AXIS_ACLK (axis_clk),
	.AXIS_ARESETN (axis_aresetn),
	.S_AXIS_TREADY (SRC_TREADY),
	.S_AXIS_TDATA (SRC_TDATA),
	.S_AXIS_TVALID (SRC_TVALID),
	.S_AXIS_TLAST (SRC_TLAST),
	.M_AXIS_TVALID (VITA_TVALID),
	.M_AXIS_TDATA (VITA_TDATA),
	.M_AXIS_TLAST (VITA_TLAST),
	.M_AXIS_TREADY (VITA_TREADY),
	
	.ctrl (vita_ctrl),
	.status (vita_status),
	.streamID (vita_streamID),
	.pkt_size (vita_pkt_size),
	.trailer (trailer),
	
	.timestamp_sec (tsi),
	.timestamp_fsec (tsf)
	);
	

initial begin
    dsrc_cmd = 0;
    dsrc_num_bytes = 0;
    dsrc_data_type = 0;
    dsrc_num_pkts = 0;
    dsrc_new_cmd = 0;
    
    VITA_TREADY = 1;
    vita_ctrl = 0;
    vita_streamID = 0;
    vita_pkt_size = 0;
    trailer = 0;

#11000
    vita_ctrl = 'h2; // reset
    dsrc_cmd = 'h2;
    dsrc_new_cmd = 1;

#50
    vita_ctrl = 'h0; 
    dsrc_cmd = 'h0;
    dsrc_new_cmd = 0;
    
    dsrc_num_bytes = 'h400;
    dsrc_data_type = 0;
    dsrc_num_pkts = 1;
    
    vita_streamID = 'hdeadbeef;
    vita_pkt_size = 'h20;
    trailer = 'h40;
    
 #50
    dsrc_cmd = 'h1;
    dsrc_new_cmd = 1;  
    //vita_ctrl = 'h04; // passthrough
    //vita_ctrl = 'h01; // start / tsi disabled
    //vita_ctrl = 'h09; // start / trailer enabled
    vita_ctrl = 'h19; // start / trailer enabled/ tsi enabled
       
#50
    dsrc_new_cmd = 0;
     




end	
	
endmodule


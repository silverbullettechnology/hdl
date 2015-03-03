

module top_tb2();

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
wire [31:0] tsi_min = tsi -1;
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

// dsrc rep
  reg [31:0] dsrc_cmd;
  reg [31:0] dsrc_num_bytes;
  reg [31:0] dsrc_data_type;
  reg [31:0] dsrc_num_pkts;
  reg        dsrc_new_cmd;

// vita 49 unpack
  wire [31:0] OUT_TDATA;
  wire OUT_TVALID;
  wire OUT_TLAST;
  reg OUT_TREADY;
  reg [31:0] vita_unpack_ctrl;
  wire [31:0] vita_unpack_status;
  reg [31:0] vita_unpack_streamID;
  reg trig;
  
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

axis_dsrc_pkt axis_dsrc_pkt (
	.S_AXI_ACLK (axi_clk),
	.AXIS_ACLK (axis_clk),
	.AXIS_ARESETN (axis_aresetn),
	.M_AXIS_TVALID (SRC_TVALID),
	.M_AXIS_TDATA (SRC_TDATA),
	.M_AXIS_TREADY (SRC_TREADY),
	.M_AXIS_TLAST (SRC_TLAST),
	.cmd(dsrc_cmd),
	.num_bytes(dsrc_num_bytes),
	.data_type (dsrc_data_type),
	.num_pkts (dsrc_num_pkts),
	.new_cmd (dsrc_new_cmd)
	);


	
vita49_unpack vita49_unpack (
	.AXIS_ACLK (axis_clk),
	.AXIS_ARESETN (axis_aresetn),
	.S_AXIS_TREADY (SRC_TREADY),
	.S_AXIS_TDATA (SRC_TDATA),
	.S_AXIS_TVALID (SRC_TVALID),
	.S_AXIS_TLAST (SRC_TLAST),
	.M_AXIS_TVALID (OUT_TVALID),
	.M_AXIS_TDATA (OUT_TDATA),
	.M_AXIS_TLAST (OUT_TLAST),
	.M_AXIS_TREADY (OUT_TREADY),
	
    .trig (trig),
	.ctrl (vita_unpack_ctrl),
	.status (vita_unpack_status),
	.streamID (vita_unpack_streamID),

	.timestamp_sec (tsi_min),
	.timestamp_fsec (tsf)
	);	
	
initial begin
    dsrc_cmd = 0;
    dsrc_num_bytes = 0;
    dsrc_data_type = 0;
    dsrc_num_pkts = 0;
    dsrc_new_cmd = 0;
    
	vita_unpack_ctrl = 0;
	vita_unpack_streamID = 0;
	trig = 0;
	OUT_TREADY = 0;
	
#11000
    vita_unpack_ctrl = 'h2; // reset
    dsrc_cmd = 'h2;
    dsrc_new_cmd = 1;

#50
    vita_unpack_ctrl = 'h0; 
    dsrc_cmd = 'h0;
    dsrc_new_cmd = 0;
    
    dsrc_num_bytes = 140*4;//'h400;
    dsrc_data_type = 2;     //canned data
    dsrc_num_pkts = 1;
    
    vita_unpack_streamID = 'hbeef0000;
    vita_unpack_streamID = 'hfacebeef;

 #50
    dsrc_cmd = 'h1;
    dsrc_new_cmd = 1;

    //vita_unpack_ctrl = 'h4; // passthrough
    vita_unpack_ctrl = 'h1; // start
       
#50
    dsrc_new_cmd = 0;
	OUT_TREADY = 1;
     
#10000
	trig = 1;

end	
	
endmodule




module top_tb();


wire reset_n;

// Clock generator
wire axi_clk;
wire axi_aresetn;
wire axis_clk;
wire axis_aresetn;
wire pps_clk;
wire samp_clk;

reg [31:0] ctrl;
reg [31:0] tsf_sync_val_0;
reg [31:0] tsf_sync_val_1;

wire [31:0] tsi_0;
wire [31:0] tsi_1;
wire [63:0] tsf_0;
wire [63:0] tsf_1;

reg sync0;
initial begin
	forever sync0 =  #(100) pps_clk;
end
reg sync1;
initial begin
	forever sync1 =  #(200) pps_clk;
end

  
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


vita49_tsfclk_logic vita49_tsfclk_logic (
	.ARESETN (reset_n),
	.sync0(sync0),
	.sync1(sync1),
	.samp_clk_0 (samp_clk),
	.samp_clk_1 (samp_clk),
	
	.ctrl (ctrl),
	.tsf_sync_val_0 (tsf_sync_val_0),
	.tsf_sync_val_1 (tsf_sync_val_1),
	
	.tsi_0 (tsi_0),
	.tsf_0 (tsf_0),
	.tsi_1 (tsi_1),
	.tsf_1 (tsf_1)
	);
	
	
	

initial begin

    
#11000
    tsf_sync_val_0 = 'h100;
    tsf_sync_val_1 = 'h200;
	ctrl = 'h2; // reset
#50
	ctrl = 'h0;
#50
	ctrl = 'h4;
#50
	ctrl = 'h0;
#50
//	ctrl = 'h61;    // both channels 2t2r
	ctrl = 'h21;    // channel 0 2t2r
	
#1000
	ctrl = 'hA1;    // HW sync enable, channel 0 2t2r


#5000
	ctrl = 'h1A1;    // HW sync OR enable, channel 0 2t2r
	
	
end	


endmodule


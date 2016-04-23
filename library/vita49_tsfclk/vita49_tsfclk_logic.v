
module vita49_tsfclk_logic
(
  input wire ARESETN,
  input wire samp_clk_0,
  input wire samp_clk_1,
   input wire sync0,
  input wire sync1,

  // from procesor 
  input wire [31:0] ctrl,
  output wire [31:0] status,
  
  input wire [31:0] tsf_sync_val_0,
  input wire [31:0] tsf_sync_val_1,
  
  output wire [31:0] tsi_0_up,
  output wire [31:0] tsf_0_hi_up,
  output wire [31:0] tsf_0_lo_up,
  output wire [31:0] tsi_1_up,
  output wire [31:0] tsf_1_hi_up,
  output wire [31:0] tsf_1_lo_up,
  
  // from timing unit
  output wire [31:0] tsi_0,
  output wire [31:0] tsi_1,
  output wire [63:0] tsf_0,
  output wire [63:0] tsf_1
 );

 

// control signals
reg reset_cmd_0;
reg en_cmd_0;
reg zero_tsf_cmd_0;
reg samp_mode_0;
reg sync_en_cmd_0;
reg sync_or_cmd_0;

always @ (posedge samp_clk_0)
begin
	en_cmd_0 <= ctrl[0];
	reset_cmd_0 <= ctrl[1];
	zero_tsf_cmd_0 <= ctrl[3];
	samp_mode_0 <= ctrl[5];
	sync_en_cmd_0 <= ctrl[7];
	sync_or_cmd_0 <= ctrl[8];
end 

reg reset_cmd_1;
reg en_cmd_1;
reg zero_tsf_cmd_1;
reg samp_mode_1;
reg sync_en_cmd_1;
reg sync_or_cmd_1;

always @ (posedge samp_clk_1)
begin
	en_cmd_1 <= ctrl[0];
	reset_cmd_1 <= ctrl[1];
	zero_tsf_cmd_1 <= ctrl[4];
	samp_mode_1 <= ctrl[6];
	sync_en_cmd_1 <= ctrl[7];
	sync_or_cmd_1 <= ctrl[8];
end 

wire sync0_s;
wire sync1_s;

assign sync0_s = (sync_or_cmd_0)?  (sync0 | sync1) : sync0;
assign sync1_s = (sync_or_cmd_1)? (sync0 | sync1) : sync1;

reg sync0_r, sync0_rr;
reg [63:0] tsf_0_reg, tsf_0_upreg;
reg reset_0, set_tsi_0, en_0;

 always @ (posedge samp_clk_0)
 begin
 	sync0_r <= sync0_s;
	sync0_rr <= sync0_r;
	reset_0 <= 0;
	en_0 <= 0;
	tsf_0_upreg <= tsf_0_reg;
	if (reset_cmd_0) begin
		tsf_0_reg <= 0;
		reset_0 <= 1;
	end
	else if (zero_tsf_cmd_0) begin
		tsf_0_reg <= (zero_tsf_cmd_0)? 0 : tsf_0_reg;
	end
	else if (en_cmd_0) begin
		en_0 <= 1;
		if (sync_en_cmd_0)
			tsf_0_reg <= (sync0_r & ~sync0_rr)?  {32'h0, tsf_sync_val_0}: tsf_0_reg+1;	
		else
			tsf_0_reg <=  tsf_0_reg+1;		
	end
end

reg sync1_r, sync1_rr;
reg [63:0] tsf_1_reg, tsf_1_upreg;
reg reset_1, set_tsi_1, en_1;

 always @ (posedge samp_clk_1)
 begin
 	sync1_r <= sync1_s;
	sync1_rr <= sync1_r; 
	reset_1 <= 0;
	en_1 <= 0;
    tsf_1_upreg <= tsf_1_reg;
	if (reset_cmd_1) begin
		tsf_1_reg <= 0;
		reset_1 <= 1;
	end
	else if ( zero_tsf_cmd_1) begin
		tsf_1_reg <= (zero_tsf_cmd_1)? 0 : tsf_1_reg;
	end
	else if (en_cmd_1) begin
		en_1 <= 1;
		if (sync_en_cmd_1)
			tsf_1_reg <= (sync1_r & ~sync1_rr)?  {32'h0, tsf_sync_val_1}: tsf_1_reg+1;	
		else
			tsf_1_reg <=  tsf_1_reg+1;		
	end
end

assign status = {26'h0, reset_1, set_tsi_1, en_1, reset_0, set_tsi_0, en_0};
 
assign tsi_0_up =  32'h0;
assign tsf_0_hi_up = (samp_mode_0)? {'h0, tsf_0_upreg[63:34]} : {'h0, tsf_0_upreg[63:33]};
assign tsf_0_lo_up = (samp_mode_0)? tsf_0_upreg[33:2]         : tsf_0_upreg[32:1];

assign tsi_1_up =  32'h0;
assign tsf_1_hi_up = (samp_mode_1)? {'h0, tsf_1_upreg[63:34]} : {'h0, tsf_1_upreg[63:33]};
assign tsf_1_lo_up = (samp_mode_1)? tsf_1_upreg[33:2]         : tsf_1_upreg[32:1];

assign tsi_0 =  32'h0;
assign tsf_0 = (samp_mode_0)? {'h0, tsf_0_upreg[63:2]} : {'h0, tsf_0_upreg[63:1]};

assign tsi_1 =  32'h0;
assign tsf_1 = (samp_mode_1)? {'h0, tsf_1_upreg[63:2]} : {'h0, tsf_1_upreg[63:1]};


endmodule

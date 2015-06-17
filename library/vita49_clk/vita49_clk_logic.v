
module vita49_clk_logic
(
  input wire ARESETN,
  input wire pps_clk,
  input wire samp_clk_0,
  input wire samp_clk_1,
 
  // from procesor 
  input wire [31:0] ctrl,
  output wire [31:0] status,
  input wire [31:0] tsi_prog,
  
  input wire [31:0] tsf_0_rollover,
  input wire [31:0] tsf_1_rollover,
  
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
reg set_tsi_cmd_0;
reg reset_cmd_0;
reg en_cmd_0;
reg zero_tsf_cmd_0;
reg samp_mode_0;

reg [31:0] tsi_prog_0;
reg [31:0] tsf_0_rollover_reg;

 always @ (posedge samp_clk_0)
 begin
	en_cmd_0 <= ctrl[0];
	reset_cmd_0 <= ctrl[1];
	set_tsi_cmd_0 <= ctrl[2];
	zero_tsf_cmd_0 <= ctrl[3];
	samp_mode_0 <= ctrl[5];
	tsi_prog_0 <= tsi_prog;
	tsf_0_rollover_reg <= tsf_0_rollover;
end 

reg set_tsi_cmd_1;
reg reset_cmd_1;
reg en_cmd_1;
reg zero_tsf_cmd_1;
reg samp_mode_1;

reg [31:0] tsi_prog_1;
reg [31:0] tsf_1_rollover_reg;

 always @ (posedge samp_clk_1)
 begin
	en_cmd_1 <= ctrl[0];
	reset_cmd_1 <= ctrl[1];
	set_tsi_cmd_1 <= ctrl[2];
	zero_tsf_cmd_1 <= ctrl[4];
	samp_mode_1 <= ctrl[6];
	tsi_prog_1 <= tsi_prog;
	tsf_1_rollover_reg <= tsf_1_rollover;
end 



 
reg pps_clk0_0, pps_clk1_0;
reg [31:0] tsi_0_reg, tsi_0_upreg;
reg [63:0] tsf_0_reg, tsf_0_upreg;
reg reset_0, set_tsi_0, en_0;

wire [33:0] roll_0_shf;
assign roll_0_shf = (samp_mode_0)? {tsf_0_rollover_reg, 2'b11} :  {tsf_0_rollover_reg, 1'b1};

 always @ (posedge samp_clk_0)
 begin
	pps_clk0_0 <= pps_clk;
	pps_clk1_0 <= pps_clk0_0;
	reset_0 <= 0;
	set_tsi_0 <= 0;
	en_0 <= 0;
	tsi_0_upreg <= tsi_0_reg;
	tsf_0_upreg <= tsf_0_reg;
	if (reset_cmd_0) begin
		tsi_0_reg <= 0;
		tsf_0_reg <= 0;
		reset_0 <= 1;
	end
	else if (set_tsi_cmd_0 | zero_tsf_cmd_0) begin
		tsi_0_reg <= (set_tsi_cmd_0) ? tsi_prog_0 : tsi_0_reg;
		tsf_0_reg <= (zero_tsf_cmd_0)? 0 : tsf_0_reg;
		set_tsi_0 <= (set_tsi_cmd_0) ? 1 : 0;
	end
	else if (en_cmd_0) begin
//		tsi_0_reg <= (pps_clk0_0 & ~pps_clk1_0)? tsi_0_reg+1: tsi_0_reg;
//      tsf_0_reg <= (pps_clk0_0 & ~pps_clk1_0)? 0: tsf_0_reg+1;
		tsi_0_reg <= (tsf_0_reg == roll_0_shf)? tsi_0_reg+1: tsi_0_reg;
        tsf_0_reg <= (tsf_0_reg == roll_0_shf)? 0: tsf_0_reg+1;
		en_0 <= 1;
	end
end

reg pps_clk0_1, pps_clk1_1;
reg [31:0] tsi_1_reg, tsi_1_upreg;
reg [63:0] tsf_1_reg, tsf_1_upreg;
reg reset_1, set_tsi_1, en_1;

wire [33:0] roll_1_shf;
assign roll_1_shf = (samp_mode_1)? {tsf_1_rollover_reg, 2'b11} :  {tsf_1_rollover_reg, 1'b1};

 always @ (posedge samp_clk_1)
 begin
	pps_clk0_1 <= pps_clk;
	pps_clk1_1 <= pps_clk0_1;
	reset_1 <= 0;
	set_tsi_1 <= 0;
	en_1 <= 0;
	tsi_1_upreg <= tsi_1_reg;
    tsf_1_upreg <= tsf_1_reg;
	if (reset_cmd_1) begin
		tsi_1_reg <= 0;
		tsf_1_reg <= 0;
		reset_1 <= 1;
	end
	else if (set_tsi_cmd_1 | zero_tsf_cmd_1) begin
		tsi_1_reg <= (set_tsi_cmd_1) ? tsi_prog_1 : tsi_1_reg;
		tsf_1_reg <= (zero_tsf_cmd_1)? 0 : tsf_1_reg;
		set_tsi_1 <= (set_tsi_cmd_1) ? 1 : 0;
	end
	else if (en_cmd_1) begin
//		tsi_1_reg <= (pps_clk0_1 & ~pps_clk1_1)? tsi_1_reg+1: tsi_1_reg;
//        tsf_1_reg <= (pps_clk0_1 & ~pps_clk1_1)? 0: tsf_1_reg+1;
		tsi_1_reg <= (tsf_1_reg == roll_1_shf)? tsi_1_reg+1: tsi_1_reg;
        tsf_1_reg <= (tsf_1_reg == roll_1_shf)? 0: tsf_1_reg+1;
		en_1 <= 1;
	end
end

assign status = {26'h0, reset_1, set_tsi_1, en_1, reset_0, set_tsi_0, en_0};
 
assign tsi_0_up = tsi_0_upreg;
assign tsf_0_hi_up = (samp_mode_0)? {'h0, tsf_0_upreg[63:34]} : {'h0, tsf_0_upreg[63:33]};
assign tsf_0_lo_up = (samp_mode_0)? tsf_0_upreg[33:2]         : tsf_0_upreg[32:1];

assign tsi_1_up = tsi_1_upreg;
assign tsf_1_hi_up = (samp_mode_1)? {'h0, tsf_1_upreg[63:34]} : {'h0, tsf_1_upreg[63:33]};
assign tsf_1_lo_up = (samp_mode_1)? tsf_1_upreg[33:2]         : tsf_1_upreg[32:1];

assign tsi_0 = tsi_0_upreg;
assign tsf_0 = (samp_mode_0)? {'h0, tsf_0_upreg[63:2]} : {'h0, tsf_0_upreg[63:1]};

assign tsi_1 = tsi_1_upreg;
assign tsf_1 = (samp_mode_1)? {'h0, tsf_1_upreg[63:2]} : {'h0, tsf_1_upreg[63:1]};


endmodule

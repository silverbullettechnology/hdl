
module vita49_trig64_logic
(
  input wire AXIS_ACLK,
  input wire AXIS_ARESETN,
  
  output wire S_AXIS_TREADY,
  input wire [(C_AXIS_TDATA_NUM_BYTES*8)-1:0] S_AXIS_TDATA,
  input wire [C_AXIS_TDATA_NUM_BYTES-1:0] S_AXIS_TSTRB,
  input wire S_AXIS_TLAST,
  input wire S_AXIS_TVALID,
 
  output wire M_AXIS_TVALID,
  output wire [(C_AXIS_TDATA_NUM_BYTES*8)-1:0] M_AXIS_TDATA,
  output wire [C_AXIS_TDATA_NUM_BYTES-1:0] M_AXIS_TSTRB,
  output wire M_AXIS_TLAST,
  input wire M_AXIS_TREADY,
 
  // from procesor 
  input wire [31:0] ctrl,
  output wire [31:0] status,
  
  input wire [31:0] tsi_trig_up,
  input wire [31:0] tsf_hi_trig_up,
  input wire [31:0] tsf_lo_trig_up,
  
  // from timing unit
  input wire [31:0] tsi,
  input wire [63:0] tsf,
  output reg trig,
 
  output [31:0] dbg_ctrl,
  output [31:0] dbg_tsi_on,
  output [31:0] dbg_tsi_off,
  output [1:0] dbg_match_on,
  output [1:0] dbg_match_off
  );

parameter integer C_AXIS_TDATA_NUM_BYTES = 4;
 
reg [31:0] ctrl_reg;
reg [31:0] tsi_trig_up_reg;
reg [31:0] tsf_hi_trig_up_reg;
reg [31:0] tsf_lo_trig_up_reg;

reg [31:0] tsi_reg_0;
reg [63:0] tsf_reg_0;
  
reg [31:0] tsi_reg;
reg [63:0] tsf_reg; 
always @ (posedge AXIS_ACLK)
begin
	ctrl_reg <= ctrl;
	tsi_reg_0 <= tsi;
	tsf_reg_0 <= tsf;
	tsi_reg <= tsi_reg_0;
	tsf_reg <= tsf_reg_0;
	tsi_trig_up_reg <= tsi_trig_up;
	tsf_hi_trig_up_reg <= tsf_hi_trig_up;
	tsf_lo_trig_up_reg <= tsf_lo_trig_up;
end

// control signals
wire passthrough_cmd;
wire set_trig_cmd;
wire en_cmd;
wire reset_cmd;

assign en_cmd = ctrl_reg[0];
assign reset_cmd = ctrl_reg[1]; 
assign set_trig_on_cmd = ctrl_reg[2];
assign set_trig_off_cmd = ctrl_reg[3];
assign passthrough_cmd = ctrl_reg[4];

reg [31:0] tsi_trig_on;
reg [63:0] tsf_trig_on; 
reg [31:0] tsi_trig_off;
reg [63:0] tsf_trig_off; 


reg match_on_reg;
reg tsi_on_ovr_reg;
reg tsi_on_eq_reg;
wire [63:0] tsf_on_comp;
wire tsf_on_match;

sub_64 sub_tsf_on
(
    .A(tsf_reg),
    .B(tsf_trig_on),
    .CLK(AXIS_ACLK),
    .S(tsf_on_comp)
);

assign tsf_on_match = (tsf_on_comp[63] == 0);
wire match_on = 
     tsi_on_ovr_reg |
     (tsi_on_eq_reg & tsf_on_match);    
//	(tsi_reg > tsi_trig_on) |
//	((tsi_reg == tsi_trig_on) &  (tsf_reg >= tsf_trig_on));


reg match_off_reg;
reg tsi_off_ovr_reg;
reg tsi_off_eq_reg;
wire [63:0] tsf_off_comp;
wire tsf_off_match;

sub_64 sub_tsf_off
(
    .A(tsf_reg),
    .B(tsf_trig_off),
    .CLK(AXIS_ACLK),
    .S(tsf_off_comp)
);


assign tsf_off_match = (tsf_off_comp[63] == 0);
wire match_off =
     tsi_off_ovr_reg |
     (tsi_off_eq_reg & tsf_off_match);    
//	(tsi_reg > tsi_trig_off) |
//	((tsi_reg == tsi_trig_off) &  (tsf_reg >= tsf_trig_off));




assign M_AXIS_TDATA  = S_AXIS_TDATA;
assign M_AXIS_TSTRB  = S_AXIS_TSTRB;
assign M_AXIS_TLAST  = S_AXIS_TLAST;
assign M_AXIS_TVALID = (passthrough_cmd | match_on_reg)? S_AXIS_TVALID : 0;
assign S_AXIS_TREADY = (passthrough_cmd | match_on_reg)? M_AXIS_TREADY: 0; 

always @ (posedge AXIS_ACLK)
begin
   if (reset_cmd | (AXIS_ARESETN == 1'b0))
   begin  
     trig <= 0;
	 tsi_trig_on <= 32'hffffffff;
	 tsf_trig_on <= 64'h0; 	 
	 tsi_trig_off <= 32'hffffffff;
	 tsf_trig_off <= 64'h0;
	 match_on_reg <= 0;
	 tsi_on_ovr_reg <= 0;
     tsi_on_eq_reg <= 0;
	 match_off_reg <= 0; 	 
	 tsi_off_ovr_reg <= 0;
     tsi_off_eq_reg <= 0;
   end
   else begin
     match_on_reg <= match_on;
	 tsi_on_ovr_reg <= (tsi_reg > tsi_trig_on);
     tsi_on_eq_reg <= (tsi_reg == tsi_trig_on);
     match_off_reg <= match_off;
     tsi_off_ovr_reg <= (tsi_reg > tsi_trig_off);
     tsi_off_eq_reg <=  (tsi_reg == tsi_trig_off);
   end
   
   if (set_trig_on_cmd) begin
	 tsi_trig_on <= tsi_trig_up_reg;
	 tsf_trig_on <= {tsf_hi_trig_up_reg, tsf_lo_trig_up_reg}; 
   end
   if (set_trig_off_cmd) begin
	 tsi_trig_off <= tsi_trig_up_reg;
	 tsf_trig_off <= {tsf_hi_trig_up_reg, tsf_lo_trig_up_reg}; 
   end
   if (passthrough_cmd) trig <= 1;
   else begin
     if (en_cmd) begin
		trig <= (match_off_reg)? 0 : 
		        (match_on_reg) ? 1 : 0;
	 end
   end
end
 
 assign dbg_ctrl = ctrl_reg;
 assign dbg_tsi_on = tsi_trig_on;
 assign dbg_tsi_off = tsi_trig_off;
 assign dbg_match_on = {match_on_reg, match_on};
 assign dbg_match_off = {match_off_reg, match_off};

endmodule

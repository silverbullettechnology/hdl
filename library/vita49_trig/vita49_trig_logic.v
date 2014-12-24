
module vita49_trig_logic
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
  output reg trig
 );

parameter integer C_AXIS_TDATA_NUM_BYTES = 4;
 
// control signals
wire passthrough_cmd;
wire set_trig_cmd;
wire en_cmd;
wire reset_cmd;

assign en_cmd = ctrl[0];
assign reset_cmd = ctrl[1]; 
assign set_trig_cmd = ctrl[2];
assign passthrough_cmd = ctrl[3];
 
//reg trig;
reg [31:0] tsi_trig;
reg [63:0] tsf_trig; 

wire tsi_match = (tsi >= tsi_trig)? 1:0;
wire tsf_match = (tsf >= tsf_trig)? 1:0;

assign M_AXIS_TDATA  = S_AXIS_TDATA;
assign M_AXIS_TSTRB  = S_AXIS_TSTRB;
assign M_AXIS_TLAST  = S_AXIS_TLAST;
assign M_AXIS_TVALID = (trig)? S_AXIS_TVALID : 0;
assign S_AXIS_TREADY = (trig)? M_AXIS_TREADY: 0; 

always @ (posedge AXIS_ACLK)
begin
   if (reset_cmd | (AXIS_ARESETN == 1'b0))
   begin  
     trig <= 0;
	 tsi_trig <= 31'hffffffff;
	 tsf_trig <= 64'h0; 	 
   end
   if (passthrough_cmd) trig <= 1;
   else begin
     if (en_cmd) begin
		trig <= (tsi_match & tsf_match);
	 end
	 if (set_trig_cmd) begin
		tsi_trig <= tsi_trig_up;
		tsf_trig <= {tsf_hi_trig_up, tsf_lo_trig_up}; 
	 end
   end
end
 

endmodule

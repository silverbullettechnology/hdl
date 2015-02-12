// looks at the header of a vita packet and generates TDEST value based on streamID field
// TLAST is also generated based on Vita packet size as stated in the header

module vita49_router_logic
(
  input wire AXIS_ACLK,
  input wire AXIS_ARESETN,
  
  output wire S_AXIS_TREADY,
  input wire [63:0] S_AXIS_TDATA,
  input wire S_AXIS_TLAST,
  input wire S_AXIS_TVALID,
 
  output wire M_AXIS_TVALID,
  output wire [63:0] M_AXIS_TDATA,
  output wire [7:0] M_AXIS_TSTRB,
  output wire M_AXIS_TLAST,
  output wire [1:0] M_AXIS_TDEST,
  input wire M_AXIS_TREADY,
  
  input wire [31:0] cmd,
  input wire [31:0] strmID_0,
  input wire [31:0] strmID_1
);


assign start_cmd = cmd[0];
assign reset_cmd = cmd[1]; 

wire m_xfr;    // master data transferred
wire s_xfr;    // slave data transferred
wire d_xfr, dval, drdy;
assign m_xfr = M_AXIS_TREADY & M_AXIS_TVALID;
assign s_xfr = S_AXIS_TREADY & S_AXIS_TVALID;
assign d_xfr = dval & drdy;

// SLAVE SIDE STATE MACHINE
localparam
  S_S0 = 1'b0,
  S_S1 = 1'b1;

reg Sstate;
reg [63:0] tdata_reg;
reg tlast_reg;

assign dval          = (Sstate == S_S1)? 1 : 0;
assign S_AXIS_TREADY = (Sstate == S_S0)? 1 : d_xfr;

always @ (posedge AXIS_ACLK)
begin
	if ( AXIS_ARESETN == 1'b0)
	begin
		Sstate <= S_S0;
		tdata_reg <= 64'h0;
		tlast_reg <= 1'b0;
	end
	else begin   
 	  case(Sstate)
 	    S_S0: begin
			tdata_reg <= (s_xfr)? S_AXIS_TDATA : tdata_reg;
			tlast_reg <= (s_xfr)? S_AXIS_TLAST : tlast_reg;
			Sstate    <= (s_xfr)? S_S1 : S_S0;
 		end
	    S_S1: begin
			tdata_reg <= (s_xfr)? S_AXIS_TDATA : tdata_reg;
			tlast_reg <= (s_xfr)? S_AXIS_TLAST : tlast_reg;
			if (d_xfr)
				Sstate     <= (s_xfr)? S_S1 : S_S0;
			else
				Sstate     <= S_S1;
  		end
 	  endcase
	end
 end
 
 
 
 
 // MASTER SIDE STATE MACHINE
localparam
  M_INIT           = 4'h0,
  M_CHK_HDR        = 4'h1,
  M_SEND_PAYLOAD   = 4'h2;

reg [3:0]  Mstate;

reg [15:0] payload_cnt;
reg [15:0] header_err;
reg [15:0] strmID_err; 
reg [3:0] tdest_reg;
 
// header
wire [3:0] pkt_type  = tdata_reg[31:28];
wire       c         = tdata_reg[27];       
wire       t         = tdata_reg[26];           
wire [1:0] tsi       = tdata_reg[23:22]; 
wire [1:0] tsf       = tdata_reg[21:20]; 
wire [3:0] pkt_cnt   = tdata_reg[19:16]; 
wire [15:0] pkt_size = tdata_reg[15:0];  reg [15:0] pkt_size_reg;
wire [31:0] strmID   = tdata_reg[63:32];

wire [3:0] tdest = 
	(strmID == strmID_0)? 0 :
	(strmID == strmID_1)? 1 : 'hf;

assign M_AXIS_TLAST = 
	((Mstate == M_SEND_PAYLOAD) & (payload_cnt+2 >= pkt_size_reg))? 1:0;

assign M_AXIS_TDATA = tdata_reg;

assign M_AXIS_TDEST = 
	(Mstate == M_CHK_HDR) ? tdest: tdest_reg;

assign M_AXIS_TSTRB =
	((Mstate == M_SEND_PAYLOAD) & (payload_cnt + 2 > pkt_size_reg))? 8'h0f : 8'hff;
	
assign M_AXIS_TVALID =
	((Mstate == M_CHK_HDR) & (pkt_type == 4'b0001)) ? dval:
	((Mstate == M_SEND_PAYLOAD) ) ? dval : 0;

assign drdy =
	(Mstate == M_INIT)          				   ? 0 :
	((Mstate == M_CHK_HDR) & (pkt_type == 4'b0001))? m_xfr :
	(Mstate == M_SEND_PAYLOAD)                     ? m_xfr : 0;

	
	
always @ (posedge AXIS_ACLK)
begin
	if ( AXIS_ARESETN == 1'b0)
	begin
		Mstate      <= M_INIT;
		header_err <= 0;
		strmID_err <= 0;
		payload_cnt <= 16'h0;
	end
	else begin   
	  if (reset_cmd) Mstate <= M_INIT;
 	  case(Mstate)
 	    M_INIT: begin
			header_err <= 0;
			strmID_err <= 0;
			payload_cnt <= 16'h0;
			tdest_reg <= 0;
			Mstate      <= (start_cmd)? M_CHK_HDR : Mstate;
 		end
	    M_CHK_HDR: begin
			payload_cnt  <= (d_xfr)? payload_cnt+2 : payload_cnt;
			pkt_size_reg <= (d_xfr)? pkt_size : pkt_size_reg;		
			tdest_reg <= (d_xfr)? tdest : tdest_reg;
			if (d_xfr)
			begin
				Mstate <= M_SEND_PAYLOAD; // default next state
				if (pkt_type != 4'b0001) begin
					header_err <= header_err + 1;
					Mstate <= M_CHK_HDR;
				end
				if (tdest == 'hf) begin
					strmID_err <= strmID_err + 1;
					tdest_reg <= tdest;
				end
			end
  		end

 	    M_SEND_PAYLOAD: begin
			if (payload_cnt+2 < pkt_size_reg) 
			begin
				payload_cnt <= (m_xfr)? payload_cnt+2 : payload_cnt;
				Mstate      <= (m_xfr)? M_SEND_PAYLOAD : Mstate;				
			end
			if (payload_cnt + 2 > pkt_size_reg)
			begin
				payload_cnt <= (m_xfr)? 0 : payload_cnt;
				Mstate      <= (m_xfr)? M_CHK_HDR : Mstate;				
			end
			if (payload_cnt + 2 == pkt_size_reg)
			begin
				payload_cnt <= (m_xfr)? 0 : payload_cnt;
				Mstate      <= (m_xfr)? M_CHK_HDR : Mstate;				
			end
 		end
 	  endcase
	end
end
 
endmodule
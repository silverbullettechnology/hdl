module srio_swrite_pack_logic
(
  input wire AXIS_ACLK,
  input wire AXIS_ARESETN,
  
  output wire S_AXIS_TREADY,
  input wire [63:0] S_AXIS_TDATA,
  input wire S_AXIS_TLAST,
  input wire S_AXIS_TVALID,
 
  output wire M_AXIS_TVALID,
  output wire [63:0] M_AXIS_TDATA,
  output wire M_AXIS_TLAST,
  output wire [31:0] M_AXIS_TUSER,
  input wire M_AXIS_TREADY,
 
  input wire [31:0] cmd,
  input wire [31:0] addr,
  input wire [31:0] srcdest
  );

localparam max_payload_size = 32; // number of 64bit words

reg [6:0] payload_cnt;
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
reg        tlast_reg;

assign dval          = (Sstate == S_S1)? 1 : 0;
assign S_AXIS_TREADY = (Sstate == S_S0)? 1 : d_xfr;

always @ (posedge AXIS_ACLK)
begin
	if ( AXIS_ARESETN == 1'b0)
	begin
		Sstate <= S_S0;
		tdata_reg <= 64'h0;
		tlast_reg <= 0;
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
  M_INIT         = 4'h0,
  M_SEND_HDR     = 4'h1,
  M_SEND_PAYLOAD = 4'h2;

 reg [3:0]  Mstate;
 
localparam
  PKT_TYPE = 4'b0110,      // Type 6 packet
  PRIO     = 2'b00,        // packet priority
  CRF      = 1'b0;         // critical request flow
  
wire [63:0] header;
assign header = {8'h0, PKT_TYPE, 4'h0, 1'h0, PRIO, CRF, 8'h0, 4'h0, addr};

 
assign M_AXIS_TUSER = srcdest;

assign M_AXIS_TLAST = 	
    ((Mstate == M_SEND_PAYLOAD) & (payload_cnt+1 == max_payload_size))? 1:
    ((Mstate == M_SEND_PAYLOAD))? tlast_reg:0;

assign M_AXIS_TDATA =
	(Mstate == M_SEND_HDR)     ? header :
	(Mstate == M_SEND_PAYLOAD) ? tdata_reg : 0;

assign M_AXIS_TVALID =
	(Mstate == M_SEND_HDR)     ? dval :
	(Mstate == M_SEND_PAYLOAD) ? dval : 0;

assign drdy =
	(Mstate == M_SEND_PAYLOAD) ? m_xfr : 0;

 
always @ (posedge AXIS_ACLK)
begin
	if ( AXIS_ARESETN == 1'b0)
	begin
		Mstate      <= M_INIT;
		payload_cnt <= 16'h0;
	end
	else begin   
	  if (reset_cmd) Mstate <= M_INIT;
 	  case(Mstate)
 	    M_INIT: begin
			payload_cnt <= 16'h0;
			Mstate      <= (start_cmd)? M_SEND_HDR : Mstate;
 		end
	    M_SEND_HDR: begin
			Mstate    <= (m_xfr)? M_SEND_PAYLOAD : Mstate;	   
		end	
 	    M_SEND_PAYLOAD: begin
			if ((payload_cnt+1 == max_payload_size) || (tlast_reg))
			begin
				payload_cnt <= (m_xfr)? 0 : payload_cnt;
				Mstate <= (m_xfr)? M_SEND_HDR : Mstate;
			end
			else
			begin
				payload_cnt <= (m_xfr)? payload_cnt+1 : payload_cnt;
				Mstate      <= (m_xfr)? M_SEND_PAYLOAD : Mstate;	   
			end
 		end
 	  endcase
	end
end

endmodule
 
// Takes SRIO Ftype 6 packets (SWRITE) removes the header and transfers the payload
// TDEST is generated based on address field of SRIO HELLO header
// SRIO address refers to ad9361 branch in TD-SRD board and may or may not be the same as the VITA stream ID value


module srio_swrite_unpack_logic
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
//  output wire M_AXIS_TUSER,
  output wire [3:0] M_AXIS_TDEST,
  input wire M_AXIS_TREADY,
 
  input wire [31:0] cmd,
  input wire [31:0] addr_0,
  input wire [31:0] addr_1
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
  M_INIT           = 4'h0,
  M_CHK_HDR        = 4'h1,
  M_SEND_PAYLOAD   = 4'h2;

  reg [3:0]  Mstate;
  reg [3:0] tdest_reg;
 
wire [31:0] srio_addr = tdata_reg[31:0];  
  
assign M_AXIS_TLAST = tlast_reg;

assign M_AXIS_TDATA = tdata_reg;

assign M_AXIS_TDEST = tdest_reg;

assign M_AXIS_TVALID = 
	(Mstate == M_SEND_PAYLOAD) ? dval : 0;

assign drdy =
	(Mstate == M_INIT)           ? 0 :
	(Mstate == M_CHK_HDR)        ? dval :
	(Mstate == M_SEND_PAYLOAD)   ? m_xfr : 0;

always @ (posedge AXIS_ACLK)
begin
	if ( AXIS_ARESETN == 1'b0)
	begin
		Mstate      <= M_INIT;
		tdest_reg   <= 0;
	end
	else begin   
	  if (reset_cmd) Mstate <= M_INIT;
 	  case(Mstate)
 	    M_INIT: begin
			tdest_reg   <= 0;
			Mstate      <= (start_cmd)? M_CHK_HDR : Mstate;
 		end
	    M_CHK_HDR: begin
			tdest_reg <= 	(srio_addr == addr_0)? 0:
							(srio_addr == addr_1)? 1: 'hf;
			if (d_xfr)
			begin
				Mstate <= M_SEND_PAYLOAD; // default next state
			end
  		end
 		
 	    M_SEND_PAYLOAD: begin
			if (tlast_reg) 
				Mstate      <= (m_xfr)? M_CHK_HDR : Mstate;				
			else
				Mstate      <= (m_xfr)? M_SEND_PAYLOAD : Mstate;				
 		end

 	  endcase
	end
end


endmodule	
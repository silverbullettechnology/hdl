// Takes SRIO Ftype 9 (streaming) packets removes the header and transfers the payload
// TDEST is generated based on streamID (16bit) field of SRIO HELLO header
// SRIO streamID refers to ad9361 branch in TD-SRD board and may or may not be the same as the VITA streamID (32bit) value


module srio_type9_dmacomb
(
  input wire AXIS_ACLK,
  input wire AXIS_ARESETN,
  
  output wire S_AXIS_TREADY,
  input wire [63:0] S_AXIS_TDATA,
  input wire S_AXIS_TLAST,
  input wire S_AXIS_TVALID,
  input wire [31:0] S_AXIS_TUSER,
 
  output wire M_AXIS_TVALID,
  output wire [63:0] M_AXIS_TDATA,
  output wire M_AXIS_TLAST,
  input wire M_AXIS_TREADY,
  output wire [31:0] M_AXIS_TUSER

  );


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
reg [31:0] tuser_reg;

assign dval          = (Sstate == S_S1)? 1 : 0;
assign S_AXIS_TREADY = (Sstate == S_S0)? 1 : d_xfr;

always @ (posedge AXIS_ACLK)
begin
	if (AXIS_ARESETN == 1'b0)
	begin
		Sstate <= S_S0;
		tdata_reg <= 64'h0;
		tlast_reg <= 0;
		tuser_reg <= 0;
	end
	else begin   
 	  case(Sstate)
 	    S_S0: begin
			tdata_reg <= (s_xfr)? S_AXIS_TDATA : tdata_reg;
			tlast_reg <= (s_xfr)? S_AXIS_TLAST : tlast_reg;
			tuser_reg <= (s_xfr)? S_AXIS_TUSER : tuser_reg;
			Sstate    <= (s_xfr)? S_S1 : S_S0;
 		end
	    S_S1: begin
			tdata_reg <= (s_xfr)? S_AXIS_TDATA : tdata_reg;
			tlast_reg <= (s_xfr)? S_AXIS_TLAST : tlast_reg;
			tuser_reg <= (s_xfr)? S_AXIS_TUSER : tuser_reg;
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
  M_SEND_PAYLOAD   = 4'h2,
  M_DROP_PKT       = 4'h3;

  reg [3:0]  Mstate;
  reg [3:0] tdest_reg;
  reg pdu_start;
 
wire type9_start = tdata_reg[63];
wire type9_end   = tdata_reg[62];
  
assign M_AXIS_TDATA = tdata_reg;
assign M_AXIS_TUSER = tuser_reg;
//assign M_AXIS_TLAST = tlast_reg;

assign M_AXIS_TLAST = (Mstate == M_SEND_PAYLOAD & !pdu_start) ? tlast_reg : 0;

assign M_AXIS_TVALID = 
	(Mstate == M_CHK_HDR & type9_start) ? dval :
	(Mstate == M_SEND_PAYLOAD) ? dval : 0;

assign drdy =
	(Mstate == M_INIT)                  ? 0 :
	(Mstate == M_CHK_HDR & type9_start) ? m_xfr :       // transfer header only on first packet of PDU
	(Mstate == M_CHK_HDR & !type9_start)? dval :
	(Mstate == M_DROP_PKT)              ? dval :
	(Mstate == M_SEND_PAYLOAD)          ? m_xfr : 0;

always @ (posedge AXIS_ACLK)
begin
	if ( AXIS_ARESETN == 1'b0)
	begin
		pdu_start   <= 0;
		Mstate      <= M_INIT;
	end
	else begin   
 	  case(Mstate)
 	    M_INIT: begin
			pdu_start   <= 0;
			Mstate      <= M_CHK_HDR;
 		end
	    M_CHK_HDR: begin
			if (type9_start & dval)
			begin
				pdu_start <= 1;
			end
			if (type9_end & dval)
			begin
				pdu_start <= 0;
			end
			if (d_xfr)
			begin			
				Mstate <= (pdu_start) ? M_SEND_PAYLOAD :
						  (type9_start) ? M_SEND_PAYLOAD : M_DROP_PKT;		  
			end
  		end

 
 	    M_SEND_PAYLOAD: begin
			if (tlast_reg)
			begin			
				Mstate      <= (m_xfr)? M_CHK_HDR : Mstate;				
			end
			else
				Mstate      <= (m_xfr)? M_SEND_PAYLOAD : Mstate;				
 		end
 		
 	    M_DROP_PKT: begin
			if (tlast_reg) 
				Mstate      <= (d_xfr)? M_CHK_HDR : Mstate;					
 		end
		
 	  endcase
	end
end


endmodule	
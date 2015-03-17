
module axis_64to32_strb_tuser
(
  input wire AXIS_ACLK,
  input wire AXIS_ARESETN,
  
  output wire S_AXIS_TREADY,
  input wire [63:0] S_AXIS_TDATA,
  input wire [7:0] S_AXIS_TSTRB,
  input wire S_AXIS_TLAST,
  input wire S_AXIS_TVALID,
  input wire [31:0] S_AXIS_TUSER,
  
  output wire M_AXIS_TVALID,
  output wire [31:0] M_AXIS_TDATA,
  output wire M_AXIS_TLAST,
  input wire M_AXIS_TREADY
 );


wire m_xfr;    // master data transferred
wire s_xfr;    // slave data transferred
wire d_xfr, dval, drdy;
assign m_xfr = M_AXIS_TREADY & M_AXIS_TVALID;
assign s_xfr = S_AXIS_TREADY & S_AXIS_TVALID;
assign d_xfr = dval & drdy;

// SLAVE SIDE STATE MACHINE
localparam
  S_S0    = 2'b00,    // first 64-bit word in packet
  S_TUSER = 2'b01,
  S_S1    = 2'b10,    // wait
  S_S2    = 2'b11;    // subsequent words

reg [1:0] Sstate;
reg [63:0] tdata_reg;
reg [31:0] tuser_reg;
reg [7:0] tstrb_reg;
reg tlast_reg;

assign dval =
	(Sstate == S_S0) ?   0 :
	(Sstate == S_TUSER)? 1 :
	(Sstate == S_S1) ?   0 :
	(Sstate == S_S2) ?   1 : 0;
	
assign S_AXIS_TREADY = 
	(Sstate == S_S0) ?   1 :
	(Sstate == S_TUSER)? 0 :	
	(Sstate == S_S1) ?   1 :
	(Sstate == S_S2) ?   0 : 0;

always @ (posedge AXIS_ACLK)
begin
	if ( AXIS_ARESETN == 1'b0)
	begin
		Sstate <= S_S0;
		tdata_reg <= 'h0;
		tlast_reg <= 'h0;
		tuser_reg <= 'h0;
		tstrb_reg <= 'h0;
	end
	else begin
	  case(Sstate)
		S_S0: begin
			tdata_reg <= (s_xfr)? S_AXIS_TDATA : tdata_reg;
			tlast_reg <= (s_xfr)? S_AXIS_TLAST : 0;
			tuser_reg <= (s_xfr)? S_AXIS_TUSER : 0;
			tstrb_reg <= (s_xfr)? S_AXIS_TSTRB : 0;
			Sstate     <= (s_xfr)? S_TUSER : S_S0;
		end
		S_TUSER: begin
			Sstate     <= (d_xfr)? S_S2 : S_TUSER;
		end
	    S_S1: begin
			tdata_reg <= (s_xfr)? S_AXIS_TDATA : tdata_reg;
			tlast_reg <= (s_xfr)? S_AXIS_TLAST : 0;
			tstrb_reg <= (s_xfr)? S_AXIS_TSTRB : 0;
			Sstate     <= (s_xfr)? S_S2 : S_S1;
		end
		S_S2: begin
			if (tlast_reg)
				Sstate     <= (d_xfr)? S_S0 : S_S2;
			else
				Sstate     <= (d_xfr)? S_S1 : S_S2;
		end
	  endcase
	end
end


// MASTER SIDE STATE MACHINE
localparam
  M_TUSER = 2'b10, // transmit tuser on first beat
  M_S0 = 2'b00,    // Least significant 32-bit word
  M_S1 = 2'b01;    // Most significant 32-bit word
  
reg [3:0]  Mstate;

assign no_msb = (tstrb_reg[7:4] == 'h0)? 1 : 0;
  
assign M_AXIS_TDATA  =
	(Mstate==M_TUSER)? tuser_reg :
	(Mstate==M_S0)? tdata_reg[31:0]  :
	(Mstate==M_S1)? tdata_reg[63:32] : 0;

assign M_AXIS_TLAST  = 
	(Mstate==M_TUSER)? 0 :
	(Mstate==M_S0)? (no_msb? tlast_reg : 0) :
	(Mstate==M_S1)? tlast_reg: 0;

assign M_AXIS_TVALID = dval;

assign drdy = 
	(Mstate==M_TUSER)? m_xfr: 
	(Mstate==M_S0)? ( no_msb? m_xfr : 0) :
	(Mstate==M_S1)? m_xfr: 0;

always @ (posedge AXIS_ACLK)
begin
	if ( AXIS_ARESETN == 1'b0)
	begin
		Mstate <= M_TUSER;
	end
	else begin
	  case(Mstate)
	  M_TUSER: begin
			Mstate <= (m_xfr)? M_S0 : M_TUSER;
		end
	  M_S0: begin
			if (no_msb)
				Mstate <= M_TUSER;
			else
				Mstate <= (m_xfr)? M_S1 : M_S0;
		end
	    M_S1: begin
			if (tlast_reg)
				Mstate <= (m_xfr)? M_TUSER: M_S1;
			else
				Mstate     <= (m_xfr)? M_S0 : M_S1;
		end
	  endcase
	end
end

endmodule

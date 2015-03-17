
module axis_32to64_strb_tuser
(
  input wire AXIS_ACLK,
  input wire AXIS_ARESETN,
  
  output wire S_AXIS_TREADY,
  input wire [31:0] S_AXIS_TDATA,
  input wire S_AXIS_TLAST,
  input wire S_AXIS_TVALID,
 
  output wire M_AXIS_TVALID,
  output wire [63:0] M_AXIS_TDATA,
  output wire [7:0] M_AXIS_TSTRB,
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
 
reg [31:0] tdata_reg;
reg [31:0] tuser_reg;
reg tlast_reg;

// SLAVE SIDE STATE MACHINE
localparam
  S_S0 = 2'b00,
  S_S1 = 2'b01;

reg [1:0] Sstate;

assign dval          = (Sstate == S_S1)? 1 : 0;
assign S_AXIS_TREADY = (Sstate == S_S0)? 1 : d_xfr;

always @ (posedge AXIS_ACLK)
begin
	if ( AXIS_ARESETN == 1'b0)
	begin
		Sstate <= S_S0;
		tdata_reg <= 32'h0;
		tlast_reg <= 'h0;
	end
	else begin   
 	  case(Sstate)
 	    S_S0: begin
			tdata_reg <= (s_xfr)? S_AXIS_TDATA : tdata_reg;
			tlast_reg <= (s_xfr)? S_AXIS_TLAST : tlast_reg;
			Sstate    <= (s_xfr)? S_S1 : S_S0;
 		end
	    S_S1: begin
			if (d_xfr) begin
				tdata_reg <= (s_xfr)? S_AXIS_TDATA : tdata_reg;
				tlast_reg <= (s_xfr)? S_AXIS_TLAST : tlast_reg;
				Sstate    <= (s_xfr)? S_S1 : S_S0;
			end
			else
				Sstate     <= S_S1;
  		end
 	  endcase
	end
 end
 
 
 // MASTER SIDE STATE MACHINE
localparam
  M_INIT   = 4'h0,
  M_TUSER  = 4'h1,
  M_LSB    = 4'h2,
  M_MSB    = 4'h3;

reg [3:0]  Mstate;
reg [31:0] tdata_reg1;

wire [63:0] tdata_half = {32'h0, tdata_reg};
wire [63:0] tdata_full = {tdata_reg, tdata_reg1};
 
assign M_AXIS_TDATA  =
	(Mstate == M_INIT)?  0:
	(Mstate == M_TUSER)? 0 :
	(Mstate == M_LSB)?  (tlast_reg? tdata_half: tdata_full) :
	(Mstate == M_MSB)?  tdata_full: tdata_full;
	
assign M_AXIS_TUSER  = tuser_reg;

assign M_AXIS_TSTRB  =
	(Mstate == M_INIT)?  0 :
	(Mstate == M_TUSER)? 0 :
	(Mstate == M_LSB)?   (tlast_reg? 'h0f: 'hff) :
	(Mstate == M_MSB)?   'hff: 'hff;
	
assign M_AXIS_TLAST  = tlast_reg;

assign M_AXIS_TVALID =
	(Mstate == M_INIT)?  0 :
	(Mstate == M_TUSER)? 0 :
	(Mstate == M_LSB)?  (tlast_reg? dval : 0) :
	(Mstate == M_MSB)?  dval : 0;

assign drdy =
	(Mstate == M_INIT)?  1 :
	(Mstate == M_TUSER)? 1 :
	(Mstate == M_LSB)?   (tlast_reg? m_xfr : 1) :
	(Mstate == M_MSB)?   m_xfr : 0;
  
  
always @ (posedge AXIS_ACLK)
begin
	if ( AXIS_ARESETN == 1'b0)
	begin
		tuser_reg <= 0;
		Mstate <= M_INIT;
	end
	else begin
	  case(Mstate)
	    M_INIT: begin
			tuser_reg <= (d_xfr)? tdata_reg : 0;
			if (tlast_reg) begin
				Mstate     <= (d_xfr)? M_TUSER : M_INIT;
			end
			else begin
				Mstate     <= (d_xfr)? M_LSB : Mstate;
			end
		end
		M_TUSER: begin
			tuser_reg <= (d_xfr)? tdata_reg : 0;
			if (tlast_reg) begin
				Mstate     <= (d_xfr)? M_TUSER : M_INIT;
			end
			else begin
				Mstate     <= (d_xfr)? M_LSB : Mstate;
			end
		end
		M_LSB: begin
			if (tlast_reg) begin
				Mstate     <= (m_xfr)? M_TUSER : M_LSB;
			end
			else begin
				tdata_reg1 <= (d_xfr)? tdata_reg : 0;
				Mstate     <= (d_xfr)? M_MSB : Mstate;
			end
		end
	    M_MSB: begin
			if (tlast_reg) begin
				Mstate     <= (m_xfr)? M_TUSER : M_MSB;
			end
			else begin
				Mstate     <= (m_xfr)? M_LSB : M_MSB;
			end		
		end

	  endcase
	end
end


endmodule

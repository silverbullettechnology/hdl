
module axis_reg
(
  input wire AXIS_ACLK,
  input wire AXIS_ARESETN,
  
  output wire S_AXIS_TREADY,
  input wire [63:0] S_AXIS_TDATA,
  input wire S_AXIS_TLAST,
  input wire S_AXIS_TVALID,
  input wire [7:0] S_AXIS_TKEEP,
  input wire [31:0] S_AXIS_TUSER,
 
  output wire M_AXIS_TVALID,
  output wire [63:0] M_AXIS_TDATA,
  output wire [7:0] M_AXIS_TKEEP,
  output wire M_AXIS_TLAST,
  output wire [31:0] M_AXIS_TUSER,
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
  S_S0 = 1'b0,
  S_S1 = 1'b1;

reg Sstate;
reg [63:0] tdata_reg;
reg [7:0] tkeep_reg;
reg [31:0] tuser_reg;
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
		tuser_reg <= 32'h0;
		tkeep_reg <= 8'h0;
	end
	else begin   
 	  case(Sstate)
 	    S_S0: begin
			tdata_reg <= (s_xfr)? S_AXIS_TDATA : tdata_reg;
			tlast_reg <= (s_xfr)? S_AXIS_TLAST : tlast_reg;
			tuser_reg <= (s_xfr)? S_AXIS_TUSER : tuser_reg;
			tkeep_reg <= (s_xfr)? S_AXIS_TKEEP : tkeep_reg;
			Sstate    <= (s_xfr)? S_S1 : S_S0;
 		end
	    S_S1: begin
			tdata_reg <= (s_xfr)? S_AXIS_TDATA : tdata_reg;
			tlast_reg <= (s_xfr)? S_AXIS_TLAST : tlast_reg;
			tuser_reg <= (s_xfr)? S_AXIS_TUSER : tuser_reg;
			tkeep_reg <= (s_xfr)? S_AXIS_TKEEP : tkeep_reg;
			if (d_xfr)
				Sstate     <= (s_xfr)? S_S1 : S_S0;
			else
				Sstate     <= S_S1;
  		end
 	  endcase
	end
 end
 
 // MASTER SIDE STATE MACHINE
assign M_AXIS_TLAST = tlast_reg;
assign M_AXIS_TDATA = tdata_reg;
assign M_AXIS_TKEEP = tkeep_reg;
assign M_AXIS_TUSER = tuser_reg;
assign M_AXIS_TVALID = dval;
assign drdy = m_xfr;


endmodule
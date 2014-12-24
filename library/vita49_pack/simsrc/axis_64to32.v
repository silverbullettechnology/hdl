
module axis_64to32
(
  input wire AXIS_ACLK,
  input wire AXIS_ARESETN,
  
  output wire S_AXIS_TREADY,
  input wire [63:0] S_AXIS_TDATA,
  input wire S_AXIS_TLAST,
  input wire S_AXIS_TVALID,
  input wire [31:0] S_AXIS_TUSER,
  
  output wire M_AXIS_TVALID,
  output wire [31:0] M_AXIS_TDATA,
  output wire M_AXIS_TLAST,
  input wire M_AXIS_TREADY,
  
  output wire [31:0] SRCDEST
 );

reg [63:0] tdata_reg;
reg tlast_reg;
reg [1:0] state;
reg [31:0] tuser_reg;

wire m_xfr;    // master data transferred
wire s_xfr;    // slave data transferred
assign m_xfr = M_AXIS_TREADY & M_AXIS_TVALID;
assign s_xfr = S_AXIS_TREADY & S_AXIS_TVALID;

localparam
  S0 = 2'b00,
  S1 = 2'b01,
  S2 = 2'b10;

assign M_AXIS_TDATA  = (state==S0 | state==S1)? S_AXIS_TDATA[31:0] : tdata_reg[63:32];
assign M_AXIS_TLAST  = tlast_reg;
assign S_AXIS_TREADY = (state==S0 | state==S1)? M_AXIS_TREADY : 0;
assign M_AXIS_TVALID = (state==S0 | state==S1)? S_AXIS_TVALID : 1;

assign SRCDEST = tuser_reg;

always @ (posedge AXIS_ACLK)
begin
	if ( AXIS_ARESETN == 1'b0)
	begin
		state <= S0;
		tdata_reg <= 32'h00000000;
		tlast_reg <= 1'b0;
		tuser_reg <= 32'h00000000;
	end
	else begin
	  case(state)
		S0: begin
			tdata_reg <= (s_xfr)? S_AXIS_TDATA : tdata_reg;
			tlast_reg <= (s_xfr)? S_AXIS_TLAST : 0;
			tuser_reg <= (s_xfr)? S_AXIS_TUSER : 0;
			state     <= (s_xfr)? S2 : S0;
		end
	    S1: begin
			tdata_reg <= (s_xfr)? S_AXIS_TDATA : tdata_reg;
			tlast_reg <= (s_xfr)? S_AXIS_TLAST : 0;
			state     <= (s_xfr)? S2 : S1;
		end
		S2: begin
			if (tlast_reg)
				state     <= (m_xfr)? S0 : S2;
			else
				state     <= (m_xfr)? S1 : S2;
		end
	  endcase
	end
end



endmodule

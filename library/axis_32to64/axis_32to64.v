// Assumes TLAST signal occurs only on even number of 32-bit words

module axis_32to64
(
  input wire AXIS_ACLK,
  input wire AXIS_ARESETN,
  
  output wire S_AXIS_TREADY,
  input wire [31:0] S_AXIS_TDATA,
  input wire S_AXIS_TLAST,
  input wire S_AXIS_TVALID,
 
  output wire M_AXIS_TVALID,
  output wire [63:0] M_AXIS_TDATA,
  output wire M_AXIS_TLAST,
  input wire M_AXIS_TREADY,
  output wire [31:0] M_AXIS_TUSER,
  
  input wire [31:0] SRCDEST
 );

reg [31:0] tdata_reg;
reg [31:0] tuser_reg;
reg [1:0] state;

wire m_xfr;    // master data transferred
wire s_xfr;    // slave data transferred
assign m_xfr = M_AXIS_TREADY & M_AXIS_TVALID;
assign s_xfr = S_AXIS_TREADY & S_AXIS_TVALID;

localparam
  S0 = 2'b00,
  S1 = 2'b01,
  S2 = 2'b10,
  S3 = 2'b11;

assign M_AXIS_TUSER  = tuser_reg;
assign M_AXIS_TDATA  = {S_AXIS_TDATA, tdata_reg};
assign M_AXIS_TLAST  = S_AXIS_TLAST;
assign S_AXIS_TREADY = (state==S0 | state==S2)? 1 : M_AXIS_TREADY;
assign M_AXIS_TVALID = (state==S1 | state==S3)? S_AXIS_TVALID: 0;

always @ (posedge AXIS_ACLK)
begin
	if ( AXIS_ARESETN == 1'b0)
	begin
		state <= S0;
		tdata_reg <= 32'h00000000;
		tuser_reg <= 32'h00000000;
	end
	else begin
	  case(state)
	    S0: begin
			tdata_reg <= (s_xfr)? S_AXIS_TDATA : 32'h00000000;
			tuser_reg <= (s_xfr)? SRCDEST : 32'h00000000;
			state     <= (s_xfr)? S1 : S0;
		end
		S1: begin
			//if tlast then goto S0 else goto S2
			if (S_AXIS_TLAST)
				state     <= (m_xfr)? S0 : S1;
			else
				state     <= (m_xfr)? S2 : S1;
		end
	    S2: begin
			tdata_reg <= (s_xfr)? S_AXIS_TDATA : 32'h00000000;
			state     <= (s_xfr)? S3 : S2;
		end
		S3: begin
			//if tlast then goto S0 else goto S2
			if (S_AXIS_TLAST)
				state     <= (m_xfr)? S0 : S3;
			else
				state     <= (m_xfr)? S2 : S3;
		end
	  endcase
	end
end



endmodule

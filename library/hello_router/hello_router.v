
// Reads FTYPE field in SRIO HELLO packet header
// and generates TDEST value so packets can be routed downstream

module hello_router
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
  output wire [1:0] M_AXIS_TDEST,
  output wire [31:0] M_AXIS_TUSER,
  input wire M_AXIS_TREADY,
  
  input wire [1:0] swrite_bypass,
  input wire [1:0] type9_bypass
 );
 
// 	swrite_bypass: 
//      2'b00 swrites get sent to adi chain; 
//      2'b01 swrites get sent to srio_fifo; 
//      2'b1x swrites get sent to srio_dma
 
 
wire m_xfr;    // master data transferred
wire s_xfr;    // slave data transferred
wire d_xfr, dval, drdy;
assign m_xfr = M_AXIS_TREADY & M_AXIS_TVALID;
assign s_xfr = S_AXIS_TREADY & S_AXIS_TVALID;
assign d_xfr = dval & drdy;

// SLAVE SIDE STATE MACHINE
localparam
  S_S0 = 2'h0,   // reg empty, first word
  S_S1 = 2'h1,   // reg full, payload
  S_S2 = 2'h2,   // reg empty, payload
  S_S3 = 2'h3;   // reg full, first word

reg [1:0] Sstate;
reg [63:0] tdata_reg;
reg [1:0]  tdest_reg;
reg        tlast_reg;
reg [31:0] tuser_reg;

wire [3:0] ftype = S_AXIS_TDATA[55:52];
wire [1:0] swrite_dest;
wire [1:0] type9_dest;
wire [1:0] tdest;

assign swrite_dest = 
	(swrite_bypass == 2'b00)? 2'b01 :
	(swrite_bypass == 2'b01)? 2'b00 : 2'b10;

assign type9_dest = 
	(type9_bypass == 2'b00)? 2'b01 :
	(type9_bypass == 2'b01)? 2'b00 : 2'b10;
	
assign tdest = (ftype ==4'h6)? swrite_dest : 
               (ftype ==4'h9)? type9_dest: 0;

assign dval          = ((Sstate == S_S1) | (Sstate == S_S3))? 1 : 0;
assign S_AXIS_TREADY = ((Sstate == S_S0) | (Sstate == S_S2))? 1 : d_xfr;

always @ (posedge AXIS_ACLK)
begin
	if ( AXIS_ARESETN == 1'b0)
	begin
		Sstate <= S_S0;
		tdata_reg <= 64'h0;
		tuser_reg <= 32'h0;
		tlast_reg <= 0;
		tdest_reg <= 0;
	end
	else begin   
 	  case(Sstate)
 	    S_S0: begin
			tdata_reg <= (s_xfr)? S_AXIS_TDATA : tdata_reg;
			tuser_reg <= (s_xfr)? S_AXIS_TUSER : tuser_reg;
			tlast_reg <= (s_xfr)? S_AXIS_TLAST : tlast_reg;
			tdest_reg <= (s_xfr)? tdest : tdest_reg;
			Sstate    <= (s_xfr)? (S_AXIS_TLAST? S_S3: S_S1) : S_S0;
 		end
	    S_S1: begin
			tdata_reg <= (s_xfr)? S_AXIS_TDATA : tdata_reg;
			tuser_reg <= (s_xfr)? S_AXIS_TUSER : tuser_reg;
			tlast_reg <= (s_xfr)? S_AXIS_TLAST : tlast_reg;
			if (d_xfr)
			begin
				Sstate     <= (s_xfr)? (S_AXIS_TLAST? S_S3: S_S1) : S_S2;
			end
			else
				Sstate     <= S_S1;
  		end
 	    S_S2: begin
			tdata_reg <= (s_xfr)? S_AXIS_TDATA : tdata_reg;
			tuser_reg <= (s_xfr)? S_AXIS_TUSER : tuser_reg;
			tlast_reg <= (s_xfr)? S_AXIS_TLAST : tlast_reg;
			Sstate    <= (s_xfr)? (S_AXIS_TLAST? S_S3: S_S1) : S_S2;
 		end
	    S_S3: begin
			tdata_reg <= (s_xfr)? S_AXIS_TDATA : tdata_reg;
			tuser_reg <= (s_xfr)? S_AXIS_TUSER : tuser_reg;
			tlast_reg <= (s_xfr)? S_AXIS_TLAST : tlast_reg;
			if (d_xfr)
			begin
				tdest_reg <= (s_xfr)? tdest : tdest_reg;
				Sstate     <= (s_xfr)? (S_AXIS_TLAST? S_S3: S_S1) : S_S0;
			end
			else
				Sstate     <= S_S3;
  		end
		
 	  endcase
	end
 end

 
  assign M_AXIS_TDATA =	tdata_reg;
  assign M_AXIS_TLAST = tlast_reg;
  assign M_AXIS_TDEST = tdest_reg;
  assign M_AXIS_TVALID = dval;
  assign drdy =	M_AXIS_TREADY;
  assign M_AXIS_TUSER = tuser_reg;
  
endmodule

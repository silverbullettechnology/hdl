
module adi_dma_split_logic
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
  input wire M_AXIS_TREADY,

  input wire [31:0] cmd,  
  output wire [31:0] status,
  input wire [31:0] num_pkts,
  input wire [31:0] pkt_size // number of 64bit words  
  );

//localparam max_swrite_size = 32; // number of 64bit words

assign en_cmd = cmd[0];
assign reset_cmd = cmd[1]; 
assign passthrough = cmd[2]; 
 
wire m_xfr;    // master data transferred
wire s_xfr;    // slave data transferred
wire d_xfr, dval, drdy;
assign m_xfr = M_AXIS_TREADY & M_AXIS_TVALID;
assign s_xfr = S_AXIS_TREADY & S_AXIS_TVALID;
assign d_xfr = dval & drdy;

reg [31:0] pkt_cnt;
reg [31:0] word_cnt;
wire last_pkt;
wire last_word;
 
reg [63:0] tdata_reg;
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
  M_PAYLOAD    = 4'h2,
  M_DONE    = 4'h3;

reg [3:0]  Mstate;

assign M_AXIS_TDATA  =
	(passthrough)? tdata_reg :
	(Mstate == M_INIT)?  tdata_reg:
//	(Mstate == M_TUSER)? 0 :
	(Mstate == M_PAYLOAD)?  tdata_reg :tdata_reg;
	
assign M_AXIS_TLAST  = 
	(passthrough)? tlast_reg :
		tlast_reg | last_word;

assign M_AXIS_TVALID =
	(passthrough)? dval :
	(Mstate == M_INIT)?  0 :
//	(Mstate == M_TUSER)? 0 :
	(Mstate == M_PAYLOAD)?  dval : 0;

assign drdy =
	(passthrough)? m_xfr :
	(Mstate == M_INIT)?  m_xfr :
//	(Mstate == M_TUSER)? 1 :
	(Mstate == M_PAYLOAD)?   m_xfr : 0;
  
assign last_word = (word_cnt ==  pkt_size-1);
assign last_pkt  = (pkt_cnt ==  num_pkts-1);

always @ (posedge AXIS_ACLK)
begin
	if ( (AXIS_ARESETN == 1'b0) | reset_cmd |passthrough)
	begin
		pkt_cnt <= 0;
		word_cnt <= 0;
		Mstate <= M_PAYLOAD;
	end
	
	else if (en_cmd) begin
	  case(Mstate)
	    // M_INIT: begin
			// tuser_reg <= (d_xfr)? tdata_reg[31:0] : 0;
			// if (tlast_reg) begin
				// Mstate     <= (d_xfr)? M_TUSER : M_INIT;
			// end
			// else begin
				// Mstate     <= (d_xfr)? M_PAYLOAD : Mstate;
			// end
		// end

		M_PAYLOAD: begin
			if (tlast_reg | last_word) begin
				pkt_cnt    <= (m_xfr)? pkt_cnt + 1 : pkt_cnt;
				word_cnt   <= (m_xfr)? 0 : word_cnt;
				Mstate     <= (m_xfr)? 
				                ((last_pkt)? M_DONE : M_PAYLOAD) :
      							Mstate	;
			end
			else begin
				word_cnt <= (m_xfr)? word_cnt + 1 : word_cnt;
				Mstate     <= (d_xfr)? M_PAYLOAD : Mstate;
			end
		end
	    M_DONE: begin
		end

	  endcase
	end //en_cmd
end

assign status = (Mstate==M_DONE) ? 1: 0;

endmodule

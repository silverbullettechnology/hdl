
module adi_dma_comb_logic
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
  input wire [31:0] num_pkts
 );

assign en_cmd = cmd[0];
assign reset_cmd = cmd[1]; 
assign passthrough = cmd[2];
 

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
reg tlast_reg;

assign dval =
	// (Sstate == S_S0) ?   0 :
	// (Sstate == S_TUSER)? 1 :
	(Sstate == S_S1) ?   0 :
	(Sstate == S_S2) ?   1 : 0;
	
assign S_AXIS_TREADY = 
	// (Sstate == S_S0) ?   1 :
	// (Sstate == S_TUSER)? 0 :	
	(Sstate == S_S1) ?   1 :
	(Sstate == S_S2) ?   d_xfr : 0;

always @ (posedge AXIS_ACLK)
begin
	if ( AXIS_ARESETN == 1'b0)
	begin
		Sstate <= S_S1;
		tdata_reg <= 'h0;
		tlast_reg <= 'h0;
	end
	else begin
	  case(Sstate)
		// S_S0: begin
			// tdata_reg <= (s_xfr)? S_AXIS_TDATA : tdata_reg;
			// tlast_reg <= (s_xfr)? S_AXIS_TLAST : tlast_reg;
			// Sstate     <= (s_xfr)? S_TUSER : S_S0;
		// end
		// S_TUSER: begin
			// Sstate     <= (d_xfr)? S_S2 : S_TUSER;
		// end
	    S_S1: begin
			tdata_reg <= (s_xfr)? S_AXIS_TDATA : tdata_reg;
			tlast_reg <= (s_xfr)? S_AXIS_TLAST : tlast_reg;
			Sstate     <= (s_xfr)? S_S2 : S_S1;
		end
		S_S2: begin

				tdata_reg <= (s_xfr)? S_AXIS_TDATA : tdata_reg;
				tlast_reg <= (s_xfr)? S_AXIS_TLAST : tlast_reg;
				if (d_xfr)
					Sstate <= (s_xfr)? S_S2 : S_S1;
				else
					Sstate <= S_S2;

		end
	  endcase
	end
end


// MASTER SIDE STATE MACHINE
localparam
  M_TUSER = 2'b10,    // transmit tuser on first beat
  M_S0    = 2'b00,    // transmit data
  M_DONE  = 2'b01;    // transfer done
  
reg [3:0]  Mstate;

reg [31:0] pkt_cnt;
reg last_pkt;

// assign last_pkt = (pkt_cnt == num_pkts-1);
   
assign M_AXIS_TDATA  =
	(passthrough)?     tdata_reg  :
	(Mstate==M_S0)?    tdata_reg  :
	(Mstate==M_DONE)?  0 : 0;

assign M_AXIS_TLAST  = 
	(passthrough)?     tlast_reg  :
	(Mstate==M_S0)?    tlast_reg & last_pkt :
	(Mstate==M_DONE)?  tlast_reg: 0;

assign M_AXIS_TVALID = 	
	(passthrough)?    dval  :
	(Mstate==M_DONE)? 0 : dval;

assign drdy = 
	(passthrough)?     m_xfr :
	(Mstate==M_S0)?    m_xfr :
	(Mstate==M_DONE)?  0: 0;

always @ (posedge AXIS_ACLK)
begin
	if ( (AXIS_ARESETN == 1'b0) | reset_cmd)
	begin
		Mstate <= M_S0;
		pkt_cnt <= 0;
		last_pkt <= 0;
	end
	else if (passthrough)
		Mstate <= M_S0;
	else if (en_cmd) begin
	  last_pkt <= (pkt_cnt == num_pkts-1);

	  case(Mstate)
	  M_TUSER: begin
			Mstate <= (m_xfr)? M_S0 : M_TUSER;
		end
	  M_S0: begin
		if (tlast_reg & last_pkt)
			Mstate <= (m_xfr)? M_DONE : M_S0;
		else if (tlast_reg & !last_pkt)
		begin
			pkt_cnt <= (m_xfr)? pkt_cnt+1 : pkt_cnt; 
			Mstate  <= (m_xfr)? M_S0 : M_S0;
		end
		else	
			Mstate <= M_S0;
	  end
	  M_DONE: begin

	  end
	  endcase
	end
end

assign status = (Mstate==M_DONE)? 1:0;

endmodule

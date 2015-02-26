
module vita49_unpack
(
  input wire AXIS_ACLK,
  input wire AXIS_ARESETN,
  
  output wire S_AXIS_TREADY,
  input wire [31:0] S_AXIS_TDATA,
  input wire S_AXIS_TLAST,
  input wire S_AXIS_TVALID,
 
  output wire M_AXIS_TVALID,
  output wire [31:0] M_AXIS_TDATA,
  output wire M_AXIS_TLAST,
  input wire M_AXIS_TREADY,

  // from procesor 
  input wire [31:0] ctrl,
  output wire [31:0] status,
  input wire [31:0] streamID,
  input wire [31:0] words_to_unpack,
  
  // from timing unit
  input wire [31:0] timestamp_sec,
  input wire [63:0] timestamp_fsec,
  
  // debug
  output wire [3:0] Mstate_dbg,
  output wire tlast_reg_dbg,
  output wire [15:0] payload_cnt_dbg,
  output wire [31:0] word_cnt_dbg
 );

// control signals
wire passthrough;
wire reset_cmd;
wire start_cmd;

assign start_cmd = ctrl[0];
assign reset_cmd = ctrl[1]; 
assign passthrough = ctrl[2];
 
// status signals
reg done;
reg pkt_size_err;
reg pkt_type_err;
reg pkt_order_err;
reg pkt_cnt_err;
reg ts_order_err;
reg ts_past_err;
reg tsi_err;
reg tsf_err;
reg strm_id_err;
reg tlast_err;
reg trailer_err; 

assign status = {start_cmd, reset_cmd, passthrough, AXIS_ARESETN,
    16'h0000,
    pkt_size_err, pkt_type_err, pkt_order_err, pkt_cnt_err,
	ts_order_err, ts_past_err, tsi_err, tsf_err,
	strm_id_err, tlast_err, trailer_err, done
	};

wire m_xfr;    // master data transferred
wire s_xfr;    // slave data transferred
wire d_xfr, dval, drdy;
assign m_xfr = M_AXIS_TREADY & M_AXIS_TVALID;
assign s_xfr = S_AXIS_TREADY & S_AXIS_TVALID;
assign d_xfr = dval & drdy;

// TIMESTAMP
reg [31:0] timestamp_sec_r;
reg [63:0] timestamp_fsec_r;
wire ts_en = 1;
always @ (posedge AXIS_ACLK)
begin
	timestamp_sec_r  <= ts_en ? timestamp_sec  :timestamp_sec_r;
	timestamp_fsec_r <= ts_en ? timestamp_fsec :timestamp_fsec_r;
end


// SLAVE SIDE STATE MACHINE
localparam
  S_S0 = 1'b0,
  S_S1 = 1'b1;

reg Sstate;
reg [31:0] tdata_reg;
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
  M_CHK_STRM_ID    = 4'h2,
  M_CHK_CLASS_ID_0 = 4'h3,
  M_CHK_CLASS_ID_1 = 4'h4,
  M_CHK_TSI        = 4'h5,
  M_CHK_TSF_0      = 4'h6,
  M_CHK_TSF_1      = 4'h7,
  M_SEND_PAYLOAD   = 4'h8,
  M_ERROR          = 4'h9,
  M_DONE           = 4'hA;

reg [3:0]  Mstate;
reg [15:0] payload_cnt;
reg [31:0] word_cnt;

reg [31:0] tsf_pkt_msb;
reg [31:0] tsi_last;
reg [63:0] tsf_last;
reg tsi_eq;

// header
wire [3:0] pkt_type  = tdata_reg[31:28];
wire       c         = tdata_reg[27];    reg c_reg;         
wire       t         = tdata_reg[26];           
wire [1:0] tsi       = tdata_reg[23:22]; reg [1:0] tsi_reg; 
wire [1:0] tsf       = tdata_reg[21:20]; reg [1:0] tsf_reg; 
wire [3:0] pkt_cnt   = tdata_reg[19:16]; reg [3:0] pkt_cnt_reg;
wire [15:0] pkt_size = tdata_reg[15:0];  reg [15:0] pkt_size_reg;

wire [3:0] pkt_cnt_reg_plusone = pkt_cnt_reg + 1;

assign M_AXIS_TLAST = (passthrough) ? tlast_reg:
	((Mstate == M_SEND_PAYLOAD) & (payload_cnt+1 == pkt_size_reg))? 1:0;

assign M_AXIS_TDATA = tdata_reg;

assign M_AXIS_TVALID = (passthrough)? dval :
	(Mstate == M_SEND_PAYLOAD) ? dval : 0;

assign drdy =
	(passthrough)                ? M_AXIS_TREADY:
	(Mstate == M_INIT)           ? 0 :
	(Mstate == M_CHK_HDR)        ? dval :
	(Mstate == M_CHK_STRM_ID)    ? dval :
	(Mstate == M_CHK_CLASS_ID_0) ? dval :
	(Mstate == M_CHK_CLASS_ID_1) ? dval :
	(Mstate == M_CHK_TSI)        ? dval :
	(Mstate == M_CHK_TSF_0)      ? dval :
	(Mstate == M_CHK_TSF_1)      ? dval :
	(Mstate == M_SEND_PAYLOAD)   ? m_xfr :
	(Mstate == M_ERROR)          ? 0 :
	(Mstate == M_DONE)           ? 0 : 0;

always @ (posedge AXIS_ACLK)
begin
	if ( AXIS_ARESETN == 1'b0)
	begin
		Mstate      <= M_INIT;
		pkt_size_err  <= 0;
		pkt_type_err  <= 0;
		pkt_order_err <= 0;
		pkt_cnt_err   <= 0;
		ts_order_err  <= 0;
		ts_past_err   <= 0;
		tsi_err       <= 0;
		tsf_err       <= 0;
		strm_id_err   <= 0;
		tlast_err     <= 0;
		trailer_err   <= 0; 		
		payload_cnt <= 16'h0;
		word_cnt    <= 32'h0;
		pkt_cnt_reg <= 4'b1111;
		tsf_pkt_msb <= 0;
		tsi_last <= 0;
		tsf_last <= 0;
		done        <= 0;
	end
	else begin   
	  if (reset_cmd) Mstate <= M_INIT;
 	  case(Mstate)
 	    M_INIT: begin
			pkt_size_err  <= 0;
			pkt_type_err  <= 0;
			pkt_order_err <= 0;
			pkt_cnt_err   <= 0;
			ts_order_err  <= 0;
			ts_past_err   <= 0;
			tsi_err       <= 0;
			tsf_err       <= 0;
			strm_id_err   <= 0;
			tlast_err     <= 0;
			trailer_err   <= 0; 		
			payload_cnt <= 16'h0;
			word_cnt    <= 32'h0;
			pkt_cnt_reg <= 4'b1111;
			tsf_pkt_msb <= 0;
			tsi_last <= 0;
			tsf_last <= 0;
			done        <= 0;
			Mstate      <= (start_cmd)? M_CHK_HDR : Mstate;
 		end
	    M_CHK_HDR: begin
			payload_cnt  <= (d_xfr)? payload_cnt+1 : payload_cnt;
			c_reg        <= (d_xfr)? c : c_reg;
			tsi_reg      <= (d_xfr)? tsi : tsi_reg;
			tsf_reg      <= (d_xfr)? tsf : tsf_reg;
			pkt_cnt_reg  <= (d_xfr)? pkt_cnt : pkt_cnt_reg;
			pkt_size_reg <= (d_xfr)? pkt_size : pkt_size_reg;			
			if (d_xfr)
			begin
				Mstate <= M_CHK_STRM_ID; // default next state
				if (pkt_type != 4'b0001) begin
					pkt_type_err <= 1;
					Mstate <= M_ERROR;
				end
				if (pkt_cnt != pkt_cnt_reg_plusone) begin
					pkt_cnt_err <= 1;
					Mstate <= M_ERROR;
				end
				if (t) begin
					trailer_err <= 1;
					Mstate <= M_ERROR;
				end
			end
  		end
 	    M_CHK_STRM_ID: begin
			payload_cnt  <= (d_xfr)? payload_cnt+1 : payload_cnt;
			if (d_xfr)
			begin
				Mstate <= (c_reg)?    M_CHK_CLASS_ID_0:
				          (tsi_reg)?  M_CHK_TSI :
						  (tsf_reg)?  M_CHK_TSF_0 :M_SEND_PAYLOAD;
				if (streamID != tdata_reg) begin
					strm_id_err <= 1;
					Mstate <= M_ERROR;
				end
			end
 		end
	    M_CHK_CLASS_ID_0: begin
			payload_cnt  <= (d_xfr)? payload_cnt+1 : payload_cnt;
			Mstate    <= (d_xfr)? M_CHK_CLASS_ID_1 : Mstate;	    
  		end
 	    M_CHK_CLASS_ID_1: begin
			payload_cnt  <= (d_xfr)? payload_cnt+1 : payload_cnt;
			if (d_xfr)
				Mstate <= (tsi_reg)?  M_CHK_TSI :
						  (tsf_reg)?  M_CHK_TSF_0 :M_SEND_PAYLOAD;
 		end
	    M_CHK_TSI: begin
			payload_cnt  <= (d_xfr)? payload_cnt+1 : payload_cnt;
			tsi_last     <= (d_xfr)? tdata_reg : tsi_last;
			if (d_xfr)
			begin
				Mstate <= M_CHK_TSF_0; // default next state
				tsi_eq <=  (tdata_reg == timestamp_sec_r)? 1:0;
//				if (tdata_reg < timestamp_sec_r) begin
//					ts_past_err <= 1;
//					tsi_err <= 1;
//					Mstate <= M_ERROR;
//				end
				if (tdata_reg < tsi_last) begin
					ts_order_err <= 1;
					tsi_err <= 1;
					Mstate <= M_ERROR;
				end
			end
  		end
		
	    M_CHK_TSF_0: begin
			payload_cnt  <= (d_xfr)? payload_cnt+1 : payload_cnt;
			tsf_pkt_msb <= (d_xfr)? tdata_reg : 0;
			Mstate    <= (d_xfr)? M_CHK_TSF_1 : Mstate;	    
  		end
 	    M_CHK_TSF_1: begin
			payload_cnt  <= (d_xfr)? payload_cnt+1 : payload_cnt;
			tsf_last     <= (d_xfr)? {tsf_pkt_msb, tdata_reg} : tsf_last;
			if (d_xfr)
			begin
				Mstate <= M_SEND_PAYLOAD; // default next state
//				if (({tsf_pkt_msb, tdata_reg} < timestamp_fsec_r) & tsi_eq) begin
//					ts_past_err <= 1;
//					tsf_err <= 1;
//					Mstate <= M_ERROR;
//				end
				if (tsi_eq && ({tsf_pkt_msb, tdata_reg} < tsf_last)) begin
					ts_order_err <= 1;
					tsf_err <= 1;
					Mstate <= M_ERROR;
				end
			end
 		end		
		
 	    M_SEND_PAYLOAD: begin
			if (payload_cnt+1 != pkt_size_reg) 
			begin
				payload_cnt <= (m_xfr)? payload_cnt+1 : payload_cnt;
				word_cnt    <= (m_xfr)? word_cnt+1:word_cnt;	
				Mstate      <= (m_xfr)? M_SEND_PAYLOAD : Mstate;				
			end
			else begin
				payload_cnt <= (m_xfr)? 0 : payload_cnt;
				word_cnt    <= (m_xfr)? word_cnt+1:word_cnt;
				//pkt_cnt_reg <= (m_xfr)? pkt_cnt_reg_plusone:pkt_cnt_reg;
				if (m_xfr)
				begin
					Mstate <= (word_cnt+1 >= words_to_unpack)? M_DONE : M_CHK_HDR;
					if (tlast_reg != 1'b1) begin
						tlast_err <= 1;
						pkt_size_err <= 1;
						Mstate <= M_ERROR;
					end
				end
			end
 		end
	    M_ERROR: begin
  		end
	    M_DONE: begin
  		end		
 	  endcase
	end
end



  assign Mstate_dbg = Mstate;
  assign tlast_reg_dbg = tlast_reg;
  assign payload_cnt_dbg = payload_cnt;
  assign word_cnt_dbg = word_cnt;


endmodule
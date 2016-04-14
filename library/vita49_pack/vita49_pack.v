
module vita49_pack
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
  input wire [15:0] pkt_size,
  input wire [31:0] trailer,
  
  // from timing unit
  input wire [31:0] timestamp_sec,
  input wire [63:0] timestamp_fsec,
  
  output wire [3:0] mstate_dbg,
  output wire [15:0] payload_cnt_dbg,
  output wire tlast_reg_dbg
 );

// control signals
wire passthrough;
wire reset_cmd;
wire start_cmd;
wire trailer_en;
wire tsi_en;
// status signals
reg done;

reg [31:0] ctrl_reg;
reg [31:0] streamID_reg;
reg [15:0] pkt_size_reg;
reg [31:0] trailer_reg;

assign start_cmd   = ctrl_reg[0];
assign reset_cmd   = ctrl_reg[1]; 
assign passthrough = ctrl_reg[2];
assign trailer_en  = ctrl_reg[3];
assign tsi_en      = ctrl_reg[4];

assign status = {'h0, payload_cnt, Mstate};
 
always @ (posedge AXIS_ACLK)
begin
    ctrl_reg <= ctrl;
    streamID_reg <= streamID;
    pkt_size_reg <= pkt_size;
    trailer_reg <= trailer;
 end
 
 
wire m_xfr;    // master data transferred
wire s_xfr;    // slave data transferred
wire d_xfr, dval, drdy;
assign m_xfr = M_AXIS_TREADY & M_AXIS_TVALID;
assign s_xfr = S_AXIS_TREADY & S_AXIS_TVALID;
assign d_xfr = dval & drdy;

// TIMESTAMP
wire ts_en;
reg [31:0] timestamp_sec_r;
reg [63:0] timestamp_fsec_r;
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
reg [63:0] tdata_reg;
reg        tlast_reg;

assign dval          = (Sstate == S_S1)? 1 : 0;
assign S_AXIS_TREADY = (Sstate == S_S0)? 1 : d_xfr;

always @ (posedge AXIS_ACLK)
begin
	if ( AXIS_ARESETN == 1'b0)
	begin
		Sstate <= S_S0;
		tdata_reg <= 64'h0;
		tlast_reg <= 0;
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
  M_INIT         = 4'h0,
  M_SEND_HDR     = 4'h1,
  M_SEND_STRM_ID = 4'h2,
  M_SEND_TSI     = 4'h3,
  M_SEND_TSF_0   = 4'h4,
  M_SEND_TSF_1   = 4'h5,
  M_SEND_PAYLOAD = 4'h6,
  M_SEND_DONE    = 4'h7,
  M_SEND_ZERO    = 4'h8,
  M_SEND_TRAIL   = 4'h9;

reg [3:0]  Mstate;
reg [15:0] payload_cnt;
reg [31:0] word_cnt;
reg [3:0]  pkt_cnt;
reg last_trail;

localparam
  PKT_TYPE = 4'b0001,      // IF Data packet with stream identifier
  C        = 1'b0,         // No class identifier
//  T        = 1'b0,         // No trailer
  RR       = 2'b00,        // reserved
//  TSI      = 2'b11,        // Integer Timestamp (other)
  TSF      = 2'b01;        // Fractional Timestamp (sample count)

wire T;
wire [1:0] TSI; 
assign T   = trailer_en;  
assign TSI = tsi_en? 2'b11: 2'b00;

wire [31:0] header;
assign header = {PKT_TYPE, C, T, RR, TSI, TSF, pkt_cnt, pkt_size_reg};

assign ts_en = (Mstate == M_SEND_STRM_ID) ? 1 : 0;

assign M_AXIS_TLAST = 	
    (passthrough)              ? tlast_reg:
    ((Mstate == M_SEND_PAYLOAD) & (payload_cnt+1 == pkt_size_reg))? 1:
    ((Mstate == M_SEND_ZERO)    & (payload_cnt+1 == pkt_size_reg))? 1:
    (Mstate == M_SEND_TRAIL)?  1:0;

wire [31:0] m_tdata_smallendian;
wire [31:0] m_tdata_bigendian;

assign m_tdata_smallendian =
	(passthrough)              ? tdata_reg:
	(Mstate == M_SEND_HDR)     ? header :
	(Mstate == M_SEND_STRM_ID) ? streamID_reg:
	(Mstate == M_SEND_TSI)     ? timestamp_sec_r:
	(Mstate == M_SEND_TSF_0)   ? timestamp_fsec_r[63:32]:
	(Mstate == M_SEND_TSF_1)   ? timestamp_fsec_r[31:0]:
	(Mstate == M_SEND_PAYLOAD) ? tdata_reg : 
	(Mstate == M_SEND_ZERO)    ? 0 :
    (Mstate == M_SEND_TRAIL)   ? trailer_reg : 0;

assign m_tdata_bigendian = {
	m_tdata_smallendian[7:0],
	m_tdata_smallendian[15:8],
	m_tdata_smallendian[23:16],
	m_tdata_smallendian[31:24]
	};

assign M_AXIS_TDATA = (passthrough)? tdata_reg : m_tdata_bigendian;

assign M_AXIS_TVALID =
	(passthrough)              ? dval :
	(Mstate == M_SEND_HDR)     ? 1 :
	(Mstate == M_SEND_STRM_ID) ? 1:
	(Mstate == M_SEND_TSI)     ? dval:
	(Mstate == M_SEND_TSF_0)   ? 1:
	(Mstate == M_SEND_TSF_1)   ? 1:
	(Mstate == M_SEND_PAYLOAD) ? dval :
	(Mstate == M_SEND_ZERO)    ? 1 :
	(Mstate == M_SEND_TRAIL)   ? 1 : 0;

assign drdy =
	(passthrough)              ? M_AXIS_TREADY:
	(Mstate == M_SEND_PAYLOAD) ? m_xfr :
	(Mstate == M_SEND_ZERO)  ? 0 :
	(Mstate == M_SEND_TRAIL) ? 0 : 0;


always @ (posedge AXIS_ACLK)
begin
	if ( AXIS_ARESETN == 1'b0)
	begin
		Mstate      <= M_INIT;
		payload_cnt <= 16'h0;
//		word_cnt    <= 32'h0;
		pkt_cnt     <= 4'h0;
		done        <= 0;
	end
	else begin   
	  if (reset_cmd) Mstate <= M_INIT;
 	  case(Mstate)
 	    M_INIT: begin
			payload_cnt <= 16'h0;
//			word_cnt    <= 32'h0;
    		pkt_cnt     <= 4'h0;
            last_trail  <= 0;			
			done        <= 0;
			Mstate      <= (start_cmd & dval)? M_SEND_HDR : Mstate;
 		end
	    M_SEND_HDR: begin
			payload_cnt <= (m_xfr)? payload_cnt+1 : payload_cnt;
			Mstate    <= (m_xfr)? M_SEND_STRM_ID : Mstate;	    
  		end
 	    M_SEND_STRM_ID: begin
			payload_cnt <= (m_xfr)? payload_cnt+1 : payload_cnt;
			Mstate    <= (m_xfr)? (tsi_en? M_SEND_TSI : M_SEND_TSF_0) : Mstate;	    
 		end
	    M_SEND_TSI: begin
			payload_cnt <= (m_xfr)? payload_cnt+1 : payload_cnt;
			Mstate    <= (m_xfr)? M_SEND_TSF_0 : Mstate;	    
  		end
 	    M_SEND_TSF_0: begin
			payload_cnt <= (m_xfr)? payload_cnt+1 : payload_cnt;
			Mstate    <= (m_xfr)? M_SEND_TSF_1 : Mstate;	    
 		end
	    M_SEND_TSF_1: begin
			payload_cnt <= (m_xfr)? payload_cnt+1 : payload_cnt;
			Mstate    <= (m_xfr)? M_SEND_PAYLOAD : Mstate;	    
  		end
 	    M_SEND_PAYLOAD: begin
			if (trailer_en & (payload_cnt+2 == pkt_size_reg)) 
			begin
				payload_cnt <= (m_xfr)? payload_cnt+1 : payload_cnt;
				last_trail  <= (m_xfr)? tlast_reg: last_trail;
				Mstate      <= (m_xfr)? M_SEND_TRAIL: Mstate;	   
			end
			else if (payload_cnt+1 == pkt_size_reg) 
			begin
				payload_cnt <= (m_xfr)? 0 : payload_cnt;
				pkt_cnt     <= (m_xfr)? pkt_cnt+1:pkt_cnt;
				Mstate      <= (m_xfr)? ((tlast_reg)? M_INIT: M_SEND_HDR) : Mstate;	   
			end
			else if (tlast_reg)
			begin
				payload_cnt <= (m_xfr)? payload_cnt+1 : payload_cnt;
				Mstate      <= (m_xfr)? M_SEND_ZERO : Mstate;	   				
			end
			else
			begin
				payload_cnt <= (m_xfr)? payload_cnt+1 : payload_cnt;
				Mstate      <= (m_xfr)? M_SEND_PAYLOAD : Mstate;	   
			end
 		end
		M_SEND_ZERO: begin
			if (trailer_en & (payload_cnt+2 == pkt_size_reg)) 
			begin
				payload_cnt <= (m_xfr)? payload_cnt+1 : payload_cnt;
				last_trail  <= (m_xfr)? 1: last_trail;
				Mstate      <= (m_xfr)? M_SEND_TRAIL: Mstate;	   
			end		
			else if (payload_cnt+1 == pkt_size_reg) 
			begin
				payload_cnt <= (m_xfr)? 0 : payload_cnt;
				pkt_cnt     <= (m_xfr)? pkt_cnt+1:pkt_cnt;
				Mstate      <= (m_xfr)? M_INIT : Mstate;	   
			end
			else
			begin			
				payload_cnt <= (m_xfr)? payload_cnt+1 : payload_cnt;
				Mstate      <= (m_xfr)? M_SEND_ZERO : Mstate;	   
			end
		end
		M_SEND_TRAIL: begin
			payload_cnt <= (m_xfr)? 0 : payload_cnt;
			pkt_cnt     <= (m_xfr)? pkt_cnt+1:pkt_cnt;
			Mstate      <= (m_xfr)? ((last_trail)? M_INIT: M_SEND_HDR) : Mstate;	   
		end
	    M_SEND_DONE: begin
			done <= 1;
  		end
 	  endcase
	end
end

assign payload_cnt_dbg = payload_cnt;
assign mstate_dbg = Mstate;
assign tlast_reg_dbg = tlast_reg;
endmodule



module axis_dsrc_pkt
(
  input wire S_AXI_ACLK,

  input wire AXIS_ACLK,
  input wire AXIS_ARESETN,
  output wire M_AXIS_TVALID,
  output wire [(C_M_AXIS_TDATA_NUM_BYTES*8)-1:0] M_AXIS_TDATA,
  output wire [C_M_AXIS_TDATA_NUM_BYTES-1:0] M_AXIS_TSTRB,
  output wire M_AXIS_TLAST,
  input wire M_AXIS_TREADY,
  
  input wire [31:0] cmd,
  input wire [31:0] num_bytes,
  input wire [31:0] data_type,
  input wire [31:0] num_pkts,
  input wire        new_cmd,
  output wire [31:0] stat,
  output reg [31:0] rx_cnt,
  output reg [31:0] rx_rep_cnt
);

parameter integer C_M_AXIS_TDATA_NUM_BYTES = 4;
parameter  C_REP_CONTINUOUS = 1;


reg [32:0] mem [255:0];

initial
$readmemh ("mem_data_hex.txt", mem);

reg cntr_rst;
reg rx_done;
reg rx_enable;
wire rx_last_early   = (rx_cnt >= num_bytes-C_M_AXIS_TDATA_NUM_BYTES) && (rx_cnt < num_bytes);
wire rx_last         = (rx_cnt >= num_bytes);
wire rx_active       = rx_enable & !rx_done;// & M_AXIS_TREADY;


reg [31:0]idx_cnt;

assign stat = { 30'h0, rx_done ,rx_enable};

always @ (posedge S_AXI_ACLK)
begin
   cntr_rst   <= 0;
   if ( AXIS_ARESETN == 1'b0 )
   begin
     cntr_rst   <= 1;
     rx_enable  <= 0;
   end
   if (new_cmd)
     begin
       case (cmd)
       'h1: //
         rx_enable <= 1;
       'h2: //reset
         begin
          cntr_rst   <= 1;
          rx_enable  <= 0;
        end        
       'h3:
         rx_enable <= 0;
      endcase;
    end
end


reg  [(C_M_AXIS_TDATA_NUM_BYTES*8)-1:0] m_axis_tdata;
wire [(C_M_AXIS_TDATA_NUM_BYTES*8)-1:0] next_tdata;
reg  m_axis_tvalid;
reg  m_axis_tlast;
reg  [1:0] state;
wire m_xfr;

assign m_xfr      = M_AXIS_TREADY & M_AXIS_TVALID;

wire [32:0] mem_data = mem[idx_cnt];
wire [31:0] mem_tdata = mem_data[31:0];
wire mem_tlast = mem_data[32];

assign next_tdata = (data_type=='h2)? mem_tdata:
					(data_type=='h1)? m_axis_tdata - 1 : m_axis_tdata +1;

assign next_tlast = (data_type=='h2)? mem_tlast: 0;
					
localparam [1:0]  IDLE      = 2'b00,
                  SEND      = 2'b01,
				  NXT_REP   = 2'b10;

always @ (posedge AXIS_ACLK)
begin
   if (cntr_rst)
   begin
	 idx_cnt <= 0;
     rx_cnt     <= 0;
     rx_rep_cnt <= 0;
     rx_done <= 0;
     state <= IDLE;
     m_axis_tvalid <= 0;
     m_axis_tlast <= 0;
     m_axis_tdata <= 0;
   end
   else begin
     case (state)
       IDLE: begin
//		 idx_cnt       <= (m_xfr)? idx_cnt+1 : idx_cnt;
         idx_cnt       <= rx_active? 1 : idx_cnt;
         rx_cnt        <= rx_active? C_M_AXIS_TDATA_NUM_BYTES : rx_cnt;
         state         <= rx_active? SEND : IDLE;
         m_axis_tlast  <= (m_xfr)? 0 : m_axis_tlast;
         m_axis_tvalid <= (m_xfr)? next_tlast : m_axis_tvalid;
         m_axis_tdata  <=  next_tdata;
       end
       SEND: begin
         m_axis_tvalid <= 1'b1;
         m_axis_tlast  <= 1'b0;
         state <= SEND;
		 
		 if (m_xfr) begin
		   m_axis_tdata <= next_tdata;
           if (rx_cnt >= num_bytes-C_M_AXIS_TDATA_NUM_BYTES) begin
		     m_axis_tlast <= 1'b1;
             rx_done      <= (num_pkts <= rx_rep_cnt +1)? 1: 0;
             rx_rep_cnt   <= rx_rep_cnt + 1;			 
             state        <= (num_pkts <= rx_rep_cnt +1)? IDLE : NXT_REP;
		   end
		   else begin
             rx_cnt        <= rx_cnt + C_M_AXIS_TDATA_NUM_BYTES;
			 idx_cnt       <= idx_cnt +1;
			 m_axis_tlast  <= next_tlast;
		   end
         end
	   end
       NXT_REP: begin
         idx_cnt        <= (m_xfr)? 0 : idx_cnt;
         rx_cnt        <= (m_xfr)? C_M_AXIS_TDATA_NUM_BYTES : rx_cnt;
         state         <= (m_xfr)? SEND : NXT_REP;
         m_axis_tlast  <= (m_xfr)? next_tlast : m_axis_tlast;
         m_axis_tvalid <= C_REP_CONTINUOUS;
         m_axis_tdata  <= (m_xfr)? next_tdata : m_axis_tdata;
       end	     
     endcase
   end
 end

assign M_AXIS_TVALID = m_axis_tvalid;
assign M_AXIS_TLAST = m_axis_tlast;
assign M_AXIS_TDATA = m_axis_tdata;
    
endmodule


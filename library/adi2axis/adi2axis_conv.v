

module adi2axis_conv
(
  input wire S_AXI_ACLK,

  input wire AXIS_ACLK,
  input wire AXIS_ARESETN,
  output wire M_AXIS_TVALID,
  output wire [(C_M_AXIS_TDATA_NUM_BYTES*8)-1:0] M_AXIS_TDATA,
  output wire [C_M_AXIS_TDATA_NUM_BYTES-1:0] M_AXIS_TSTRB,
  output wire M_AXIS_TLAST,
  input wire M_AXIS_TREADY,
  
  input wire [(C_M_AXIS_TDATA_NUM_BYTES*8)-1:0] ddata,
  input wire dvalid,
  input wire dsync,
  output wire ovf,
  
  input wire [31:0] ctrl,
  input wire [31:0] num_bytes,
  output wire [31:0] stat,
  
  input wire trig
);

parameter integer C_M_AXIS_TDATA_NUM_BYTES = 8;

reg cntr_rst;
reg rx_enable;
reg dma_start_legacy;
reg dma_start_trig;
reg [31:0] cnt;

reg [31:0] ctrl_reg;
reg [31:0] num_bytes_reg;

always @ (posedge S_AXI_ACLK)
begin
    ctrl_reg <= ctrl;
    num_bytes_reg <= num_bytes;
end


always @ (posedge S_AXI_ACLK)
begin
   cntr_rst   <= 0;
   if ( AXIS_ARESETN == 1'b0 )
   begin
     cntr_rst   <= 1;
     rx_enable  <= 0;
	 dma_start_trig <= 0;
   end
   else begin
       case (ctrl_reg)
	   'h2:
	     dma_start_trig <= 1;
       'h1: //
         dma_start_legacy <= 1;
       'h0: //reset
         begin
          cntr_rst   <= 1;
          dma_start_legacy  <= 0;
		  dma_start_trig <= 0;
         end        
      endcase;
	end
end

reg dma_capture_en;
reg done;

reg trig_reg0;
reg trig_reg1;
reg sync_reg0;
reg sync_reg1;
reg [(C_M_AXIS_TDATA_NUM_BYTES*8)-1:0] ddata_reg0;
reg [(C_M_AXIS_TDATA_NUM_BYTES*8)-1:0] ddata_reg1;

reg tlast_prev;
reg tvalid_prev;
wire last_trig = tvalid_prev & ~tlast_prev & ~trig_reg1;

assign stat  = { 30'h0, done, dma_capture_en};
wire   m_xfr = M_AXIS_TREADY & M_AXIS_TVALID;

assign M_AXIS_TLAST  = 
	(dma_start_legacy) ? ((cnt>=num_bytes_reg-8)? M_AXIS_TVALID : 0)  :
	(dma_start_trig)   ? (last_trig? M_AXIS_TVALID : 0)  : 0;

//assign M_AXIS_TVALID = (dma_capture_en)? (dvalid & dsync) : 0;	

assign M_AXIS_TVALID  = 
	(dma_start_legacy) ? (dma_capture_en? sync_reg1 : 0)  :
	(dma_start_trig)   ? ((trig_reg1 | last_trig)? sync_reg1 : 0)  : 0;

assign M_AXIS_TDATA  = ddata_reg1;
assign M_AXIS_TSTRB = 'hff;

assign ovf = (M_AXIS_TVALID) & (!M_AXIS_TREADY);   

always @ (posedge AXIS_ACLK)
//always @ (posedge (dvalid & dsync))
begin
   if (cntr_rst) begin
     trig_reg0 <= 0;  trig_reg1 <= 0;
     sync_reg0 <= 0;  sync_reg1 <= 0;
     ddata_reg0 <= 0;  ddata_reg1 <= 0;
     tlast_prev <=0;
     tvalid_prev <= 0;
   end
   else begin
     trig_reg0 <= trig; 
     trig_reg1 <= trig_reg0;
     sync_reg0 <= (dvalid & dsync); 
     sync_reg1 <= sync_reg0;
     ddata_reg0 <= ddata; 
     ddata_reg1 <= ddata_reg0;
     tlast_prev <= m_xfr? M_AXIS_TLAST : tlast_prev;
     tvalid_prev <= m_xfr? M_AXIS_TVALID : tvalid_prev;
   end
end

always @ (posedge AXIS_ACLK)
begin
   if (cntr_rst)
   begin
     cnt     <= 0; 
	 dma_capture_en <= 0;
	 done <= 0;
   end

   else if (dma_start_legacy) begin
     dma_capture_en <= (done)? 0 : dma_start_legacy & trig;
	 if (dma_capture_en)
	 begin
	   cnt   <= m_xfr? cnt + 8: cnt;
	   done  <= m_xfr? (cnt==num_bytes_reg-8) : done;
	 end
   end

 //  else if (dma_start_trig) begin
 //    dma_capture_en <= dma_start_trig & ((trig & trig_reg) | (trig_reg & trig_reg1));
 //  end
  end

    
endmodule


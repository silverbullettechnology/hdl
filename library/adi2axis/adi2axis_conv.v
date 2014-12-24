

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
reg dma_start;
reg [31:0] cnt;

always @ (posedge S_AXI_ACLK)
begin
   cntr_rst   <= 0;
   if ( AXIS_ARESETN == 1'b0 )
   begin
     cntr_rst   <= 1;
     rx_enable  <= 0;
   end
   else begin
       case (ctrl)
       'h1: //
         dma_start <= 1;
       'h0: //reset
         begin
          cntr_rst   <= 1;
          dma_start  <= 0;
         end        
      endcase;
	end
end

reg dma_capture_en;
reg done;
//reg tlast;

assign stat  = { 30'h0, done, dma_capture_en};
wire   m_xfr = M_AXIS_TREADY & M_AXIS_TVALID;

assign M_AXIS_TVALID = (dma_capture_en)? (dvalid & dsync) : 0;
assign M_AXIS_TLAST  = (cnt>=num_bytes-8)? M_AXIS_TVALID : 0; //done & dma_capture_en;
assign M_AXIS_TDATA  = ddata;
assign M_AXIS_TSTRB = 'hff;

assign ovf = (dvalid & dsync) & (!M_AXIS_TREADY);   

always @ (posedge AXIS_ACLK)
begin
   if (cntr_rst)
   begin
     cnt     <= 0; 
	 dma_capture_en <= 0;
	 done <= 0;
//	 tlast <= 0;
   end
   else begin
     dma_capture_en <= (done)? 0 : dma_start & trig;
	 if (dma_capture_en)
	 begin
	   cnt   <= m_xfr? cnt + 8: cnt;
	   done  <= m_xfr? (cnt==num_bytes-8) : done;
//	   tlast <= m_xfr? (cnt==num_bytes-8) : done;
	 end
   end
 end

    
endmodule


module axis2adi
(
  input wire AXIS_ACLK,
  input wire AXIS_ARESETN,
  output wire S_AXIS_TREADY,
  input wire [(C_S_AXIS_TDATA_NUM_BYTES*8)-1:0] S_AXIS_TDATA,
  input wire [C_S_AXIS_TDATA_NUM_BYTES-1:0] S_AXIS_TSTRB,
  input wire S_AXIS_TLAST,
  input wire S_AXIS_TVALID,

  output wire [(C_S_AXIS_TDATA_NUM_BYTES*8)-1:0] dma_data,
  output wire dma_valid,
  input wire dma_rd,
  output wire dma_unf
);

parameter integer C_S_AXIS_TDATA_NUM_BYTES = 8;

reg dma_rd_reg;


assign dma_data  = S_AXIS_TDATA;

assign S_AXIS_TREADY =  S_AXIS_TVALID && dma_rd_reg;
assign dma_valid     =  S_AXIS_TVALID && dma_rd_reg;
assign dma_unf       = ~S_AXIS_TVALID && dma_rd_reg;

always @ (posedge AXIS_ACLK)
begin
    if ( AXIS_ARESETN == 1'b0 )
    begin
      dma_rd_reg      <= 0;
    end
	else
	  dma_rd_reg <= dma_rd;
end


endmodule


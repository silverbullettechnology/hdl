
module axis_dsnk
(
  input wire S_AXI_ACLK,

  input wire AXIS_ACLK,
  input wire AXIS_ARESETN,
  output wire S_AXIS_TREADY,
  input wire [(C_S_AXIS_TDATA_NUM_BYTES*8)-1:0] S_AXIS_TDATA,
  input wire [C_S_AXIS_TDATA_NUM_BYTES-1:0] S_AXIS_TSTRB,
  input wire S_AXIS_TLAST,
  input wire S_AXIS_TVALID,
  
  input  wire [31:0] cmd,
  input  wire        new_cmd,
  output  wire [31:0] stat,
  output  reg [31:0] recv_bytes,
  output  reg [63:0] checksum
  
);

parameter integer C_S_AXIS_TDATA_NUM_BYTES = 4;

reg tx_enable;
reg cntr_rst;
reg tx_done;

wire tx_active = tx_enable & !tx_done;// & M_AXIS_TREADY;

assign S_AXIS_TREADY = tx_active;
assign stat = { 30'h0, tx_done ,tx_enable};

always @ (posedge S_AXI_ACLK)
begin
    cntr_rst <= 0;
    if ( AXIS_ARESETN == 1'b0 )
    begin
      cntr_rst       <= 1;
      tx_enable      <= 0;
      tx_done        <= 0;
    end
    if (new_cmd)
    begin
      case (cmd)
      'h1: //
      begin
          tx_enable <= 1;
      end
      'h2: //reset
        begin
          cntr_rst   <= 1;
          tx_enable  <= 0;
          tx_done    <= 0;
        end        
      'h3:
          tx_enable <= 0;
      endcase;
    end
end


always @ (posedge AXIS_ACLK)
begin
   if (cntr_rst)
    begin  
     checksum <= 0;
     recv_bytes <= 0;
   end
   
    if (tx_active)
    begin
      if (S_AXIS_TVALID)
      begin      
        recv_bytes <= recv_bytes + C_S_AXIS_TDATA_NUM_BYTES;
        checksum <= {checksum[0], checksum[63:1]} + S_AXIS_TDATA;
      end
    end

end


endmodule

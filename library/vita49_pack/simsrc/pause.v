
module pause
(
  input wire S_AXI_ACLK,

  input wire AXIS_ACLK,
  input wire AXIS_ARESETN,
  
  output wire S_AXIS_TREADY,
  input wire [(C_AXIS_TDATA_NUM_BYTES*8)-1:0] S_AXIS_TDATA,
  input wire [C_AXIS_TDATA_NUM_BYTES-1:0] S_AXIS_TSTRB,
  input wire S_AXIS_TLAST,
  input wire S_AXIS_TVALID,
 
  output wire M_AXIS_TVALID,
  output wire [(C_AXIS_TDATA_NUM_BYTES*8)-1:0] M_AXIS_TDATA,
  output wire [C_AXIS_TDATA_NUM_BYTES-1:0] M_AXIS_TSTRB,
  output wire M_AXIS_TLAST,
  input wire M_AXIS_TREADY,
 
  input  wire [31:0] cmd,
  input  wire        new_cmd,
  input  wire [31:0] on_cycle,
  input  wire [31:0] off_cycle,
  output wire [31:0] stat

);

parameter integer C_AXIS_TDATA_NUM_BYTES = 4;

reg [31:0] data_cnt;
reg [31:0] pause_cnt;

reg pause;
reg enable;

reg cntr_rst;

assign stat = { 30'h0, pause ,enable};

assign M_AXIS_TDATA = S_AXIS_TDATA;
assign M_AXIS_TSTRB = S_AXIS_TSTRB;
assign M_AXIS_TLAST = S_AXIS_TLAST;
assign M_AXIS_TVALID = (pause)? 0: S_AXIS_TVALID;
assign S_AXIS_TREADY = (pause)? 0: M_AXIS_TREADY;

always @ (posedge S_AXI_ACLK)
begin
    cntr_rst <= 0;
    if ( AXIS_ARESETN == 1'b0 )
    begin
      cntr_rst    <= 1;
      enable      <= 0;
    end
    if (new_cmd)
    begin
      case (cmd)
      'h1: //
      begin
          enable <= 1;
      end
      'h2: //reset
        begin
          cntr_rst   <= 1;
          enable  <= 0;
        end        
      'h3:
          enable <= 0;
      endcase;
    end
end


always @ (posedge AXIS_ACLK)
begin
   if (cntr_rst)
   begin  
     data_cnt <= 0;
     pause_cnt <= 0;
	 pause <= 0;
   end
   if (!enable) pause <= 0;
   else begin
     if (!pause) begin
	   if (data_cnt < on_cycle) 
	     data_cnt <= (S_AXIS_TREADY & S_AXIS_TVALID)? data_cnt +1 : data_cnt;
	   else begin
	     data_cnt <= 0;
		 pause <= 1;
	   end
	 end else begin
	   if (pause_cnt < off_cycle) pause_cnt <= pause_cnt + 1;
	   else begin
	     pause_cnt <= 0;
		 pause <= 0;
	   end
	 end
    end
   
     

end


endmodule

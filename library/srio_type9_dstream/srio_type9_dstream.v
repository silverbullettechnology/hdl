
module srio_type9_dstream
(
    input             clk,
    input             reset,

    output         ireq_tvalid,
    input          ireq_tready,
    output         ireq_tlast,
    output  [63:0] ireq_tdata,
    output   [7:0] ireq_tkeep,
    output  [31:0] ireq_tuser,

    input             user_ireq_tvalid,
    output            user_ireq_tready,
    input             user_ireq_tlast,
    input  [63:0]     user_ireq_tdata,
    input   [7:0]     user_ireq_tkeep,
    input  [31:0]     user_ireq_tuser
);


wire            w_tvalid;
wire            w_tready;
wire            w_tlast;
wire  [63:0]    w_tdata;
wire   [7:0]    w_tkeep;
wire  [31:0]    w_tuser;


dstream_seg_srio_gen2_0 dstream_seg_srio_gen2_0
(
  .clk   (clk),
  .reset (reset),

.user_ireq_tvalid  (user_ireq_tvalid),
.user_ireq_tready  (user_ireq_tready),
.user_ireq_tlast   (user_ireq_tlast),
.user_ireq_tdata   (user_ireq_tdata),
.user_ireq_tkeep   (user_ireq_tkeep),
.user_ireq_tuser   (user_ireq_tuser),

.ireq_tvalid  (w_tvalid),
.ireq_tready  (w_tready),
.ireq_tlast   (w_tlast),
.ireq_tdata   (w_tdata),
.ireq_tkeep   (w_tkeep),
.ireq_tuser   (w_tuser)

);

axis_reg axis_reg
(
  .AXIS_ACLK    (clk),
  .AXIS_ARESETN (~reset),
  
  .S_AXIS_TREADY  (w_tready),
  .S_AXIS_TDATA   (w_tdata),
  .S_AXIS_TLAST   (w_tlast),
  .S_AXIS_TVALID  (w_tvalid),
  .S_AXIS_TKEEP   (w_tkeep),
  .S_AXIS_TUSER   (w_tuser),
 
  .M_AXIS_TVALID  (ireq_tvalid),
  .M_AXIS_TDATA   (ireq_tdata),
  .M_AXIS_TKEEP   (ireq_tkeep),
  .M_AXIS_TLAST   (ireq_tlast),
  .M_AXIS_TUSER   (ireq_tuser),
  .M_AXIS_TREADY  (ireq_tready)
);
   
endmodule

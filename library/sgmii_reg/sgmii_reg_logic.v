
module sgmii_reg_logic
(
  input wire ARESETN,
  input wire mdc,
  input wire gmii_txclk,
  input wire gmii_rxclk,

  // from procesor 
  input wire [31:0] cnt_ctrl, 
  output wire [31:0] mdc_cnt,
  output wire [31:0] gmii_txclk_cnt,
  output wire [31:0] gmii_rxclk_cnt
 );

// control signals

reg [31:0] mdc_cnt_reg;
reg [31:0] gmii_txclk_cnt_reg;
reg [31:0] gmii_rxclk_cnt_reg;

assign rst_0 = cnt_ctrl[0];
assign rst_1 = cnt_ctrl[1];
assign rst_2 = cnt_ctrl[2];
 
assign en_0 = cnt_ctrl[16];
assign en_1 = cnt_ctrl[17];
assign en_2 = cnt_ctrl[18];

always @ (posedge mdc)
 begin
	if (ARESETN == 'b0) mdc_cnt_reg <= 'h0;
	else mdc_cnt_reg <= (en_0)? mdc_cnt_reg + 1 : mdc_cnt_reg;
end
always @ (posedge gmii_txclk)
 begin
	if (ARESETN == 'b0) gmii_txclk_cnt_reg <= 'h0;
	else gmii_txclk_cnt_reg <= (en_1)? gmii_txclk_cnt_reg + 1 : gmii_txclk_cnt_reg;
end
always @ (posedge gmii_rxclk)
 begin
	if (ARESETN == 'b0) gmii_rxclk_cnt_reg <= 'h0;
	else gmii_rxclk_cnt_reg <= (en_2)? gmii_rxclk_cnt_reg + 1 : gmii_rxclk_cnt_reg;
end

assign mdc_cnt        = mdc_cnt_reg;
assign gmii_txclk_cnt = gmii_txclk_cnt_reg;
assign gmii_rxclk_cnt = gmii_rxclk_cnt_reg;




endmodule

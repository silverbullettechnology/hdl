
`define C_S_AXI_DATA_WIDTH 32
`define C_S_AXI_ADDR_WIDTH 5

module sgmii_reg
(
  ////////////////////////////////////////////////////////////////////////////
  // AXI-LITE

  input wire S_AXI_ACLK,
  input wire S_AXI_ARESETN,
  input  wire [`C_S_AXI_ADDR_WIDTH - 1:0] S_AXI_AWADDR,
  input  wire                          S_AXI_AWVALID,
  output wire                          S_AXI_AWREADY,
  input  wire [`C_S_AXI_DATA_WIDTH-1:0] S_AXI_WDATA,
  input  wire [`C_S_AXI_DATA_WIDTH/8-1:0] S_AXI_WSTRB,
  input  wire                          S_AXI_WVALID,
  output wire                          S_AXI_WREADY,
  output wire [1:0]                    S_AXI_BRESP,
  output wire                          S_AXI_BVALID,
  input  wire                          S_AXI_BREADY,
  input  wire [`C_S_AXI_ADDR_WIDTH - 1:0] S_AXI_ARADDR,
  input  wire                          S_AXI_ARVALID,
  output wire                          S_AXI_ARREADY,
  output wire [`C_S_AXI_DATA_WIDTH-1:0] S_AXI_RDATA,
  output wire [1:0]                    S_AXI_RRESP,
  output wire                          S_AXI_RVALID,
  input  wire                          S_AXI_RREADY,

  output wire sgmii_reset,
  output wire signal_detect,
  
  input wire [15:0] status_vector,
  input wire gmii_isolate,
  input wire mcmm_locked,
  
  output wire [4:0] configuration_vector,
  output wire configuration_valid,

  output wire [15:0] an_adv_config_vector,
  output wire an_adv_config_val,
  output wire an_restart_config,
  
  input wire mdc,
  input wire gmii_txclk,
  input wire gmii_rxclk
 );

wire [31:0] cnt_ctrl; 
wire [31:0] mdc_cnt;
wire [31:0] gmii_txclk_cnt;
wire [31:0] gmii_rxclk_cnt;
 

sgmii_reg_if sgmii_reg_if (
  .S_AXI_ACLK    (S_AXI_ACLK),
  .S_AXI_ARESETN (S_AXI_ARESETN),
  .S_AXI_AWADDR  (S_AXI_AWADDR),
  .S_AXI_AWVALID (S_AXI_AWVALID),
  .S_AXI_AWREADY (S_AXI_AWREADY),
  .S_AXI_WDATA   (S_AXI_WDATA),
  .S_AXI_WSTRB   (S_AXI_WSTRB),
  .S_AXI_WVALID  (S_AXI_WVALID),
  .S_AXI_WREADY  (S_AXI_WREADY),
  .S_AXI_BRESP   (S_AXI_BRESP),
  .S_AXI_BVALID  (S_AXI_BVALID),
  .S_AXI_BREADY  (S_AXI_BREADY),
  .S_AXI_ARADDR  (S_AXI_ARADDR),
  .S_AXI_ARVALID (S_AXI_ARVALID),
  .S_AXI_ARREADY (S_AXI_ARREADY),
  .S_AXI_RDATA   (S_AXI_RDATA),
  .S_AXI_RRESP   (S_AXI_RRESP),
  .S_AXI_RVALID  (S_AXI_RVALID),
  .S_AXI_RREADY  (S_AXI_RREADY),
  
  .sgmii_reset(sgmii_reset),
  .signal_detect(signal_detect),
  
  .status_vector(status_vector),
  .gmii_isolate(gmii_isolate),
  .mcmm_locked(mcmm_locked),
  
  .configuration_vector(configuration_vector),
  .configuration_valid(configuration_valid),

  .an_adv_config_vector(an_adv_config_vector),
  .an_adv_config_val(an_adv_config_val),
  .an_restart_config(an_restart_config),
  
  .cnt_ctrl(cnt_ctrl),
  .mdc_cnt(mdc_cnt),
  .gmii_rxclk_cnt(gmii_rxclk_cnt),
  .gmii_txclk_cnt(gmii_txclk_cnt)
);
  
sgmii_reg_logic  sgmii_reg_logic
(
  .ARESETN (S_AXI_ARESETN),
  .mdc(mdc),
  .gmii_txclk(gmii_txclk),
  .gmii_rxclk(gmii_rxclk),

  .cnt_ctrl(cnt_ctrl), 
  .mdc_cnt(mdc_cnt),
  .gmii_txclk_cnt(gmii_txclk_cnt),
  .gmii_rxclk_cnt(gmii_rxclk_cnt)
 );

  
endmodule

// ***************************************************************************
// ***************************************************************************
// Copyright 2011(c) Analog Devices, Inc.
// 
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//     - Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     - Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in
//       the documentation and/or other materials provided with the
//       distribution.
//     - Neither the name of Analog Devices, Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//     - The use of this software may or may not infringe the patent rights
//       of one or more patent holders.  This license does not release you
//       from the requirement that you obtain separate licenses from these
//       patent holders to use this software.
//     - Use of the software either in source or binary form, must be run
//       on or directly connected to an Analog Devices Inc. component.
//    
// THIS SOFTWARE IS PROVIDED BY ANALOG DEVICES "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A
// PARTICULAR PURPOSE ARE DISCLAIMED.
//
// IN NO EVENT SHALL ANALOG DEVICES BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, INTELLECTUAL PROPERTY
// RIGHTS, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR 
// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF 
// THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module system_top (

  DDR_addr,
  DDR_ba,
  DDR_cas_n,
  DDR_ck_n,
  DDR_ck_p,
  DDR_cke,
  DDR_cs_n,
  DDR_dm,
  DDR_dq,
  DDR_dqs_n,
  DDR_dqs_p,
  DDR_odt,
  DDR_ras_n,
  DDR_reset_n,
  DDR_we_n,

  FIXED_IO_ddr_vrn,
  FIXED_IO_ddr_vrp,
  FIXED_IO_mio,
  FIXED_IO_ps_clk,
  FIXED_IO_ps_porb,
  FIXED_IO_ps_srstb,

  ps7_gpio,
  
  rx_clk_in_0_p,
  rx_clk_in_0_n,
  rx_frame_in_0_p,
  rx_frame_in_0_n,
  rx_data_in_0_p,
  rx_data_in_0_n,
  tx_clk_out_0_p,
  tx_clk_out_0_n,
  tx_frame_out_0_p,
  tx_frame_out_0_n,
  tx_data_out_0_p,
  tx_data_out_0_n,

  rx_clk_in_1_p,
  rx_clk_in_1_n,
  rx_frame_in_1_p,
  rx_frame_in_1_n,
  rx_data_in_1_p,
  rx_data_in_1_n,
  tx_clk_out_1_p,
  tx_clk_out_1_n,
  tx_frame_out_1_p,
  tx_frame_out_1_n,
  tx_data_out_1_p,
  tx_data_out_1_n,

    sgmii_refclk125_n,
    sgmii_refclk125_p,
    sgmii_rxn,
    sgmii_rxp,
    sgmii_txn,
    sgmii_txp,
 
//  spi0_clk,
//  spi0_mosi,
//  spi0_miso,
//  spi1_clk,
//  spi1_mosi,
//  spi1_miso,
  
  axi_gpio);

  inout   [14:0]  DDR_addr;
  inout   [ 2:0]  DDR_ba;
  inout           DDR_cas_n;
  inout           DDR_ck_n;
  inout           DDR_ck_p;
  inout           DDR_cke;
  inout           DDR_cs_n;
  inout   [ 3:0]  DDR_dm;
  inout   [31:0]  DDR_dq;
  inout   [ 3:0]  DDR_dqs_n;
  inout   [ 3:0]  DDR_dqs_p;
  inout           DDR_odt;
  inout           DDR_ras_n;
  inout           DDR_reset_n;
  inout           DDR_we_n;

  inout           FIXED_IO_ddr_vrn;
  inout           FIXED_IO_ddr_vrp;
  inout   [53:0]  FIXED_IO_mio;
  inout           FIXED_IO_ps_clk;
  inout           FIXED_IO_ps_porb;
  inout           FIXED_IO_ps_srstb;

  inout   [45:0]  ps7_gpio;

  input           rx_clk_in_0_p;
  input           rx_clk_in_0_n;
  input           rx_frame_in_0_p;
  input           rx_frame_in_0_n;
  input   [ 5:0]  rx_data_in_0_p;
  input   [ 5:0]  rx_data_in_0_n;
  output          tx_clk_out_0_p;
  output          tx_clk_out_0_n;
  output          tx_frame_out_0_p;
  output          tx_frame_out_0_n;
  output  [ 5:0]  tx_data_out_0_p;
  output  [ 5:0]  tx_data_out_0_n;

  input           rx_clk_in_1_p;
  input           rx_clk_in_1_n;
  input           rx_frame_in_1_p;
  input           rx_frame_in_1_n;
  input   [ 5:0]  rx_data_in_1_p;
  input   [ 5:0]  rx_data_in_1_n;
  output          tx_clk_out_1_p;
  output          tx_clk_out_1_n;
  output          tx_frame_out_1_p;
  output          tx_frame_out_1_n;
  output  [ 5:0]  tx_data_out_1_p;
  output  [ 5:0]  tx_data_out_1_n;

//  output          spi0_clk;
//  output          spi0_mosi;
//  input           spi0_miso;
//  output          spi1_clk;
//  output          spi1_mosi;
//  input           spi1_miso;
  
  input sgmii_refclk125_n;
  input sgmii_refclk125_p;
  input sgmii_rxn;
  input sgmii_rxp;
  output sgmii_txn;
  output sgmii_txp;
  
  input [15:0] axi_gpio;

  // internal signals

  wire    [54:0]  gpio_i;
  wire    [54:0]  gpio_o;
  wire    [54:0]  gpio_t;
  
  genvar n;
  generate
  for (n = 0; n <= 54; n = n + 1) begin: g_iobuf_gpio_bd
  IOBUF i_iobuf_gpio_bd (
    .I (gpio_o[n]),
    .O (gpio_i[n]),
    .T (gpio_t[n]),
    .IO (ps7_gpio[n]));
  end
  endgenerate

  system_wrapper i_system_wrapper (
    .DDR_addr (DDR_addr),
    .DDR_ba (DDR_ba),
    .DDR_cas_n (DDR_cas_n),
    .DDR_ck_n (DDR_ck_n),
    .DDR_ck_p (DDR_ck_p),
    .DDR_cke (DDR_cke),
    .DDR_cs_n (DDR_cs_n),
    .DDR_dm (DDR_dm),
    .DDR_dq (DDR_dq),
    .DDR_dqs_n (DDR_dqs_n),
    .DDR_dqs_p (DDR_dqs_p),
    .DDR_odt (DDR_odt),
    .DDR_ras_n (DDR_ras_n),
    .DDR_reset_n (DDR_reset_n),
    .DDR_we_n (DDR_we_n),
    .FIXED_IO_ddr_vrn (FIXED_IO_ddr_vrn),
    .FIXED_IO_ddr_vrp (FIXED_IO_ddr_vrp),
    .FIXED_IO_mio (FIXED_IO_mio),
    .FIXED_IO_ps_clk (FIXED_IO_ps_clk),
    .FIXED_IO_ps_porb (FIXED_IO_ps_porb),
    .FIXED_IO_ps_srstb (FIXED_IO_ps_srstb),
    .GPIO_I (gpio_i),
    .GPIO_O (gpio_o),
    .GPIO_T (gpio_t),

    .rx_clk_in_0_n (rx_clk_in_0_n),
    .rx_clk_in_0_p (rx_clk_in_0_p),
    .rx_data_in_0_n (rx_data_in_0_n),
    .rx_data_in_0_p (rx_data_in_0_p),
    .rx_frame_in_0_n (rx_frame_in_0_n),
    .rx_frame_in_0_p (rx_frame_in_0_p),

    .rx_clk_in_1_n (rx_clk_in_1_n),
    .rx_clk_in_1_p (rx_clk_in_1_p),
    .rx_data_in_1_n (rx_data_in_1_n),
    .rx_data_in_1_p (rx_data_in_1_p),
    .rx_frame_in_1_n (rx_frame_in_1_n),
    .rx_frame_in_1_p (rx_frame_in_1_p),
    
//    .spi0_csn_i (1'b1),
//    .spi0_miso_i (spi0_miso),
//    .spi0_mosi_i (1'b0),
//    .spi0_mosi_o (spi0_mosi),
//    .spi0_sclk_i (1'b0),
//    .spi0_sclk_o (spi0_clk),

//    .spi1_csn_i (1'b1),
//    .spi1_miso_i (spi1_miso),
//    .spi1_mosi_i (1'b0),
//    .spi1_mosi_o (spi1_mosi),
//    .spi1_sclk_i (1'b0),
//    .spi1_sclk_o (spi1_clk),
    
    .tx_clk_out_0_n (tx_clk_out_0_n),
    .tx_clk_out_0_p (tx_clk_out_0_p),
    .tx_data_out_0_n (tx_data_out_0_n),
    .tx_data_out_0_p (tx_data_out_0_p),
    .tx_frame_out_0_n (tx_frame_out_0_n),
    .tx_frame_out_0_p (tx_frame_out_0_p),

    .tx_clk_out_1_n (tx_clk_out_1_n),
    .tx_clk_out_1_p (tx_clk_out_1_p),
    .tx_data_out_1_n (tx_data_out_1_n),
    .tx_data_out_1_p (tx_data_out_1_p),
    .tx_frame_out_1_n (tx_frame_out_1_n),
    .tx_frame_out_1_p (tx_frame_out_1_p),

    .sgmii_refclk125_n (sgmii_refclk125_n),
    .sgmii_refclk125_p (sgmii_refclk125_p),
    .sgmii_rxn (sgmii_rxn),
    .sgmii_rxp (sgmii_rxp),
    .sgmii_txn (sgmii_txn),
    .sgmii_txp (sgmii_txp),
    
    .axi_gpio (axi_gpio)
    
    );

endmodule

// ***************************************************************************
// ***************************************************************************

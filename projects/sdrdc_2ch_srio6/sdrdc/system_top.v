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

  // to connect clock on 105 board (sdrdc only)
  iic_1_scl_io,
  iic_1_sda_io,

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

  spi_csn0,
  spi_csn1,
  spi_clk,
  spi_mosi,
  spi_miso,
  
  axi_gpio,
  

  srio_rxn0,
  srio_rxp0,
  srio_rxn1,
  srio_rxp1,
  srio_rxn2,
  srio_rxp2,
  srio_rxn3,
  srio_rxp3,
  srio_sys_clkn,
  srio_sys_clkp,
  srio_txn0,
  srio_txp0,
  srio_txn1,
  srio_txp1,
  srio_txn2,
  srio_txp2,
  srio_txn3,
  srio_txp3  
  );

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

  inout iic_1_scl_io;
  inout iic_1_sda_io;

  inout   [53:0]  ps7_gpio;

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
  
  output          spi_csn0;
  output          spi_csn1;
  output          spi_clk;
  output          spi_mosi;
  input           spi_miso;
  
  input [23:0] axi_gpio;

  input srio_sys_clkn;
  input srio_sys_clkp;
  output srio_txn0;
  output srio_txp0;
  input srio_rxn0;
  input srio_rxp0;
  output srio_txn1;
  output srio_txp1;
  input srio_rxn1;
  input srio_rxp1;

  output srio_txn2;
  output srio_txp2;
  input srio_rxn2;
  input srio_rxp2;
  output srio_txn3;
  output srio_txp3;
  input srio_rxn3;
  input srio_rxp3;


  // internal signals

  wire    [53:0]  gpio_i;
  wire    [53:0]  gpio_o;
  wire    [53:0]  gpio_t;
  
  genvar n;
  generate
  for (n = 0; n <= 53; n = n + 1) begin: g_iobuf_gpio_bd
  IOBUF i_iobuf_gpio_bd (
    .I (gpio_o[n]),
    .O (gpio_i[n]),
    .T (gpio_t[n]),
    .IO (ps7_gpio[n]));
  end
  endgenerate

//IOBUF iic_1_scl_iobuf
//       (.I(iic_1_scl_o),
//        .IO(iic_1_scl_io),
//        .O(iic_1_scl_i),
//        .T(iic_1_scl_t));
//IOBUF iic_1_sda_iobuf
//       (.I(iic_1_sda_o),
//        .IO(iic_1_sda_io),
//        .O(iic_1_sda_i),
//        .T(iic_1_sda_t));


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

    .iic_1_scl_io(iic_1_scl_io),
    .iic_1_sda_io(iic_1_sda_io),

//    .IIC_1_scl_i(iic_1_scl_i),
//    .IIC_1_scl_o(iic_1_scl_o),
//    .IIC_1_scl_t(iic_1_scl_t),
//    .IIC_1_sda_i(iic_1_sda_i),
//    .IIC_1_sda_o(iic_1_sda_o),
//    .IIC_1_sda_t(iic_1_sda_t),

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
    
    .spi_csn_0_i (1'b1),
    .spi_csn_0_o (spi_csn0),    
    .spi_csn_1_o (spi_csn1),    
    .spi_csn_2_o ( ),    
    .spi_miso_i (spi_miso),
    .spi_mosi_i (1'b0),
    .spi_mosi_o (spi_mosi),
    .spi_sclk_i (1'b0),
    .spi_sclk_o (spi_clk),
    
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
    
    .axi_gpio (axi_gpio),

    .srio_rxn0(srio_rxn0),
    .srio_rxp0(srio_rxp0),
    .srio_rxn1(srio_rxn1),
    .srio_rxp1(srio_rxp1),
    .srio_rxn2(srio_rxn2),
    .srio_rxp2(srio_rxp2),
    .srio_rxn3(srio_rxn3),
    .srio_rxp3(srio_rxp3),
    .srio_sys_clkn(srio_sys_clkn),
    .srio_sys_clkp(srio_sys_clkp),
    .srio_txn0(srio_txn0),
    .srio_txp0(srio_txp0),
    .srio_txn1(srio_txn1),
    .srio_txp1(srio_txp1),
    .srio_txn2(srio_txn2),
    .srio_txp2(srio_txp2),
    .srio_txn3(srio_txn3),
    .srio_txp3(srio_txp3)
    
    );

endmodule

// ***************************************************************************
// ***************************************************************************

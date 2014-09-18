
# constraints
# ad9361 

set_property  -dict {PACKAGE_PIN  Y12  IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_clk_in_p]        ; ##  
set_property  -dict {PACKAGE_PIN  Y11  IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_clk_in_n]        ; ## 
      
set_property  -dict {PACKAGE_PIN  AA17 IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_frame_in_p]      ; ##     
set_property  -dict {PACKAGE_PIN  AB17 IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_frame_in_n]      ; ##   

set_property  -dict {PACKAGE_PIN  T10  IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_p[0]]    ; ##     
set_property  -dict {PACKAGE_PIN  T9   IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_n[0]]    ; ##  
set_property  -dict {PACKAGE_PIN  Y9   IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_p[1]]    ; ##       
set_property  -dict {PACKAGE_PIN  AA9  IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_n[1]]    ; ##     
set_property  -dict {PACKAGE_PIN  U9   IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_p[2]]    ; ##          
set_property  -dict {PACKAGE_PIN  U8   IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_n[2]]    ; ##           
set_property  -dict {PACKAGE_PIN  W9   IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_p[3]]    ; ##         
set_property  -dict {PACKAGE_PIN  Y8   IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_n[3]]    ; ##           
set_property  -dict {PACKAGE_PIN  V8   IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_p[4]]    ; ##          
set_property  -dict {PACKAGE_PIN  W8   IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_n[4]]    ; ##       
set_property  -dict {PACKAGE_PIN  U10  IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_p[5]]    ; ## 
set_property  -dict {PACKAGE_PIN  V10  IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_n[5]]    ; ## 

set_property  -dict {PACKAGE_PIN  W14  IOSTANDARD LVDS_25} [get_ports tx_clk_out_p]                      ; ##        
set_property  -dict {PACKAGE_PIN  W13  IOSTANDARD LVDS_25} [get_ports tx_clk_out_n]                      ; ##           

set_property  -dict {PACKAGE_PIN  AA15 IOSTANDARD LVDS_25} [get_ports tx_frame_out_p]                    ; ## 
set_property  -dict {PACKAGE_PIN  AB15 IOSTANDARD LVDS_25} [get_ports tx_frame_out_n]                    ; ##       

set_property  -dict {PACKAGE_PIN  AB9  IOSTANDARD LVDS_25} [get_ports tx_data_out_p[0]]                  ; ## 
set_property  -dict {PACKAGE_PIN  AB8  IOSTANDARD LVDS_25} [get_ports tx_data_out_n[0]]                  ; ## 
set_property  -dict {PACKAGE_PIN  AB13 IOSTANDARD LVDS_25} [get_ports tx_data_out_p[1]]                  ; ## 
set_property  -dict {PACKAGE_PIN  AB12 IOSTANDARD LVDS_25} [get_ports tx_data_out_n[1]]                  ; ## 
set_property  -dict {PACKAGE_PIN  AA10 IOSTANDARD LVDS_25} [get_ports tx_data_out_p[2]]                  ; ##
set_property  -dict {PACKAGE_PIN  AB10 IOSTANDARD LVDS_25} [get_ports tx_data_out_n[2]]                  ; ## 
set_property  -dict {PACKAGE_PIN  AA12 IOSTANDARD LVDS_25} [get_ports tx_data_out_p[3]]                  ; ## 
set_property  -dict {PACKAGE_PIN  AA11 IOSTANDARD LVDS_25} [get_ports tx_data_out_n[3]]                  ; ## 
set_property  -dict {PACKAGE_PIN  Y16  IOSTANDARD LVDS_25} [get_ports tx_data_out_p[4]]                  ; ## 
set_property  -dict {PACKAGE_PIN  AA16 IOSTANDARD LVDS_25} [get_ports tx_data_out_n[4]]                  ; ## 
set_property  -dict {PACKAGE_PIN  AA14 IOSTANDARD LVDS_25} [get_ports tx_data_out_p[5]]                  ; ##        
set_property  -dict {PACKAGE_PIN  AB14 IOSTANDARD LVDS_25} [get_ports tx_data_out_n[5]]                  ; ##     

set_property  -dict {PACKAGE_PIN  A2  IOSTANDARD LVCMOS18  PULLTYPE PULLUP} [get_ports spi_miso]        ; ## PL_Bank35_SPI1_MISO          
set_property  -dict {PACKAGE_PIN  B2  IOSTANDARD LVCMOS18  PULLTYPE PULLUP} [get_ports spi_mosi]        ; ## PL_Bank35_SPI1_MOSI          
set_property  -dict {PACKAGE_PIN  A1  IOSTANDARD LVCMOS18  PULLTYPE PULLUP} [get_ports spi_clk]         ; ## PL_Bank35_SPI1_CK          
set_property  -dict {PACKAGE_PIN  B4  IOSTANDARD LVCMOS18  PULLTYPE PULLUP} [get_ports spi_csn]         ; ## PL_Bank35_SPI1_AD1_CS         


##  GPIO
##  LEDs
set_property  -dict {PACKAGE_PIN  Y22  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[0]]                   ;
set_property  -dict {PACKAGE_PIN  V21  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[1]]                   ;
set_property  -dict {PACKAGE_PIN  V22  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[2]]                   ;
set_property  -dict {PACKAGE_PIN  W19  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[3]]                   ;

## ADI reset
set_property  -dict {PACKAGE_PIN  T11  IOSTANDARD LVCMOS25} [get_ports ps7_gpio[4]]                   ; ## AD1_RESET
set_property  -dict {PACKAGE_PIN  C3   IOSTANDARD LVCMOS18} [get_ports ps7_gpio[5]]                   ; ## AD2_RESET

## ASFE signals
set_property  -dict {PACKAGE_PIN  AA22 IOSTANDARD LVCMOS33} [get_ports ps7_gpio[6]]                   ; ## ASFE_Spare_1
set_property  -dict {PACKAGE_PIN  AB22 IOSTANDARD LVCMOS33} [get_ports ps7_gpio[7]]                   ; ## ASFE_Spare_2
set_property  -dict {PACKAGE_PIN  W21  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[8]]                   ; ## ASFE_RSTN
set_property  -dict {PACKAGE_PIN  AA20 IOSTANDARD LVCMOS33} [get_ports ps7_gpio[9]]                   ; ## ADI1_TX_EN
set_property  -dict {PACKAGE_PIN  U18  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[10]]                  ; ## ASFE_Reserve1
set_property  -dict {PACKAGE_PIN  V18  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[11]]                  ; ## ASFE_Reserve2
set_property  -dict {PACKAGE_PIN  N20  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[12]]                  ; ## ASFE_Reserve4
set_property  -dict {PACKAGE_PIN  P20  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[13]]                  ; ## ASFE_Reserve3
set_property  -dict {PACKAGE_PIN  AB20 IOSTANDARD LVCMOS33} [get_ports ps7_gpio[14]]                  ; ## ADI2_TX_EN
set_property  -dict {PACKAGE_PIN  Y21  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[15]]                  ; ## ASFE_Spare_3
set_property  -dict {PACKAGE_PIN  AA21 IOSTANDARD LVCMOS33} [get_ports ps7_gpio[16]]                  ; ## ASFE_Spare_4

## ADAPT signals
set_property  -dict {PACKAGE_PIN  N21  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[17]]                  ; ## IO60PPB1
set_property  -dict {PACKAGE_PIN  N22  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[18]]                  ; ## IO60NPB1
set_property  -dict {PACKAGE_PIN  R22  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[19]]                  ; ## IO63PPB1
set_property  -dict {PACKAGE_PIN  T22  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[20]]                  ; ## IO63NPB1
set_property  -dict {PACKAGE_PIN  T21  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[21]]                  ; ## IO62PDB1
set_property  -dict {PACKAGE_PIN  U22  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[22]]                  ; ## IO62NDB1
set_property  -dict {PACKAGE_PIN  P21  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[23]]                  ; ## IO64PDB1
set_property  -dict {PACKAGE_PIN  R21  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[24]]                  ; ## IO64NDB1
set_property  -dict {PACKAGE_PIN  T20  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[25]]                  ; ## IO67PDB1
set_property  -dict {PACKAGE_PIN  U20  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[26]]                  ; ## IO67NDB1
set_property  -dict {PACKAGE_PIN  R19  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[27]]                  ; ## IO68PDB1
set_property  -dict {PACKAGE_PIN  T19  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[28]]                  ; ## IO68NDB1
set_property  -dict {PACKAGE_PIN  T17  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[29]]                  ; ## IO69PDB1
set_property  -dict {PACKAGE_PIN  U17  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[30]]                  ; ## IO69NDB1
set_property  -dict {PACKAGE_PIN  R17  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[31]]                  ; ## IO70PDB1
set_property  -dict {PACKAGE_PIN  R18  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[32]]                  ; ## IO70NDB1

##USB reset
set_property  -dict {PACKAGE_PIN  T15  IOSTANDARD LVCMOS33} [get_ports ps7_gpio[33]]                  ; ## USBPHY_RESET_B
##EMMC reset
set_property  -dict {PACKAGE_PIN  AA19 IOSTANDARD LVCMOS33} [get_ports ps7_gpio[34]]                  ; ## eMMC_RST_N

## SPI
set_property  -dict {PACKAGE_PIN  N17  IOSTANDARD LVCMOS33  PULLTYPE PULLUP} [get_ports ps7_gpio[35]] ; ## PL_Bank13_SPI0_MISO      
set_property  -dict {PACKAGE_PIN  P18  IOSTANDARD LVCMOS33  PULLTYPE PULLUP} [get_ports ps7_gpio[36]] ; ## PL_Bank13_SPI0_MOSI     
set_property  -dict {PACKAGE_PIN  N18  IOSTANDARD LVCMOS33  PULLTYPE PULLUP} [get_ports ps7_gpio[37]] ; ## PL_Bank13_SPI0_CK      
set_property  -dict {PACKAGE_PIN  T16  IOSTANDARD LVCMOS33  PULLTYPE PULLUP} [get_ports ps7_gpio[38]] ; ## PL_Bank13_SPI0_ASFE_SPI_CS    
set_property  -dict {PACKAGE_PIN  P19  IOSTANDARD LVCMOS33  PULLTYPE PULLUP} [get_ports ps7_gpio[39]] ; ## PL_Bank13_SPI0_TRSS_CS        

set_property  -dict {PACKAGE_PIN  W15  IOSTANDARD LVCMOS25} [get_ports ps7_gpio[40]]                  ; ## AD1_EN_AGC
set_property  -dict {PACKAGE_PIN  T12  IOSTANDARD LVCMOS25} [get_ports ps7_gpio[41]]                  ; ## AD1_CTL_IN0
set_property  -dict {PACKAGE_PIN  U12  IOSTANDARD LVCMOS25} [get_ports ps7_gpio[42]]                  ; ## AD1_CTL_IN1
set_property  -dict {PACKAGE_PIN  V16  IOSTANDARD LVCMOS25} [get_ports ps7_gpio[43]]                  ; ## AD1_CTL_IN2
set_property  -dict {PACKAGE_PIN  W16  IOSTANDARD LVCMOS25} [get_ports ps7_gpio[44]]                  ; ## AD1_CTL_IN3
set_property  -dict {PACKAGE_PIN  U13  IOSTANDARD LVCMOS25} [get_ports ps7_gpio[45]]                  ; ## AD1_ENABLE
set_property  -dict {PACKAGE_PIN  V11  IOSTANDARD LVCMOS25} [get_ports ps7_gpio[46]]                  ; ## AD1_TXNRX

set_property  -dict {PACKAGE_PIN  P3   IOSTANDARD LVCMOS18} [get_ports ps7_gpio[47]]                  ; ## AD2_EN_AGC
set_property  -dict {PACKAGE_PIN  M3   IOSTANDARD LVCMOS18} [get_ports ps7_gpio[48]]                  ; ## AD2_CTL_IN0
set_property  -dict {PACKAGE_PIN  M2   IOSTANDARD LVCMOS18} [get_ports ps7_gpio[49]]                  ; ## AD2_CTL_IN1
set_property  -dict {PACKAGE_PIN  K3   IOSTANDARD LVCMOS18} [get_ports ps7_gpio[50]]                  ; ## AD2_CTL_IN2
set_property  -dict {PACKAGE_PIN  K2   IOSTANDARD LVCMOS18} [get_ports ps7_gpio[51]]                  ; ## AD2_CTL_IN3
set_property  -dict {PACKAGE_PIN  N3   IOSTANDARD LVCMOS18} [get_ports ps7_gpio[52]]                  ; ## AD2_ENABLE
set_property  -dict {PACKAGE_PIN  D3   IOSTANDARD LVCMOS18} [get_ports ps7_gpio[53]]                  ; ## AD2_TXNRX

# clocks

create_clock -name rx_clk       -period  5 [get_ports rx_clk_in_p]
create_clock -name ad9361_clk   -period  5 [get_pins i_system_wrapper/system_i/axi_ad9361/clk]
create_clock -name fmc_dma_clk  -period  10.00 [get_pins i_system_wrapper/system_i/sys_ps7/FCLK_CLK2]

set_clock_groups -asynchronous -group {ad9361_clk}
set_clock_groups -asynchronous -group {fmc_dma_clk}



    # tdsdr_2chan



    set spi0_csn_i      [create_bd_port -dir I spi0_csn_i]
    set spi0_sclk_i      [create_bd_port -dir I spi0_sclk_i]
    set spi0_sclk_o      [create_bd_port -dir O spi0_sclk_o]
    set spi0_mosi_i      [create_bd_port -dir I spi0_mosi_i]
    set spi0_mosi_o      [create_bd_port -dir O spi0_mosi_o]
    set spi0_miso_i      [create_bd_port -dir I spi0_miso_i]

    set spi1_csn_i      [create_bd_port -dir I spi1_csn_i]
    set spi1_sclk_i      [create_bd_port -dir I spi1_sclk_i]
    set spi1_sclk_o      [create_bd_port -dir O spi1_sclk_o]
    set spi1_mosi_i      [create_bd_port -dir I spi1_mosi_i]
    set spi1_mosi_o      [create_bd_port -dir O spi1_mosi_o]
    set spi1_miso_i      [create_bd_port -dir I spi1_miso_i]

    set rx_clk_in_0_p     [create_bd_port -dir I rx_clk_in_0_p]
    set rx_clk_in_0_n     [create_bd_port -dir I rx_clk_in_0_n]
    set rx_frame_in_0_p   [create_bd_port -dir I rx_frame_in_0_p]
    set rx_frame_in_0_n   [create_bd_port -dir I rx_frame_in_0_n]
    set rx_data_in_0_p    [create_bd_port -dir I -from 5 -to 0 rx_data_in_0_p]
    set rx_data_in_0_n    [create_bd_port -dir I -from 5 -to 0 rx_data_in_0_n]
    set tx_clk_out_0_p    [create_bd_port -dir O tx_clk_out_0_p]
    set tx_clk_out_0_n    [create_bd_port -dir O tx_clk_out_0_n]
    set tx_frame_out_0_p  [create_bd_port -dir O tx_frame_out_0_p]
    set tx_frame_out_0_n  [create_bd_port -dir O tx_frame_out_0_n]
    set tx_data_out_0_p   [create_bd_port -dir O -from 5 -to 0 tx_data_out_0_p]
    set tx_data_out_0_n   [create_bd_port -dir O -from 5 -to 0 tx_data_out_0_n]

    set rx_clk_in_1_p     [create_bd_port -dir I rx_clk_in_1_p]
    set rx_clk_in_1_n     [create_bd_port -dir I rx_clk_in_1_n]
    set rx_frame_in_1_p   [create_bd_port -dir I rx_frame_in_1_p]
    set rx_frame_in_1_n   [create_bd_port -dir I rx_frame_in_1_n]
    set rx_data_in_1_p    [create_bd_port -dir I -from 5 -to 0 rx_data_in_1_p]
    set rx_data_in_1_n    [create_bd_port -dir I -from 5 -to 0 rx_data_in_1_n]
    set tx_clk_out_1_p    [create_bd_port -dir O tx_clk_out_1_p]
    set tx_clk_out_1_n    [create_bd_port -dir O tx_clk_out_1_n]
    set tx_frame_out_1_p  [create_bd_port -dir O tx_frame_out_1_p]
    set tx_frame_out_1_n  [create_bd_port -dir O tx_frame_out_1_n]
    set tx_data_out_1_p   [create_bd_port -dir O -from 5 -to 0 tx_data_out_1_p]
    set tx_data_out_1_n   [create_bd_port -dir O -from 5 -to 0 tx_data_out_1_n]
    
    set axi_gpio [create_bd_port -dir I -from 15 -to 0 axi_gpio]


## INSTANTIATIONS

    # constant 0
    set constant_0 [create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 constant_0]
    set_property -dict [list CONFIG.CONST_VAL {0}] $constant_0

    # axi_gpio
    set axi_gpio [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio]
    set_property -dict [list CONFIG.C_GPIO_WIDTH {16}] $axi_gpio
    set_property -dict [list CONFIG.C_ALL_INPUTS {1} ] $axi_gpio
    set_property -dict [list CONFIG.C_INTERRUPT_PRESENT {1}] $axi_gpio


    # ad9361_0 core
    set axi_ad9361_0 [create_bd_cell -type ip -vlnv analog.com:user:axi_ad9361:1.0 axi_ad9361_0]
    set_property -dict [list CONFIG.PCORE_ID {0}] $axi_ad9361_0
    set_property -dict [list CONFIG.PCORE_IODELAY_GROUP {dev_0_if_delay_group}] $axi_ad9361_0

    set axi_ad9361_0_dac_dma [create_bd_cell -type ip -vlnv analog.com:user:axi_dmac:1.0 axi_ad9361_0_dac_dma]
    set_property -dict [list CONFIG.C_DMA_TYPE_SRC {0}] $axi_ad9361_0_dac_dma
    set_property -dict [list CONFIG.C_DMA_TYPE_DEST {2}] $axi_ad9361_0_dac_dma
    set_property -dict [list CONFIG.C_CYCLIC {1}] $axi_ad9361_0_dac_dma
    set_property -dict [list CONFIG.C_SYNC_TRANSFER_START {0}] $axi_ad9361_0_dac_dma
    set_property -dict [list CONFIG.C_AXI_SLICE_SRC {0}] $axi_ad9361_0_dac_dma
    set_property -dict [list CONFIG.C_AXI_SLICE_DEST {1}] $axi_ad9361_0_dac_dma
    set_property -dict [list CONFIG.C_CLKS_ASYNC_DEST_REQ {1}] $axi_ad9361_0_dac_dma
    set_property -dict [list CONFIG.C_CLKS_ASYNC_SRC_DEST {1}] $axi_ad9361_0_dac_dma
    set_property -dict [list CONFIG.C_CLKS_ASYNC_REQ_SRC {1}] $axi_ad9361_0_dac_dma
    set_property -dict [list CONFIG.C_2D_TRANSFER {0}] $axi_ad9361_0_dac_dma
    set_property -dict [list CONFIG.C_DMA_DATA_WIDTH_DEST {128}] $axi_ad9361_0_dac_dma

    # channel packing for the ADC
    set util_adc_pack_0 [create_bd_cell -type ip -vlnv analog.com:user:util_adc_pack:1.0 util_adc_pack_0]
    set util_dac_unpack_0 [create_bd_cell -type ip -vlnv analog.com:user:util_dac_unpack:1.0 util_dac_unpack_0]

    set axi_ad9361_0_dac_dma_interconnect [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_ad9361_0_dac_dma_interconnect]
    set_property -dict [list CONFIG.NUM_MI {1}] $axi_ad9361_0_dac_dma_interconnect

    set axi_ad9361_0_adc_dma [create_bd_cell -type ip -vlnv analog.com:user:axi_dmac:1.0 axi_ad9361_0_adc_dma]
    set_property -dict [list CONFIG.C_DMA_TYPE_SRC {2}] $axi_ad9361_0_adc_dma
    set_property -dict [list CONFIG.C_DMA_TYPE_DEST {0}] $axi_ad9361_0_adc_dma
    set_property -dict [list CONFIG.C_CYCLIC {0}] $axi_ad9361_0_adc_dma
    set_property -dict [list CONFIG.C_SYNC_TRANSFER_START {1}] $axi_ad9361_0_adc_dma
    set_property -dict [list CONFIG.C_AXI_SLICE_SRC {0}] $axi_ad9361_0_adc_dma
    set_property -dict [list CONFIG.C_AXI_SLICE_DEST {0}] $axi_ad9361_0_adc_dma
    set_property -dict [list CONFIG.C_CLKS_ASYNC_DEST_REQ {1}] $axi_ad9361_0_adc_dma
    set_property -dict [list CONFIG.C_CLKS_ASYNC_SRC_DEST {1}] $axi_ad9361_0_adc_dma
    set_property -dict [list CONFIG.C_CLKS_ASYNC_REQ_SRC {1}] $axi_ad9361_0_adc_dma
    set_property -dict [list CONFIG.C_2D_TRANSFER {0}] $axi_ad9361_0_adc_dma
    set_property -dict [list CONFIG.C_DMA_DATA_WIDTH_SRC {128}]  $axi_ad9361_0_adc_dma

    set axi_ad9361_0_adc_dma_interconnect [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_ad9361_0_adc_dma_interconnect]
    set_property -dict [list CONFIG.NUM_MI {1}] $axi_ad9361_0_adc_dma_interconnect

    # ad9361_1 core
    set axi_ad9361_1 [create_bd_cell -type ip -vlnv analog.com:user:axi_ad9361:1.0 axi_ad9361_1]
    set_property -dict [list CONFIG.PCORE_ID {0}] $axi_ad9361_1
    set_property -dict [list CONFIG.PCORE_IODELAY_GROUP {dev_1_if_delay_group}] $axi_ad9361_1

    set axi_ad9361_1_dac_dma [create_bd_cell -type ip -vlnv analog.com:user:axi_dmac:1.0 axi_ad9361_1_dac_dma]
    set_property -dict [list CONFIG.C_DMA_TYPE_SRC {0}] $axi_ad9361_1_dac_dma
    set_property -dict [list CONFIG.C_DMA_TYPE_DEST {2}] $axi_ad9361_1_dac_dma
    set_property -dict [list CONFIG.C_CYCLIC {1}] $axi_ad9361_1_dac_dma
    set_property -dict [list CONFIG.C_SYNC_TRANSFER_START {0}] $axi_ad9361_1_dac_dma
    set_property -dict [list CONFIG.C_AXI_SLICE_SRC {0}] $axi_ad9361_1_dac_dma
    set_property -dict [list CONFIG.C_AXI_SLICE_DEST {1}] $axi_ad9361_1_dac_dma
    set_property -dict [list CONFIG.C_CLKS_ASYNC_DEST_REQ {1}] $axi_ad9361_1_dac_dma
    set_property -dict [list CONFIG.C_CLKS_ASYNC_SRC_DEST {1}] $axi_ad9361_1_dac_dma
    set_property -dict [list CONFIG.C_CLKS_ASYNC_REQ_SRC {1}] $axi_ad9361_1_dac_dma
    set_property -dict [list CONFIG.C_2D_TRANSFER {0}] $axi_ad9361_1_dac_dma
    set_property -dict [list CONFIG.C_DMA_DATA_WIDTH_DEST {128}] $axi_ad9361_1_dac_dma

    # channel packing for the ADC
    set util_adc_pack_1 [create_bd_cell -type ip -vlnv analog.com:user:util_adc_pack:1.0 util_adc_pack_1]
    set util_dac_unpack_1 [create_bd_cell -type ip -vlnv analog.com:user:util_dac_unpack:1.0 util_dac_unpack_1]

    set axi_ad9361_1_dac_dma_interconnect [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_ad9361_1_dac_dma_interconnect]
    set_property -dict [list CONFIG.NUM_MI {1}] $axi_ad9361_1_dac_dma_interconnect

    set axi_ad9361_1_adc_dma [create_bd_cell -type ip -vlnv analog.com:user:axi_dmac:1.0 axi_ad9361_1_adc_dma]
    set_property -dict [list CONFIG.C_DMA_TYPE_SRC {2}] $axi_ad9361_1_adc_dma
    set_property -dict [list CONFIG.C_DMA_TYPE_DEST {0}] $axi_ad9361_1_adc_dma
    set_property -dict [list CONFIG.C_CYCLIC {0}] $axi_ad9361_1_adc_dma
    set_property -dict [list CONFIG.C_SYNC_TRANSFER_START {1}] $axi_ad9361_1_adc_dma
    set_property -dict [list CONFIG.C_AXI_SLICE_SRC {0}] $axi_ad9361_1_adc_dma
    set_property -dict [list CONFIG.C_AXI_SLICE_DEST {0}] $axi_ad9361_1_adc_dma
    set_property -dict [list CONFIG.C_CLKS_ASYNC_DEST_REQ {1}] $axi_ad9361_1_adc_dma
    set_property -dict [list CONFIG.C_CLKS_ASYNC_SRC_DEST {1}] $axi_ad9361_1_adc_dma
    set_property -dict [list CONFIG.C_CLKS_ASYNC_REQ_SRC {1}] $axi_ad9361_1_adc_dma
    set_property -dict [list CONFIG.C_2D_TRANSFER {0}] $axi_ad9361_1_adc_dma
    set_property -dict [list CONFIG.C_DMA_DATA_WIDTH_SRC {128}]  $axi_ad9361_1_adc_dma

    set axi_ad9361_1_adc_dma_interconnect [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_ad9361_1_adc_dma_interconnect]
    set_property -dict [list CONFIG.NUM_MI {1}] $axi_ad9361_1_adc_dma_interconnect


    # additions to default configuration
    set_property -dict [list CONFIG.NUM_MI {10}] $axi_cpu_interconnect

	set_property -dict [list CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 1.8V} ] $sys_ps7
    set_property -dict [list CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V}] $sys_ps7

	set_property -dict [list CONFIG.PCW_SD0_GRP_WP_ENABLE {0} ] $sys_ps7
	set_property -dict [list CONFIG.PCW_SD1_SD1_IO {MIO 10 .. 15} ] $sys_ps7
	
	set_property -dict [list CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} ] $sys_ps7 
	set_property -dict [list CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} ] $sys_ps7
	set_property -dict [list CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} ] $sys_ps7
	set_property -dict [list CONFIG.PCW_ENET1_PERIPHERAL_ENABLE {0} ] $sys_ps7

	set_property -dict [list CONFIG.PCW_UART0_PERIPHERAL_ENABLE {1} ] $sys_ps7
	set_property -dict [list CONFIG.PCW_UART0_UART0_IO {MIO 46 .. 47} ] $sys_ps7
	set_property -dict [list CONFIG.PCW_SPI1_PERIPHERAL_ENABLE {1} ] $sys_ps7
     set_property -dict [list CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {1}] $sys_ps7   

    set_property -dict [list CONFIG.PCW_USE_S_AXI_HP0 {1}] $sys_ps7
    set_property -dict [list CONFIG.PCW_USE_S_AXI_HP1 {1}] $sys_ps7
    set_property -dict [list CONFIG.PCW_USE_S_AXI_HP2 {1}] $sys_ps7
    set_property -dict [list CONFIG.PCW_USE_S_AXI_HP3 {1}] $sys_ps7
    set_property -dict [list CONFIG.PCW_EN_CLK2_PORT {1}] $sys_ps7
    set_property -dict [list CONFIG.PCW_EN_RST2_PORT {1}] $sys_ps7
    set_property -dict [list CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {250}] $sys_ps7
    set_property -dict [list CONFIG.PCW_GPIO_EMIO_GPIO_IO {45}]      $sys_ps7

    set_property LEFT 44 [get_bd_ports GPIO_I]
    set_property LEFT 44 [get_bd_ports GPIO_O]
    set_property LEFT 44 [get_bd_ports GPIO_T]



## CONNECTIONS
    # connections (spi)

    connect_bd_net -net spi0_csn_i   [get_bd_ports spi0_csn_i]  [get_bd_pins sys_ps7/SPI0_SS_I]
    connect_bd_net -net spi0_sclk_i  [get_bd_ports spi0_sclk_i] [get_bd_pins sys_ps7/SPI0_SCLK_I]
    connect_bd_net -net spi0_sclk_o  [get_bd_ports spi0_sclk_o] [get_bd_pins sys_ps7/SPI0_SCLK_O]
    connect_bd_net -net spi0_mosi_i  [get_bd_ports spi0_mosi_i] [get_bd_pins sys_ps7/SPI0_MOSI_I]
    connect_bd_net -net spi0_mosi_o  [get_bd_ports spi0_mosi_o] [get_bd_pins sys_ps7/SPI0_MOSI_O]
    connect_bd_net -net spi0_miso_i  [get_bd_ports spi0_miso_i] [get_bd_pins sys_ps7/SPI0_MISO_I]
	
    connect_bd_net -net spi1_csn_i   [get_bd_ports spi1_csn_i]  [get_bd_pins sys_ps7/SPI1_SS_I]
    connect_bd_net -net spi1_sclk_i  [get_bd_ports spi1_sclk_i]   [get_bd_pins sys_ps7/SPI1_SCLK_I]
    connect_bd_net -net spi1_sclk_o  [get_bd_ports spi1_sclk_o]   [get_bd_pins sys_ps7/SPI1_SCLK_O]
    connect_bd_net -net spi1_mosi_i  [get_bd_ports spi1_mosi_i]   [get_bd_pins sys_ps7/SPI1_MOSI_I]
    connect_bd_net -net spi1_mosi_o  [get_bd_ports spi1_mosi_o]   [get_bd_pins sys_ps7/SPI1_MOSI_O]
    connect_bd_net -net spi1_miso_i  [get_bd_ports spi1_miso_i]   [get_bd_pins sys_ps7/SPI1_MISO_I]

	
    # connections axi_gpio
    connect_bd_net [get_bd_ports axi_gpio] [get_bd_pins axi_gpio/gpio_io_i]
    connect_bd_net -net axi_gpio_irq      [get_bd_pins axi_gpio/ip2intc_irpt]  [get_bd_pins sys_concat_intc/In4]
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m00_axi  [get_bd_intf_pins axi_cpu_interconnect/M00_AXI] [get_bd_intf_pins axi_gpio/S_AXI]
    connect_bd_net -net sys_100m_clk [get_bd_pins axi_gpio/s_axi_aclk]
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_gpio/s_axi_aresetn]

    
    # connections (ad9361_0)

    connect_bd_net -net sys_200m_clk [get_bd_pins axi_ad9361_0/delay_clk]
    connect_bd_net -net axi_ad9361_0_clk [get_bd_pins axi_ad9361_0/l_clk]
    connect_bd_net -net axi_ad9361_0_clk [get_bd_pins axi_ad9361_0/clk]
    connect_bd_net -net axi_ad9361_0_clk [get_bd_pins axi_ad9361_0_adc_dma/fifo_wr_clk]
    connect_bd_net -net axi_ad9361_0_clk [get_bd_pins axi_ad9361_0_dac_dma/fifo_rd_clk]

    connect_bd_net -net axi_ad9361_0_rx_clk_in_p      [get_bd_ports rx_clk_in_0_p]            [get_bd_pins axi_ad9361_0/rx_clk_in_p]
    connect_bd_net -net axi_ad9361_0_rx_clk_in_n      [get_bd_ports rx_clk_in_0_n]            [get_bd_pins axi_ad9361_0/rx_clk_in_n]
    connect_bd_net -net axi_ad9361_0_rx_frame_in_p    [get_bd_ports rx_frame_in_0_p]          [get_bd_pins axi_ad9361_0/rx_frame_in_p]
    connect_bd_net -net axi_ad9361_0_rx_frame_in_n    [get_bd_ports rx_frame_in_0_n]          [get_bd_pins axi_ad9361_0/rx_frame_in_n]
    connect_bd_net -net axi_ad9361_0_rx_data_in_p     [get_bd_ports rx_data_in_0_p]           [get_bd_pins axi_ad9361_0/rx_data_in_p]
    connect_bd_net -net axi_ad9361_0_rx_data_in_n     [get_bd_ports rx_data_in_0_n]           [get_bd_pins axi_ad9361_0/rx_data_in_n]
    connect_bd_net -net axi_ad9361_0_tx_clk_out_p     [get_bd_ports tx_clk_out_0_p]           [get_bd_pins axi_ad9361_0/tx_clk_out_p]
    connect_bd_net -net axi_ad9361_0_tx_clk_out_n     [get_bd_ports tx_clk_out_0_n]           [get_bd_pins axi_ad9361_0/tx_clk_out_n]
    connect_bd_net -net axi_ad9361_0_tx_frame_out_p   [get_bd_ports tx_frame_out_0_p]         [get_bd_pins axi_ad9361_0/tx_frame_out_p]
    connect_bd_net -net axi_ad9361_0_tx_frame_out_n   [get_bd_ports tx_frame_out_0_n]         [get_bd_pins axi_ad9361_0/tx_frame_out_n]
    connect_bd_net -net axi_ad9361_0_tx_data_out_p    [get_bd_ports tx_data_out_0_p]          [get_bd_pins axi_ad9361_0/tx_data_out_p]
    connect_bd_net -net axi_ad9361_0_tx_data_out_n    [get_bd_ports tx_data_out_0_n]          [get_bd_pins axi_ad9361_0/tx_data_out_n]

    connect_bd_net -net axi_ad9361_0_clk              [get_bd_pins util_adc_pack_0/clk]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_adc_pack_0/chan_valid_4]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_adc_pack_0/chan_valid_5]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_adc_pack_0/chan_valid_6]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_adc_pack_0/chan_valid_7]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_adc_pack_0/chan_enable_4]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_adc_pack_0/chan_enable_5]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_adc_pack_0/chan_enable_6]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_adc_pack_0/chan_enable_7]
    connect_bd_net -net axi_ad9361_0_adc_valid_0      [get_bd_pins axi_ad9361_0/adc_valid_i0]  [get_bd_pins util_adc_pack_0/chan_valid_0]
    connect_bd_net -net axi_ad9361_0_adc_valid_1      [get_bd_pins axi_ad9361_0/adc_valid_q0]  [get_bd_pins util_adc_pack_0/chan_valid_1]
    connect_bd_net -net axi_ad9361_0_adc_valid_2      [get_bd_pins axi_ad9361_0/adc_valid_i1]  [get_bd_pins util_adc_pack_0/chan_valid_2]
    connect_bd_net -net axi_ad9361_0_adc_valid_3      [get_bd_pins axi_ad9361_0/adc_valid_q1]  [get_bd_pins util_adc_pack_0/chan_valid_3]
    connect_bd_net -net axi_ad9361_0_adc_enable_0     [get_bd_pins axi_ad9361_0/adc_enable_i0]  [get_bd_pins util_adc_pack_0/chan_enable_0]
    connect_bd_net -net axi_ad9361_0_adc_enable_1     [get_bd_pins axi_ad9361_0/adc_enable_q0]  [get_bd_pins util_adc_pack_0/chan_enable_1]
    connect_bd_net -net axi_ad9361_0_adc_enable_2     [get_bd_pins axi_ad9361_0/adc_enable_i1]  [get_bd_pins util_adc_pack_0/chan_enable_2]
    connect_bd_net -net axi_ad9361_0_adc_enable_3     [get_bd_pins axi_ad9361_0/adc_enable_q1]  [get_bd_pins util_adc_pack_0/chan_enable_3]
    connect_bd_net -net axi_ad9361_0_adc_chan_i1      [get_bd_pins axi_ad9361_0/adc_data_i0]  [get_bd_pins util_adc_pack_0/chan_data_0]
    connect_bd_net -net axi_ad9361_0_adc_chan_q1      [get_bd_pins axi_ad9361_0/adc_data_q0]  [get_bd_pins util_adc_pack_0/chan_data_1]
    connect_bd_net -net axi_ad9361_0_adc_chan_i2      [get_bd_pins axi_ad9361_0/adc_data_i1]  [get_bd_pins util_adc_pack_0/chan_data_2]
    connect_bd_net -net axi_ad9361_0_adc_chan_q2      [get_bd_pins axi_ad9361_0/adc_data_q1]  [get_bd_pins util_adc_pack_0/chan_data_3]
    connect_bd_net -net util_adc_pack_0_dvalid        [get_bd_pins util_adc_pack_0/dvalid] [get_bd_pins axi_ad9361_0_adc_dma/fifo_wr_en]
    connect_bd_net -net util_adc_pack_0_dsync         [get_bd_pins util_adc_pack_0/dsync]  [get_bd_pins axi_ad9361_0_adc_dma/fifo_wr_sync]
    connect_bd_net -net util_adc_pack_0_ddata         [get_bd_pins util_adc_pack_0/ddata]  [get_bd_pins axi_ad9361_0_adc_dma/fifo_wr_din]
    connect_bd_net -net axi_ad9361_0_adc_dovf         [get_bd_pins axi_ad9361_0/adc_dovf]   [get_bd_pins axi_ad9361_0_adc_dma/fifo_wr_overflow]

    connect_bd_net -net axi_ad9361_0_clk              [get_bd_pins util_dac_unpack_0/clk]
    connect_bd_net -net axi_ad9361_0_dac_valid_0      [get_bd_pins util_dac_unpack_0/dac_valid_00] [get_bd_pins axi_ad9361_0/dac_valid_i0]
    connect_bd_net -net axi_ad9361_0_dac_valid_1      [get_bd_pins util_dac_unpack_0/dac_valid_01] [get_bd_pins axi_ad9361_0/dac_valid_q0]
    connect_bd_net -net axi_ad9361_0_dac_valid_2      [get_bd_pins util_dac_unpack_0/dac_valid_02] [get_bd_pins axi_ad9361_0/dac_valid_i1]
    connect_bd_net -net axi_ad9361_0_dac_valid_3      [get_bd_pins util_dac_unpack_0/dac_valid_03] [get_bd_pins axi_ad9361_0/dac_valid_q1]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_dac_unpack_0/dac_valid_04]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_dac_unpack_0/dac_valid_05]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_dac_unpack_0/dac_valid_06]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_dac_unpack_0/dac_valid_07]
    connect_bd_net -net axi_ad9361_0_dac_enable_0     [get_bd_pins util_dac_unpack_0/dac_enable_00] [get_bd_pins axi_ad9361_0/dac_enable_i0]
    connect_bd_net -net axi_ad9361_0_dac_enable_1     [get_bd_pins util_dac_unpack_0/dac_enable_01] [get_bd_pins axi_ad9361_0/dac_enable_q0]
    connect_bd_net -net axi_ad9361_0_dac_enable_2     [get_bd_pins util_dac_unpack_0/dac_enable_02] [get_bd_pins axi_ad9361_0/dac_enable_i1]
    connect_bd_net -net axi_ad9361_0_dac_enable_3     [get_bd_pins util_dac_unpack_0/dac_enable_03] [get_bd_pins axi_ad9361_0/dac_enable_q1]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_dac_unpack_0/dac_enable_04]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_dac_unpack_0/dac_enable_05]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_dac_unpack_0/dac_enable_06]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_dac_unpack_0/dac_enable_07]
    connect_bd_net -net axi_ad9361_0_dac_data_0       [get_bd_pins util_dac_unpack_0/dac_data_00] [get_bd_pins axi_ad9361_0/dac_data_i0]
    connect_bd_net -net axi_ad9361_0_dac_data_1       [get_bd_pins util_dac_unpack_0/dac_data_01] [get_bd_pins axi_ad9361_0/dac_data_q0]
    connect_bd_net -net axi_ad9361_0_dac_data_2       [get_bd_pins util_dac_unpack_0/dac_data_02] [get_bd_pins axi_ad9361_0/dac_data_i1]
    connect_bd_net -net axi_ad9361_0_dac_data_3       [get_bd_pins util_dac_unpack_0/dac_data_03] [get_bd_pins axi_ad9361_0/dac_data_q1]

    connect_bd_net -net fifo_data_0                   [get_bd_pins util_dac_unpack_0/dma_data] [get_bd_pins axi_ad9361_0_dac_dma/fifo_rd_dout]
    connect_bd_net -net fifo_valid_0                  [get_bd_pins axi_ad9361_0_dac_dma/fifo_rd_valid] [get_bd_pins util_dac_unpack_0/fifo_valid]
    connect_bd_net -net axi_ad9361_0_dac_drd          [get_bd_pins util_dac_unpack_0/dma_rd]  [get_bd_pins axi_ad9361_0_dac_dma/fifo_rd_en]
    connect_bd_net -net axi_ad9361_0_dac_dunf         [get_bd_pins axi_ad9361_0/dac_dunf]   [get_bd_pins axi_ad9361_0_dac_dma/fifo_rd_underflow]

    connect_bd_net -net axi_ad9361_0_adc_dma_irq      [get_bd_pins axi_ad9361_0_adc_dma/irq]  [get_bd_pins sys_concat_intc/In0]
    connect_bd_net -net axi_ad9361_0_dac_dma_irq      [get_bd_pins axi_ad9361_0_dac_dma/irq]  [get_bd_pins sys_concat_intc/In1]

    # connections (ad9361_1)

    connect_bd_net -net sys_200m_clk [get_bd_pins axi_ad9361_1/delay_clk]
    connect_bd_net -net axi_ad9361_1_clk [get_bd_pins axi_ad9361_1/l_clk]
    connect_bd_net -net axi_ad9361_1_clk [get_bd_pins axi_ad9361_1/clk]
    connect_bd_net -net axi_ad9361_1_clk [get_bd_pins axi_ad9361_1_adc_dma/fifo_wr_clk]
    connect_bd_net -net axi_ad9361_1_clk [get_bd_pins axi_ad9361_1_dac_dma/fifo_rd_clk]

    connect_bd_net -net axi_ad9361_1_rx_clk_in_p      [get_bd_ports rx_clk_in_1_p]            [get_bd_pins axi_ad9361_1/rx_clk_in_p]
    connect_bd_net -net axi_ad9361_1_rx_clk_in_n      [get_bd_ports rx_clk_in_1_n]            [get_bd_pins axi_ad9361_1/rx_clk_in_n]
    connect_bd_net -net axi_ad9361_1_rx_frame_in_p    [get_bd_ports rx_frame_in_1_p]          [get_bd_pins axi_ad9361_1/rx_frame_in_p]
    connect_bd_net -net axi_ad9361_1_rx_frame_in_n    [get_bd_ports rx_frame_in_1_n]          [get_bd_pins axi_ad9361_1/rx_frame_in_n]
    connect_bd_net -net axi_ad9361_1_rx_data_in_p     [get_bd_ports rx_data_in_1_p]           [get_bd_pins axi_ad9361_1/rx_data_in_p]
    connect_bd_net -net axi_ad9361_1_rx_data_in_n     [get_bd_ports rx_data_in_1_n]           [get_bd_pins axi_ad9361_1/rx_data_in_n]
    connect_bd_net -net axi_ad9361_1_tx_clk_out_p     [get_bd_ports tx_clk_out_1_p]           [get_bd_pins axi_ad9361_1/tx_clk_out_p]
    connect_bd_net -net axi_ad9361_1_tx_clk_out_n     [get_bd_ports tx_clk_out_1_n]           [get_bd_pins axi_ad9361_1/tx_clk_out_n]
    connect_bd_net -net axi_ad9361_1_tx_frame_out_p   [get_bd_ports tx_frame_out_1_p]         [get_bd_pins axi_ad9361_1/tx_frame_out_p]
    connect_bd_net -net axi_ad9361_1_tx_frame_out_n   [get_bd_ports tx_frame_out_1_n]         [get_bd_pins axi_ad9361_1/tx_frame_out_n]
    connect_bd_net -net axi_ad9361_1_tx_data_out_p    [get_bd_ports tx_data_out_1_p]          [get_bd_pins axi_ad9361_1/tx_data_out_p]
    connect_bd_net -net axi_ad9361_1_tx_data_out_n    [get_bd_ports tx_data_out_1_n]          [get_bd_pins axi_ad9361_1/tx_data_out_n]

    connect_bd_net -net axi_ad9361_1_clk              [get_bd_pins util_adc_pack_1/clk]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_adc_pack_1/chan_valid_4]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_adc_pack_1/chan_valid_5]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_adc_pack_1/chan_valid_6]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_adc_pack_1/chan_valid_7]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_adc_pack_1/chan_enable_4]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_adc_pack_1/chan_enable_5]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_adc_pack_1/chan_enable_6]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_adc_pack_1/chan_enable_7]
    connect_bd_net -net axi_ad9361_1_adc_valid_0      [get_bd_pins axi_ad9361_1/adc_valid_i0]  [get_bd_pins util_adc_pack_1/chan_valid_0]
    connect_bd_net -net axi_ad9361_1_adc_valid_1      [get_bd_pins axi_ad9361_1/adc_valid_q0]  [get_bd_pins util_adc_pack_1/chan_valid_1]
    connect_bd_net -net axi_ad9361_1_adc_valid_2      [get_bd_pins axi_ad9361_1/adc_valid_i1]  [get_bd_pins util_adc_pack_1/chan_valid_2]
    connect_bd_net -net axi_ad9361_1_adc_valid_3      [get_bd_pins axi_ad9361_1/adc_valid_q1]  [get_bd_pins util_adc_pack_1/chan_valid_3]
    connect_bd_net -net axi_ad9361_1_adc_enable_0     [get_bd_pins axi_ad9361_1/adc_enable_i0]  [get_bd_pins util_adc_pack_1/chan_enable_0]
    connect_bd_net -net axi_ad9361_1_adc_enable_1     [get_bd_pins axi_ad9361_1/adc_enable_q0]  [get_bd_pins util_adc_pack_1/chan_enable_1]
    connect_bd_net -net axi_ad9361_1_adc_enable_2     [get_bd_pins axi_ad9361_1/adc_enable_i1]  [get_bd_pins util_adc_pack_1/chan_enable_2]
    connect_bd_net -net axi_ad9361_1_adc_enable_3     [get_bd_pins axi_ad9361_1/adc_enable_q1]  [get_bd_pins util_adc_pack_1/chan_enable_3]
    connect_bd_net -net axi_ad9361_1_adc_chan_i1      [get_bd_pins axi_ad9361_1/adc_data_i0]  [get_bd_pins util_adc_pack_1/chan_data_0]
    connect_bd_net -net axi_ad9361_1_adc_chan_q1      [get_bd_pins axi_ad9361_1/adc_data_q0]  [get_bd_pins util_adc_pack_1/chan_data_1]
    connect_bd_net -net axi_ad9361_1_adc_chan_i2      [get_bd_pins axi_ad9361_1/adc_data_i1]  [get_bd_pins util_adc_pack_1/chan_data_2]
    connect_bd_net -net axi_ad9361_1_adc_chan_q2      [get_bd_pins axi_ad9361_1/adc_data_q1]  [get_bd_pins util_adc_pack_1/chan_data_3]
    connect_bd_net -net util_adc_pack_1_dvalid        [get_bd_pins util_adc_pack_1/dvalid] [get_bd_pins axi_ad9361_1_adc_dma/fifo_wr_en]
    connect_bd_net -net util_adc_pack_1_dsync         [get_bd_pins util_adc_pack_1/dsync]  [get_bd_pins axi_ad9361_1_adc_dma/fifo_wr_sync]
    connect_bd_net -net util_adc_pack_1_ddata         [get_bd_pins util_adc_pack_1/ddata]  [get_bd_pins axi_ad9361_1_adc_dma/fifo_wr_din]
    connect_bd_net -net axi_ad9361_1_adc_dovf         [get_bd_pins axi_ad9361_1/adc_dovf]   [get_bd_pins axi_ad9361_1_adc_dma/fifo_wr_overflow]

    connect_bd_net -net axi_ad9361_1_clk              [get_bd_pins util_dac_unpack_1/clk]
    connect_bd_net -net axi_ad9361_1_dac_valid_0      [get_bd_pins util_dac_unpack_1/dac_valid_00] [get_bd_pins axi_ad9361_1/dac_valid_i0]
    connect_bd_net -net axi_ad9361_1_dac_valid_1      [get_bd_pins util_dac_unpack_1/dac_valid_01] [get_bd_pins axi_ad9361_1/dac_valid_q0]
    connect_bd_net -net axi_ad9361_1_dac_valid_2      [get_bd_pins util_dac_unpack_1/dac_valid_02] [get_bd_pins axi_ad9361_1/dac_valid_i1]
    connect_bd_net -net axi_ad9361_1_dac_valid_3      [get_bd_pins util_dac_unpack_1/dac_valid_03] [get_bd_pins axi_ad9361_1/dac_valid_q1]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_dac_unpack_1/dac_valid_04]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_dac_unpack_1/dac_valid_05]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_dac_unpack_1/dac_valid_06]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_dac_unpack_1/dac_valid_07]
    connect_bd_net -net axi_ad9361_1_dac_enable_0     [get_bd_pins util_dac_unpack_1/dac_enable_00] [get_bd_pins axi_ad9361_1/dac_enable_i0]
    connect_bd_net -net axi_ad9361_1_dac_enable_1     [get_bd_pins util_dac_unpack_1/dac_enable_01] [get_bd_pins axi_ad9361_1/dac_enable_q0]
    connect_bd_net -net axi_ad9361_1_dac_enable_2     [get_bd_pins util_dac_unpack_1/dac_enable_02] [get_bd_pins axi_ad9361_1/dac_enable_i1]
    connect_bd_net -net axi_ad9361_1_dac_enable_3     [get_bd_pins util_dac_unpack_1/dac_enable_03] [get_bd_pins axi_ad9361_1/dac_enable_q1]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_dac_unpack_1/dac_enable_04]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_dac_unpack_1/dac_enable_05]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_dac_unpack_1/dac_enable_06]
    connect_bd_net -net gnd                         [get_bd_pins constant_0/const] [get_bd_pins util_dac_unpack_1/dac_enable_07]
    connect_bd_net -net axi_ad9361_1_dac_data_0       [get_bd_pins util_dac_unpack_1/dac_data_00] [get_bd_pins axi_ad9361_1/dac_data_i0]
    connect_bd_net -net axi_ad9361_1_dac_data_1       [get_bd_pins util_dac_unpack_1/dac_data_01] [get_bd_pins axi_ad9361_1/dac_data_q0]
    connect_bd_net -net axi_ad9361_1_dac_data_2       [get_bd_pins util_dac_unpack_1/dac_data_02] [get_bd_pins axi_ad9361_1/dac_data_i1]
    connect_bd_net -net axi_ad9361_1_dac_data_3       [get_bd_pins util_dac_unpack_1/dac_data_03] [get_bd_pins axi_ad9361_1/dac_data_q1]

    connect_bd_net -net fifo_data_1                   [get_bd_pins util_dac_unpack_1/dma_data] [get_bd_pins axi_ad9361_1_dac_dma/fifo_rd_dout]
    connect_bd_net -net fifo_valid_1                  [get_bd_pins axi_ad9361_1_dac_dma/fifo_rd_valid] [get_bd_pins util_dac_unpack_1/fifo_valid]
    connect_bd_net -net axi_ad9361_1_dac_drd          [get_bd_pins util_dac_unpack_1/dma_rd]  [get_bd_pins axi_ad9361_1_dac_dma/fifo_rd_en]
    connect_bd_net -net axi_ad9361_1_dac_dunf         [get_bd_pins axi_ad9361_1/dac_dunf]   [get_bd_pins axi_ad9361_1_dac_dma/fifo_rd_underflow]

    connect_bd_net -net axi_ad9361_1_adc_dma_irq      [get_bd_pins axi_ad9361_1_adc_dma/irq]  [get_bd_pins sys_concat_intc/In2]
    connect_bd_net -net axi_ad9361_1_dac_dma_irq      [get_bd_pins axi_ad9361_1_dac_dma/irq]  [get_bd_pins sys_concat_intc/In3]


    # interconnect (cpu)

    connect_bd_intf_net -intf_net axi_cpu_interconnect_m07_axi [get_bd_intf_pins axi_cpu_interconnect/M07_AXI] [get_bd_intf_pins axi_ad9361_0/s_axi]
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m08_axi [get_bd_intf_pins axi_cpu_interconnect/M08_AXI] [get_bd_intf_pins axi_ad9361_0_adc_dma/s_axi]
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m09_axi [get_bd_intf_pins axi_cpu_interconnect/M09_AXI] [get_bd_intf_pins axi_ad9361_0_dac_dma/s_axi]
    connect_bd_net -net sys_100m_clk [get_bd_pins axi_cpu_interconnect/M07_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk [get_bd_pins axi_cpu_interconnect/M08_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk [get_bd_pins axi_cpu_interconnect/M09_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk [get_bd_pins axi_ad9361_0/s_axi_aclk]
    connect_bd_net -net sys_100m_clk [get_bd_pins axi_ad9361_0_adc_dma/s_axi_aclk]
    connect_bd_net -net sys_100m_clk [get_bd_pins axi_ad9361_0_dac_dma/s_axi_aclk]
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M07_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M08_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M09_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_0/s_axi_aresetn]
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_0_adc_dma/s_axi_aresetn]
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_0_dac_dma/s_axi_aresetn]

    connect_bd_intf_net -intf_net axi_cpu_interconnect_m01_axi [get_bd_intf_pins axi_cpu_interconnect/M01_AXI] [get_bd_intf_pins axi_ad9361_1/s_axi]
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m02_axi [get_bd_intf_pins axi_cpu_interconnect/M02_AXI] [get_bd_intf_pins axi_ad9361_1_adc_dma/s_axi]
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m03_axi [get_bd_intf_pins axi_cpu_interconnect/M03_AXI] [get_bd_intf_pins axi_ad9361_1_dac_dma/s_axi]
    connect_bd_net -net sys_100m_clk [get_bd_pins axi_cpu_interconnect/M01_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk [get_bd_pins axi_cpu_interconnect/M02_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk [get_bd_pins axi_cpu_interconnect/M03_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk [get_bd_pins axi_ad9361_1/s_axi_aclk]
    connect_bd_net -net sys_100m_clk [get_bd_pins axi_ad9361_1_adc_dma/s_axi_aclk]
    connect_bd_net -net sys_100m_clk [get_bd_pins axi_ad9361_1_dac_dma/s_axi_aclk]
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M01_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M02_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M03_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_1/s_axi_aresetn]
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_1_adc_dma/s_axi_aresetn]
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_1_dac_dma/s_axi_aresetn]


    # memory interconnects share the same clock (fclk2)

if {$sys_zynq == 1} {
    set sys_fmc_dma_clk_source [get_bd_pins sys_ps7/FCLK_CLK2]
    connect_bd_net -net sys_fmc_dma_clk $sys_fmc_dma_clk_source
}

    # interconnect (mem/dac(0))

    connect_bd_intf_net -intf_net axi_ad9361_0_dac_dma_interconnect_s00_axi [get_bd_intf_pins axi_ad9361_0_dac_dma_interconnect/S00_AXI] [get_bd_intf_pins axi_ad9361_0_dac_dma/m_src_axi]
    connect_bd_intf_net -intf_net axi_ad9361_0_dac_dma_interconnect_m00_axi [get_bd_intf_pins axi_ad9361_0_dac_dma_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_HP0]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_0_dac_dma_interconnect/ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_0_dac_dma_interconnect/M00_ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_0_dac_dma_interconnect/S00_ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_0_dac_dma/m_src_axi_aclk]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins sys_ps7/S_AXI_HP0_ACLK]
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_0_dac_dma_interconnect/ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_0_dac_dma_interconnect/M00_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_0_dac_dma_interconnect/S00_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_0_dac_dma/m_src_axi_aresetn]

    connect_bd_intf_net -intf_net axi_ad9361_0_adc_dma_interconnect_s00_axi [get_bd_intf_pins axi_ad9361_0_adc_dma_interconnect/S00_AXI] [get_bd_intf_pins axi_ad9361_0_adc_dma/m_dest_axi]
    connect_bd_intf_net -intf_net axi_ad9361_0_adc_dma_interconnect_m00_axi [get_bd_intf_pins axi_ad9361_0_adc_dma_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_HP1]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_0_adc_dma_interconnect/ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_0_adc_dma_interconnect/M00_ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_0_adc_dma_interconnect/S00_ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_0_adc_dma/m_dest_axi_aclk]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins sys_ps7/S_AXI_HP1_ACLK]
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_0_adc_dma_interconnect/ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_0_adc_dma_interconnect/M00_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_0_adc_dma_interconnect/S00_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_0_adc_dma/m_dest_axi_aresetn]

    # interconnect (mem/dac(1))

    connect_bd_intf_net -intf_net axi_ad9361_1_dac_dma_interconnect_s00_axi [get_bd_intf_pins axi_ad9361_1_dac_dma_interconnect/S00_AXI] [get_bd_intf_pins axi_ad9361_1_dac_dma/m_src_axi]
    connect_bd_intf_net -intf_net axi_ad9361_1_dac_dma_interconnect_m00_axi [get_bd_intf_pins axi_ad9361_1_dac_dma_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_HP2]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_1_dac_dma_interconnect/ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_1_dac_dma_interconnect/M00_ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_1_dac_dma_interconnect/S00_ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_1_dac_dma/m_src_axi_aclk]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins sys_ps7/S_AXI_HP2_ACLK]
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_1_dac_dma_interconnect/ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_1_dac_dma_interconnect/M00_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_1_dac_dma_interconnect/S00_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_1_dac_dma/m_src_axi_aresetn]

    connect_bd_intf_net -intf_net axi_ad9361_1_adc_dma_interconnect_s00_axi [get_bd_intf_pins axi_ad9361_1_adc_dma_interconnect/S00_AXI] [get_bd_intf_pins axi_ad9361_1_adc_dma/m_dest_axi]
    connect_bd_intf_net -intf_net axi_ad9361_1_adc_dma_interconnect_m00_axi [get_bd_intf_pins axi_ad9361_1_adc_dma_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_HP3]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_1_adc_dma_interconnect/ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_1_adc_dma_interconnect/M00_ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_1_adc_dma_interconnect/S00_ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_1_adc_dma/m_dest_axi_aclk]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins sys_ps7/S_AXI_HP3_ACLK]
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_1_adc_dma_interconnect/ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_1_adc_dma_interconnect/M00_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_1_adc_dma_interconnect/S00_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_1_adc_dma/m_dest_axi_aresetn]


    # ila (adc0)

    set ila_adc [create_bd_cell -type ip -vlnv xilinx.com:ip:ila:4.0 ila_adc]
    set_property -dict [list CONFIG.C_MONITOR_TYPE {Native}] $ila_adc
    set_property -dict [list CONFIG.C_NUM_OF_PROBES {5}] $ila_adc
    set_property -dict [list CONFIG.C_PROBE0_WIDTH {1}] $ila_adc
    set_property -dict [list CONFIG.C_PROBE1_WIDTH {16}] $ila_adc
    set_property -dict [list CONFIG.C_PROBE2_WIDTH {16}] $ila_adc
    set_property -dict [list CONFIG.C_PROBE3_WIDTH {16}] $ila_adc
    set_property -dict [list CONFIG.C_PROBE4_WIDTH {16}] $ila_adc
    set_property -dict [list CONFIG.C_TRIGIN_EN {false}] $ila_adc
    set_property -dict [list CONFIG.C_EN_STRG_QUAL {1}] $ila_adc

    connect_bd_net -net axi_ad9361_0_clk            [get_bd_pins ila_adc/clk]
    connect_bd_net -net axi_ad9361_0_adc_valid_0    [get_bd_pins ila_adc/probe0]
    connect_bd_net -net axi_ad9361_0_adc_chan_i1    [get_bd_pins ila_adc/probe1]
    connect_bd_net -net axi_ad9361_0_adc_chan_q1    [get_bd_pins ila_adc/probe2]
    connect_bd_net -net axi_ad9361_0_adc_chan_i2    [get_bd_pins ila_adc/probe3]
    connect_bd_net -net axi_ad9361_0_adc_chan_q2    [get_bd_pins ila_adc/probe4]


    # ila (dac0)

    set ila_dac [create_bd_cell -type ip -vlnv xilinx.com:ip:ila:4.0 ila_dac]
    set_property -dict [list CONFIG.C_MONITOR_TYPE {Native}] $ila_dac
    set_property -dict [list CONFIG.C_NUM_OF_PROBES {5}] $ila_dac
    set_property -dict [list CONFIG.C_PROBE0_WIDTH {1}] $ila_dac
    set_property -dict [list CONFIG.C_PROBE1_WIDTH {16}] $ila_dac
    set_property -dict [list CONFIG.C_PROBE2_WIDTH {16}] $ila_dac
    set_property -dict [list CONFIG.C_PROBE3_WIDTH {16}] $ila_dac
    set_property -dict [list CONFIG.C_PROBE4_WIDTH {16}] $ila_dac
    set_property -dict [list CONFIG.C_TRIGIN_EN {false}] $ila_dac
    set_property -dict [list CONFIG.C_EN_STRG_QUAL {1}] $ila_dac

    connect_bd_net -net axi_ad9361_0_clk           [get_bd_pins ila_dac/clk]
    connect_bd_net -net axi_ad9361_0_dac_drd       [get_bd_pins ila_dac/probe0]
    connect_bd_net -net axi_ad9361_0_dac_data_0    [get_bd_pins ila_dac/probe1]
    connect_bd_net -net axi_ad9361_0_dac_data_1    [get_bd_pins ila_dac/probe2]
    connect_bd_net -net axi_ad9361_0_dac_data_2    [get_bd_pins ila_dac/probe3]
    connect_bd_net -net axi_ad9361_0_dac_data_3    [get_bd_pins ila_dac/probe4]


    # address map

    create_bd_addr_seg -range 0x00010000 -offset 0x41200000 $sys_addr_cntrl_space [get_bd_addr_segs axi_gpio/s_axi/Reg]          SEG_data_axi_gpio
    create_bd_addr_seg -range 0x00010000 -offset 0x79020000 $sys_addr_cntrl_space [get_bd_addr_segs axi_ad9361_0/s_axi/axi_lite]          SEG_data_ad9361_0
    create_bd_addr_seg -range 0x00010000 -offset 0x7C420000 $sys_addr_cntrl_space [get_bd_addr_segs axi_ad9361_0_dac_dma/s_axi/axi_lite]  SEG_data_ad9361_0_dac_dma
    create_bd_addr_seg -range 0x00010000 -offset 0x7C400000 $sys_addr_cntrl_space [get_bd_addr_segs axi_ad9361_0_adc_dma/s_axi/axi_lite]  SEG_data_ad9361_0_adc_dma
    create_bd_addr_seg -range $sys_mem_size -offset 0x00000000 -verbose [get_bd_addr_spaces axi_ad9361_0_dac_dma/m_src_axi]  [get_bd_addr_segs sys_ps7/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_sys_ps7_hp0_ddr_lowocm
    create_bd_addr_seg -range $sys_mem_size -offset 0x00000000 -verbose [get_bd_addr_spaces axi_ad9361_0_adc_dma/m_dest_axi] [get_bd_addr_segs sys_ps7/S_AXI_HP1/HP1_DDR_LOWOCM] SEG_sys_ps7_hp1_ddr_lowocm

    create_bd_addr_seg -range 0x00010000 -offset 0x7A020000 $sys_addr_cntrl_space [get_bd_addr_segs axi_ad9361_1/s_axi/axi_lite]          SEG_data_ad9361_1
    create_bd_addr_seg -range 0x00010000 -offset 0x7D420000 $sys_addr_cntrl_space [get_bd_addr_segs axi_ad9361_1_dac_dma/s_axi/axi_lite]  SEG_data_ad9361_1_dac_dma
    create_bd_addr_seg -range 0x00010000 -offset 0x7D400000 $sys_addr_cntrl_space [get_bd_addr_segs axi_ad9361_1_adc_dma/s_axi/axi_lite]  SEG_data_ad9361_1_adc_dma
    create_bd_addr_seg -range $sys_mem_size -offset 0x00000000 -verbose [get_bd_addr_spaces axi_ad9361_1_dac_dma/m_src_axi]  [get_bd_addr_segs sys_ps7/S_AXI_HP2/HP2_DDR_LOWOCM] SEG_sys_ps7_hp2_ddr_lowocm
    create_bd_addr_seg -range $sys_mem_size -offset 0x00000000 -verbose [get_bd_addr_spaces axi_ad9361_1_adc_dma/m_dest_axi] [get_bd_addr_segs sys_ps7/S_AXI_HP3/HP3_DDR_LOWOCM] SEG_sys_ps7_hp3_ddr_lowocm

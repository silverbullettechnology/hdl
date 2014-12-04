
    # sdrdc_2chan



     set spi_csn_0_i [create_bd_port -dir I spi_csn_0_i]
     set spi_csn_0_o [create_bd_port -dir O spi_csn_0_o]
     set spi_csn_1_o [create_bd_port -dir O spi_csn_1_o]    
     set spi_csn_2_o [create_bd_port -dir O spi_csn_2_o]

    set spi_sclk_i      [create_bd_port -dir I spi_sclk_i]
    set spi_sclk_o      [create_bd_port -dir O spi_sclk_o]
    set spi_mosi_i      [create_bd_port -dir I spi_mosi_i]
    set spi_mosi_o      [create_bd_port -dir O spi_mosi_o]
    set spi_miso_i      [create_bd_port -dir I spi_miso_i]

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
    
    set axi_gpio [create_bd_port -dir I -from 23 -to 0 axi_gpio]


## INSTANTIATIONS

    # constant 0
    set constant_0 [create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 constant_0]
    set_property -dict [list CONFIG.CONST_VAL {0}] $constant_0

    # axi_gpio
    set axi_gpio [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio]
    set_property -dict [list CONFIG.C_GPIO_WIDTH {24}] $axi_gpio
    set_property -dict [list CONFIG.C_ALL_INPUTS {1} ] $axi_gpio
    set_property -dict [list CONFIG.C_INTERRUPT_PRESENT {1}] $axi_gpio

	# axi_sg_interconnect
	set axi_sg_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_sg_interconnect ]
	set_property -dict [list CONFIG.NUM_SI {2}] $axi_sg_interconnect
	set_property -dict [list CONFIG.NUM_MI {1}] $axi_sg_interconnect

	
    # AD9361_0 CORE
    set axi_ad9361_0 [create_bd_cell -type ip -vlnv analog.com:user:axi_ad9361:1.0 axi_ad9361_0]
    set_property -dict [list CONFIG.PCORE_ID {0}] $axi_ad9361_0
    set_property -dict [list CONFIG.PCORE_IODELAY_GROUP {dev_0_if_delay_group}] $axi_ad9361_0

    # channel packing for the ADC
    set util_adc_pack_0 [create_bd_cell -type ip -vlnv analog.com:user:util_adc_pack:1.0 util_adc_pack_0]
	set_property -dict [list CONFIG.CHANNELS {4}] [get_bd_cells util_adc_pack_0]
    set util_dac_unpack_0 [create_bd_cell -type ip -vlnv analog.com:user:util_dac_unpack:1.0 util_dac_unpack_0]
    set_property -dict [list CONFIG.CHANNELS {4}] [get_bd_cells util_dac_unpack_0]
	
    # axis2adi_0
	set axis2adi_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis2adi:1.0 axis2adi_0 ]
	# adi2axis_0
	set adi2axis_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:adi2axis:1.0 adi2axis_0 ]
	# axis_adc_interconnect_0
	set axis_adc_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_adc_interconnect_0 ]
	set_property -dict [ list CONFIG.NUM_MI {1} ] $axis_adc_interconnect_0
	# axis_dac_interconnect_0
	set axis_dac_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_dac_interconnect_0 ]
	set_property -dict [ list CONFIG.NUM_MI {1}  ] $axis_dac_interconnect_0

	# AXI_DMA_0
	set axi_dma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0 ]
	set_property -dict [ list CONFIG.c_include_s2mm {1} ] $axi_dma_0
	set_property -dict [ list CONFIG.c_m_axi_mm2s_data_width {64}  ] $axi_dma_0
	set_property -dict [ list CONFIG.c_m_axi_s2mm_data_width {64}  ] $axi_dma_0
	set_property -dict [ list CONFIG.c_m_axis_mm2s_tdata_width {64}  ] $axi_dma_0
	set_property -dict [ list CONFIG.c_sg_include_stscntrl_strm {0}  ] $axi_dma_0
	set_property -dict [ list CONFIG.c_sg_length_width {16}  ] $axi_dma_0

	# DAC DMA INTERCONNECT
    set axi_ad9361_0_dac_dma_interconnect [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_ad9361_0_dac_dma_interconnect]
    set_property -dict [list CONFIG.NUM_MI {1}] $axi_ad9361_0_dac_dma_interconnect

	# ADC DMA INTERCONNECT
    set axi_ad9361_0_adc_dma_interconnect [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_ad9361_0_adc_dma_interconnect]
    set_property -dict [list CONFIG.NUM_MI {1}] $axi_ad9361_0_adc_dma_interconnect

	
    # AD9361_1 CORE
    set axi_ad9361_1 [create_bd_cell -type ip -vlnv analog.com:user:axi_ad9361:1.0 axi_ad9361_1]
    set_property -dict [list CONFIG.PCORE_ID {0}] $axi_ad9361_1
    set_property -dict [list CONFIG.PCORE_IODELAY_GROUP {dev_1_if_delay_group}] $axi_ad9361_1

    # channel packing for the ADC
    set util_adc_pack_1 [create_bd_cell -type ip -vlnv analog.com:user:util_adc_pack:1.0 util_adc_pack_1]
	set_property -dict [list CONFIG.CHANNELS {4}] [get_bd_cells util_adc_pack_1]
    set util_dac_unpack_1 [create_bd_cell -type ip -vlnv analog.com:user:util_dac_unpack:1.0 util_dac_unpack_1]
    set_property -dict [list CONFIG.CHANNELS {4}] [get_bd_cells util_dac_unpack_1]

    # axis2adi_1
	set axis2adi_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis2adi:1.0 axis2adi_1 ]
	# adi2axis_1
	set adi2axis_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:adi2axis:1.0 adi2axis_1 ]
	# axis_adc_interconnect_1
	set axis_adc_interconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_adc_interconnect_1 ]
	set_property -dict [ list CONFIG.NUM_MI {1} ] $axis_adc_interconnect_1
	# axis_dac_interconnect_1
	set axis_dac_interconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_dac_interconnect_1 ]
	set_property -dict [ list CONFIG.NUM_MI {1}  ] $axis_dac_interconnect_1

	# AXI_DMA_1
	set axi_dma_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_1 ]
	set_property -dict [ list CONFIG.c_include_s2mm {1} ] $axi_dma_1
	set_property -dict [ list CONFIG.c_m_axi_mm2s_data_width {64}  ] $axi_dma_1
	set_property -dict [ list CONFIG.c_m_axi_s2mm_data_width {64}  ] $axi_dma_1
	set_property -dict [ list CONFIG.c_m_axis_mm2s_tdata_width {64}  ] $axi_dma_1
	set_property -dict [ list CONFIG.c_sg_include_stscntrl_strm {0}  ] $axi_dma_1
	set_property -dict [ list CONFIG.c_sg_length_width {16}  ] $axi_dma_1
	
	# DAC DMA INTERCONNECT
    set axi_ad9361_1_dac_dma_interconnect [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_ad9361_1_dac_dma_interconnect]
    set_property -dict [list CONFIG.NUM_MI {1}] $axi_ad9361_1_dac_dma_interconnect

	# ADC DMA INTERCONNECT
    set axi_ad9361_1_adc_dma_interconnect [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_ad9361_1_adc_dma_interconnect]
    set_property -dict [list CONFIG.NUM_MI {1}] $axi_ad9361_1_adc_dma_interconnect
	

    # additions to default configuration
    set_property -dict [list CONFIG.NUM_MI {10}] $axi_cpu_interconnect

    set_property -dict [list CONFIG.PCW_USE_S_AXI_GP0 {1}] $sys_ps7
    set_property -dict [list CONFIG.PCW_USE_S_AXI_HP0 {1}] $sys_ps7
    set_property -dict [list CONFIG.PCW_USE_S_AXI_HP1 {1}] $sys_ps7
    set_property -dict [list CONFIG.PCW_USE_S_AXI_HP2 {1}] $sys_ps7
    set_property -dict [list CONFIG.PCW_USE_S_AXI_HP3 {1}] $sys_ps7
    set_property -dict [list CONFIG.PCW_EN_CLK2_PORT {1}] $sys_ps7
    set_property -dict [list CONFIG.PCW_EN_RST2_PORT {1}] $sys_ps7
    set_property -dict [list CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {250}] $sys_ps7
    set_property -dict [list CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {1}] $sys_ps7   
    set_property -dict [list CONFIG.PCW_GPIO_EMIO_GPIO_IO {54}]      $sys_ps7

    set_property LEFT 53 [get_bd_ports GPIO_I]
    set_property LEFT 53 [get_bd_ports GPIO_O]
    set_property LEFT 53 [get_bd_ports GPIO_T]

    # memory interconnects share the same clock (fclk2)
if {$sys_zynq == 1} {
    set sys_fmc_dma_clk_source [get_bd_pins sys_ps7/FCLK_CLK2]
    connect_bd_net -net sys_fmc_dma_clk $sys_fmc_dma_clk_source
}


## CONNECTIONS
    # connections (spi)

    connect_bd_net -net spi_csn_i   [get_bd_ports spi_csn_0_i]  [get_bd_pins sys_ps7/SPI0_SS_I]
    connect_bd_net -net spi_csn_o   [get_bd_ports spi_csn_0_o]  [get_bd_pins sys_ps7/SPI0_SS_O]
    connect_bd_net -net spi_csn_1_o [get_bd_ports spi_csn_1_o]  [get_bd_pins sys_ps7/SPI0_SS1_O]
    connect_bd_net -net spi_csn_2_o [get_bd_ports spi_csn_2_o]  [get_bd_pins sys_ps7/SPI0_SS2_O]  
    connect_bd_net -net spi_sclk_i  [get_bd_ports spi_sclk_i]   [get_bd_pins sys_ps7/SPI0_SCLK_I]
    connect_bd_net -net spi_sclk_o  [get_bd_ports spi_sclk_o]   [get_bd_pins sys_ps7/SPI0_SCLK_O]
    connect_bd_net -net spi_mosi_i  [get_bd_ports spi_mosi_i]   [get_bd_pins sys_ps7/SPI0_MOSI_I]
    connect_bd_net -net spi_mosi_o  [get_bd_ports spi_mosi_o]   [get_bd_pins sys_ps7/SPI0_MOSI_O]
    connect_bd_net -net spi_miso_i  [get_bd_ports spi_miso_i]   [get_bd_pins sys_ps7/SPI0_MISO_I]

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
  	  connect_bd_net -net util_adc_pack_0_ddata       [get_bd_pins adi2axis_0/ddata]  [get_bd_pins util_adc_pack_0/ddata]
	  connect_bd_net -net util_adc_pack_0_dsync       [get_bd_pins adi2axis_0/dsync]  [get_bd_pins util_adc_pack_0/dsync]
	  connect_bd_net -net util_adc_pack_0_dvalid      [get_bd_pins adi2axis_0/dvalid] [get_bd_pins util_adc_pack_0/dvalid]

	connect_bd_net -net axi_ad9361_0_clk	    	[get_bd_pins adi2axis_0/AXIS_ACLK] 
    connect_bd_net -net [get_bd_nets axi_ad9361_0_clk] [get_bd_pins axis_adc_interconnect_0/ACLK]
	connect_bd_net -net [get_bd_nets axi_ad9361_0_clk]		    [get_bd_pins axis_adc_interconnect_0/S00_AXIS_ACLK] 
	connect_bd_net -net [get_bd_nets sys_fmc_dma_clk]			[get_bd_pins axis_adc_interconnect_0/M00_AXIS_ACLK] 
    connect_bd_net -net [get_bd_nets sys_100m_resetn]				[get_bd_pins axis_adc_interconnect_0/ARESETN] 
    connect_bd_net -net [get_bd_nets sys_100m_resetn]				[get_bd_pins axis_adc_interconnect_0/M00_AXIS_ARESETN]
    connect_bd_net -net [get_bd_nets sys_100m_resetn]				[get_bd_pins axis_adc_interconnect_0/S00_AXIS_ARESETN]
	connect_bd_intf_net -boundary_type upper [get_bd_intf_pins axis_adc_interconnect_0/S00_AXIS] [get_bd_intf_pins adi2axis_0/M_AXIS]
	connect_bd_intf_net -intf_net axis_adc_interconnect_0_M00_AXIS [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM] [get_bd_intf_pins axis_adc_interconnect_0/M00_AXIS]

    connect_bd_net -net axi_ad9361_0_clk              [get_bd_pins util_dac_unpack_0/clk]
    connect_bd_net -net axi_ad9361_0_dac_valid_0      [get_bd_pins util_dac_unpack_0/dac_valid_00] [get_bd_pins axi_ad9361_0/dac_valid_i0]
    connect_bd_net -net axi_ad9361_0_dac_valid_1      [get_bd_pins util_dac_unpack_0/dac_valid_01] [get_bd_pins axi_ad9361_0/dac_valid_q0]
    connect_bd_net -net axi_ad9361_0_dac_valid_2      [get_bd_pins util_dac_unpack_0/dac_valid_02] [get_bd_pins axi_ad9361_0/dac_valid_i1]
    connect_bd_net -net axi_ad9361_0_dac_valid_3      [get_bd_pins util_dac_unpack_0/dac_valid_03] [get_bd_pins axi_ad9361_0/dac_valid_q1]
    connect_bd_net -net axi_ad9361_0_dac_enable_0     [get_bd_pins util_dac_unpack_0/dac_enable_00] [get_bd_pins axi_ad9361_0/dac_enable_i0]
    connect_bd_net -net axi_ad9361_0_dac_enable_1     [get_bd_pins util_dac_unpack_0/dac_enable_01] [get_bd_pins axi_ad9361_0/dac_enable_q0]
    connect_bd_net -net axi_ad9361_0_dac_enable_2     [get_bd_pins util_dac_unpack_0/dac_enable_02] [get_bd_pins axi_ad9361_0/dac_enable_i1]
    connect_bd_net -net axi_ad9361_0_dac_enable_3     [get_bd_pins util_dac_unpack_0/dac_enable_03] [get_bd_pins axi_ad9361_0/dac_enable_q1]

    connect_bd_net -net axi_ad9361_0_dac_data_0       [get_bd_pins util_dac_unpack_0/dac_data_00] [get_bd_pins axi_ad9361_0/dac_data_i0]
    connect_bd_net -net axi_ad9361_0_dac_data_1       [get_bd_pins util_dac_unpack_0/dac_data_01] [get_bd_pins axi_ad9361_0/dac_data_q0]
    connect_bd_net -net axi_ad9361_0_dac_data_2       [get_bd_pins util_dac_unpack_0/dac_data_02] [get_bd_pins axi_ad9361_0/dac_data_i1]
    connect_bd_net -net axi_ad9361_0_dac_data_3       [get_bd_pins util_dac_unpack_0/dac_data_03] [get_bd_pins axi_ad9361_0/dac_data_q1]

	connect_bd_net -net fifo_data_0                   [get_bd_pins axis2adi_0/dma_data]   [get_bd_pins util_dac_unpack_0/dma_data]
	connect_bd_net -net fifo_valid_0                  [get_bd_pins axis2adi_0/dma_valid]  [get_bd_pins util_dac_unpack_0/fifo_valid]
	connect_bd_net -net axi_ad9361_0_dac_drd          [get_bd_pins axis2adi_0/dma_rd]     [get_bd_pins util_dac_unpack_0/dma_rd]
	connect_bd_net -net axi_ad9361_0_dac_dunf         [get_bd_pins axi_ad9361_0/dac_dunf] [get_bd_pins axis2adi_0/dma_unf] 

	connect_bd_net -net axi_ad9361_0_clk            [get_bd_pins axis2adi_0/AXIS_ACLK] 
	connect_bd_net -net [get_bd_nets axi_ad9361_0_clk]            [get_bd_pins axis_dac_interconnect_0/M00_AXIS_ACLK] 	
	connect_bd_net -net [get_bd_nets sys_fmc_dma_clk] 			[get_bd_pins axis_dac_interconnect_0/ACLK] 
	connect_bd_net -net [get_bd_nets sys_fmc_dma_clk] 			[get_bd_pins axis_dac_interconnect_0/S00_AXIS_ACLK]
	connect_bd_net -net [get_bd_nets sys_100m_resetn] 			[get_bd_pins axis_dac_interconnect_0/ARESETN]
    connect_bd_net -net [get_bd_nets sys_100m_resetn]				[get_bd_pins axis_dac_interconnect_0/M00_AXIS_ARESETN] 
    connect_bd_net -net [get_bd_nets sys_100m_resetn]				[get_bd_pins axis_dac_interconnect_0/S00_AXIS_ARESETN] 
	connect_bd_net -net axis2adi_0_S_AXIS_TREADY    [get_bd_pins axis2adi_0/S_AXIS_TREADY] [get_bd_pins axis_dac_interconnect_0/M00_AXIS_tready] 
	connect_bd_net -net axis2adi_0_M_AXIS_TDATA     [get_bd_pins axis2adi_0/S_AXIS_TDATA]  [get_bd_pins axis_dac_interconnect_0/M00_AXIS_tdata]
	connect_bd_net -net axis2adi_0_M_AXIS_TLAST     [get_bd_pins axis2adi_0/S_AXIS_TLAST]  [get_bd_pins axis_dac_interconnect_0/M00_AXIS_tlast]
	connect_bd_net -net axis2adi_0_M_AXIS_TVALID    [get_bd_pins axis2adi_0/S_AXIS_TVALID] [get_bd_pins axis_dac_interconnect_0/M00_AXIS_tvalid]
	connect_bd_net -net [get_bd_nets sys_100m_resetn] [get_bd_pins axis2adi_0/AXIS_ARESETN] [get_bd_pins sys_rstgen/peripheral_aresetn]
	connect_bd_intf_net -intf_net axi_dma_0_M_AXIS_MM2S 			[get_bd_intf_pins axi_dma_0/M_AXIS_MM2S] [get_bd_intf_pins axis_dac_interconnect_0/S00_AXIS]
	connect_bd_intf_net -intf_net axis_dac_interconnect_0_M00_AXIS 	[get_bd_intf_pins axis2adi_0/S_AXIS] [get_bd_intf_pins axis_dac_interconnect_0/M00_AXIS]
	
 	connect_bd_net -net axi_dma_0_mm2s_introut [get_bd_pins axi_dma_0/mm2s_introut] [get_bd_pins sys_concat_intc/In0]
	connect_bd_net -net axi_dma_0_s2mm_introut [get_bd_pins axi_dma_0/s2mm_introut] [get_bd_pins sys_concat_intc/In1]
	
    # connections (ad9361_1)

    connect_bd_net -net sys_200m_clk [get_bd_pins axi_ad9361_1/delay_clk]
    connect_bd_net -net axi_ad9361_1_clk [get_bd_pins axi_ad9361_1/l_clk]
    connect_bd_net -net axi_ad9361_1_clk [get_bd_pins axi_ad9361_1/clk]

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
	connect_bd_net -net util_adc_pack_1_ddata       [get_bd_pins adi2axis_1/ddata]  [get_bd_pins util_adc_pack_1/ddata]
	connect_bd_net -net util_adc_pack_1_dsync       [get_bd_pins adi2axis_1/dsync]  [get_bd_pins util_adc_pack_1/dsync]
	connect_bd_net -net util_adc_pack_1_dvalid      [get_bd_pins adi2axis_1/dvalid] [get_bd_pins util_adc_pack_1/dvalid]

	connect_bd_net -net axi_ad9361_1_clk	    	[get_bd_pins adi2axis_1/AXIS_ACLK] 
	connect_bd_net -net [get_bd_nets axi_ad9361_1_clk]		   	[get_bd_pins axis_adc_interconnect_1/ACLK] 
	connect_bd_net -net [get_bd_nets axi_ad9361_1_clk]		    [get_bd_pins axis_adc_interconnect_1/S00_AXIS_ACLK] 
	connect_bd_net -net [get_bd_nets sys_fmc_dma_clk]			[get_bd_pins axis_adc_interconnect_1/M00_AXIS_ACLK] 
    connect_bd_net -net [get_bd_nets sys_100m_resetn]				[get_bd_pins axis_adc_interconnect_1/ARESETN] 
    connect_bd_net -net [get_bd_nets sys_100m_resetn]				[get_bd_pins axis_adc_interconnect_1/M00_AXIS_ARESETN]
    connect_bd_net -net [get_bd_nets sys_100m_resetn]				[get_bd_pins axis_adc_interconnect_1/S00_AXIS_ARESETN]
	connect_bd_intf_net -boundary_type upper [get_bd_intf_pins axis_adc_interconnect_1/S00_AXIS] [get_bd_intf_pins adi2axis_1/M_AXIS]
 	connect_bd_intf_net -intf_net axis_adc_interconnect_1_M00_AXIS [get_bd_intf_pins axi_dma_1/S_AXIS_S2MM] [get_bd_intf_pins axis_adc_interconnect_1/M00_AXIS]
 
    connect_bd_net -net axi_ad9361_1_clk              [get_bd_pins util_dac_unpack_1/clk]
    connect_bd_net -net axi_ad9361_1_dac_valid_0      [get_bd_pins util_dac_unpack_1/dac_valid_00] [get_bd_pins axi_ad9361_1/dac_valid_i0]
    connect_bd_net -net axi_ad9361_1_dac_valid_1      [get_bd_pins util_dac_unpack_1/dac_valid_01] [get_bd_pins axi_ad9361_1/dac_valid_q0]
    connect_bd_net -net axi_ad9361_1_dac_valid_2      [get_bd_pins util_dac_unpack_1/dac_valid_02] [get_bd_pins axi_ad9361_1/dac_valid_i1]
    connect_bd_net -net axi_ad9361_1_dac_valid_3      [get_bd_pins util_dac_unpack_1/dac_valid_03] [get_bd_pins axi_ad9361_1/dac_valid_q1]
	connect_bd_net -net axi_ad9361_1_dac_enable_0     [get_bd_pins util_dac_unpack_1/dac_enable_00] [get_bd_pins axi_ad9361_1/dac_enable_i0]
    connect_bd_net -net axi_ad9361_1_dac_enable_1     [get_bd_pins util_dac_unpack_1/dac_enable_01] [get_bd_pins axi_ad9361_1/dac_enable_q0]
    connect_bd_net -net axi_ad9361_1_dac_enable_2     [get_bd_pins util_dac_unpack_1/dac_enable_02] [get_bd_pins axi_ad9361_1/dac_enable_i1]
    connect_bd_net -net axi_ad9361_1_dac_enable_3     [get_bd_pins util_dac_unpack_1/dac_enable_03] [get_bd_pins axi_ad9361_1/dac_enable_q1]
    connect_bd_net -net axi_ad9361_1_dac_data_0       [get_bd_pins util_dac_unpack_1/dac_data_00] [get_bd_pins axi_ad9361_1/dac_data_i0]
    connect_bd_net -net axi_ad9361_1_dac_data_1       [get_bd_pins util_dac_unpack_1/dac_data_01] [get_bd_pins axi_ad9361_1/dac_data_q0]
    connect_bd_net -net axi_ad9361_1_dac_data_2       [get_bd_pins util_dac_unpack_1/dac_data_02] [get_bd_pins axi_ad9361_1/dac_data_i1]
    connect_bd_net -net axi_ad9361_1_dac_data_3       [get_bd_pins util_dac_unpack_1/dac_data_03] [get_bd_pins axi_ad9361_1/dac_data_q1]

	connect_bd_net -net fifo_data_1                   [get_bd_pins axis2adi_1/dma_data]   [get_bd_pins util_dac_unpack_1/dma_data]
	connect_bd_net -net fifo_valid_1                  [get_bd_pins axis2adi_1/dma_valid]  [get_bd_pins util_dac_unpack_1/fifo_valid]
	connect_bd_net -net axi_ad9361_1_dac_drd          [get_bd_pins axis2adi_1/dma_rd]     [get_bd_pins util_dac_unpack_1/dma_rd]
	connect_bd_net -net axi_ad9361_1_dac_dunf         [get_bd_pins axi_ad9361_1/dac_dunf] [get_bd_pins axis2adi_1/dma_unf] 

	connect_bd_net -net axi_ad9361_1_clk            [get_bd_pins axis2adi_1/AXIS_ACLK] 
	connect_bd_net -net [get_bd_nets axi_ad9361_1_clk]            [get_bd_pins axis_dac_interconnect_1/M00_AXIS_ACLK] 	
	connect_bd_net -net [get_bd_nets sys_fmc_dma_clk] 			[get_bd_pins axis_dac_interconnect_1/ACLK] 
	connect_bd_net -net [get_bd_nets sys_fmc_dma_clk] 			[get_bd_pins axis_dac_interconnect_1/S00_AXIS_ACLK]
	connect_bd_net -net [get_bd_nets sys_100m_resetn] 			[get_bd_pins axis_dac_interconnect_1/ARESETN]
    connect_bd_net -net [get_bd_nets sys_100m_resetn]				[get_bd_pins axis_dac_interconnect_1/M00_AXIS_ARESETN] 
    connect_bd_net -net [get_bd_nets sys_100m_resetn]				[get_bd_pins axis_dac_interconnect_1/S00_AXIS_ARESETN] 
	connect_bd_net -net axis2adi_1_S_AXIS_TREADY    [get_bd_pins axis2adi_1/S_AXIS_TREADY] [get_bd_pins axis_dac_interconnect_1/M00_AXIS_tready] 
	connect_bd_net -net axis2adi_1_M_AXIS_TDATA     [get_bd_pins axis2adi_1/S_AXIS_TDATA]  [get_bd_pins axis_dac_interconnect_1/M00_AXIS_tdata]
	connect_bd_net -net axis2adi_1_M_AXIS_TLAST     [get_bd_pins axis2adi_1/S_AXIS_TLAST]  [get_bd_pins axis_dac_interconnect_1/M00_AXIS_tlast]
	connect_bd_net -net axis2adi_1_M_AXIS_TVALID    [get_bd_pins axis2adi_1/S_AXIS_TVALID] [get_bd_pins axis_dac_interconnect_1/M00_AXIS_tvalid]
	connect_bd_net -net [get_bd_nets sys_100m_resetn] [get_bd_pins axis2adi_1/AXIS_ARESETN] [get_bd_pins sys_rstgen/peripheral_aresetn]
	connect_bd_intf_net -intf_net axi_dma_1_M_AXIS_MM2S 			[get_bd_intf_pins axi_dma_1/M_AXIS_MM2S] [get_bd_intf_pins axis_dac_interconnect_1/S00_AXIS]
	connect_bd_intf_net -intf_net axis_dac_interconnect_1_M00_AXIS 	[get_bd_intf_pins axis2adi_1/S_AXIS] [get_bd_intf_pins axis_dac_interconnect_1/M00_AXIS]

	connect_bd_net -net axi_dma_1_mm2s_introut [get_bd_pins axi_dma_1/mm2s_introut] [get_bd_pins sys_concat_intc/In2]
	connect_bd_net -net axi_dma_1_s2mm_introut [get_bd_pins axi_dma_1/s2mm_introut] [get_bd_pins sys_concat_intc/In3]


    # interconnect (cpu)
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m07_axi [get_bd_intf_pins axi_cpu_interconnect/M07_AXI] [get_bd_intf_pins axi_ad9361_0/s_axi]
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m08_axi [get_bd_intf_pins axi_cpu_interconnect/M08_AXI] [get_bd_intf_pins adi2axis_0/S_AXI] 
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m09_axi [get_bd_intf_pins axi_cpu_interconnect/M09_AXI] [get_bd_intf_pins axi_dma_0/S_AXI_LITE]
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M07_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M08_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M09_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_ad9361_0/s_axi_aclk] 
    connect_bd_net -net sys_100m_clk    [get_bd_pins adi2axis_0/S_AXI_ACLK] 
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_dma_0/s_axi_lite_aclk] 
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M07_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M08_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M09_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn	[get_bd_pins axi_ad9361_0/s_axi_aresetn] 
    connect_bd_net -net sys_100m_resetn	[get_bd_pins adi2axis_0/AXIS_ARESETN] 
    connect_bd_net -net sys_100m_resetn	[get_bd_pins adi2axis_0/S_AXI_ARESETN] 
    connect_bd_net -net sys_100m_resetn	[get_bd_pins axi_dma_0/axi_resetn] 

    connect_bd_intf_net -intf_net axi_cpu_interconnect_m01_axi [get_bd_intf_pins axi_cpu_interconnect/M01_AXI] [get_bd_intf_pins axi_ad9361_1/s_axi]
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m02_axi [get_bd_intf_pins axi_cpu_interconnect/M02_AXI] [get_bd_intf_pins adi2axis_1/S_AXI] 
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m03_axi [get_bd_intf_pins axi_cpu_interconnect/M03_AXI] [get_bd_intf_pins axi_dma_1/S_AXI_LITE]
    connect_bd_net -net sys_100m_clk 	[get_bd_pins axi_cpu_interconnect/M01_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk 	[get_bd_pins axi_cpu_interconnect/M02_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk 	[get_bd_pins axi_cpu_interconnect/M03_ACLK] $sys_100m_clk_source
	connect_bd_net -net sys_100m_clk 	[get_bd_pins axi_ad9361_1/s_axi_aclk] 
    connect_bd_net -net sys_100m_clk 	[get_bd_pins adi2axis_1/S_AXI_ACLK] 
    connect_bd_net -net sys_100m_clk 	[get_bd_pins axi_dma_1/s_axi_lite_aclk] 
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M01_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M02_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M03_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_1/s_axi_aresetn] 
    connect_bd_net -net sys_100m_resetn [get_bd_pins adi2axis_1/AXIS_ARESETN] 
    connect_bd_net -net sys_100m_resetn [get_bd_pins adi2axis_1/S_AXI_ARESETN] 
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_dma_1/axi_resetn] 
	
	# interconnect scatter gather
    connect_bd_intf_net -intf_net axi_sg_interconnect_M00_AXI [get_bd_intf_pins axi_sg_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_GP0]
    connect_bd_intf_net -intf_net axi_dma_0_M_AXI_SG [get_bd_intf_pins axi_dma_0/M_AXI_SG] [get_bd_intf_pins axi_sg_interconnect/S00_AXI]
    connect_bd_intf_net -intf_net axi_dma_1_M_AXI_SG [get_bd_intf_pins axi_dma_1/M_AXI_SG] [get_bd_intf_pins axi_sg_interconnect/S01_AXI]
    connect_bd_net -net sys_fmc_dma_clk 	[get_bd_pins sys_ps7/S_AXI_GP0_ACLK]
    connect_bd_net -net sys_fmc_dma_clk 	[get_bd_pins axi_sg_interconnect/ACLK]     $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk 	[get_bd_pins axi_sg_interconnect/M00_ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk 	[get_bd_pins axi_sg_interconnect/S00_ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk 	[get_bd_pins axi_sg_interconnect/S01_ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk 	[get_bd_pins axi_dma_0/m_axi_sg_aclk]      $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk 	[get_bd_pins axi_dma_1/m_axi_sg_aclk]      $sys_fmc_dma_clk_source
	connect_bd_net -net [get_bd_nets sys_100m_resetn] [get_bd_pins axi_sg_interconnect/ARESETN] [get_bd_pins sys_rstgen/peripheral_aresetn]
	connect_bd_net -net [get_bd_nets sys_100m_resetn] [get_bd_pins axi_sg_interconnect/S00_ARESETN] [get_bd_pins sys_rstgen/peripheral_aresetn]
	connect_bd_net -net [get_bd_nets sys_100m_resetn] [get_bd_pins axi_sg_interconnect/M00_ARESETN] [get_bd_pins sys_rstgen/peripheral_aresetn]
	connect_bd_net -net [get_bd_nets sys_100m_resetn] [get_bd_pins axi_sg_interconnect/S01_ARESETN] [get_bd_pins sys_rstgen/peripheral_aresetn]

    # interconnect (mem/dac(0))
	connect_bd_intf_net -intf_net axi_dma_0_M_AXI_MM2S [get_bd_intf_pins axi_ad9361_0_dac_dma_interconnect/S00_AXI] [get_bd_intf_pins axi_dma_0/M_AXI_MM2S]
    connect_bd_intf_net -intf_net axi_dma_0_M_AXI_S2MM [get_bd_intf_pins axi_ad9361_0_adc_dma_interconnect/S00_AXI] [get_bd_intf_pins axi_dma_0/M_AXI_S2MM]
	connect_bd_net -net sys_fmc_dma_clk  [get_bd_pins axi_dma_0/m_axi_mm2s_aclk]
	connect_bd_net -net sys_fmc_dma_clk  [get_bd_pins axi_dma_0/m_axi_s2mm_aclk] 
	
    connect_bd_intf_net -intf_net axi_ad9361_0_dac_dma_interconnect_m00_axi [get_bd_intf_pins axi_ad9361_0_dac_dma_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_HP0]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_0_dac_dma_interconnect/ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_0_dac_dma_interconnect/M00_ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_0_dac_dma_interconnect/S00_ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins sys_ps7/S_AXI_HP0_ACLK]
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_0_dac_dma_interconnect/ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_0_dac_dma_interconnect/M00_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_0_dac_dma_interconnect/S00_ARESETN] $sys_100m_resetn_source

    connect_bd_intf_net -intf_net axi_ad9361_0_adc_dma_interconnect_m00_axi [get_bd_intf_pins axi_ad9361_0_adc_dma_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_HP1]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_0_adc_dma_interconnect/ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_0_adc_dma_interconnect/M00_ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_0_adc_dma_interconnect/S00_ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins sys_ps7/S_AXI_HP1_ACLK]
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_0_adc_dma_interconnect/ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_0_adc_dma_interconnect/M00_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_0_adc_dma_interconnect/S00_ARESETN] $sys_100m_resetn_source

    # interconnect (mem/dac(1))

	connect_bd_intf_net -intf_net axi_dma_1_M_AXI_MM2S [get_bd_intf_pins axi_ad9361_1_dac_dma_interconnect/S00_AXI] [get_bd_intf_pins axi_dma_1/M_AXI_MM2S]
	connect_bd_intf_net -intf_net axi_dma_1_M_AXI_S2MM [get_bd_intf_pins axi_ad9361_1_adc_dma_interconnect/S00_AXI] [get_bd_intf_pins axi_dma_1/M_AXI_S2MM]
 	connect_bd_net -net sys_fmc_dma_clk  [get_bd_pins axi_dma_1/m_axi_mm2s_aclk]
	connect_bd_net -net sys_fmc_dma_clk  [get_bd_pins axi_dma_1/m_axi_s2mm_aclk] 
	
    connect_bd_intf_net -intf_net axi_ad9361_1_dac_dma_interconnect_m00_axi [get_bd_intf_pins axi_ad9361_1_dac_dma_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_HP2]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_1_dac_dma_interconnect/ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_1_dac_dma_interconnect/M00_ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_1_dac_dma_interconnect/S00_ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins sys_ps7/S_AXI_HP2_ACLK]
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_1_dac_dma_interconnect/ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_1_dac_dma_interconnect/M00_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_1_dac_dma_interconnect/S00_ARESETN] $sys_100m_resetn_source

    connect_bd_intf_net -intf_net axi_ad9361_1_adc_dma_interconnect_m00_axi [get_bd_intf_pins axi_ad9361_1_adc_dma_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_HP3]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_1_adc_dma_interconnect/ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_1_adc_dma_interconnect/M00_ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_1_adc_dma_interconnect/S00_ACLK] $sys_fmc_dma_clk_source
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins sys_ps7/S_AXI_HP3_ACLK]
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_1_adc_dma_interconnect/ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_1_adc_dma_interconnect/M00_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_1_adc_dma_interconnect/S00_ARESETN] $sys_100m_resetn_source


    # # ila (adc0)

    # set ila_adc [create_bd_cell -type ip -vlnv xilinx.com:ip:ila:4.0 ila_adc]
    # set_property -dict [list CONFIG.C_MONITOR_TYPE {Native}] $ila_adc
    # set_property -dict [list CONFIG.C_NUM_OF_PROBES {5}] $ila_adc
    # set_property -dict [list CONFIG.C_PROBE0_WIDTH {1}] $ila_adc
    # set_property -dict [list CONFIG.C_PROBE1_WIDTH {16}] $ila_adc
    # set_property -dict [list CONFIG.C_PROBE2_WIDTH {16}] $ila_adc
    # set_property -dict [list CONFIG.C_PROBE3_WIDTH {16}] $ila_adc
    # set_property -dict [list CONFIG.C_PROBE4_WIDTH {16}] $ila_adc
    # set_property -dict [list CONFIG.C_TRIGIN_EN {false}] $ila_adc
    # set_property -dict [list CONFIG.C_EN_STRG_QUAL {1}] $ila_adc

    # connect_bd_net -net axi_ad9361_0_clk            [get_bd_pins ila_adc/clk]
    # connect_bd_net -net axi_ad9361_0_adc_valid_0    [get_bd_pins ila_adc/probe0]
    # connect_bd_net -net axi_ad9361_0_adc_chan_i1    [get_bd_pins ila_adc/probe1]
    # connect_bd_net -net axi_ad9361_0_adc_chan_q1    [get_bd_pins ila_adc/probe2]
    # connect_bd_net -net axi_ad9361_0_adc_chan_i2    [get_bd_pins ila_adc/probe3]
    # connect_bd_net -net axi_ad9361_0_adc_chan_q2    [get_bd_pins ila_adc/probe4]


    # # ila (dac0)

    # set ila_dac [create_bd_cell -type ip -vlnv xilinx.com:ip:ila:4.0 ila_dac]
    # set_property -dict [list CONFIG.C_MONITOR_TYPE {Native}] $ila_dac
    # set_property -dict [list CONFIG.C_NUM_OF_PROBES {5}] $ila_dac
    # set_property -dict [list CONFIG.C_PROBE0_WIDTH {1}] $ila_dac
    # set_property -dict [list CONFIG.C_PROBE1_WIDTH {16}] $ila_dac
    # set_property -dict [list CONFIG.C_PROBE2_WIDTH {16}] $ila_dac
    # set_property -dict [list CONFIG.C_PROBE3_WIDTH {16}] $ila_dac
    # set_property -dict [list CONFIG.C_PROBE4_WIDTH {16}] $ila_dac
    # set_property -dict [list CONFIG.C_TRIGIN_EN {false}] $ila_dac
    # set_property -dict [list CONFIG.C_EN_STRG_QUAL {1}] $ila_dac

    # connect_bd_net -net axi_ad9361_0_clk           [get_bd_pins ila_dac/clk]
    # connect_bd_net -net axi_ad9361_0_dac_drd       [get_bd_pins ila_dac/probe0]
    # connect_bd_net -net axi_ad9361_0_dac_data_0    [get_bd_pins ila_dac/probe1]
    # connect_bd_net -net axi_ad9361_0_dac_data_1    [get_bd_pins ila_dac/probe2]
    # connect_bd_net -net axi_ad9361_0_dac_data_2    [get_bd_pins ila_dac/probe3]
    # connect_bd_net -net axi_ad9361_0_dac_data_3    [get_bd_pins ila_dac/probe4]


	
	
    # address map
	
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_dma_0/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_DDR_LOWOCM] SEG_sys_ps7_GP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x1000000 -offset 0xFC000000 [get_bd_addr_spaces axi_dma_0/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_QSPI_LINEAR] SEG_sys_ps7_GP0_QSPI_LINEAR
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs sys_ps7/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_sys_ps7_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs sys_ps7/S_AXI_HP1/HP1_DDR_LOWOCM] SEG_sys_ps7_HP1_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_dma_1/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_DDR_LOWOCM] SEG_sys_ps7_GP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x1000000 -offset 0xFC000000 [get_bd_addr_spaces axi_dma_1/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_QSPI_LINEAR] SEG_sys_ps7_GP0_QSPI_LINEAR
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs sys_ps7/S_AXI_HP2/HP2_DDR_LOWOCM] SEG_sys_ps7_HP2_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs sys_ps7/S_AXI_HP3/HP3_DDR_LOWOCM] SEG_sys_ps7_HP3_DDR_LOWOCM	
	
    create_bd_addr_seg -range 0x00010000 -offset 0x41200000 $sys_addr_cntrl_space [get_bd_addr_segs axi_gpio/s_axi/Reg]            SEG_data_axi_gpio

    create_bd_addr_seg -range 0x00010000 -offset 0x43C00000 $sys_addr_cntrl_space [get_bd_addr_segs axi_ad9361_0/s_axi/axi_lite]   SEG_data_ad9361_0
    create_bd_addr_seg -range 0x00010000 -offset 0x43C10000 $sys_addr_cntrl_space [get_bd_addr_segs adi2axis_0/S_AXI/reg0]         SEG_data_ad9361_0_adi2axis
    create_bd_addr_seg -range 0x00010000 -offset 0x40400000 $sys_addr_cntrl_space [get_bd_addr_segs axi_dma_0/S_AXI_LITE/Reg]      SEG_data_ad9361_0_dma

    create_bd_addr_seg -range 0x00010000 -offset 0x43C20000 $sys_addr_cntrl_space [get_bd_addr_segs axi_ad9361_1/s_axi/axi_lite]   SEG_data_ad9361_1
    create_bd_addr_seg -range 0x00010000 -offset 0x43C30000 $sys_addr_cntrl_space [get_bd_addr_segs adi2axis_1/S_AXI/reg0]         SEG_data_ad9361_1_adi2axis
    create_bd_addr_seg -range 0x00010000 -offset 0x40410000 $sys_addr_cntrl_space [get_bd_addr_segs axi_dma_1/S_AXI_LITE/Reg]      SEG_data_ad9361_1_dma

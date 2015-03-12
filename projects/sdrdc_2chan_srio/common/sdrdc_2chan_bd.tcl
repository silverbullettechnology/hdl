
    # sdrdc_2chan_srio

    set IIC_1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC_1 ]

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

    set srio_rxn0 [ create_bd_port -dir I srio_rxn0 ]  
    set srio_rxn1 [ create_bd_port -dir I srio_rxn1 ]
    set srio_rxn2 [ create_bd_port -dir I srio_rxn2 ]
    set srio_rxn3 [ create_bd_port -dir I srio_rxn3 ]
    set srio_rxp0 [ create_bd_port -dir I srio_rxp0 ]
    set srio_rxp1 [ create_bd_port -dir I srio_rxp1 ]
    set srio_rxp2 [ create_bd_port -dir I srio_rxp2 ]
    set srio_rxp3 [ create_bd_port -dir I srio_rxp3 ]
    set srio_sys_clkn [ create_bd_port -dir I -type clk srio_sys_clkn ]
    set srio_sys_clkp [ create_bd_port -dir I -type clk srio_sys_clkp ]
    set srio_txn0 [ create_bd_port -dir O srio_txn0 ]
    set srio_txn1 [ create_bd_port -dir O srio_txn1 ]
    set srio_txn2 [ create_bd_port -dir O srio_txn2 ]
    set srio_txn3 [ create_bd_port -dir O srio_txn3 ]
    set srio_txp0 [ create_bd_port -dir O srio_txp0 ]
    set srio_txp1 [ create_bd_port -dir O srio_txp1 ]
    set srio_txp2 [ create_bd_port -dir O srio_txp2 ]
    set srio_txp3 [ create_bd_port -dir O srio_txp3 ]
    
    set axi_gpio [create_bd_port -dir I -from 23 -to 0 axi_gpio]


## INSTANTIATIONS

    # constant 0
    set constant_0 [create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 constant_0]
    set_property -dict [list CONFIG.CONST_VAL {0}] $constant_0

	# Create instance: const_1, and set properties
    set const_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_1 ]
    set_property -dict [ list CONFIG.CONST_VAL {255} CONFIG.CONST_WIDTH {8}  ] $const_1

    # axi_gpio
    set axi_gpio [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio]
    set_property -dict [list CONFIG.C_GPIO_WIDTH {24}] $axi_gpio
    set_property -dict [list CONFIG.C_ALL_INPUTS {1} ] $axi_gpio
    set_property -dict [list CONFIG.C_INTERRUPT_PRESENT {1}] $axi_gpio

	# axi_sg_interconnect
	set axi_sg_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_sg_interconnect ]
	set_property -dict [list CONFIG.NUM_SI {2}] $axi_sg_interconnect
	set_property -dict [list CONFIG.NUM_MI {1}] $axi_sg_interconnect
	set_property -dict [list CONFIG.S00_HAS_REGSLICE {4}] $axi_sg_interconnect
	set_property -dict [list CONFIG.S01_HAS_REGSLICE {4}] $axi_sg_interconnect
	set_property -dict [list CONFIG.M00_HAS_REGSLICE {4}] $axi_sg_interconnect

	# Create instance: vita49_clk, and set properties
	set vita49_clk [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:vita49_clk:1.0 vita49_clk ]

    # Create instance: sys_reg_0, and set properties
    set sys_reg_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:sys_reg:1.0 sys_reg_0 ]
		
	# Create instance: c_counter_binary_0, and set properties
	set c_counter_binary_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_counter_binary:12.0 c_counter_binary_0 ]
	set_property -dict [ list CONFIG.Output_Width {28}  ] $c_counter_binary_0
	
	# Create instance: xlslice_0, and set properties
	set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
	set_property -dict [ list CONFIG.DIN_FROM {26} CONFIG.DIN_TO {26} CONFIG.DIN_WIDTH {28}  ] $xlslice_0

	
# CHANNEL 0	
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

	# ADC_0 PATH
	set axis_64to32_adc_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_64to32:1.0 axis_64to32_adc_0 ]
	# Create instance: vita49_trig_adc_0, and set properties
	set vita49_trig_adc_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:vita49_trig:1.0 vita49_trig_adc_0 ]
	# Create instance: axis_vita49_pack_0, and set properties
	set axis_vita49_pack_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_vita49_pack:1.0 axis_vita49_pack_0 ]
	# Create instance: axis_32to64_adc_0, and set properties
	set axis_32to64_adc_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_32to64:1.0 axis_32to64_adc_0 ]

    # Create instance: adc_fifo_0, and set properties
    set adc_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:1.1 adc_fifo_0 ]
    set_property -dict [ list CONFIG.FIFO_DEPTH {512}  ] $adc_fifo_0	
	# Create instance: adc_ddr_sw_0, and set properties
    set adc_ddr_sw_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 adc_ddr_sw_0 ]
    set_property -dict [ list CONFIG.NUM_SI {1}  ] $adc_ddr_sw_0
    # Create instance: srio_swrite_pack_0, and set properties
    set srio_swrite_pack_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:srio_swrite_pack:1.0 srio_swrite_pack_0 ]

	# DAC_0 PATH
    # Create instance: vita49_assem_0, and set properties
    set vita49_assem_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:vita49_assem:1.0 vita49_assem_0 ]
	# Create instance: dac_fifo_0, and set properties
    set dac_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:1.1 dac_fifo_0 ]
    set_property -dict [ list CONFIG.FIFO_DEPTH {512}  ] $dac_fifo_0
	# Create instance: dac_ddr_sw_0, and set properties
    set dac_ddr_sw_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 dac_ddr_sw_0 ]	

	set axis_64to32_dac_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_64to32:1.0 axis_64to32_dac_0 ]
	# Create instance: vita_unpack_dac_reg_0, and set properties
	set vita_unpack_dac_reg_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 vita_unpack_dac_reg_0 ]
	# Create instance: axis_vita49_unpack_0, and set properties
	set axis_vita49_unpack_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_vita49_unpack:1.0 axis_vita49_unpack_0 ]
    # Create instance: vita_trig_dac_reg_0, and set properties
    set vita_trig_dac_reg_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 vita_trig_dac_reg_0 ]
	# Create instance: vita49_trig_dac_0, and set properties
	set vita49_trig_dac_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:vita49_trig:1.0 vita49_trig_dac_0 ]
	# Create instance: axis_32to64_dac_0, and set properties
	set axis_32to64_dac_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_32to64:1.0 axis_32to64_dac_0 ]
	
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
	

# CHANNEL 1	
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

	# ADC_1 PATH	
	# Create instance: axis_64to32_adc_1, and set properties
	set axis_64to32_adc_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_64to32:1.0 axis_64to32_adc_1 ]
	# Create instance: vita49_trig_adc_1, and set properties
	set vita49_trig_adc_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:vita49_trig:1.0 vita49_trig_adc_1 ]
	# Create instance: axis_vita49_pack_1, and set properties
	set axis_vita49_pack_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_vita49_pack:1.0 axis_vita49_pack_1 ]
	# Create instance: axis_32to64_adc_1, and set properties
	set axis_32to64_adc_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_32to64:1.0 axis_32to64_adc_1 ]

    # Create instance: adc_fifo_1, and set properties
    set adc_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:1.1 adc_fifo_1 ]
    set_property -dict [ list CONFIG.FIFO_DEPTH {512}  ] $adc_fifo_1
    # Create instance: adc_ddr_sw_1, and set properties
    set adc_ddr_sw_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 adc_ddr_sw_1 ]
    set_property -dict [ list CONFIG.NUM_SI {1}  ] $adc_ddr_sw_1
    # Create instance: srio_swrite_pack_1, and set properties
    set srio_swrite_pack_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:srio_swrite_pack:1.0 srio_swrite_pack_1 ]
	
	# DAC_1 PATH	
    # Create instance: vita49_assem_1, and set properties
    set vita49_assem_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:vita49_assem:1.0 vita49_assem_1 ]
    # Create instance: dac_fifo_1, and set properties
    set dac_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:1.1 dac_fifo_1 ]
    set_property -dict [ list CONFIG.FIFO_DEPTH {512}  ] $dac_fifo_1
    # Create instance: dac_ddr_sw_1, and set properties
    set dac_ddr_sw_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 dac_ddr_sw_1 ]
   
	# Create instance: axis_64to32_dac_1, and set properties
	set axis_64to32_dac_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_64to32:1.0 axis_64to32_dac_1 ]
	# Create instance: vita_unpack_dac_reg_1, and set properties
	set vita_unpack_dac_reg_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 vita_unpack_dac_reg_1 ]
    # Create instance: vita_trig_dac_reg_1, and set properties
	set vita49_trig_dac_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:vita49_trig:1.0 vita49_trig_dac_1 ]
    # Create instance: vita_trig_dac_reg_1, and set properties
    set vita_trig_dac_reg_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 vita_trig_dac_reg_1 ]	
	# Create instance: axis_vita49_unpack_1, and set properties
	set axis_vita49_unpack_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_vita49_unpack:1.0 axis_vita49_unpack_1 ]
	# Create instance: axis_32to64_dac_1, and set properties
	set axis_32to64_dac_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_32to64:1.0 axis_32to64_dac_1 ]

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

# SRIO AND SWITCHES
    # Create instance: srio_gen2_0, and set properties
    set srio_gen2_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:srio_gen2:3.1 srio_gen2_0 ]
    set_property -dict [ list CONFIG.assembly_identifier {7045} CONFIG.assembly_revision_level {0001} CONFIG.assembly_vendor_identifier {4242} CONFIG.c_transceivercontrol {1} CONFIG.device_id {02} CONFIG.extended_features_enable_user {false} CONFIG.link_width {4} CONFIG.mode_selection {Advanced} CONFIG.port_init_targ_userdef {true} CONFIG.silicon_rev {Production} CONFIG.software_assisted_error_recovery {true} CONFIG.transfer_frequency {5.0} CONFIG.unified_clk {true}  ] $srio_gen2_0
    # Create instance: axi_srio_interconnect, and set properties
    set axi_srio_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_srio_interconnect ]
    set_property -dict [ list CONFIG.ENABLE_ADVANCED_OPTIONS {1} CONFIG.M00_HAS_REGSLICE {4} CONFIG.M01_HAS_REGSLICE {4} CONFIG.M02_HAS_REGSLICE {4} CONFIG.M03_HAS_REGSLICE {4} CONFIG.M04_HAS_REGSLICE {4} CONFIG.M05_HAS_REGSLICE {4} CONFIG.M06_HAS_REGSLICE {4} CONFIG.M07_HAS_REGSLICE {4} CONFIG.NUM_MI {5} CONFIG.S00_HAS_REGSLICE {4} CONFIG.STRATEGY {2}  ] $axi_srio_interconnect
    # Create instance: srio_ireq_intc, and set properties
    set srio_ireq_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 srio_ireq_intc ]
    set_property -dict [ list CONFIG.NUM_MI {1}  ] $srio_ireq_intc
    # Create instance: srio_iresp_intc, and set properties
    set srio_iresp_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 srio_iresp_intc ]
    set_property -dict [ list CONFIG.NUM_MI {1}  ] $srio_iresp_intc
    # Create instance: srio_treq_intc, and set properties
    set srio_treq_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 srio_treq_intc ]
    set_property -dict [ list CONFIG.NUM_MI {1}  ] $srio_treq_intc
    # Create instance: srio_tresp_intc, and set properties
    set srio_tresp_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 srio_tresp_intc ]
    set_property -dict [ list CONFIG.NUM_MI {1}  ] $srio_tresp_intc
    # Create instance: const_loopback, and set properties
    set const_loopback [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_loopback ]
    set_property -dict [ list CONFIG.CONST_VAL {585} CONFIG.CONST_WIDTH {12}  ] $const_loopback

    # SRIO - ZYNQ FIFOS
    # Create instance: axi_srio_initiator_fifo, and set properties
    set axi_srio_initiator_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_fifo_mm_s:4.0 axi_srio_initiator_fifo ]
    set_property -dict [ list CONFIG.C_DATA_INTERFACE_TYPE {1} CONFIG.C_HAS_AXIS_TDEST {true} CONFIG.C_HAS_AXIS_TUSER {false} CONFIG.C_RX_FIFO_DEPTH {512} CONFIG.C_S_AXI4_DATA_WIDTH {32} CONFIG.C_TX_FIFO_DEPTH {512} CONFIG.C_USE_RX_CUT_THROUGH {false} CONFIG.C_USE_TX_CTRL {0} CONFIG.C_USE_TX_CUT_THROUGH {1}  ] $axi_srio_initiator_fifo
    # Create instance: axi_srio_target_fifo, and set properties
    set axi_srio_target_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_fifo_mm_s:4.0 axi_srio_target_fifo ]
    set_property -dict [ list CONFIG.C_DATA_INTERFACE_TYPE {1} CONFIG.C_HAS_AXIS_TDEST {true} CONFIG.C_HAS_AXIS_TUSER {false} CONFIG.C_RX_FIFO_DEPTH {512} CONFIG.C_S_AXI4_DATA_WIDTH {32} CONFIG.C_TX_FIFO_DEPTH {512} CONFIG.C_USE_RX_CUT_THROUGH {true} CONFIG.C_USE_TX_CTRL {0} CONFIG.C_USE_TX_CUT_THROUGH {1}  ] $axi_srio_target_fifo
    # Create instance: axis_32to64_srio_init, and set properties
    set axis_32to64_srio_init [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_32to64_strb:1.0 axis_32to64_srio_init ]
    # Create instance: axis_32to64_srio_target, and set properties
    set axis_32to64_srio_target [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_32to64_strb:1.0 axis_32to64_srio_target ]
    # Create instance: axis_64to32_srio_init, and set properties
    set axis_64to32_srio_init [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_64to32_strb:1.0 axis_64to32_srio_init ]
    # Create instance: axis_64to32_srio_target, and set properties
    set axis_64to32_srio_target [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_64to32_strb:1.0 axis_64to32_srio_target ]
    # Create instance: srio_target_reg, and set properties
    set srio_target_reg [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 srio_target_reg ]

	# SRIO SWITCHES
	# Create instance: srio_ireq_sw, and set properties
	set srio_ireq_sw [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 srio_ireq_sw ]
	set_property -dict [ list CONFIG.ARB_ON_TLAST {0} CONFIG.NUM_MI {1} CONFIG.NUM_SI {3}  ] $srio_ireq_sw
	# Create instance: hello_router_0, and set properties
	set hello_router_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:hello_router:1.0 hello_router_0 ]
	# Create instance: srio_treq_sw, and set properties
	set srio_treq_sw [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 srio_treq_sw ]
	set_property -dict [ list CONFIG.NUM_SI {1} CONFIG.TUSER_WIDTH {32}  ] $srio_treq_sw
	# Create instance: srio_swrite_unpack_0, and set properties
	set srio_swrite_unpack_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:srio_swrite_unpack:1.0 srio_swrite_unpack_0 ]
	# Create instance: vita_dac_sw, and set properties
	set vita_dac_sw [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 vita_dac_sw ]
	set_property -dict [ list CONFIG.NUM_SI {1}  ] $vita_dac_sw
	
	
    # additions to default configuration
	set_property -dict [list CONFIG.NUM_PORTS {9}] [get_bd_cells sys_concat_intc]
    set_property -dict [list CONFIG.NUM_MI {22}] $axi_cpu_interconnect

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
    set_property -dict [list CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {1}]      $sys_ps7 
    set_property -dict [list CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K256M16 RE-125}]      $sys_ps7 
    set_property -dict [list CONFIG.PCW_USE_M_AXI_GP1 {1}]      $sys_ps7 

    set_property LEFT 53 [get_bd_ports GPIO_I]
    set_property LEFT 53 [get_bd_ports GPIO_O]
    set_property LEFT 53 [get_bd_ports GPIO_T]

    # memory interconnects share the same clock (fclk2)
if {$sys_zynq == 1} {
    set sys_fmc_dma_clk_source [get_bd_pins sys_ps7/FCLK_CLK2]
    connect_bd_net -net sys_fmc_dma_clk $sys_fmc_dma_clk_source
}


## CONNECTIONS
    connect_bd_intf_net -intf_net sys_ps7_IIC_1 [get_bd_intf_ports IIC_1] [get_bd_intf_pins sys_ps7/IIC_1]
  
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

	# vita49 clock
	connect_bd_net -net c_counter_binary_0_Q [get_bd_pins c_counter_binary_0/Q] [get_bd_pins xlslice_0/Din]
	connect_bd_net -net sys_100m_clk 	[get_bd_pins c_counter_binary_0/CLK]
	connect_bd_net -net xlslice_0_Dout [get_bd_pins vita49_clk/pps_clk] [get_bd_pins xlslice_0/Dout]
	connect_bd_net -net axi_ad9361_0_clk [get_bd_pins vita49_clk/samp_clk_0]
	connect_bd_net -net axi_ad9361_1_clk [get_bd_pins vita49_clk/samp_clk_1]
	connect_bd_net -net vita49_clk_tsf_0 [get_bd_pins vita49_clk/tsf_0] [get_bd_pins axis_vita49_pack_0/timestamp_fsec] [get_bd_pins axis_vita49_unpack_0/timestamp_fsec]  [get_bd_pins vita49_trig_adc_0/tsf] [get_bd_pins vita49_trig_dac_0/tsf]
	connect_bd_net -net vita49_clk_tsi_0 [get_bd_pins vita49_clk/tsi_0] [get_bd_pins axis_vita49_pack_0/timestamp_sec] [get_bd_pins axis_vita49_unpack_0/timestamp_sec] [get_bd_pins vita49_trig_adc_0/tsi] [get_bd_pins vita49_trig_dac_0/tsi]
	connect_bd_net -net vita49_clk_tsf_1 [get_bd_pins vita49_clk/tsf_1] [get_bd_pins axis_vita49_pack_1/timestamp_fsec] [get_bd_pins axis_vita49_unpack_1/timestamp_fsec]  [get_bd_pins vita49_trig_adc_1/tsf] [get_bd_pins vita49_trig_dac_1/tsf]
	connect_bd_net -net vita49_clk_tsi_1 [get_bd_pins vita49_clk/tsi_1] [get_bd_pins axis_vita49_pack_1/timestamp_sec] [get_bd_pins axis_vita49_unpack_1/timestamp_sec] [get_bd_pins vita49_trig_adc_1/tsi] [get_bd_pins vita49_trig_dac_1/tsi]

	#sys_reg_0
    connect_bd_net -net sys_reg_0_srio_srcdest_ireq [get_bd_pins axis_32to64_srio_init/SRCDEST] [get_bd_pins sys_reg_0/srio_srcdest_ireq]
    connect_bd_net -net sys_reg_0_srio_srcdest_tresp [get_bd_pins axis_32to64_srio_target/SRCDEST] [get_bd_pins sys_reg_0/srio_srcdest_tresp]
    connect_bd_net -net sys_reg_0_swrite_bypass [get_bd_pins hello_router_0/swrite_bypass] [get_bd_pins sys_reg_0/swrite_bypass]
    connect_bd_net -net sys_reg_0_adc_sw_dest0 [get_bd_pins adc_ddr_sw_0/s_axis_tdest] [get_bd_pins sys_reg_0/adc_sw_dest0]
    connect_bd_net -net sys_reg_0_adc_sw_dest1 [get_bd_pins adc_ddr_sw_1/s_axis_tdest] [get_bd_pins sys_reg_0/adc_sw_dest1]
    connect_bd_net -net sys_reg_0_srio_reset [get_bd_pins srio_gen2_0/sys_rst] [get_bd_pins sys_reg_0/srio_reset]
    connect_bd_net -net sys_100m_clk [get_bd_pins sys_reg_0/S_AXI_ACLK] 
    connect_bd_net -net sys_100m_resetn [get_bd_pins sys_reg_0/S_AXI_ARESETN] 

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

	# ADC
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
#	connect_bd_intf_net -intf_net axis_adc_interconnect_0_M00_AXIS [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM] [get_bd_intf_pins axis_adc_interconnect_0/M00_AXIS]
	connect_bd_intf_net -intf_net axis_adc_interconnect_0_M00_AXIS [get_bd_intf_pins axis_64to32_adc_0/S_AXIS] [get_bd_intf_pins axis_adc_interconnect_0/M00_AXIS]

	# VITA ADC
	connect_bd_intf_net -intf_net axis_64to32_adc_0_M_AXIS [get_bd_intf_pins axis_64to32_adc_0/M_AXIS] [get_bd_intf_pins vita49_trig_adc_0/S_AXIS]
	connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axis_64to32_adc_0/AXIS_ACLK]
	connect_bd_net -net sys_100m_resetn [get_bd_pins axis_64to32_adc_0/AXIS_ARESETN]
	# connect_bd_net -net axis_64to32_adc_0_M_AXIS_TDATA [get_bd_pins axis_64to32_adc_0/M_AXIS_TDATA] [get_bd_pins ila_adc_trig/probe0] [get_bd_pins vita49_trig_adc_0/S_AXIS_TDATA]
	# connect_bd_net -net axis_64to32_adc_0_M_AXIS_TLAST [get_bd_pins axis_64to32_adc_0/M_AXIS_TLAST] [get_bd_pins ila_adc_trig/probe1] [get_bd_pins vita49_trig_adc_0/S_AXIS_TLAST]
	# connect_bd_net -net axis_64to32_adc_0_M_AXIS_TVALID [get_bd_pins axis_64to32_adc_0/M_AXIS_TVALID] [get_bd_pins ila_adc_trig/probe2] [get_bd_pins vita49_trig_adc_0/S_AXIS_TVALID]

	connect_bd_intf_net -intf_net vita49_trig_adc_0_M_AXIS [get_bd_intf_pins axis_vita49_pack_0/S_AXIS] [get_bd_intf_pins vita49_trig_adc_0/M_AXIS]
	connect_bd_net -net vita49_trig_adc_0_trig [get_bd_pins adi2axis_0/trig] [get_bd_pins vita49_trig_adc_0/trig]
	connect_bd_net -net sys_fmc_dma_clk [get_bd_pins vita49_trig_adc_0/AXIS_ACLK]
	connect_bd_net -net sys_100m_resetn [get_bd_pins vita49_trig_adc_0/AXIS_ARESETN]
	connect_bd_net [get_bd_pins vita49_trig_adc_0/M_AXIS_TDATA] [get_bd_pins axis_vita49_pack_0/S_AXIS_TDATA]
	connect_bd_net [get_bd_pins vita49_trig_adc_0/M_AXIS_TLAST] [get_bd_pins axis_vita49_pack_0/S_AXIS_TLAST]
	connect_bd_net [get_bd_pins vita49_trig_adc_0/M_AXIS_TVALID] [get_bd_pins axis_vita49_pack_0/S_AXIS_TVALID]
	connect_bd_net [get_bd_pins vita49_trig_adc_0/M_AXIS_TREADY] [get_bd_pins axis_vita49_pack_0/S_AXIS_TREADY] 

	connect_bd_intf_net -intf_net axis_vita49_pack_0_M_AXIS [get_bd_intf_pins axis_32to64_adc_0/S_AXIS] [get_bd_intf_pins axis_vita49_pack_0/M_AXIS]
	connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axis_vita49_pack_0/AXIS_ACLK]
	connect_bd_net -net sys_100m_resetn [get_bd_pins axis_vita49_pack_0/AXIS_ARESETN]
	connect_bd_net [get_bd_pins axis_vita49_pack_0/M_AXIS_TDATA] [get_bd_pins axis_32to64_adc_0/S_AXIS_TDATA]
	connect_bd_net [get_bd_pins axis_vita49_pack_0/M_AXIS_TLAST] [get_bd_pins axis_32to64_adc_0/S_AXIS_TLAST]
	connect_bd_net [get_bd_pins axis_vita49_pack_0/M_AXIS_TVALID] [get_bd_pins axis_32to64_adc_0/S_AXIS_TVALID]
	connect_bd_net [get_bd_pins axis_vita49_pack_0/M_AXIS_TREADY] [get_bd_pins axis_32to64_adc_0/S_AXIS_TREADY]

    connect_bd_intf_net -intf_net axis_32to64_adc_0_M_AXIS [get_bd_intf_pins adc_fifo_0/S_AXIS] [get_bd_intf_pins axis_32to64_adc_0/M_AXIS]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axis_32to64_adc_0/AXIS_ACLK]
	connect_bd_net -net sys_100m_resetn [get_bd_pins axis_32to64_adc_0/AXIS_ARESETN]	

	# ADC FIFO_0
    connect_bd_intf_net -intf_net adc_fifo_0_M_AXIS [get_bd_intf_pins adc_ddr_sw_0/S00_AXIS] [get_bd_intf_pins adc_fifo_0/M_AXIS]	
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins adc_fifo_0/s_axis_aclk]
	connect_bd_net -net sys_100m_resetn [get_bd_pins adc_fifo_0/s_axis_aresetn]
    # connect_bd_net -net adc_ddr_sw_0_s_axis_tready [get_bd_pins adc_ddr_sw_0/s_axis_tready] [get_bd_pins adc_fifo_0/m_axis_tready] [get_bd_pins ila_vita_adc_0/probe2]
    # connect_bd_net -net adc_fifo_0_m_axis_tdata [get_bd_pins adc_ddr_sw_0/s_axis_tdata] [get_bd_pins adc_fifo_0/m_axis_tdata] [get_bd_pins ila_vita_adc_0/probe0]
    # connect_bd_net -net adc_fifo_0_m_axis_tlast [get_bd_pins adc_ddr_sw_0/s_axis_tlast] [get_bd_pins adc_fifo_0/m_axis_tlast] [get_bd_pins ila_vita_adc_0/probe3]
    # connect_bd_net -net adc_fifo_0_m_axis_tvalid [get_bd_pins adc_ddr_sw_0/s_axis_tvalid] [get_bd_pins adc_fifo_0/m_axis_tvalid] [get_bd_pins ila_vita_adc_0/probe1]

	# ADC_DDR_SW_0
    connect_bd_intf_net -intf_net adc_ddr_sw_0_M00_AXIS [get_bd_intf_pins adc_ddr_sw_0/M00_AXIS] [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM]	
    connect_bd_intf_net -intf_net adc_ddr_sw_0_M01_AXIS [get_bd_intf_pins adc_ddr_sw_0/M01_AXIS] [get_bd_intf_pins srio_swrite_pack_0/S_AXIS]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins adc_ddr_sw_0/aclk]
	connect_bd_net -net sys_100m_resetn [get_bd_pins adc_ddr_sw_0/aresetn]

	# DAC
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
	connect_bd_intf_net -intf_net axis_dac_interconnect_0_M00_AXIS 	[get_bd_intf_pins axis2adi_0/S_AXIS] [get_bd_intf_pins axis_dac_interconnect_0/M00_AXIS]
#	connect_bd_intf_net -intf_net axi_dma_0_M_AXIS_MM2S 			[get_bd_intf_pins axi_dma_0/M_AXIS_MM2S] [get_bd_intf_pins axis_dac_interconnect_0/S00_AXIS]

	# VITA DAC
	connect_bd_intf_net -intf_net axis_32to64_dac_0_M_AXIS [get_bd_intf_pins axis_32to64_dac_0/M_AXIS] [get_bd_intf_pins axis_dac_interconnect_0/S00_AXIS]
	connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axis_32to64_dac_0/AXIS_ACLK]
	connect_bd_net -net sys_100m_resetn [get_bd_pins axis_32to64_dac_0/AXIS_ARESETN]	
	# connect_bd_net -net axis_32to64_dac_0_S_AXIS_TREADY [get_bd_pins axis_32to64_dac_0/S_AXIS_TREADY] [get_bd_pins ila_4/probe5] [get_bd_pins vita49_trig_dac_0/M_AXIS_TREADY]
  
	connect_bd_intf_net -intf_net vita49_trig_dac_0_M_AXIS [get_bd_intf_pins axis_32to64_dac_0/S_AXIS] [get_bd_intf_pins vita49_trig_dac_0/M_AXIS]
	connect_bd_net -net [get_bd_nets vita49_trig_dac_0_trig] [get_bd_pins axis_vita49_unpack_0/trig] [get_bd_pins vita49_trig_dac_0/trig]	
	connect_bd_net -net sys_fmc_dma_clk [get_bd_pins vita49_trig_dac_0/AXIS_ACLK]
	connect_bd_net -net sys_100m_resetn [get_bd_pins vita49_trig_dac_0/AXIS_ARESETN]	

    connect_bd_intf_net -intf_net vita_trig_dac_reg_0_M_AXIS [get_bd_intf_pins vita_trig_dac_reg_0/M_AXIS] [get_bd_intf_pins vita49_trig_dac_0/S_AXIS]	
    connect_bd_net -net sys_100m_resetn [get_bd_pins vita_trig_dac_reg_0/aresetn]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins vita_trig_dac_reg_0/aclk] 

    connect_bd_intf_net -intf_net axis_vita49_unpack_0_M_AXIS [get_bd_intf_pins vita_trig_dac_reg_0/S_AXIS] [get_bd_intf_pins axis_vita49_unpack_0/M_AXIS]	
	connect_bd_net [get_bd_pins axis_vita49_unpack_0/irq] [get_bd_pins sys_concat_intc/In5]
	connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axis_vita49_unpack_0/AXIS_ACLK]
	connect_bd_net -net sys_100m_resetn [get_bd_pins axis_vita49_unpack_0/AXIS_ARESETN]	
  
	connect_bd_intf_net -intf_net vita_unpack_dac_reg_0_M_AXIS [get_bd_intf_pins axis_vita49_unpack_0/S_AXIS] [get_bd_intf_pins vita_unpack_dac_reg_0/M_AXIS]
    connect_bd_net -net sys_100m_resetn [get_bd_pins vita_unpack_dac_reg_0/aresetn]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins vita_unpack_dac_reg_0/aclk] 

	connect_bd_intf_net -intf_net axis_64to32_dac_0_M_AXIS [get_bd_intf_pins axis_64to32_dac_0/M_AXIS] [get_bd_intf_pins vita_unpack_dac_reg_0/S_AXIS]
	connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axis_64to32_dac_0/AXIS_ACLK]
	connect_bd_net -net sys_100m_resetn [get_bd_pins axis_64to32_dac_0/AXIS_ARESETN]	
    connect_bd_intf_net -intf_net dac_ddr_sw_0_M00_AXIS1 [get_bd_intf_pins axis_64to32_dac_0/S_AXIS] [get_bd_intf_pins dac_ddr_sw_0/M00_AXIS]

 	connect_bd_net -net axi_dma_0_mm2s_introut [get_bd_pins axi_dma_0/mm2s_introut] [get_bd_pins sys_concat_intc/In0]
	connect_bd_net -net axi_dma_0_s2mm_introut [get_bd_pins axi_dma_0/s2mm_introut] [get_bd_pins sys_concat_intc/In1]

	# DAC_DDR_SW_0
    connect_bd_intf_net -intf_net axi_dma_0_M_AXIS_MM2S [get_bd_intf_pins axi_dma_0/M_AXIS_MM2S] [get_bd_intf_pins dac_ddr_sw_0/S00_AXIS]
    connect_bd_intf_net -intf_net dac_fifo_0_M_AXIS [get_bd_intf_pins dac_ddr_sw_0/S01_AXIS] [get_bd_intf_pins dac_fifo_0/M_AXIS]
    connect_bd_net -net sys_100m_resetn [get_bd_pins dac_ddr_sw_0/aresetn]
    connect_bd_net -net sys_fmc_dma_clk	[get_bd_pins dac_ddr_sw_0/aclk] 
    connect_bd_net -net sys_fmc_dma_clk  [get_bd_pins dac_fifo_0/s_axis_aclk]
	connect_bd_net -net sys_100m_resetn  [get_bd_pins dac_fifo_0/s_axis_aresetn]
	
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

	# ADC
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
 	#connect_bd_intf_net -intf_net axis_adc_interconnect_1_M00_AXIS [get_bd_intf_pins axi_dma_1/S_AXIS_S2MM] [get_bd_intf_pins axis_adc_interconnect_1/M00_AXIS]
 	connect_bd_intf_net -intf_net axis_adc_interconnect_1_M00_AXIS [get_bd_intf_pins axis_64to32_adc_1/S_AXIS] [get_bd_intf_pins axis_adc_interconnect_1/M00_AXIS]

	# VITA ADC
	connect_bd_intf_net -intf_net axis_64to32_adc_1_M_AXIS [get_bd_intf_pins axis_64to32_adc_1/M_AXIS] [get_bd_intf_pins vita49_trig_adc_1/S_AXIS]
	connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axis_64to32_adc_1/AXIS_ACLK]
	connect_bd_net -net sys_100m_resetn [get_bd_pins axis_64to32_adc_1/AXIS_ARESETN]
	# connect_bd_net -net axis_64to32_adc_1_M_AXIS_TDATA [get_bd_pins axis_64to32_adc_1/M_AXIS_TDATA] [get_bd_pins ila_adc_trig/probe0] [get_bd_pins vita49_trig_adc_1/S_AXIS_TDATA]
	# connect_bd_net -net axis_64to32_adc_1_M_AXIS_TLAST [get_bd_pins axis_64to32_adc_1/M_AXIS_TLAST] [get_bd_pins ila_adc_trig/probe1] [get_bd_pins vita49_trig_adc_1/S_AXIS_TLAST]
	# connect_bd_net -net axis_64to32_adc_1_M_AXIS_TVALID [get_bd_pins axis_64to32_adc_1/M_AXIS_TVALID] [get_bd_pins ila_adc_trig/probe2] [get_bd_pins vita49_trig_adc_1/S_AXIS_TVALID]

	connect_bd_intf_net -intf_net vita49_trig_adc_1_M_AXIS [get_bd_intf_pins axis_vita49_pack_1/S_AXIS] [get_bd_intf_pins vita49_trig_adc_1/M_AXIS]
	connect_bd_net -net vita49_trig_adc_1_trig [get_bd_pins adi2axis_1/trig] [get_bd_pins vita49_trig_adc_1/trig]
	connect_bd_net -net sys_fmc_dma_clk [get_bd_pins vita49_trig_adc_1/AXIS_ACLK]
	connect_bd_net -net sys_100m_resetn [get_bd_pins vita49_trig_adc_1/AXIS_ARESETN]
	connect_bd_net [get_bd_pins vita49_trig_adc_1/M_AXIS_TDATA] [get_bd_pins axis_vita49_pack_1/S_AXIS_TDATA]
	connect_bd_net [get_bd_pins vita49_trig_adc_1/M_AXIS_TLAST] [get_bd_pins axis_vita49_pack_1/S_AXIS_TLAST]
	connect_bd_net [get_bd_pins vita49_trig_adc_1/M_AXIS_TVALID] [get_bd_pins axis_vita49_pack_1/S_AXIS_TVALID]
	connect_bd_net [get_bd_pins vita49_trig_adc_1/M_AXIS_TREADY] [get_bd_pins axis_vita49_pack_1/S_AXIS_TREADY]

	connect_bd_intf_net -intf_net axis_vita49_pack_1_M_AXIS [get_bd_intf_pins axis_32to64_adc_1/S_AXIS] [get_bd_intf_pins axis_vita49_pack_1/M_AXIS]
	connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axis_vita49_pack_1/AXIS_ACLK]
	connect_bd_net -net sys_100m_resetn [get_bd_pins axis_vita49_pack_1/AXIS_ARESETN]
	connect_bd_net [get_bd_pins axis_vita49_pack_1/M_AXIS_TDATA] [get_bd_pins axis_32to64_adc_1/S_AXIS_TDATA]
	connect_bd_net [get_bd_pins axis_vita49_pack_1/M_AXIS_TLAST] [get_bd_pins axis_32to64_adc_1/S_AXIS_TLAST]
	connect_bd_net [get_bd_pins axis_vita49_pack_1/M_AXIS_TVALID] [get_bd_pins axis_32to64_adc_1/S_AXIS_TVALID]
	connect_bd_net [get_bd_pins axis_vita49_pack_1/M_AXIS_TREADY] [get_bd_pins axis_32to64_adc_1/S_AXIS_TREADY]

    connect_bd_intf_net -intf_net axis_32to64_adc_1_M_AXIS [get_bd_intf_pins adc_fifo_1/S_AXIS] [get_bd_intf_pins axis_32to64_adc_1/M_AXIS]
	connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axis_32to64_adc_1/AXIS_ACLK]
	connect_bd_net -net sys_100m_resetn [get_bd_pins axis_32to64_adc_1/AXIS_ARESETN]	

	# ADC FIFO_1
    connect_bd_intf_net -intf_net adc_fifo_1_M_AXIS [get_bd_intf_pins adc_ddr_sw_1/S00_AXIS] [get_bd_intf_pins adc_fifo_1/M_AXIS]	
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins adc_fifo_1/s_axis_aclk]
	connect_bd_net -net sys_100m_resetn [get_bd_pins adc_fifo_1/s_axis_aresetn]
    # connect_bd_net -net adc_ddr_sw_1_s_axis_tready [get_bd_pins adc_ddr_sw_1/s_axis_tready] [get_bd_pins adc_fifo_1/m_axis_tready] [get_bd_pins ila_vita_adc_1/probe2]
    # connect_bd_net -net adc_fifo_1_m_axis_tdata [get_bd_pins adc_ddr_sw_1/s_axis_tdata] [get_bd_pins adc_fifo_1/m_axis_tdata] [get_bd_pins ila_vita_adc_1/probe0]
    # connect_bd_net -net adc_fifo_1_m_axis_tlast [get_bd_pins adc_ddr_sw_1/s_axis_tlast] [get_bd_pins adc_fifo_1/m_axis_tlast] [get_bd_pins ila_vita_adc_1/probe3]
    # connect_bd_net -net adc_fifo_1_m_axis_tvalid [get_bd_pins adc_ddr_sw_1/s_axis_tvalid] [get_bd_pins adc_fifo_1/m_axis_tvalid] [get_bd_pins ila_vita_adc_1/probe1]

	# ADC_DDR_SW_1
    connect_bd_intf_net -intf_net adc_ddr_sw_1_M00_AXIS [get_bd_intf_pins adc_ddr_sw_1/M00_AXIS] [get_bd_intf_pins axi_dma_1/S_AXIS_S2MM]
    connect_bd_intf_net -intf_net adc_ddr_sw_1_M01_AXIS [get_bd_intf_pins adc_ddr_sw_1/M01_AXIS] [get_bd_intf_pins srio_swrite_pack_1/S_AXIS]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins adc_ddr_sw_1/aclk]
	connect_bd_net -net sys_100m_resetn [get_bd_pins adc_ddr_sw_1/aresetn]

	# DAC
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
	connect_bd_intf_net -intf_net axis_dac_interconnect_1_M00_AXIS 	[get_bd_intf_pins axis2adi_1/S_AXIS] [get_bd_intf_pins axis_dac_interconnect_1/M00_AXIS]
#	connect_bd_intf_net -intf_net axi_dma_1_M_AXIS_MM2S 			[get_bd_intf_pins axi_dma_1/M_AXIS_MM2S] [get_bd_intf_pins axis_dac_interconnect_1/S00_AXIS]

	# VITA DAC
	connect_bd_intf_net -intf_net axis_32to64_dac_1_M_AXIS [get_bd_intf_pins axis_32to64_dac_1/M_AXIS] [get_bd_intf_pins axis_dac_interconnect_1/S00_AXIS]
	connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axis_32to64_dac_1/AXIS_ACLK]
	connect_bd_net -net sys_100m_resetn [get_bd_pins axis_32to64_dac_1/AXIS_ARESETN]	
	# connect_bd_net -net axis_32to64_dac_1_S_AXIS_TREADY [get_bd_pins axis_32to64_dac_1/S_AXIS_TREADY] [get_bd_pins ila_4/probe5] [get_bd_pins vita49_trig_dac_1/M_AXIS_TREADY]
  
	connect_bd_intf_net -intf_net vita49_trig_dac_1_M_AXIS [get_bd_intf_pins axis_32to64_dac_1/S_AXIS] [get_bd_intf_pins vita49_trig_dac_1/M_AXIS]
	connect_bd_net -net [get_bd_nets vita49_trig_dac_1_trig] [get_bd_pins axis_vita49_unpack_1/trig] [get_bd_pins vita49_trig_dac_1/trig]
	connect_bd_net -net sys_fmc_dma_clk [get_bd_pins vita49_trig_dac_1/AXIS_ACLK]
	connect_bd_net -net sys_100m_resetn [get_bd_pins vita49_trig_dac_1/AXIS_ARESETN]	

    connect_bd_intf_net -intf_net vita_trig_dac_reg_1_M_AXIS [get_bd_intf_pins vita_trig_dac_reg_1/M_AXIS] [get_bd_intf_pins vita49_trig_dac_1/S_AXIS]	
    connect_bd_net -net sys_100m_resetn [get_bd_pins vita_trig_dac_reg_1/aresetn]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins vita_trig_dac_reg_1/aclk] 
	
    connect_bd_intf_net -intf_net axis_vita49_unpack_1_M_AXIS [get_bd_intf_pins vita_trig_dac_reg_1/S_AXIS] [get_bd_intf_pins axis_vita49_unpack_1/M_AXIS]
	connect_bd_net [get_bd_pins axis_vita49_unpack_1/irq] [get_bd_pins sys_concat_intc/In6]
	connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axis_vita49_unpack_1/AXIS_ACLK]
	connect_bd_net -net sys_100m_resetn [get_bd_pins axis_vita49_unpack_1/AXIS_ARESETN]	
 
	connect_bd_intf_net -intf_net vita_unpack_dac_reg_1_M_AXIS [get_bd_intf_pins axis_vita49_unpack_1/S_AXIS] [get_bd_intf_pins vita_unpack_dac_reg_1/M_AXIS]
    connect_bd_net -net sys_100m_resetn [get_bd_pins vita_unpack_dac_reg_1/aresetn]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins vita_unpack_dac_reg_1/aclk] 
	
	connect_bd_intf_net -intf_net axis_64to32_dac_1_M_AXIS [get_bd_intf_pins axis_64to32_dac_1/M_AXIS] [get_bd_intf_pins vita_unpack_dac_reg_1/S_AXIS] 
	connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axis_64to32_dac_1/AXIS_ACLK]
	connect_bd_net -net sys_100m_resetn [get_bd_pins axis_64to32_dac_1/AXIS_ARESETN]	
    connect_bd_intf_net -intf_net dac_ddr_sw_1_M00_AXIS [get_bd_intf_pins axis_64to32_dac_1/S_AXIS] [get_bd_intf_pins dac_ddr_sw_1/M00_AXIS]

	connect_bd_net -net axi_dma_1_mm2s_introut [get_bd_pins axi_dma_1/mm2s_introut] [get_bd_pins sys_concat_intc/In2]
	connect_bd_net -net axi_dma_1_s2mm_introut [get_bd_pins axi_dma_1/s2mm_introut] [get_bd_pins sys_concat_intc/In3]

	# DAC_DDR_SW_1
    connect_bd_intf_net -intf_net axi_dma_1_M_AXIS_MM2S [get_bd_intf_pins axi_dma_1/M_AXIS_MM2S] [get_bd_intf_pins dac_ddr_sw_1/S00_AXIS]
    connect_bd_intf_net -intf_net dac_fifo_1_M_AXIS [get_bd_intf_pins dac_ddr_sw_1/S01_AXIS] [get_bd_intf_pins dac_fifo_1/M_AXIS]
    connect_bd_net -net sys_100m_resetn [get_bd_pins dac_ddr_sw_1/aresetn]
    connect_bd_net -net sys_fmc_dma_clk	[get_bd_pins dac_ddr_sw_1/aclk] 
    connect_bd_net -net sys_fmc_dma_clk  [get_bd_pins dac_fifo_1/s_axis_aclk]
	connect_bd_net -net sys_100m_resetn  [get_bd_pins dac_fifo_1/s_axis_aresetn]

	
	# SRIO_GEN2
    connect_bd_net -net srio_gen2_0_srio_txn0 [get_bd_ports srio_txn0] [get_bd_pins srio_gen2_0/srio_txn0]
    connect_bd_net -net srio_gen2_0_srio_txn1 [get_bd_ports srio_txn1] [get_bd_pins srio_gen2_0/srio_txn1]
    connect_bd_net -net srio_gen2_0_srio_txn2 [get_bd_ports srio_txn2] [get_bd_pins srio_gen2_0/srio_txn2]
    connect_bd_net -net srio_gen2_0_srio_txn3 [get_bd_ports srio_txn3] [get_bd_pins srio_gen2_0/srio_txn3]
    connect_bd_net -net srio_gen2_0_srio_txp0 [get_bd_ports srio_txp0] [get_bd_pins srio_gen2_0/srio_txp0]
    connect_bd_net -net srio_gen2_0_srio_txp1 [get_bd_ports srio_txp1] [get_bd_pins srio_gen2_0/srio_txp1]
    connect_bd_net -net srio_gen2_0_srio_txp2 [get_bd_ports srio_txp2] [get_bd_pins srio_gen2_0/srio_txp2]
    connect_bd_net -net srio_gen2_0_srio_txp3 [get_bd_ports srio_txp3] [get_bd_pins srio_gen2_0/srio_txp3]
    connect_bd_net -net srio_rxn0_1 [get_bd_ports srio_rxn0] [get_bd_pins srio_gen2_0/srio_rxn0]
    connect_bd_net -net srio_rxn1_1 [get_bd_ports srio_rxn1] [get_bd_pins srio_gen2_0/srio_rxn1]
    connect_bd_net -net srio_rxn2_1 [get_bd_ports srio_rxn2] [get_bd_pins srio_gen2_0/srio_rxn2]
    connect_bd_net -net srio_rxn3_1 [get_bd_ports srio_rxn3] [get_bd_pins srio_gen2_0/srio_rxn3]
    connect_bd_net -net srio_rxp0_1 [get_bd_ports srio_rxp0] [get_bd_pins srio_gen2_0/srio_rxp0]
    connect_bd_net -net srio_rxp1_1 [get_bd_ports srio_rxp1] [get_bd_pins srio_gen2_0/srio_rxp1]
    connect_bd_net -net srio_rxp2_1 [get_bd_ports srio_rxp2] [get_bd_pins srio_gen2_0/srio_rxp2]
    connect_bd_net -net srio_rxp3_1 [get_bd_ports srio_rxp3] [get_bd_pins srio_gen2_0/srio_rxp3]
    connect_bd_net -net srio_sys_clkn_1 [get_bd_ports srio_sys_clkn] [get_bd_pins srio_gen2_0/sys_clkn]
    connect_bd_net -net srio_sys_clkp_1 [get_bd_ports srio_sys_clkp] [get_bd_pins srio_gen2_0/sys_clkp]
  
	connect_bd_net -net srio_gen2_0_clk_lock_out [get_bd_pins srio_gen2_0/clk_lock_out] [get_bd_pins sys_reg_0/srio_clk_out_lock]
    connect_bd_net -net srio_gen2_0_link_initialized [get_bd_pins srio_gen2_0/link_initialized] [get_bd_pins sys_reg_0/srio_link_initialized]
    connect_bd_net -net srio_gen2_0_mode_1x [get_bd_pins srio_gen2_0/mode_1x] [get_bd_pins sys_reg_0/srio_mode_1x]
    connect_bd_net -net srio_gen2_0_port_initialized [get_bd_pins srio_gen2_0/port_initialized] [get_bd_pins sys_reg_0/srio_port_initialized]
    connect_bd_net -net gt_loopback_in_1 [get_bd_pins const_loopback/dout] [get_bd_pins srio_gen2_0/gt_loopback_in]
	
	#SRIO AXI-4 INTERCONNECT
	connect_bd_intf_net -intf_net axi_srio_interconnect_M00_AXI [get_bd_intf_pins axi_srio_interconnect/M00_AXI] [get_bd_intf_pins axi_srio_initiator_fifo/S_AXI]
    connect_bd_intf_net -intf_net axi_srio_interconnect_M01_AXI [get_bd_intf_pins axi_srio_interconnect/M01_AXI] [get_bd_intf_pins axi_srio_initiator_fifo/S_AXI_FULL]
    connect_bd_intf_net -intf_net axi_srio_interconnect_M02_AXI [get_bd_intf_pins axi_srio_interconnect/M02_AXI] [get_bd_intf_pins axi_srio_target_fifo/S_AXI]
    connect_bd_intf_net -intf_net axi_srio_interconnect_M03_AXI [get_bd_intf_pins axi_srio_interconnect/M03_AXI] [get_bd_intf_pins axi_srio_target_fifo/S_AXI_FULL]
    connect_bd_intf_net -intf_net axi_srio_interconnect_M04_AXI [get_bd_intf_pins axi_srio_interconnect/M04_AXI] [get_bd_intf_pins srio_gen2_0/MAINT_IF]
    connect_bd_net -net [get_bd_nets sys_100m_resetn] [get_bd_pins axi_srio_interconnect/ARESETN]
	connect_bd_net -net [get_bd_nets sys_100m_resetn] [get_bd_pins axi_srio_interconnect/M00_ARESETN] 
	connect_bd_net -net [get_bd_nets sys_100m_resetn] [get_bd_pins axi_srio_interconnect/M01_ARESETN] 
	connect_bd_net -net [get_bd_nets sys_100m_resetn] [get_bd_pins axi_srio_interconnect/M02_ARESETN] 
	connect_bd_net -net [get_bd_nets sys_100m_resetn] [get_bd_pins axi_srio_interconnect/M03_ARESETN] 
	connect_bd_net -net [get_bd_nets sys_100m_resetn] [get_bd_pins axi_srio_interconnect/M04_ARESETN] 
	connect_bd_net -net [get_bd_nets sys_100m_resetn] [get_bd_pins axi_srio_interconnect/S00_ARESETN]

	connect_bd_net -net [get_bd_nets sys_100m_clk] [get_bd_pins sys_ps7/M_AXI_GP1_ACLK]
    connect_bd_net -net [get_bd_nets sys_100m_clk] 	[get_bd_pins axi_srio_interconnect/S00_ACLK] 
    connect_bd_net -net [get_bd_nets sys_100m_clk] 	[get_bd_pins axi_srio_interconnect/ACLK] 
    connect_bd_intf_net -intf_net sys_ps7_M_AXI_GP1 [get_bd_intf_pins axi_srio_interconnect/S00_AXI] [get_bd_intf_pins sys_ps7/M_AXI_GP1]
    connect_bd_net -net [get_bd_nets sys_fmc_dma_clk] [get_bd_pins axi_srio_interconnect/M00_ACLK] 
	connect_bd_net -net [get_bd_nets sys_fmc_dma_clk] [get_bd_pins axi_srio_interconnect/M01_ACLK] 
	connect_bd_net -net [get_bd_nets sys_fmc_dma_clk] [get_bd_pins axi_srio_interconnect/M02_ACLK] 
	connect_bd_net -net [get_bd_nets sys_fmc_dma_clk] [get_bd_pins axi_srio_interconnect/M03_ACLK]
	create_bd_net srio_gen2_0_log_clk_out
    connect_bd_net -net [get_bd_nets srio_gen2_0_log_clk_out] [get_bd_pins axi_srio_interconnect/M04_ACLK] 
  
	# SRIO AXI-S INTERCONNECT
	connect_bd_intf_net -intf_net srio_gen2_0_INITIATOR_RESP [get_bd_intf_pins srio_gen2_0/INITIATOR_RESP] [get_bd_intf_pins srio_iresp_intc/S00_AXIS]
	connect_bd_intf_net -intf_net srio_gen2_0_TARGET_REQ [get_bd_intf_pins srio_gen2_0/TARGET_REQ] [get_bd_intf_pins srio_treq_intc/S00_AXIS]	
	connect_bd_intf_net -intf_net srio_ireq_intc_M00_AXIS [get_bd_intf_pins srio_gen2_0/INITIATOR_REQ] [get_bd_intf_pins srio_ireq_intc/M00_AXIS]
	connect_bd_intf_net -intf_net srio_tresp_intc_M00_AXIS [get_bd_intf_pins srio_gen2_0/TARGET_RESP] [get_bd_intf_pins srio_tresp_intc/M00_AXIS]
    connect_bd_net -net srio_gen2_0_log_clk_out [get_bd_pins srio_gen2_0/log_clk_out] [get_bd_pins srio_ireq_intc/M00_AXIS_ACLK] [get_bd_pins srio_iresp_intc/S00_AXIS_ACLK] [get_bd_pins srio_treq_intc/S00_AXIS_ACLK] [get_bd_pins srio_tresp_intc/M00_AXIS_ACLK]
    connect_bd_net -net [get_bd_nets sys_100m_resetn] [get_bd_pins srio_tresp_intc/ARESETN] [get_bd_pins srio_tresp_intc/M00_AXIS_ARESETN] [get_bd_pins srio_tresp_intc/S00_AXIS_ARESETN]	
    connect_bd_net -net [get_bd_nets sys_100m_resetn] [get_bd_pins srio_treq_intc/ARESETN] [get_bd_pins srio_treq_intc/M00_AXIS_ARESETN] [get_bd_pins srio_treq_intc/S00_AXIS_ARESETN]
    connect_bd_net -net [get_bd_nets sys_100m_resetn] [get_bd_pins srio_iresp_intc/ARESETN] [get_bd_pins srio_iresp_intc/M00_AXIS_ARESETN] [get_bd_pins srio_iresp_intc/S00_AXIS_ARESETN]
    connect_bd_net -net [get_bd_nets sys_100m_resetn] [get_bd_pins srio_ireq_intc/ARESETN] [get_bd_pins srio_ireq_intc/M00_AXIS_ARESETN] [get_bd_pins srio_ireq_intc/S00_AXIS_ARESETN] 
    connect_bd_net -net [get_bd_nets sys_fmc_dma_clk] [get_bd_pins srio_treq_intc/ACLK] [get_bd_pins srio_treq_intc/M00_AXIS_ACLK] [get_bd_pins srio_tresp_intc/ACLK] [get_bd_pins srio_tresp_intc/S00_AXIS_ACLK] 
    connect_bd_net -net [get_bd_nets sys_fmc_dma_clk] [get_bd_pins srio_ireq_intc/ACLK] [get_bd_pins srio_ireq_intc/S00_AXIS_ACLK] [get_bd_pins srio_iresp_intc/ACLK] [get_bd_pins srio_iresp_intc/M00_AXIS_ACLK] 
	
	# SRIO AXIS FIFO
	# initiator
	connect_bd_intf_net -intf_net axi_srio_initiator_fifo_AXI_STR_TXD [get_bd_intf_pins axi_srio_initiator_fifo/AXI_STR_TXD] [get_bd_intf_pins axis_32to64_srio_init/S_AXIS]
    connect_bd_intf_net -intf_net axis_32to64_strb_0_M_AXIS [get_bd_intf_pins axis_32to64_srio_init/M_AXIS] [get_bd_intf_pins srio_ireq_sw/S00_AXIS]
    connect_bd_intf_net -intf_net axis_64to32_strb_0_M_AXIS [get_bd_intf_pins axi_srio_initiator_fifo/AXI_STR_RXD] [get_bd_intf_pins axis_64to32_srio_init/M_AXIS]
	connect_bd_intf_net -intf_net srio_iresp_intc_M00_AXIS [get_bd_intf_pins axis_64to32_srio_init/S_AXIS] [get_bd_intf_pins srio_iresp_intc/M00_AXIS]
    connect_bd_net -net axis_64to32_strb_0_SRCDEST [get_bd_pins axis_64to32_srio_init/SRCDEST] [get_bd_pins sys_reg_0/srio_srcdest_iresp]
    connect_bd_net -net axi_srio_initiator_fifo_interrupt [get_bd_pins axi_srio_initiator_fifo/interrupt] [get_bd_pins sys_concat_intc/In7]
    #target
    connect_bd_intf_net -intf_net axi_srio_target_fifo_AXI_STR_TXD [get_bd_intf_pins axi_srio_target_fifo/AXI_STR_TXD] [get_bd_intf_pins axis_32to64_srio_target/S_AXIS]
    connect_bd_intf_net -intf_net axis_64to32_strb_0_M_AXIS1 [get_bd_intf_pins axi_srio_target_fifo/AXI_STR_RXD] [get_bd_intf_pins axis_64to32_srio_target/M_AXIS]
    connect_bd_net -net const_1_dout [get_bd_pins axis_64to32_srio_target/S_AXIS_TSTRB] [get_bd_pins const_1/dout]
    connect_bd_intf_net -intf_net axis_32to64_strb_0_M_AXIS1 [get_bd_intf_pins axis_32to64_srio_target/M_AXIS] [get_bd_intf_pins srio_tresp_intc/S00_AXIS]
    connect_bd_intf_net -intf_net srio_target_reg_M_AXIS [get_bd_intf_pins axis_64to32_srio_target/S_AXIS] [get_bd_intf_pins srio_target_reg/M_AXIS]
    connect_bd_net -net axis_64to32_strb_0_SRCDEST1 [get_bd_pins axis_64to32_srio_target/SRCDEST] [get_bd_pins sys_reg_0/srio_srcdest_treq]
	connect_bd_net -net axi_srio_target_fifo_interrupt [get_bd_pins axi_srio_target_fifo/interrupt] [get_bd_pins sys_concat_intc/In8]
    connect_bd_net -net sys_100m_resetn  [get_bd_pins axi_srio_initiator_fifo/s_axi_aresetn] [get_bd_pins axi_srio_target_fifo/s_axi_aresetn] [get_bd_pins axis_32to64_srio_init/AXIS_ARESETN] [get_bd_pins axis_32to64_srio_target/AXIS_ARESETN] [get_bd_pins axis_64to32_srio_init/AXIS_ARESETN] [get_bd_pins axis_64to32_srio_target/AXIS_ARESETN] [get_bd_pins srio_target_reg/aresetn] 
    connect_bd_net -net sys_fmc_dma_clk   [get_bd_pins axi_srio_initiator_fifo/s_axi_aclk] [get_bd_pins axi_srio_target_fifo/s_axi_aclk] [get_bd_pins axis_32to64_srio_init/AXIS_ACLK] [get_bd_pins axis_32to64_srio_target/AXIS_ACLK] [get_bd_pins axis_64to32_srio_init/AXIS_ACLK] [get_bd_pins axis_64to32_srio_target/AXIS_ACLK] [get_bd_pins srio_target_reg/aclk] 

	#SRIO SWITCH IREQ
	#SWRITE PACK 0
    connect_bd_intf_net -intf_net srio_swrite_pack_0_M_AXIS [get_bd_intf_pins srio_ireq_sw/S01_AXIS] [get_bd_intf_pins srio_swrite_pack_0/M_AXIS]	
    connect_bd_net -net sys_100m_clk  [get_bd_pins srio_swrite_pack_0/S_AXI_ACLK] 	
    connect_bd_net -net sys_100m_resetn [get_bd_pins srio_swrite_pack_0/AXIS_ARESETN]  [get_bd_pins srio_swrite_pack_0/S_AXI_ARESETN]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins srio_swrite_pack_0/AXIS_ACLK]  
	#SWRITE PACK 1
    connect_bd_intf_net -intf_net srio_swrite_pack_1_M_AXIS [get_bd_intf_pins srio_ireq_sw/S02_AXIS] [get_bd_intf_pins srio_swrite_pack_1/M_AXIS]	
    connect_bd_net -net sys_100m_clk  [get_bd_pins srio_swrite_pack_1/S_AXI_ACLK] 	
    connect_bd_net -net sys_100m_resetn [get_bd_pins srio_swrite_pack_1/AXIS_ARESETN]  [get_bd_pins srio_swrite_pack_1/S_AXI_ARESETN]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins srio_swrite_pack_1/AXIS_ACLK]  
	#SRIO IREQ SWITCH	
    connect_bd_intf_net -intf_net srio_ireq_sw_M00_AXIS [get_bd_intf_pins srio_ireq_intc/S00_AXIS] [get_bd_intf_pins srio_ireq_sw/M00_AXIS]	
    connect_bd_net -net sys_100m_resetn  [get_bd_pins srio_ireq_sw/aresetn]
    connect_bd_net -net sys_fmc_dma_clk   [get_bd_pins srio_ireq_sw/aclk] 
  
	#SRIO SWITCH TREQ
	#HELLO ROUTER
    connect_bd_intf_net -intf_net srio_treq_intc_M00_AXIS [get_bd_intf_pins hello_router_0/S_AXIS] [get_bd_intf_pins srio_treq_intc/M00_AXIS]
	connect_bd_intf_net -intf_net hello_router_1_M_AXIS [get_bd_intf_pins hello_router_0/M_AXIS] [get_bd_intf_pins srio_treq_sw/S00_AXIS]
    connect_bd_net -net sys_100m_resetn  [get_bd_pins hello_router_0/AXIS_ARESETN]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins hello_router_0/AXIS_ACLK]
	#SRIO TREQ SWITCH
    connect_bd_intf_net -intf_net srio_treq_sw_M00_AXIS [get_bd_intf_pins srio_target_reg/S_AXIS] [get_bd_intf_pins srio_treq_sw/M00_AXIS]
    connect_bd_intf_net -intf_net srio_treq_sw_M01_AXIS [get_bd_intf_pins srio_swrite_unpack_0/S_AXIS] [get_bd_intf_pins srio_treq_sw/M01_AXIS]	
    connect_bd_net -net sys_100m_resetn  [get_bd_pins srio_treq_sw/aresetn]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins srio_treq_sw/aclk]
    #SWRITE UNPACK
    connect_bd_intf_net -intf_net srio_swrite_unpack_0_M_AXIS [get_bd_intf_pins srio_swrite_unpack_0/M_AXIS] [get_bd_intf_pins vita_dac_sw/S00_AXIS]	
    connect_bd_net -net sys_100m_clk   [get_bd_pins srio_swrite_unpack_0/S_AXI_ACLK] 
    connect_bd_net -net sys_100m_resetn  [get_bd_pins srio_swrite_unpack_0/S_AXI_ARESETN]
    connect_bd_net -net sys_100m_resetn  [get_bd_pins srio_swrite_unpack_0/AXIS_ARESETN] 
    connect_bd_net -net sys_fmc_dma_clk   [get_bd_pins srio_swrite_unpack_0/AXIS_ACLK]
    #VITA DAC SWITCH
    connect_bd_intf_net -intf_net vita_dac_sw_M00_AXIS [get_bd_intf_pins vita49_assem_0/S_AXIS] [get_bd_intf_pins vita_dac_sw/M00_AXIS]
    connect_bd_intf_net -intf_net vita_dac_sw_M01_AXIS [get_bd_intf_pins vita49_assem_1/S_AXIS] [get_bd_intf_pins vita_dac_sw/M01_AXIS]
    connect_bd_net -net sys_100m_resetn [get_bd_pins vita_dac_sw/aresetn]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins vita_dac_sw/aclk]
    #VITA ASSEM
	connect_bd_intf_net -intf_net vita49_assem_0_M_AXIS [get_bd_intf_pins dac_fifo_0/S_AXIS] [get_bd_intf_pins vita49_assem_0/M_AXIS]
    connect_bd_intf_net -intf_net vita49_assem_1_M_AXIS [get_bd_intf_pins dac_fifo_1/S_AXIS] [get_bd_intf_pins vita49_assem_1/M_AXIS]
    connect_bd_net -net sys_100m_clk [get_bd_pins vita49_assem_0/S_AXI_ACLK] [get_bd_pins vita49_assem_1/S_AXI_ACLK]	
    connect_bd_net -net sys_100m_resetn [get_bd_pins vita49_assem_0/AXIS_ARESETN] [get_bd_pins vita49_assem_0/S_AXI_ARESETN] [get_bd_pins vita49_assem_1/AXIS_ARESETN] [get_bd_pins vita49_assem_1/S_AXI_ARESETN]
    connect_bd_net -net sys_fmc_dma_clk [get_bd_pins vita49_assem_0/AXIS_ACLK] [get_bd_pins vita49_assem_1/AXIS_ACLK] 
 
 
    # interconnect (cpu)	
	connect_bd_intf_net -intf_net axi_cpu_interconnect_M01_AXI [get_bd_intf_pins axi_cpu_interconnect/M01_AXI] [get_bd_intf_pins vita49_clk/S_AXI]
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M01_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M01_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins vita49_clk/S_AXI_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins vita49_clk/S_AXI_ARESETN] $sys_100m_resetn_source
  
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m02_axi [get_bd_intf_pins axi_cpu_interconnect/M02_AXI] [get_bd_intf_pins axi_ad9361_0/s_axi]
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m03_axi [get_bd_intf_pins axi_cpu_interconnect/M03_AXI] [get_bd_intf_pins adi2axis_0/S_AXI] 
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m04_axi [get_bd_intf_pins axi_cpu_interconnect/M04_AXI] [get_bd_intf_pins axi_dma_0/S_AXI_LITE]
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M02_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M03_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M04_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_ad9361_0/s_axi_aclk] 
    connect_bd_net -net sys_100m_clk    [get_bd_pins adi2axis_0/S_AXI_ACLK] 
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_dma_0/s_axi_lite_aclk] 
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M02_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M03_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M04_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn	[get_bd_pins axi_ad9361_0/s_axi_aresetn] 
    connect_bd_net -net sys_100m_resetn	[get_bd_pins adi2axis_0/AXIS_ARESETN] 
    connect_bd_net -net sys_100m_resetn	[get_bd_pins adi2axis_0/S_AXI_ARESETN] 
    connect_bd_net -net sys_100m_resetn	[get_bd_pins axi_dma_0/axi_resetn] 

    connect_bd_intf_net -intf_net axi_cpu_interconnect_m05_axi [get_bd_intf_pins axi_cpu_interconnect/M05_AXI] [get_bd_intf_pins axis_vita49_unpack_0/S_AXI]
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m06_axi [get_bd_intf_pins axi_cpu_interconnect/M06_AXI] [get_bd_intf_pins vita49_trig_dac_0/S_AXI] 
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m07_axi [get_bd_intf_pins axi_cpu_interconnect/M07_AXI] [get_bd_intf_pins axis_vita49_pack_0/S_AXI]
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m08_axi [get_bd_intf_pins axi_cpu_interconnect/M08_AXI] [get_bd_intf_pins vita49_trig_adc_0/S_AXI]
    connect_bd_net -net sys_100m_clk    [get_bd_pins axis_vita49_unpack_0/S_AXI_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins vita49_trig_dac_0/S_AXI_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axis_vita49_pack_0/S_AXI_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins vita49_trig_adc_0/S_AXI_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axis_vita49_unpack_0/S_AXI_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins vita49_trig_dac_0/S_AXI_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axis_vita49_pack_0/S_AXI_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins vita49_trig_adc_0/S_AXI_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M05_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M06_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M07_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M08_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M05_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M06_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M07_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M08_ARESETN] $sys_100m_resetn_source
	
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m09_axi [get_bd_intf_pins axi_cpu_interconnect/M09_AXI] [get_bd_intf_pins axi_ad9361_1/s_axi]
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m10_axi [get_bd_intf_pins axi_cpu_interconnect/M10_AXI] [get_bd_intf_pins adi2axis_1/S_AXI] 
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m11_axi [get_bd_intf_pins axi_cpu_interconnect/M11_AXI] [get_bd_intf_pins axi_dma_1/S_AXI_LITE]
    connect_bd_net -net sys_100m_clk 	[get_bd_pins axi_cpu_interconnect/M09_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk 	[get_bd_pins axi_cpu_interconnect/M10_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk 	[get_bd_pins axi_cpu_interconnect/M11_ACLK] $sys_100m_clk_source
	connect_bd_net -net sys_100m_clk 	[get_bd_pins axi_ad9361_1/s_axi_aclk] 
    connect_bd_net -net sys_100m_clk 	[get_bd_pins adi2axis_1/S_AXI_ACLK] 
    connect_bd_net -net sys_100m_clk 	[get_bd_pins axi_dma_1/s_axi_lite_aclk] 
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M09_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M10_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M11_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_1/s_axi_aresetn] 
    connect_bd_net -net sys_100m_resetn [get_bd_pins adi2axis_1/AXIS_ARESETN] 
    connect_bd_net -net sys_100m_resetn [get_bd_pins adi2axis_1/S_AXI_ARESETN] 
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_dma_1/axi_resetn] 

    connect_bd_intf_net -intf_net axi_cpu_interconnect_m12_axi [get_bd_intf_pins axi_cpu_interconnect/M12_AXI] [get_bd_intf_pins axis_vita49_unpack_1/S_AXI]
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m13_axi [get_bd_intf_pins axi_cpu_interconnect/M13_AXI] [get_bd_intf_pins vita49_trig_dac_1/S_AXI] 
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m14_axi [get_bd_intf_pins axi_cpu_interconnect/M14_AXI] [get_bd_intf_pins axis_vita49_pack_1/S_AXI]
    connect_bd_intf_net -intf_net axi_cpu_interconnect_m15_axi [get_bd_intf_pins axi_cpu_interconnect/M15_AXI] [get_bd_intf_pins vita49_trig_adc_1/S_AXI]
    connect_bd_net -net sys_100m_clk    [get_bd_pins axis_vita49_unpack_1/S_AXI_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins vita49_trig_dac_1/S_AXI_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axis_vita49_pack_1/S_AXI_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins vita49_trig_adc_1/S_AXI_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axis_vita49_unpack_1/S_AXI_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins vita49_trig_dac_1/S_AXI_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axis_vita49_pack_1/S_AXI_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins vita49_trig_adc_1/S_AXI_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M12_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M13_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M14_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M15_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M12_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M13_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M14_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M15_ARESETN] $sys_100m_resetn_source

  connect_bd_intf_net -intf_net axi_cpu_interconnect_M16_AXI [get_bd_intf_pins axi_cpu_interconnect/M16_AXI] [get_bd_intf_pins srio_swrite_pack_0/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M17_AXI [get_bd_intf_pins axi_cpu_interconnect/M17_AXI] [get_bd_intf_pins srio_swrite_pack_1/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M18_AXI [get_bd_intf_pins axi_cpu_interconnect/M18_AXI] [get_bd_intf_pins srio_swrite_unpack_0/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M19_AXI [get_bd_intf_pins axi_cpu_interconnect/M19_AXI] [get_bd_intf_pins vita49_assem_0/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M20_AXI [get_bd_intf_pins axi_cpu_interconnect/M20_AXI] [get_bd_intf_pins vita49_assem_1/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M21_AXI [get_bd_intf_pins axi_cpu_interconnect/M21_AXI] [get_bd_intf_pins sys_reg_0/S_AXI]
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M16_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M17_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M18_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M19_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M20_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_clk    [get_bd_pins axi_cpu_interconnect/M21_ACLK] $sys_100m_clk_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M16_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M17_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M18_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M19_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M20_ARESETN] $sys_100m_resetn_source
    connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M21_ARESETN] $sys_100m_resetn_source
  
	
	# DMA interconnect scatter gather
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

    # DMA interconnect (mem/dac(0))
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

    # DMA interconnect (mem/dac(1))
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

	
validate_bd_design
	##############
	# DEBUG (ILA)

	create_bd_cell -type ip -vlnv xilinx.com:ip:ila:4.0 ila_0
	set_property -dict [list CONFIG.C_PROBE4_WIDTH {32} CONFIG.C_PROBE0_WIDTH {32} CONFIG.C_NUM_OF_PROBES {9} CONFIG.C_EN_STRG_QUAL {1} CONFIG.C_INPUT_PIPE_STAGES {2}  CONFIG.C_MONITOR_TYPE {Native}] [get_bd_cells ila_0]

	connect_bd_net -net vita_trig_dac_reg_0_s_axis_tready [get_bd_pins axis_vita49_unpack_0/M_AXIS_TREADY] [get_bd_pins vita_trig_dac_reg_0/s_axis_tready]
	connect_bd_net -net axis_vita49_unpack_0_M_AXIS_TDATA [get_bd_pins axis_vita49_unpack_0/M_AXIS_TDATA] [get_bd_pins vita_trig_dac_reg_0/s_axis_tdata]
	connect_bd_net -net axis_vita49_unpack_0_M_AXIS_TLAST [get_bd_pins axis_vita49_unpack_0/M_AXIS_TLAST] [get_bd_pins vita_trig_dac_reg_0/s_axis_tlast]
	connect_bd_net -net axis_vita49_unpack_0_M_AXIS_TVALID [get_bd_pins axis_vita49_unpack_0/M_AXIS_TVALID] [get_bd_pins vita_trig_dac_reg_0/s_axis_tvalid]
	connect_bd_net -net vita_unpack_dac_reg_0_m_axis_tdata [get_bd_pins axis_vita49_unpack_0/S_AXIS_TDATA] [get_bd_pins vita_unpack_dac_reg_0/m_axis_tdata]
	connect_bd_net -net vita_unpack_dac_reg_0_m_axis_tlast [get_bd_pins axis_vita49_unpack_0/S_AXIS_TLAST] [get_bd_pins vita_unpack_dac_reg_0/m_axis_tlast]
	connect_bd_net -net vita_unpack_dac_reg_0_m_axis_tvalid [get_bd_pins axis_vita49_unpack_0/S_AXIS_TVALID] [get_bd_pins vita_unpack_dac_reg_0/m_axis_tvalid]
	connect_bd_net -net axis_vita49_unpack_0_S_AXIS_TREADY [get_bd_pins axis_vita49_unpack_0/S_AXIS_TREADY] [get_bd_pins vita_unpack_dac_reg_0/m_axis_tready]
	connect_bd_net -net [get_bd_nets sys_fmc_dma_clk] [get_bd_pins ila_0/clk] [get_bd_pins sys_ps7/FCLK_CLK2]
	connect_bd_net -net [get_bd_nets vita_unpack_dac_reg_0_m_axis_tdata] [get_bd_pins ila_0/probe0] [get_bd_pins vita_unpack_dac_reg_0/m_axis_tdata]
	connect_bd_net -net [get_bd_nets vita_unpack_dac_reg_0_m_axis_tlast] [get_bd_pins ila_0/probe1] [get_bd_pins vita_unpack_dac_reg_0/m_axis_tlast]
	connect_bd_net -net [get_bd_nets vita_unpack_dac_reg_0_m_axis_tvalid] [get_bd_pins ila_0/probe2] [get_bd_pins vita_unpack_dac_reg_0/m_axis_tvalid]
	connect_bd_net -net [get_bd_nets axis_vita49_unpack_0_S_AXIS_TREADY] [get_bd_pins ila_0/probe3] [get_bd_pins axis_vita49_unpack_0/S_AXIS_TREADY]
	connect_bd_net -net [get_bd_nets axis_vita49_unpack_0_M_AXIS_TDATA] [get_bd_pins ila_0/probe4] [get_bd_pins axis_vita49_unpack_0/M_AXIS_TDATA]
	connect_bd_net -net [get_bd_nets axis_vita49_unpack_0_M_AXIS_TLAST] [get_bd_pins ila_0/probe5] [get_bd_pins axis_vita49_unpack_0/M_AXIS_TLAST]
	connect_bd_net -net [get_bd_nets axis_vita49_unpack_0_M_AXIS_TVALID] [get_bd_pins ila_0/probe6] [get_bd_pins axis_vita49_unpack_0/M_AXIS_TVALID]
	connect_bd_net -net [get_bd_nets vita_trig_dac_reg_0_s_axis_tready] [get_bd_pins ila_0/probe7] [get_bd_pins vita_trig_dac_reg_0/s_axis_tready]
	connect_bd_net -net [get_bd_nets vita49_trig_dac_0_trig] [get_bd_pins ila_0/probe8] [get_bd_pins vita49_trig_dac_0/trig]

	
	# create_bd_cell -type ip -vlnv xilinx.com:ip:ila:4.0 ila_1
	# set_property -dict [list CONFIG.C_PROBE4_WIDTH {32} CONFIG.C_PROBE0_WIDTH {32} CONFIG.C_NUM_OF_PROBES {9} CONFIG.C_EN_STRG_QUAL {1} CONFIG.C_MONITOR_TYPE {Native}] [get_bd_cells ila_1]
	# set_property -dict [list CONFIG.C_INPUT_PIPE_STAGES {2}] [get_bd_cells ila_1]

	# connect_bd_net -net [get_bd_nets sys_fmc_dma_clk] [get_bd_pins ila_1/clk] [get_bd_pins sys_ps7/FCLK_CLK2]
	# connect_bd_net -net [get_bd_nets vita49_trig_adc_0_M_AXIS_TDATA] [get_bd_pins ila_1/probe0] [get_bd_pins vita49_trig_adc_0/M_AXIS_TDATA]
	# connect_bd_net -net [get_bd_nets vita49_trig_adc_0_M_AXIS_TLAST] [get_bd_pins ila_1/probe1] [get_bd_pins vita49_trig_adc_0/M_AXIS_TLAST]
	# connect_bd_net -net [get_bd_nets vita49_trig_adc_0_M_AXIS_TVALID] [get_bd_pins ila_1/probe2] [get_bd_pins vita49_trig_adc_0/M_AXIS_TVALID]
	# connect_bd_net -net [get_bd_nets axis_vita49_pack_0_S_AXIS_TREADY] [get_bd_pins ila_1/probe3] [get_bd_pins axis_vita49_pack_0/S_AXIS_TREADY]
	# connect_bd_net -net [get_bd_nets axis_vita49_pack_0_M_AXIS_TDATA] [get_bd_pins ila_1/probe4] [get_bd_pins axis_vita49_pack_0/M_AXIS_TDATA]
	# connect_bd_net -net [get_bd_nets axis_vita49_pack_0_M_AXIS_TLAST] [get_bd_pins ila_1/probe5] [get_bd_pins axis_vita49_pack_0/M_AXIS_TLAST]
	# connect_bd_net -net [get_bd_nets axis_vita49_pack_0_M_AXIS_TVALID] [get_bd_pins ila_1/probe6] [get_bd_pins axis_vita49_pack_0/M_AXIS_TVALID]
	# connect_bd_net -net [get_bd_nets axis_32to64_adc_0_S_AXIS_TREADY] [get_bd_pins ila_1/probe7] [get_bd_pins axis_32to64_adc_0/S_AXIS_TREADY]
	# connect_bd_net -net [get_bd_nets vita49_trig_adc_0_trig] [get_bd_pins ila_1/probe8] [get_bd_pins vita49_trig_adc_0/trig]


	# create_bd_cell -type ip -vlnv xilinx.com:ip:ila:4.0 ila_2
	# set_property -dict [list CONFIG.C_PROBE2_WIDTH {32} CONFIG.C_PROBE1_WIDTH {32} CONFIG.C_PROBE0_WIDTH {32} CONFIG.C_NUM_OF_PROBES {7} CONFIG.C_EN_STRG_QUAL {1} CONFIG.C_INPUT_PIPE_STAGES {2} CONFIG.C_MONITOR_TYPE {Native}] [get_bd_cells ila_2]

	# connect_bd_net [get_bd_pins adc_fifo_0/m_axis_tvalid] [get_bd_pins adc_ddr_sw_0/s_axis_tvalid]
	# connect_bd_net [get_bd_pins adc_fifo_0/m_axis_tready] [get_bd_pins adc_ddr_sw_0/s_axis_tready]
	# connect_bd_net [get_bd_pins adc_fifo_0/m_axis_tdata] [get_bd_pins adc_ddr_sw_0/s_axis_tdata]
	# connect_bd_net [get_bd_pins adc_fifo_0/m_axis_tlast] [get_bd_pins adc_ddr_sw_0/s_axis_tlast]
	# connect_bd_net [get_bd_pins adc_fifo_0/m_axis_tuser] [get_bd_pins adc_ddr_sw_0/s_axis_tuser]
	# connect_bd_net -net [get_bd_nets sys_fmc_dma_clk] [get_bd_pins ila_2/clk] [get_bd_pins sys_ps7/FCLK_CLK2]
	# connect_bd_net [get_bd_pins ila_2/probe1] [get_bd_pins adc_fifo_0/axis_data_count]
	# connect_bd_net [get_bd_pins ila_2/probe0] [get_bd_pins adc_fifo_0/axis_wr_data_count]
	# connect_bd_net [get_bd_pins ila_2/probe2] [get_bd_pins adc_fifo_0/axis_rd_data_count]
	# connect_bd_net -net [get_bd_nets adc_fifo_0_m_axis_tvalid] [get_bd_pins ila_2/probe3] [get_bd_pins adc_fifo_0/m_axis_tvalid]
	# connect_bd_net -net [get_bd_nets adc_ddr_sw_0_s_axis_tready] [get_bd_pins ila_2/probe4] [get_bd_pins adc_ddr_sw_0/s_axis_tready]
	# connect_bd_net -net [get_bd_nets sys_reg_0_adc_sw_dest0] [get_bd_pins ila_2/probe5] [get_bd_pins sys_reg_0/adc_sw_dest0]
	# connect_bd_net -net [get_bd_nets vita49_trig_adc_0_trig] [get_bd_pins ila_2/probe6] [get_bd_pins vita49_trig_adc_0/trig]


	# create_bd_cell -type ip -vlnv xilinx.com:ip:ila:4.0 ila_3
	# set_property -dict [list CONFIG.C_PROBE2_WIDTH {32} CONFIG.C_PROBE1_WIDTH {8} CONFIG.C_PROBE0_WIDTH {64} CONFIG.C_NUM_OF_PROBES {6} CONFIG.C_EN_STRG_QUAL {1} CONFIG.C_INPUT_PIPE_STAGES {2} CONFIG.C_MONITOR_TYPE {Native}] [get_bd_cells ila_3]

	# connect_bd_net [get_bd_pins srio_ireq_sw/m_axis_tvalid] [get_bd_pins srio_ireq_intc/S00_AXIS_tvalid]
	# connect_bd_net [get_bd_pins srio_ireq_sw/m_axis_tready] [get_bd_pins srio_ireq_intc/S00_AXIS_tready]
	# connect_bd_net [get_bd_pins srio_ireq_sw/m_axis_tdata] [get_bd_pins srio_ireq_intc/S00_AXIS_tdata]
	# connect_bd_net [get_bd_pins srio_ireq_sw/m_axis_tstrb] [get_bd_pins srio_ireq_intc/S00_AXIS_tstrb]
	# connect_bd_net [get_bd_pins srio_ireq_sw/m_axis_tlast] [get_bd_pins srio_ireq_intc/S00_AXIS_tlast]
	# connect_bd_net [get_bd_pins srio_ireq_sw/m_axis_tuser] [get_bd_pins srio_ireq_intc/S00_AXIS_tuser]
	# connect_bd_net -net [get_bd_nets sys_fmc_dma_clk] [get_bd_pins ila_3/clk] [get_bd_pins sys_ps7/FCLK_CLK2]
	# connect_bd_net -net [get_bd_nets srio_ireq_sw_m_axis_tdata] [get_bd_pins ila_3/probe0] [get_bd_pins srio_ireq_sw/m_axis_tdata]
	# connect_bd_net -net [get_bd_nets srio_ireq_sw_m_axis_tstrb] [get_bd_pins ila_3/probe1] [get_bd_pins srio_ireq_sw/m_axis_tstrb]
	# connect_bd_net -net [get_bd_nets srio_ireq_sw_m_axis_tuser] [get_bd_pins ila_3/probe2] [get_bd_pins srio_ireq_sw/m_axis_tuser]
	# connect_bd_net -net [get_bd_nets srio_ireq_sw_m_axis_tvalid] [get_bd_pins ila_3/probe3] [get_bd_pins srio_ireq_sw/m_axis_tvalid]
	# connect_bd_net -net [get_bd_nets srio_ireq_intc_S00_AXIS_tready] [get_bd_pins ila_3/probe4] [get_bd_pins srio_ireq_intc/S00_AXIS_tready]
	# connect_bd_net -net [get_bd_nets srio_ireq_sw_m_axis_tlast] [get_bd_pins ila_3/probe5] [get_bd_pins srio_ireq_sw/m_axis_tlast]


	# create_bd_cell -type ip -vlnv xilinx.com:ip:ila:4.0 ila_4
	# set_property -dict [list CONFIG.C_PROBE2_WIDTH {32} CONFIG.C_PROBE0_WIDTH {64} CONFIG.C_NUM_OF_PROBES {6} CONFIG.C_EN_STRG_QUAL {1} CONFIG.C_INPUT_PIPE_STAGES {2} CONFIG.C_MONITOR_TYPE {Native}] [get_bd_cells ila_4]

	# connect_bd_net [get_bd_pins srio_treq_intc/M00_AXIS_tdata] [get_bd_pins hello_router_0/S_AXIS_TDATA]
	# connect_bd_net [get_bd_pins srio_treq_intc/M00_AXIS_tlast] [get_bd_pins hello_router_0/S_AXIS_TLAST]
	# connect_bd_net [get_bd_pins srio_treq_intc/M00_AXIS_tuser] [get_bd_pins hello_router_0/S_AXIS_TUSER]
	# connect_bd_net [get_bd_pins srio_treq_intc/M00_AXIS_tvalid] [get_bd_pins hello_router_0/S_AXIS_TVALID]
	# connect_bd_net [get_bd_pins srio_treq_intc/M00_AXIS_tready] [get_bd_pins hello_router_0/S_AXIS_TREADY]
	# connect_bd_net -net [get_bd_nets sys_fmc_dma_clk] [get_bd_pins ila_4/clk] [get_bd_pins sys_ps7/FCLK_CLK2]
	# connect_bd_net -net [get_bd_nets srio_treq_intc_M00_AXIS_tdata] [get_bd_pins ila_4/probe0] [get_bd_pins srio_treq_intc/M00_AXIS_tdata]
	# connect_bd_net -net [get_bd_nets srio_treq_intc_M00_AXIS_tlast] [get_bd_pins ila_4/probe1] [get_bd_pins srio_treq_intc/M00_AXIS_tlast]
	# connect_bd_net -net [get_bd_nets srio_treq_intc_M00_AXIS_tuser] [get_bd_pins ila_4/probe2] [get_bd_pins srio_treq_intc/M00_AXIS_tuser]
	# connect_bd_net -net [get_bd_nets srio_treq_intc_M00_AXIS_tvalid] [get_bd_pins ila_4/probe3] [get_bd_pins srio_treq_intc/M00_AXIS_tvalid]
	# connect_bd_net -net [get_bd_nets M00_AXIS_tready_1] [get_bd_pins ila_4/probe4] [get_bd_pins hello_router_0/S_AXIS_TREADY]
	# connect_bd_net -net [get_bd_nets sys_reg_0_swrite_bypass] [get_bd_pins ila_4/probe5] [get_bd_pins sys_reg_0/swrite_bypass]


  # Create address segments
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_dma_0/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_DDR_LOWOCM] SEG_sys_ps7_GP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x1000000 -offset 0xFC000000 [get_bd_addr_spaces axi_dma_0/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_QSPI_LINEAR] SEG_sys_ps7_GP0_QSPI_LINEAR
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs sys_ps7/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_sys_ps7_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs sys_ps7/S_AXI_HP1/HP1_DDR_LOWOCM] SEG_sys_ps7_HP1_DDR_LOWOCM
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_dma_1/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_DDR_LOWOCM] SEG_sys_ps7_GP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x1000000 -offset 0xFC000000 [get_bd_addr_spaces axi_dma_1/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_QSPI_LINEAR] SEG_sys_ps7_GP0_QSPI_LINEAR
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs sys_ps7/S_AXI_HP2/HP2_DDR_LOWOCM] SEG_sys_ps7_HP2_DDR_LOWOCM
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs sys_ps7/S_AXI_HP3/HP3_DDR_LOWOCM] SEG_sys_ps7_HP3_DDR_LOWOCM
  create_bd_addr_seg -range 0x10000 -offset 0x43C60000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axis_vita49_pack_0/S_AXI/reg0] SEG_axis_vita49_pack_0_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43CA0000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axis_vita49_pack_1/S_AXI/reg0] SEG_axis_vita49_pack_1_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43C70000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axis_vita49_unpack_0/S_AXI/reg0] SEG_axis_vita49_unpack_0_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43CB0000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axis_vita49_unpack_1/S_AXI/reg0] SEG_axis_vita49_unpack_1_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43C00000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9361_0/s_axi/axi_lite] SEG_data_ad9361_0
  create_bd_addr_seg -range 0x10000 -offset 0x43C10000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs adi2axis_0/S_AXI/reg0] SEG_data_ad9361_0_adi2axis
  create_bd_addr_seg -range 0x10000 -offset 0x40400000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_dma_0/S_AXI_LITE/Reg] SEG_data_ad9361_0_dma
  create_bd_addr_seg -range 0x10000 -offset 0x43C20000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9361_1/s_axi/axi_lite] SEG_data_ad9361_1
  create_bd_addr_seg -range 0x10000 -offset 0x43C30000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs adi2axis_1/S_AXI/reg0] SEG_data_ad9361_1_adi2axis
  create_bd_addr_seg -range 0x10000 -offset 0x40410000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_dma_1/S_AXI_LITE/Reg] SEG_data_ad9361_1_dma
  create_bd_addr_seg -range 0x10000 -offset 0x41200000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_gpio/S_AXI/Reg] SEG_data_axi_gpio
  create_bd_addr_seg -range 0x10000 -offset 0x43CE0000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs srio_swrite_pack_0/S_AXI/reg0] SEG_srio_swrite_pack_0_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43D00000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs srio_swrite_pack_1/S_AXI/reg0] SEG_srio_swrite_pack_1_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43CF0000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs srio_swrite_unpack_0/S_AXI/reg0] SEG_srio_swrite_unpack_0_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43CD0000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs sys_reg_0/S_AXI/reg0] SEG_sys_reg_0_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43D10000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs vita49_assem_0/S_AXI/reg0] SEG_vita49_assem_0_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43D20000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs vita49_assem_1/S_AXI/reg0] SEG_vita49_assem_1_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43C40000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs vita49_clk/S_AXI/reg0] SEG_vita49_clk_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43C50000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs vita49_trig_adc_0/S_AXI/reg0] SEG_vita49_trig_adc_0_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43C90000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs vita49_trig_adc_1/S_AXI/reg0] SEG_vita49_trig_adc_1_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43C80000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs vita49_trig_dac_0/S_AXI/reg0] SEG_vita49_trig_dac_0_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43CC0000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs vita49_trig_dac_1/S_AXI/reg0] SEG_vita49_trig_dac_1_reg0

  create_bd_addr_seg -range 0x10000 -offset 0x83C00000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs srio_gen2_0/MAINT_IF/Reg] SEG_srio_gen2_0_Reg  
  set_property range 2M [get_bd_addr_segs {sys_ps7/Data/SEG_srio_gen2_0_Reg}]
  create_bd_addr_seg -range 0x10000 -offset 0x84C10000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_srio_initiator_fifo/S_AXI/Mem0] SEG_axi_srio_initiator_fifo_Mem0
  create_bd_addr_seg -range 0x10000 -offset 0x84C20000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_srio_initiator_fifo/S_AXI_FULL/Mem1] SEG_axi_srio_initiator_fifo_Mem1
  create_bd_addr_seg -range 0x10000 -offset 0x84C30000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_srio_target_fifo/S_AXI/Mem0] SEG_axi_srio_target_fifo_Mem0
  create_bd_addr_seg -range 0x10000 -offset 0x84C40000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_srio_target_fifo/S_AXI_FULL/Mem1] SEG_axi_srio_target_fifo_Mem1






  
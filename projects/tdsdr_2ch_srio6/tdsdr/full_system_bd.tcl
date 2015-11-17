
################################################################
# This is a generated script based on design: system
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2015.3
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source system_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z030fbg484-2

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name system

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]

  # Create ports
  set GPIO_I [ create_bd_port -dir I -from 53 -to 0 GPIO_I ]
  set GPIO_O [ create_bd_port -dir O -from 53 -to 0 GPIO_O ]
  set GPIO_T [ create_bd_port -dir O -from 54 -to 0 GPIO_T ]
  set axi_gpio [ create_bd_port -dir I -from 22 -to 0 axi_gpio ]
  set rx_clk_in_0_n [ create_bd_port -dir I rx_clk_in_0_n ]
  set rx_clk_in_0_p [ create_bd_port -dir I rx_clk_in_0_p ]
  set rx_clk_in_1_n [ create_bd_port -dir I rx_clk_in_1_n ]
  set rx_clk_in_1_p [ create_bd_port -dir I rx_clk_in_1_p ]
  set rx_data_in_0_n [ create_bd_port -dir I -from 5 -to 0 rx_data_in_0_n ]
  set rx_data_in_0_p [ create_bd_port -dir I -from 5 -to 0 rx_data_in_0_p ]
  set rx_data_in_1_n [ create_bd_port -dir I -from 5 -to 0 rx_data_in_1_n ]
  set rx_data_in_1_p [ create_bd_port -dir I -from 5 -to 0 rx_data_in_1_p ]
  set rx_frame_in_0_n [ create_bd_port -dir I rx_frame_in_0_n ]
  set rx_frame_in_0_p [ create_bd_port -dir I rx_frame_in_0_p ]
  set rx_frame_in_1_n [ create_bd_port -dir I rx_frame_in_1_n ]
  set rx_frame_in_1_p [ create_bd_port -dir I rx_frame_in_1_p ]
  set spi_csn_0_i [ create_bd_port -dir I spi_csn_0_i ]
  set spi_csn_0_o [ create_bd_port -dir O spi_csn_0_o ]
  set spi_csn_1_o [ create_bd_port -dir O spi_csn_1_o ]
  set spi_csn_2_o [ create_bd_port -dir O spi_csn_2_o ]
  set spi_miso_i [ create_bd_port -dir I spi_miso_i ]
  set spi_mosi_i [ create_bd_port -dir I spi_mosi_i ]
  set spi_mosi_o [ create_bd_port -dir O spi_mosi_o ]
  set spi_sclk_i [ create_bd_port -dir I spi_sclk_i ]
  set spi_sclk_o [ create_bd_port -dir O spi_sclk_o ]
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
  set tx_clk_out_0_n [ create_bd_port -dir O tx_clk_out_0_n ]
  set tx_clk_out_0_p [ create_bd_port -dir O tx_clk_out_0_p ]
  set tx_clk_out_1_n [ create_bd_port -dir O tx_clk_out_1_n ]
  set tx_clk_out_1_p [ create_bd_port -dir O tx_clk_out_1_p ]
  set tx_data_out_0_n [ create_bd_port -dir O -from 5 -to 0 tx_data_out_0_n ]
  set tx_data_out_0_p [ create_bd_port -dir O -from 5 -to 0 tx_data_out_0_p ]
  set tx_data_out_1_n [ create_bd_port -dir O -from 5 -to 0 tx_data_out_1_n ]
  set tx_data_out_1_p [ create_bd_port -dir O -from 5 -to 0 tx_data_out_1_p ]
  set tx_frame_out_0_n [ create_bd_port -dir O tx_frame_out_0_n ]
  set tx_frame_out_0_p [ create_bd_port -dir O tx_frame_out_0_p ]
  set tx_frame_out_1_n [ create_bd_port -dir O tx_frame_out_1_n ]
  set tx_frame_out_1_p [ create_bd_port -dir O tx_frame_out_1_p ]

  # Create instance: adc_ddr_sw_0, and set properties
  set adc_ddr_sw_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 adc_ddr_sw_0 ]
  set_property -dict [ list \
CONFIG.NUM_MI {2} \
CONFIG.NUM_SI {2} \
 ] $adc_ddr_sw_0

  # Create instance: adc_ddr_sw_1, and set properties
  set adc_ddr_sw_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 adc_ddr_sw_1 ]
  set_property -dict [ list \
CONFIG.NUM_MI {2} \
CONFIG.NUM_SI {2} \
 ] $adc_ddr_sw_1

  # Create instance: adc_ddr_tdest_0, and set properties
  set adc_ddr_tdest_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 adc_ddr_tdest_0 ]

  # Create instance: adc_ddr_tdest_1, and set properties
  set adc_ddr_tdest_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 adc_ddr_tdest_1 ]

  # Create instance: adc_fifo_0, and set properties
  set adc_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:1.1 adc_fifo_0 ]
  set_property -dict [ list \
CONFIG.FIFO_DEPTH {512} \
 ] $adc_fifo_0

  # Create instance: adc_fifo_1, and set properties
  set adc_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:1.1 adc_fifo_1 ]
  set_property -dict [ list \
CONFIG.FIFO_DEPTH {512} \
 ] $adc_fifo_1

  # Create instance: adi2axis_0, and set properties
  set adi2axis_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:adi2axis:1.0 adi2axis_0 ]

  # Create instance: adi2axis_1, and set properties
  set adi2axis_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:adi2axis:1.0 adi2axis_1 ]

  # Create instance: adi_dma_comb_0, and set properties
  set adi_dma_comb_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:adi_dma_comb:1.0 adi_dma_comb_0 ]

  # Create instance: adi_dma_comb_1, and set properties
  set adi_dma_comb_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:adi_dma_comb:1.0 adi_dma_comb_1 ]

  # Create instance: adi_dma_split_0, and set properties
  set adi_dma_split_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:adi_dma_split:1.0 adi_dma_split_0 ]

  # Create instance: adi_dma_split_1, and set properties
  set adi_dma_split_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:adi_dma_split:1.0 adi_dma_split_1 ]

  # Create instance: axi_ad9361_0, and set properties
  set axi_ad9361_0 [ create_bd_cell -type ip -vlnv analog.com:user:axi_ad9361:1.0 axi_ad9361_0 ]
  set_property -dict [ list \
CONFIG.PCORE_ID {0} \
CONFIG.PCORE_IODELAY_GROUP {dev_0_if_delay_group} \
 ] $axi_ad9361_0

  # Create instance: axi_ad9361_0_adc_dma_interconnect, and set properties
  set axi_ad9361_0_adc_dma_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_ad9361_0_adc_dma_interconnect ]
  set_property -dict [ list \
CONFIG.NUM_MI {1} \
CONFIG.S00_HAS_REGSLICE {4} \
 ] $axi_ad9361_0_adc_dma_interconnect

  # Create instance: axi_ad9361_0_dac_dma_interconnect, and set properties
  set axi_ad9361_0_dac_dma_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_ad9361_0_dac_dma_interconnect ]
  set_property -dict [ list \
CONFIG.M00_HAS_REGSLICE {4} \
CONFIG.NUM_MI {1} \
CONFIG.NUM_SI {2} \
CONFIG.S00_HAS_REGSLICE {4} \
CONFIG.S01_HAS_REGSLICE {4} \
 ] $axi_ad9361_0_dac_dma_interconnect

  # Create instance: axi_ad9361_1, and set properties
  set axi_ad9361_1 [ create_bd_cell -type ip -vlnv analog.com:user:axi_ad9361:1.0 axi_ad9361_1 ]
  set_property -dict [ list \
CONFIG.PCORE_ID {0} \
CONFIG.PCORE_IODELAY_GROUP {dev_1_if_delay_group} \
 ] $axi_ad9361_1

  # Create instance: axi_ad9361_1_adc_dma_interconnect, and set properties
  set axi_ad9361_1_adc_dma_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_ad9361_1_adc_dma_interconnect ]
  set_property -dict [ list \
CONFIG.M00_HAS_REGSLICE {4} \
CONFIG.NUM_MI {1} \
CONFIG.NUM_SI {2} \
CONFIG.S00_HAS_REGSLICE {4} \
CONFIG.S01_HAS_REGSLICE {4} \
 ] $axi_ad9361_1_adc_dma_interconnect

  # Create instance: axi_ad9361_1_dac_dma_interconnect, and set properties
  set axi_ad9361_1_dac_dma_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_ad9361_1_dac_dma_interconnect ]
  set_property -dict [ list \
CONFIG.M00_HAS_REGSLICE {4} \
CONFIG.NUM_MI {1} \
CONFIG.NUM_SI {2} \
CONFIG.S00_HAS_REGSLICE {4} \
CONFIG.S01_HAS_REGSLICE {4} \
 ] $axi_ad9361_1_dac_dma_interconnect

  # Create instance: axi_cpu_interconnect, and set properties
  set axi_cpu_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_cpu_interconnect ]
  set_property -dict [ list \
CONFIG.NUM_MI {30} \
 ] $axi_cpu_interconnect

  # Create instance: axi_dma_0, and set properties
  set axi_dma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0 ]
  set_property -dict [ list \
CONFIG.c_include_s2mm {1} \
CONFIG.c_m_axi_mm2s_data_width {64} \
CONFIG.c_m_axi_s2mm_data_width {64} \
CONFIG.c_m_axis_mm2s_tdata_width {64} \
CONFIG.c_sg_include_stscntrl_strm {0} \
CONFIG.c_sg_length_width {16} \
 ] $axi_dma_0

  # Create instance: axi_dma_1, and set properties
  set axi_dma_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_1 ]
  set_property -dict [ list \
CONFIG.c_include_s2mm {1} \
CONFIG.c_m_axi_mm2s_data_width {64} \
CONFIG.c_m_axi_s2mm_data_width {64} \
CONFIG.c_m_axis_mm2s_tdata_width {64} \
CONFIG.c_sg_include_stscntrl_strm {0} \
CONFIG.c_sg_length_width {16} \
 ] $axi_dma_1

  # Create instance: axi_gpio, and set properties
  set axi_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio ]
  set_property -dict [ list \
CONFIG.C_ALL_INPUTS {1} \
CONFIG.C_GPIO_WIDTH {23} \
CONFIG.C_INTERRUPT_PRESENT {1} \
 ] $axi_gpio

  # Create instance: axi_sg_interconnect, and set properties
  set axi_sg_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_sg_interconnect ]
  set_property -dict [ list \
CONFIG.M00_HAS_REGSLICE {4} \
CONFIG.NUM_MI {1} \
CONFIG.NUM_SI {3} \
CONFIG.S00_HAS_REGSLICE {4} \
CONFIG.S01_HAS_REGSLICE {4} \
CONFIG.S02_HAS_REGSLICE {4} \
 ] $axi_sg_interconnect

  # Create instance: axi_srio_initiator_fifo, and set properties
  set axi_srio_initiator_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_fifo_mm_s:4.1 axi_srio_initiator_fifo ]
  set_property -dict [ list \
CONFIG.C_DATA_INTERFACE_TYPE {0} \
CONFIG.C_HAS_AXIS_TDEST {true} \
CONFIG.C_HAS_AXIS_TUSER {false} \
CONFIG.C_RX_FIFO_DEPTH {512} \
CONFIG.C_S_AXI4_DATA_WIDTH {32} \
CONFIG.C_TX_FIFO_DEPTH {512} \
CONFIG.C_USE_RX_CUT_THROUGH {false} \
CONFIG.C_USE_TX_CTRL {0} \
CONFIG.C_USE_TX_CUT_THROUGH {1} \
 ] $axi_srio_initiator_fifo

  # Create instance: axi_srio_interconnect, and set properties
  set axi_srio_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_srio_interconnect ]
  set_property -dict [ list \
CONFIG.ENABLE_ADVANCED_OPTIONS {1} \
CONFIG.M00_HAS_REGSLICE {4} \
CONFIG.M01_HAS_REGSLICE {4} \
CONFIG.M02_HAS_REGSLICE {4} \
CONFIG.M03_HAS_REGSLICE {4} \
CONFIG.M04_HAS_REGSLICE {4} \
CONFIG.M05_HAS_REGSLICE {4} \
CONFIG.M06_HAS_REGSLICE {4} \
CONFIG.M07_HAS_REGSLICE {4} \
CONFIG.NUM_MI {8} \
CONFIG.S00_HAS_REGSLICE {4} \
CONFIG.STRATEGY {2} \
 ] $axi_srio_interconnect

  # Create instance: axi_srio_target_fifo, and set properties
  set axi_srio_target_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_fifo_mm_s:4.1 axi_srio_target_fifo ]
  set_property -dict [ list \
CONFIG.C_DATA_INTERFACE_TYPE {0} \
CONFIG.C_HAS_AXIS_TDEST {true} \
CONFIG.C_HAS_AXIS_TUSER {false} \
CONFIG.C_RX_FIFO_DEPTH {512} \
CONFIG.C_S_AXI4_DATA_WIDTH {32} \
CONFIG.C_TX_FIFO_DEPTH {512} \
CONFIG.C_USE_RX_CUT_THROUGH {true} \
CONFIG.C_USE_TX_CTRL {0} \
CONFIG.C_USE_TX_CUT_THROUGH {1} \
 ] $axi_srio_target_fifo

  # Create instance: axis2adi_0, and set properties
  set axis2adi_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis2adi:1.0 axis2adi_0 ]

  # Create instance: axis2adi_1, and set properties
  set axis2adi_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis2adi:1.0 axis2adi_1 ]

  # Create instance: axis_32to64_adc_0, and set properties
  set axis_32to64_adc_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_32to64:1.0 axis_32to64_adc_0 ]

  # Create instance: axis_32to64_adc_1, and set properties
  set axis_32to64_adc_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_32to64:1.0 axis_32to64_adc_1 ]

  # Create instance: axis_32to64_dac_0, and set properties
  set axis_32to64_dac_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_32to64_dac_0 ]
  set_property -dict [ list \
CONFIG.HAS_TLAST {0} \
CONFIG.M_TDATA_NUM_BYTES {8} \
 ] $axis_32to64_dac_0

  # Create instance: axis_32to64_dac_1, and set properties
  set axis_32to64_dac_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_32to64_dac_1 ]
  set_property -dict [ list \
CONFIG.HAS_TLAST {0} \
CONFIG.M_TDATA_NUM_BYTES {8} \
 ] $axis_32to64_dac_1

  # Create instance: axis_32to64_srio_init, and set properties
  set axis_32to64_srio_init [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_32to64_strb_tuser:1.0 axis_32to64_srio_init ]

  # Create instance: axis_32to64_srio_target, and set properties
  set axis_32to64_srio_target [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_32to64_strb_tuser:1.0 axis_32to64_srio_target ]

  # Create instance: axis_64to32_adc_0, and set properties
  set axis_64to32_adc_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_64to32:1.0 axis_64to32_adc_0 ]

  # Create instance: axis_64to32_adc_1, and set properties
  set axis_64to32_adc_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_64to32:1.0 axis_64to32_adc_1 ]

  # Create instance: axis_64to32_dac_0, and set properties
  set axis_64to32_dac_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_64to32_strb:1.0 axis_64to32_dac_0 ]

  # Create instance: axis_64to32_dac_1, and set properties
  set axis_64to32_dac_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_64to32_strb:1.0 axis_64to32_dac_1 ]

  # Create instance: axis_64to32_srio_init, and set properties
  set axis_64to32_srio_init [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_64to32_strb_tuser:1.0 axis_64to32_srio_init ]

  # Create instance: axis_64to32_srio_target, and set properties
  set axis_64to32_srio_target [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_64to32_strb_tuser:1.0 axis_64to32_srio_target ]

  # Create instance: axis_adc_interconnect_0, and set properties
  set axis_adc_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_adc_interconnect_0 ]
  set_property -dict [ list \
CONFIG.M00_HAS_REGSLICE {1} \
CONFIG.NUM_MI {1} \
 ] $axis_adc_interconnect_0

  # Create instance: axis_adc_interconnect_1, and set properties
  set axis_adc_interconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_adc_interconnect_1 ]
  set_property -dict [ list \
CONFIG.M00_HAS_REGSLICE {1} \
CONFIG.NUM_MI {1} \
 ] $axis_adc_interconnect_1

  # Create instance: axis_dac_interconnect_0, and set properties
  set axis_dac_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_dac_interconnect_0 ]
  set_property -dict [ list \
CONFIG.NUM_MI {1} \
 ] $axis_dac_interconnect_0

  # Create instance: axis_dac_interconnect_1, and set properties
  set axis_dac_interconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_dac_interconnect_1 ]
  set_property -dict [ list \
CONFIG.NUM_MI {1} \
 ] $axis_dac_interconnect_1

  # Create instance: axis_vita49_pack_0, and set properties
  set axis_vita49_pack_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_vita49_pack:1.0 axis_vita49_pack_0 ]

  # Create instance: axis_vita49_pack_1, and set properties
  set axis_vita49_pack_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_vita49_pack:1.0 axis_vita49_pack_1 ]

  # Create instance: axis_vita49_unpack_0, and set properties
  set axis_vita49_unpack_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_vita49_unpack:1.0 axis_vita49_unpack_0 ]

  # Create instance: axis_vita49_unpack_1, and set properties
  set axis_vita49_unpack_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_vita49_unpack:1.0 axis_vita49_unpack_1 ]

  # Create instance: c_counter_binary_0, and set properties
  set c_counter_binary_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_counter_binary:12.0 c_counter_binary_0 ]
  set_property -dict [ list \
CONFIG.Output_Width {28} \
 ] $c_counter_binary_0

  # Create instance: const_1, and set properties
  set const_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_1 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {255} \
CONFIG.CONST_WIDTH {8} \
 ] $const_1

  # Create instance: const_loopback, and set properties
  set const_loopback [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_loopback ]
  set_property -dict [ list \
CONFIG.CONST_VAL {585} \
CONFIG.CONST_WIDTH {12} \
 ] $const_loopback

  # Create instance: constant_0, and set properties
  set constant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 constant_0 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $constant_0

  # Create instance: dac_ddr_sw_0, and set properties
  set dac_ddr_sw_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 dac_ddr_sw_0 ]
  set_property -dict [ list \
CONFIG.NUM_MI {2} \
 ] $dac_ddr_sw_0

  # Create instance: dac_ddr_sw_0_reg, and set properties
  set dac_ddr_sw_0_reg [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 dac_ddr_sw_0_reg ]

  # Create instance: dac_ddr_sw_1, and set properties
  set dac_ddr_sw_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 dac_ddr_sw_1 ]
  set_property -dict [ list \
CONFIG.NUM_MI {2} \
 ] $dac_ddr_sw_1

  # Create instance: dac_ddr_tdest_0, and set properties
  set dac_ddr_tdest_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 dac_ddr_tdest_0 ]

  # Create instance: dac_ddr_tdest_1, and set properties
  set dac_ddr_tdest_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 dac_ddr_tdest_1 ]

  # Create instance: dac_fifo_0, and set properties
  set dac_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:1.1 dac_fifo_0 ]
  set_property -dict [ list \
CONFIG.FIFO_DEPTH {512} \
 ] $dac_fifo_0

  # Create instance: dac_fifo_1, and set properties
  set dac_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:1.1 dac_fifo_1 ]
  set_property -dict [ list \
CONFIG.FIFO_DEPTH {512} \
 ] $dac_fifo_1

  # Create instance: ddr_fifo, and set properties
  set ddr_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vfifo_ctrl:2.0 ddr_fifo ]
  set_property -dict [ list \
CONFIG.axis_tdata_width {64} \
CONFIG.deassert_tready {true} \
CONFIG.dram_base_addr {3f000000} \
CONFIG.enable_interrupt {true} \
CONFIG.number_of_channel {2} \
CONFIG.number_of_page_ch0 {2048} \
CONFIG.number_of_page_ch1 {2048} \
 ] $ddr_fifo

  # Create instance: drp_bridge_0, and set properties
  set drp_bridge_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:drp_bridge:1.0 drp_bridge_0 ]
  set_property -dict [ list \
CONFIG.DRP_ADDR_WIDTH {9} \
CONFIG.DRP_COUNT {4} \
CONFIG.DRP_DATA_WIDTH {16} \
 ] $drp_bridge_0

  # Create instance: drpaddr_concat, and set properties
  set drpaddr_concat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 drpaddr_concat ]
  set_property -dict [ list \
CONFIG.IN0_WIDTH {9} \
CONFIG.IN1_WIDTH {9} \
CONFIG.IN2_WIDTH {9} \
CONFIG.IN3_WIDTH {9} \
CONFIG.NUM_PORTS {4} \
 ] $drpaddr_concat

  # Create instance: drpdi_concat, and set properties
  set drpdi_concat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 drpdi_concat ]
  set_property -dict [ list \
CONFIG.IN0_WIDTH {16} \
CONFIG.IN1_WIDTH {16} \
CONFIG.IN2_WIDTH {16} \
CONFIG.IN3_WIDTH {16} \
CONFIG.NUM_PORTS {4} \
 ] $drpdi_concat

  # Create instance: drpdo_slice_0, and set properties
  set drpdo_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 drpdo_slice_0 ]
  set_property -dict [ list \
CONFIG.DIN_FROM {15} \
CONFIG.DIN_TO {0} \
CONFIG.DIN_WIDTH {64} \
 ] $drpdo_slice_0

  # Create instance: drpdo_slice_1, and set properties
  set drpdo_slice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 drpdo_slice_1 ]
  set_property -dict [ list \
CONFIG.DIN_FROM {31} \
CONFIG.DIN_TO {16} \
CONFIG.DIN_WIDTH {64} \
 ] $drpdo_slice_1

  # Create instance: drpdo_slice_2, and set properties
  set drpdo_slice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 drpdo_slice_2 ]
  set_property -dict [ list \
CONFIG.DIN_FROM {47} \
CONFIG.DIN_TO {32} \
CONFIG.DIN_WIDTH {64} \
 ] $drpdo_slice_2

  # Create instance: drpdo_slice_3, and set properties
  set drpdo_slice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 drpdo_slice_3 ]
  set_property -dict [ list \
CONFIG.DIN_FROM {63} \
CONFIG.DIN_TO {48} \
CONFIG.DIN_WIDTH {64} \
 ] $drpdo_slice_3

  # Create instance: drpen_concat, and set properties
  set drpen_concat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 drpen_concat ]
  set_property -dict [ list \
CONFIG.NUM_PORTS {4} \
 ] $drpen_concat

  # Create instance: drprdy_slice_0, and set properties
  set drprdy_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 drprdy_slice_0 ]
  set_property -dict [ list \
CONFIG.DIN_WIDTH {4} \
 ] $drprdy_slice_0

  # Create instance: drprdy_slice_1, and set properties
  set drprdy_slice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 drprdy_slice_1 ]
  set_property -dict [ list \
CONFIG.DIN_FROM {1} \
CONFIG.DIN_TO {1} \
CONFIG.DIN_WIDTH {4} \
 ] $drprdy_slice_1

  # Create instance: drprdy_slice_2, and set properties
  set drprdy_slice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 drprdy_slice_2 ]
  set_property -dict [ list \
CONFIG.DIN_FROM {2} \
CONFIG.DIN_TO {2} \
CONFIG.DIN_WIDTH {4} \
 ] $drprdy_slice_2

  # Create instance: drprdy_slice_3, and set properties
  set drprdy_slice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 drprdy_slice_3 ]
  set_property -dict [ list \
CONFIG.DIN_FROM {3} \
CONFIG.DIN_TO {3} \
CONFIG.DIN_WIDTH {4} \
 ] $drprdy_slice_3

  # Create instance: drpwe_concat, and set properties
  set drpwe_concat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 drpwe_concat ]
  set_property -dict [ list \
CONFIG.NUM_PORTS {4} \
 ] $drpwe_concat

  # Create instance: hello_router_0, and set properties
  set hello_router_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:hello_router:1.0 hello_router_0 ]

  # Create instance: irq_stub0, and set properties
  set irq_stub0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 irq_stub0 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $irq_stub0

  # Create instance: irq_stub1, and set properties
  set irq_stub1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 irq_stub1 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $irq_stub1

  # Create instance: irq_stub2, and set properties
  set irq_stub2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 irq_stub2 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $irq_stub2

  # Create instance: irq_stub3, and set properties
  set irq_stub3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 irq_stub3 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $irq_stub3

  # Create instance: irq_stub11, and set properties
  set irq_stub11 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 irq_stub11 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $irq_stub11

  # Create instance: routing_reg_0, and set properties
  set routing_reg_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:routing_reg:1.0 routing_reg_0 ]

  # Create instance: srio_dma, and set properties
  set srio_dma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 srio_dma ]
  set_property -dict [ list \
CONFIG.c_include_s2mm {1} \
CONFIG.c_m_axi_mm2s_data_width {64} \
CONFIG.c_m_axi_s2mm_data_width {64} \
CONFIG.c_m_axis_mm2s_tdata_width {64} \
CONFIG.c_sg_include_stscntrl_strm {0} \
CONFIG.c_sg_length_width {16} \
 ] $srio_dma

  # Create instance: srio_dma_comb_0, and set properties
  set srio_dma_comb_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:srio_dma_comb:1.0 srio_dma_comb_0 ]

  # Create instance: srio_dma_reg_0_delete, and set properties
  set srio_dma_reg_0_delete [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 srio_dma_reg_0_delete ]

  # Create instance: srio_dma_split_0, and set properties
  set srio_dma_split_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:srio_dma_split:1.0 srio_dma_split_0 ]

  # Create instance: srio_gen2_0, and set properties
  set srio_gen2_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:srio_gen2:4.0 srio_gen2_0 ]
  set_property -dict [ list \
CONFIG.assembly_identifier {7045} \
CONFIG.assembly_revision_level {0001} \
CONFIG.assembly_vendor_identifier {4242} \
CONFIG.c_transceivercontrol {1} \
CONFIG.device_id {02} \
CONFIG.extended_features_enable_user {false} \
CONFIG.idle2_support {true} \
CONFIG.link_width {4} \
CONFIG.mode_selection {Advanced} \
CONFIG.port_init_targ_userdef {false} \
CONFIG.software_assisted_error_recovery {true} \
CONFIG.transfer_frequency {5.0} \
CONFIG.unified_clk {true} \
 ] $srio_gen2_0

  # Create instance: srio_ireq_intc, and set properties
  set srio_ireq_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 srio_ireq_intc ]
  set_property -dict [ list \
CONFIG.NUM_MI {1} \
 ] $srio_ireq_intc

  # Create instance: srio_ireq_sw, and set properties
  set srio_ireq_sw [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 srio_ireq_sw ]
  set_property -dict [ list \
CONFIG.ARB_ON_MAX_XFERS {0} \
CONFIG.ARB_ON_TLAST {1} \
CONFIG.HAS_TLAST {1} \
CONFIG.NUM_MI {1} \
CONFIG.NUM_SI {4} \
 ] $srio_ireq_sw

  # Create instance: srio_iresp_intc, and set properties
  set srio_iresp_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 srio_iresp_intc ]
  set_property -dict [ list \
CONFIG.NUM_MI {1} \
 ] $srio_iresp_intc

  # Create instance: srio_maint_reg, and set properties
  set srio_maint_reg [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 srio_maint_reg ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {28} \
 ] $srio_maint_reg

  # Create instance: srio_swrite_pack_0, and set properties
  set srio_swrite_pack_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:srio_swrite_pack:1.0 srio_swrite_pack_0 ]

  # Create instance: srio_swrite_pack_1, and set properties
  set srio_swrite_pack_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:srio_swrite_pack:1.0 srio_swrite_pack_1 ]

  # Create instance: srio_swrite_unpack_0, and set properties
  set srio_swrite_unpack_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:srio_swrite_unpack:1.0 srio_swrite_unpack_0 ]

  # Create instance: srio_swrite_unpack_reg, and set properties
  set srio_swrite_unpack_reg [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 srio_swrite_unpack_reg ]

  # Create instance: srio_target_reg, and set properties
  set srio_target_reg [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 srio_target_reg ]

  # Create instance: srio_treq_intc, and set properties
  set srio_treq_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 srio_treq_intc ]
  set_property -dict [ list \
CONFIG.NUM_MI {1} \
 ] $srio_treq_intc

  # Create instance: srio_treq_sw, and set properties
  set srio_treq_sw [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 srio_treq_sw ]
  set_property -dict [ list \
CONFIG.M02_AXIS_HIGHTDEST {0x00000003} \
CONFIG.NUM_MI {3} \
CONFIG.NUM_SI {1} \
CONFIG.TUSER_WIDTH {32} \
 ] $srio_treq_sw

  # Create instance: srio_tresp_intc, and set properties
  set srio_tresp_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 srio_tresp_intc ]
  set_property -dict [ list \
CONFIG.NUM_MI {1} \
 ] $srio_tresp_intc

  # Create instance: sys_concat_intc, and set properties
  set sys_concat_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 sys_concat_intc ]
  set_property -dict [ list \
CONFIG.NUM_PORTS {16} \
 ] $sys_concat_intc

  # Create instance: sys_ps7, and set properties
  set sys_ps7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 sys_ps7 ]
  set_property -dict [ list \
CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {600} \
CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ {40.0} \
CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_EN_CLK1_PORT {1} \
CONFIG.PCW_EN_CLK2_PORT {1} \
CONFIG.PCW_EN_RST1_PORT {1} \
CONFIG.PCW_EN_RST2_PORT {1} \
CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100.0} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {200.0} \
CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {250} \
CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {1} \
CONFIG.PCW_GPIO_EMIO_GPIO_IO {55} \
CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_IRQ_F2P_INTR {1} \
CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 1.8V} \
CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {1} \
CONFIG.PCW_QSPI_GRP_IO1_ENABLE {0} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
CONFIG.PCW_QSPI_GRP_SS1_ENABLE {0} \
CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SD0_GRP_CD_ENABLE {1} \
CONFIG.PCW_SD0_GRP_CD_IO {MIO 0} \
CONFIG.PCW_SD0_GRP_WP_ENABLE {0} \
CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SD1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SD1_SD1_IO {MIO 10 .. 15} \
CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SPI1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K256M16 RE-125} \
CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
CONFIG.PCW_USE_M_AXI_GP1 {1} \
CONFIG.PCW_USE_S_AXI_GP0 {1} \
CONFIG.PCW_USE_S_AXI_HP0 {1} \
CONFIG.PCW_USE_S_AXI_HP1 {1} \
CONFIG.PCW_USE_S_AXI_HP2 {1} \
CONFIG.PCW_USE_S_AXI_HP3 {1} \
CONFIG.PCW_WDT_PERIPHERAL_ENABLE {1} \
 ] $sys_ps7

  # Create instance: sys_reg_0, and set properties
  set sys_reg_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:sys_reg:1.0 sys_reg_0 ]

  # Create instance: sys_rstgen, and set properties
  set sys_rstgen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 sys_rstgen ]
  set_property -dict [ list \
CONFIG.C_EXT_RST_WIDTH {1} \
 ] $sys_rstgen

  # Create instance: util_adc_pack_0, and set properties
  set util_adc_pack_0 [ create_bd_cell -type ip -vlnv analog.com:user:util_adc_pack:1.0 util_adc_pack_0 ]
  set_property -dict [ list \
CONFIG.CHANNELS {4} \
 ] $util_adc_pack_0

  # Create instance: util_adc_pack_1, and set properties
  set util_adc_pack_1 [ create_bd_cell -type ip -vlnv analog.com:user:util_adc_pack:1.0 util_adc_pack_1 ]
  set_property -dict [ list \
CONFIG.CHANNELS {4} \
 ] $util_adc_pack_1

  # Create instance: util_dac_unpack_0, and set properties
  set util_dac_unpack_0 [ create_bd_cell -type ip -vlnv analog.com:user:util_dac_unpack:1.0 util_dac_unpack_0 ]
  set_property -dict [ list \
CONFIG.CHANNELS {4} \
 ] $util_dac_unpack_0

  # Create instance: util_dac_unpack_1, and set properties
  set util_dac_unpack_1 [ create_bd_cell -type ip -vlnv analog.com:user:util_dac_unpack:1.0 util_dac_unpack_1 ]
  set_property -dict [ list \
CONFIG.CHANNELS {4} \
 ] $util_dac_unpack_1

  # Create instance: vita49_assem_0, and set properties
  set vita49_assem_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:vita49_assem:1.0 vita49_assem_0 ]

  # Create instance: vita49_assem_1, and set properties
  set vita49_assem_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:vita49_assem:1.0 vita49_assem_1 ]

  # Create instance: vita49_clk, and set properties
  set vita49_clk [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:vita49_clk:1.0 vita49_clk ]

  # Create instance: vita49_trig_adc_0, and set properties
  set vita49_trig_adc_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:vita49_trig:1.0 vita49_trig_adc_0 ]

  # Create instance: vita49_trig_adc_1, and set properties
  set vita49_trig_adc_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:vita49_trig:1.0 vita49_trig_adc_1 ]

  # Create instance: vita49_trig_dac_0, and set properties
  set vita49_trig_dac_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:vita49_trig:1.0 vita49_trig_dac_0 ]

  # Create instance: vita49_trig_dac_1, and set properties
  set vita49_trig_dac_1 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:vita49_trig:1.0 vita49_trig_dac_1 ]

  # Create instance: vita_dac_sw, and set properties
  set vita_dac_sw [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 vita_dac_sw ]
  set_property -dict [ list \
CONFIG.M02_AXIS_HIGHTDEST {0x00000003} \
CONFIG.NUM_MI {2} \
CONFIG.NUM_SI {1} \
 ] $vita_dac_sw

  # Create instance: vita_pack_adc_reg_0, and set properties
  set vita_pack_adc_reg_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 vita_pack_adc_reg_0 ]

  # Create instance: vita_pack_adc_reg_1, and set properties
  set vita_pack_adc_reg_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 vita_pack_adc_reg_1 ]

  # Create instance: vita_trig_dac_reg_0, and set properties
  set vita_trig_dac_reg_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 vita_trig_dac_reg_0 ]

  # Create instance: vita_trig_dac_reg_1, and set properties
  set vita_trig_dac_reg_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 vita_trig_dac_reg_1 ]

  # Create instance: vita_unpack_dac_reg_0, and set properties
  set vita_unpack_dac_reg_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 vita_unpack_dac_reg_0 ]

  # Create instance: vita_unpack_dac_reg_1, and set properties
  set vita_unpack_dac_reg_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 vita_unpack_dac_reg_1 ]

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list \
CONFIG.DIN_FROM {26} \
CONFIG.DIN_TO {26} \
CONFIG.DIN_WIDTH {28} \
 ] $xlslice_0

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [ list \
CONFIG.DIN_FROM {53} \
CONFIG.DIN_WIDTH {55} \
 ] $xlslice_1

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_pins adi2axis_0/M_AXIS] [get_bd_intf_pins axis_adc_interconnect_0/S00_AXIS]
  connect_bd_intf_net -intf_net S00_AXIS_2 [get_bd_intf_pins adi2axis_1/M_AXIS] [get_bd_intf_pins axis_adc_interconnect_1/S00_AXIS]
  connect_bd_intf_net -intf_net S01_AXI_1 [get_bd_intf_pins axi_ad9361_0_dac_dma_interconnect/S01_AXI] [get_bd_intf_pins ddr_fifo/M_AXI]
  connect_bd_intf_net -intf_net adc_ddr_sw_0_M00_AXIS [get_bd_intf_pins adc_ddr_sw_0/M00_AXIS] [get_bd_intf_pins adi_dma_comb_0/S_AXIS]
  connect_bd_intf_net -intf_net adc_ddr_sw_0_M01_AXIS [get_bd_intf_pins adc_ddr_sw_0/M01_AXIS] [get_bd_intf_pins srio_swrite_pack_0/S_AXIS]
  connect_bd_intf_net -intf_net adc_ddr_sw_1_M00_AXIS [get_bd_intf_pins adc_ddr_sw_1/M00_AXIS] [get_bd_intf_pins adi_dma_comb_1/S_AXIS]
  connect_bd_intf_net -intf_net adc_ddr_sw_1_M01_AXIS [get_bd_intf_pins adc_ddr_sw_1/M01_AXIS] [get_bd_intf_pins srio_swrite_pack_1/S_AXIS]
  connect_bd_intf_net -intf_net adc_fifo_0_M_AXIS [get_bd_intf_pins adc_ddr_sw_0/S00_AXIS] [get_bd_intf_pins adc_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net adc_fifo_1_M_AXIS [get_bd_intf_pins adc_ddr_sw_1/S00_AXIS] [get_bd_intf_pins adc_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net adi_dma_comb_0_M_AXIS [get_bd_intf_pins adi_dma_comb_0/M_AXIS] [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM]
  connect_bd_intf_net -intf_net adi_dma_comb_1_M_AXIS [get_bd_intf_pins adi_dma_comb_1/M_AXIS] [get_bd_intf_pins axi_dma_1/S_AXIS_S2MM]
  connect_bd_intf_net -intf_net adi_dma_split_0_M_AXIS [get_bd_intf_pins adi_dma_split_0/M_AXIS] [get_bd_intf_pins dac_ddr_sw_0/S00_AXIS]
  connect_bd_intf_net -intf_net adi_dma_split_1_M_AXIS [get_bd_intf_pins adi_dma_split_1/M_AXIS] [get_bd_intf_pins dac_ddr_sw_1/S00_AXIS]
  connect_bd_intf_net -intf_net axi_ad9361_0_adc_dma_interconnect_m00_axi [get_bd_intf_pins axi_ad9361_0_adc_dma_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_HP1]
  connect_bd_intf_net -intf_net axi_ad9361_0_dac_dma_interconnect_m00_axi [get_bd_intf_pins axi_ad9361_0_dac_dma_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_HP0]
  connect_bd_intf_net -intf_net axi_ad9361_1_adc_dma_interconnect_m00_axi [get_bd_intf_pins axi_ad9361_1_adc_dma_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_HP3]
  connect_bd_intf_net -intf_net axi_ad9361_1_dac_dma_interconnect_m00_axi [get_bd_intf_pins axi_ad9361_1_dac_dma_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_HP2]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M01_AXI [get_bd_intf_pins axi_cpu_interconnect/M01_AXI] [get_bd_intf_pins vita49_clk/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M06_AXI [get_bd_intf_pins axi_cpu_interconnect/M06_AXI] [get_bd_intf_pins sys_reg_0/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M15_AXI [get_bd_intf_pins axi_cpu_interconnect/M15_AXI] [get_bd_intf_pins vita49_trig_adc_1/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M16_AXI [get_bd_intf_pins axi_cpu_interconnect/M16_AXI] [get_bd_intf_pins srio_swrite_pack_0/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M17_AXI [get_bd_intf_pins axi_cpu_interconnect/M17_AXI] [get_bd_intf_pins srio_swrite_pack_1/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M18_AXI [get_bd_intf_pins axi_cpu_interconnect/M18_AXI] [get_bd_intf_pins srio_swrite_unpack_0/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M19_AXI [get_bd_intf_pins axi_cpu_interconnect/M19_AXI] [get_bd_intf_pins vita49_assem_0/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M20_AXI [get_bd_intf_pins axi_cpu_interconnect/M20_AXI] [get_bd_intf_pins vita49_assem_1/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M21_AXI [get_bd_intf_pins axi_cpu_interconnect/M21_AXI] [get_bd_intf_pins vita49_trig_dac_0/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M22_AXI [get_bd_intf_pins axi_cpu_interconnect/M22_AXI] [get_bd_intf_pins routing_reg_0/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M23_AXI [get_bd_intf_pins axi_cpu_interconnect/M23_AXI] [get_bd_intf_pins srio_dma/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M24_AXI [get_bd_intf_pins axi_cpu_interconnect/M24_AXI] [get_bd_intf_pins srio_dma_comb_0/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M25_AXI [get_bd_intf_pins axi_cpu_interconnect/M25_AXI] [get_bd_intf_pins srio_dma_split_0/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M26_AXI [get_bd_intf_pins adi_dma_comb_0/S_AXI] [get_bd_intf_pins axi_cpu_interconnect/M26_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M27_AXI [get_bd_intf_pins adi_dma_split_0/S_AXI] [get_bd_intf_pins axi_cpu_interconnect/M27_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M28_AXI [get_bd_intf_pins adi_dma_comb_1/S_AXI] [get_bd_intf_pins axi_cpu_interconnect/M28_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M29_AXI [get_bd_intf_pins adi_dma_split_1/S_AXI] [get_bd_intf_pins axi_cpu_interconnect/M29_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_m00_axi [get_bd_intf_pins axi_cpu_interconnect/M00_AXI] [get_bd_intf_pins axi_gpio/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_m02_axi [get_bd_intf_pins axi_ad9361_0/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M02_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_m03_axi [get_bd_intf_pins adi2axis_0/S_AXI] [get_bd_intf_pins axi_cpu_interconnect/M03_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_m04_axi [get_bd_intf_pins axi_cpu_interconnect/M04_AXI] [get_bd_intf_pins axi_dma_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_m05_axi [get_bd_intf_pins axi_cpu_interconnect/M05_AXI] [get_bd_intf_pins axis_vita49_unpack_0/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_m07_axi [get_bd_intf_pins axi_cpu_interconnect/M07_AXI] [get_bd_intf_pins axis_vita49_pack_0/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_m08_axi [get_bd_intf_pins axi_cpu_interconnect/M08_AXI] [get_bd_intf_pins vita49_trig_adc_0/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_m09_axi [get_bd_intf_pins axi_ad9361_1/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M09_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_m10_axi [get_bd_intf_pins adi2axis_1/S_AXI] [get_bd_intf_pins axi_cpu_interconnect/M10_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_m11_axi [get_bd_intf_pins axi_cpu_interconnect/M11_AXI] [get_bd_intf_pins axi_dma_1/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_m12_axi [get_bd_intf_pins axi_cpu_interconnect/M12_AXI] [get_bd_intf_pins axis_vita49_unpack_1/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_m13_axi [get_bd_intf_pins axi_cpu_interconnect/M13_AXI] [get_bd_intf_pins vita49_trig_dac_1/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_m14_axi [get_bd_intf_pins axi_cpu_interconnect/M14_AXI] [get_bd_intf_pins axis_vita49_pack_1/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_s00_axi [get_bd_intf_pins axi_cpu_interconnect/S00_AXI] [get_bd_intf_pins sys_ps7/M_AXI_GP0]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXIS_MM2S [get_bd_intf_pins adi_dma_split_0/S_AXIS] [get_bd_intf_pins axi_dma_0/M_AXIS_MM2S]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_MM2S [get_bd_intf_pins axi_ad9361_0_dac_dma_interconnect/S00_AXI] [get_bd_intf_pins axi_dma_0/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_S2MM [get_bd_intf_pins axi_ad9361_0_adc_dma_interconnect/S00_AXI] [get_bd_intf_pins axi_dma_0/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_SG [get_bd_intf_pins axi_dma_0/M_AXI_SG] [get_bd_intf_pins axi_sg_interconnect/S00_AXI]
  connect_bd_intf_net -intf_net axi_dma_1_M_AXIS_MM2S [get_bd_intf_pins adi_dma_split_1/S_AXIS] [get_bd_intf_pins axi_dma_1/M_AXIS_MM2S]
  connect_bd_intf_net -intf_net axi_dma_1_M_AXI_MM2S [get_bd_intf_pins axi_ad9361_1_dac_dma_interconnect/S00_AXI] [get_bd_intf_pins axi_dma_1/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_dma_1_M_AXI_S2MM [get_bd_intf_pins axi_ad9361_1_adc_dma_interconnect/S00_AXI] [get_bd_intf_pins axi_dma_1/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axi_dma_1_M_AXI_SG [get_bd_intf_pins axi_dma_1/M_AXI_SG] [get_bd_intf_pins axi_sg_interconnect/S01_AXI]
  connect_bd_intf_net -intf_net axi_dma_2_M_AXI_MM2S [get_bd_intf_pins axi_ad9361_1_dac_dma_interconnect/S01_AXI] [get_bd_intf_pins srio_dma/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_dma_2_M_AXI_S2MM [get_bd_intf_pins axi_ad9361_1_adc_dma_interconnect/S01_AXI] [get_bd_intf_pins srio_dma/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axi_dma_2_M_AXI_SG [get_bd_intf_pins axi_sg_interconnect/S02_AXI] [get_bd_intf_pins srio_dma/M_AXI_SG]
  connect_bd_intf_net -intf_net axi_sg_interconnect_M00_AXI [get_bd_intf_pins axi_sg_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_GP0]
  connect_bd_intf_net -intf_net axi_srio_initiator_fifo_AXI_STR_TXD [get_bd_intf_pins axi_srio_initiator_fifo/AXI_STR_TXD] [get_bd_intf_pins axis_32to64_srio_init/S_AXIS]
  connect_bd_intf_net -intf_net axi_srio_interconnect_M00_AXI [get_bd_intf_pins axi_srio_initiator_fifo/S_AXI] [get_bd_intf_pins axi_srio_interconnect/M00_AXI]
  connect_bd_intf_net -intf_net axi_srio_interconnect_M02_AXI [get_bd_intf_pins axi_srio_interconnect/M02_AXI] [get_bd_intf_pins axi_srio_target_fifo/S_AXI]
  connect_bd_intf_net -intf_net axi_srio_interconnect_M04_AXI [get_bd_intf_pins axi_srio_interconnect/M04_AXI] [get_bd_intf_pins srio_maint_reg/S_AXI]
  connect_bd_intf_net -intf_net axi_srio_interconnect_M07_AXI [get_bd_intf_pins axi_srio_interconnect/M07_AXI] [get_bd_intf_pins drp_bridge_0/S_AXI]
  connect_bd_intf_net -intf_net axi_srio_target_fifo_AXI_STR_TXD [get_bd_intf_pins axi_srio_target_fifo/AXI_STR_TXD] [get_bd_intf_pins axis_32to64_srio_target/S_AXIS]
  connect_bd_intf_net -intf_net axis_32to64_adc_0_M_AXIS [get_bd_intf_pins adc_fifo_0/S_AXIS] [get_bd_intf_pins axis_32to64_adc_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_32to64_adc_1_M_AXIS [get_bd_intf_pins adc_fifo_1/S_AXIS] [get_bd_intf_pins axis_32to64_adc_1/M_AXIS]
  connect_bd_intf_net -intf_net axis_32to64_dac_0_M_AXIS [get_bd_intf_pins axis_32to64_dac_0/M_AXIS] [get_bd_intf_pins axis_dac_interconnect_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_32to64_dac_1_M_AXIS [get_bd_intf_pins axis_32to64_dac_1/M_AXIS] [get_bd_intf_pins axis_dac_interconnect_1/S00_AXIS]
  connect_bd_intf_net -intf_net axis_32to64_strb_0_M_AXIS [get_bd_intf_pins axis_32to64_srio_init/M_AXIS] [get_bd_intf_pins srio_ireq_sw/S00_AXIS]
  connect_bd_intf_net -intf_net axis_32to64_strb_0_M_AXIS1 [get_bd_intf_pins axis_32to64_srio_target/M_AXIS] [get_bd_intf_pins srio_tresp_intc/S00_AXIS]
  connect_bd_intf_net -intf_net axis_64to32_adc_0_M_AXIS [get_bd_intf_pins axis_64to32_adc_0/M_AXIS] [get_bd_intf_pins vita49_trig_adc_0/S_AXIS]
  connect_bd_intf_net -intf_net axis_64to32_adc_1_M_AXIS [get_bd_intf_pins axis_64to32_adc_1/M_AXIS] [get_bd_intf_pins vita49_trig_adc_1/S_AXIS]
  connect_bd_intf_net -intf_net axis_64to32_dac_0_M_AXIS [get_bd_intf_pins axis_64to32_dac_0/M_AXIS] [get_bd_intf_pins vita_unpack_dac_reg_0/S_AXIS]
  connect_bd_intf_net -intf_net axis_64to32_dac_1_M_AXIS [get_bd_intf_pins axis_64to32_dac_1/M_AXIS] [get_bd_intf_pins vita_unpack_dac_reg_1/S_AXIS]
  connect_bd_intf_net -intf_net axis_64to32_strb_0_M_AXIS [get_bd_intf_pins axi_srio_initiator_fifo/AXI_STR_RXD] [get_bd_intf_pins axis_64to32_srio_init/M_AXIS]
  connect_bd_intf_net -intf_net axis_64to32_strb_0_M_AXIS1 [get_bd_intf_pins axi_srio_target_fifo/AXI_STR_RXD] [get_bd_intf_pins axis_64to32_srio_target/M_AXIS]
  connect_bd_intf_net -intf_net axis_adc_interconnect_0_M00_AXIS [get_bd_intf_pins axis_64to32_adc_0/S_AXIS] [get_bd_intf_pins axis_adc_interconnect_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_adc_interconnect_1_M00_AXIS [get_bd_intf_pins axis_64to32_adc_1/S_AXIS] [get_bd_intf_pins axis_adc_interconnect_1/M00_AXIS]
  connect_bd_intf_net -intf_net axis_dac_interconnect_0_M00_AXIS [get_bd_intf_pins axis2adi_0/S_AXIS] [get_bd_intf_pins axis_dac_interconnect_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_dac_interconnect_1_M00_AXIS [get_bd_intf_pins axis2adi_1/S_AXIS] [get_bd_intf_pins axis_dac_interconnect_1/M00_AXIS]
  connect_bd_intf_net -intf_net axis_register_slice_0_M_AXIS [get_bd_intf_pins srio_dma_reg_0_delete/M_AXIS] [get_bd_intf_pins srio_ireq_sw/S03_AXIS]
  connect_bd_intf_net -intf_net axis_vita49_pack_0_M_AXIS [get_bd_intf_pins axis_32to64_adc_0/S_AXIS] [get_bd_intf_pins axis_vita49_pack_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_vita49_pack_1_M_AXIS [get_bd_intf_pins axis_32to64_adc_1/S_AXIS] [get_bd_intf_pins axis_vita49_pack_1/M_AXIS]
  connect_bd_intf_net -intf_net axis_vita49_unpack_0_M_AXIS [get_bd_intf_pins axis_vita49_unpack_0/M_AXIS] [get_bd_intf_pins vita_trig_dac_reg_0/S_AXIS]
  connect_bd_intf_net -intf_net axis_vita49_unpack_1_M_AXIS [get_bd_intf_pins axis_vita49_unpack_1/M_AXIS] [get_bd_intf_pins vita_trig_dac_reg_1/S_AXIS]
  connect_bd_intf_net -intf_net dac_ddr_sw_0_M00_AXIS [get_bd_intf_pins dac_ddr_sw_0/M00_AXIS] [get_bd_intf_pins dac_ddr_sw_0_reg/S_AXIS]
  connect_bd_intf_net -intf_net dac_ddr_sw_0_M01_AXIS [get_bd_intf_pins adc_ddr_sw_0/S01_AXIS] [get_bd_intf_pins dac_ddr_sw_0/M01_AXIS]
  connect_bd_intf_net -intf_net dac_ddr_sw_0_reg_M_AXIS [get_bd_intf_pins axis_64to32_dac_0/S_AXIS] [get_bd_intf_pins dac_ddr_sw_0_reg/M_AXIS]
  connect_bd_intf_net -intf_net dac_ddr_sw_1_M00_AXIS [get_bd_intf_pins axis_64to32_dac_1/S_AXIS] [get_bd_intf_pins dac_ddr_sw_1/M00_AXIS]
  connect_bd_intf_net -intf_net dac_ddr_sw_1_M01_AXIS [get_bd_intf_pins adc_ddr_sw_1/S01_AXIS] [get_bd_intf_pins dac_ddr_sw_1/M01_AXIS]
  connect_bd_intf_net -intf_net dac_fifo_0_M_AXIS [get_bd_intf_pins dac_ddr_sw_0/S01_AXIS] [get_bd_intf_pins dac_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net dac_fifo_1_M_AXIS [get_bd_intf_pins dac_ddr_sw_1/S01_AXIS] [get_bd_intf_pins dac_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net ddr_fifo_M_AXIS [get_bd_intf_pins ddr_fifo/M_AXIS] [get_bd_intf_pins vita_dac_sw/S00_AXIS]
  connect_bd_intf_net -intf_net hello_router_0_M_AXIS [get_bd_intf_pins hello_router_0/M_AXIS] [get_bd_intf_pins srio_treq_sw/S00_AXIS]
  connect_bd_intf_net -intf_net srio_dma_M_AXIS_MM2S [get_bd_intf_pins srio_dma/M_AXIS_MM2S] [get_bd_intf_pins srio_dma_split_0/S_AXIS]
  connect_bd_intf_net -intf_net srio_dma_comb_0_M_AXIS [get_bd_intf_pins srio_dma/S_AXIS_S2MM] [get_bd_intf_pins srio_dma_comb_0/M_AXIS]
  connect_bd_intf_net -intf_net srio_dma_split_0_M_AXIS [get_bd_intf_pins srio_dma_reg_0_delete/S_AXIS] [get_bd_intf_pins srio_dma_split_0/M_AXIS]
  connect_bd_intf_net -intf_net srio_gen2_0_INITIATOR_RESP [get_bd_intf_pins srio_gen2_0/INITIATOR_RESP] [get_bd_intf_pins srio_iresp_intc/S00_AXIS]
  connect_bd_intf_net -intf_net srio_gen2_0_TARGET_REQ [get_bd_intf_pins srio_gen2_0/TARGET_REQ] [get_bd_intf_pins srio_treq_intc/S00_AXIS]
  connect_bd_intf_net -intf_net srio_ireq_intc_M00_AXIS [get_bd_intf_pins srio_gen2_0/INITIATOR_REQ] [get_bd_intf_pins srio_ireq_intc/M00_AXIS]
  connect_bd_intf_net -intf_net srio_ireq_sw_M00_AXIS [get_bd_intf_pins srio_ireq_intc/S00_AXIS] [get_bd_intf_pins srio_ireq_sw/M00_AXIS]
  connect_bd_intf_net -intf_net srio_iresp_intc_M00_AXIS [get_bd_intf_pins axis_64to32_srio_init/S_AXIS] [get_bd_intf_pins srio_iresp_intc/M00_AXIS]
  connect_bd_intf_net -intf_net srio_maint_reg_M_AXI [get_bd_intf_pins srio_gen2_0/MAINT_IF] [get_bd_intf_pins srio_maint_reg/M_AXI]
  connect_bd_intf_net -intf_net srio_swrite_pack_0_M_AXIS [get_bd_intf_pins srio_ireq_sw/S01_AXIS] [get_bd_intf_pins srio_swrite_pack_0/M_AXIS]
  connect_bd_intf_net -intf_net srio_swrite_pack_1_M_AXIS [get_bd_intf_pins srio_ireq_sw/S02_AXIS] [get_bd_intf_pins srio_swrite_pack_1/M_AXIS]
  connect_bd_intf_net -intf_net srio_swrite_unpack_0_M_AXIS [get_bd_intf_pins ddr_fifo/S_AXIS] [get_bd_intf_pins srio_swrite_unpack_0/M_AXIS]
  connect_bd_intf_net -intf_net srio_swrite_unpack_reg_M_AXIS [get_bd_intf_pins srio_swrite_unpack_0/S_AXIS] [get_bd_intf_pins srio_swrite_unpack_reg/M_AXIS]
  connect_bd_intf_net -intf_net srio_target_reg_M_AXIS [get_bd_intf_pins axis_64to32_srio_target/S_AXIS] [get_bd_intf_pins srio_target_reg/M_AXIS]
  connect_bd_intf_net -intf_net srio_treq_intc_M00_AXIS [get_bd_intf_pins hello_router_0/S_AXIS] [get_bd_intf_pins srio_treq_intc/M00_AXIS]
  connect_bd_intf_net -intf_net srio_treq_sw_M00_AXIS [get_bd_intf_pins srio_target_reg/S_AXIS] [get_bd_intf_pins srio_treq_sw/M00_AXIS]
  connect_bd_intf_net -intf_net srio_treq_sw_M01_AXIS [get_bd_intf_pins srio_swrite_unpack_reg/S_AXIS] [get_bd_intf_pins srio_treq_sw/M01_AXIS]
  connect_bd_intf_net -intf_net srio_treq_sw_M02_AXIS [get_bd_intf_pins srio_dma_comb_0/S_AXIS] [get_bd_intf_pins srio_treq_sw/M02_AXIS]
  connect_bd_intf_net -intf_net srio_tresp_intc_M00_AXIS [get_bd_intf_pins srio_gen2_0/TARGET_RESP] [get_bd_intf_pins srio_tresp_intc/M00_AXIS]
  connect_bd_intf_net -intf_net sys_ps7_M_AXI_GP1 [get_bd_intf_pins axi_srio_interconnect/S00_AXI] [get_bd_intf_pins sys_ps7/M_AXI_GP1]
  connect_bd_intf_net -intf_net sys_ps7_ddr [get_bd_intf_ports DDR] [get_bd_intf_pins sys_ps7/DDR]
  connect_bd_intf_net -intf_net sys_ps7_fixed_io [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins sys_ps7/FIXED_IO]
  connect_bd_intf_net -intf_net vita49_assem_0_M_AXIS [get_bd_intf_pins dac_fifo_0/S_AXIS] [get_bd_intf_pins vita49_assem_0/M_AXIS]
  connect_bd_intf_net -intf_net vita49_assem_1_M_AXIS [get_bd_intf_pins dac_fifo_1/S_AXIS] [get_bd_intf_pins vita49_assem_1/M_AXIS]
  connect_bd_intf_net -intf_net vita49_trig_adc_0_M_AXIS [get_bd_intf_pins vita49_trig_adc_0/M_AXIS] [get_bd_intf_pins vita_pack_adc_reg_0/S_AXIS]
  connect_bd_intf_net -intf_net vita49_trig_adc_1_M_AXIS [get_bd_intf_pins vita49_trig_adc_1/M_AXIS] [get_bd_intf_pins vita_pack_adc_reg_1/S_AXIS]
  connect_bd_intf_net -intf_net vita49_trig_dac_0_M_AXIS [get_bd_intf_pins axis_32to64_dac_0/S_AXIS] [get_bd_intf_pins vita49_trig_dac_0/M_AXIS]
  connect_bd_intf_net -intf_net vita49_trig_dac_1_M_AXIS [get_bd_intf_pins axis_32to64_dac_1/S_AXIS] [get_bd_intf_pins vita49_trig_dac_1/M_AXIS]
  connect_bd_intf_net -intf_net vita_dac_sw_M00_AXIS [get_bd_intf_pins vita49_assem_0/S_AXIS] [get_bd_intf_pins vita_dac_sw/M00_AXIS]
  connect_bd_intf_net -intf_net vita_dac_sw_M01_AXIS [get_bd_intf_pins vita49_assem_1/S_AXIS] [get_bd_intf_pins vita_dac_sw/M01_AXIS]
  connect_bd_intf_net -intf_net vita_pack_adc_reg_0_M_AXIS [get_bd_intf_pins axis_vita49_pack_0/S_AXIS] [get_bd_intf_pins vita_pack_adc_reg_0/M_AXIS]
  connect_bd_intf_net -intf_net vita_pack_adc_reg_1_M_AXIS [get_bd_intf_pins axis_vita49_pack_1/S_AXIS] [get_bd_intf_pins vita_pack_adc_reg_1/M_AXIS]
  connect_bd_intf_net -intf_net vita_trig_dac_reg_0_M_AXIS [get_bd_intf_pins vita49_trig_dac_0/S_AXIS] [get_bd_intf_pins vita_trig_dac_reg_0/M_AXIS]
  connect_bd_intf_net -intf_net vita_trig_dac_reg_1_M_AXIS [get_bd_intf_pins vita49_trig_dac_1/S_AXIS] [get_bd_intf_pins vita_trig_dac_reg_1/M_AXIS]
  connect_bd_intf_net -intf_net vita_unpack_dac_reg_0_M_AXIS [get_bd_intf_pins axis_vita49_unpack_0/S_AXIS] [get_bd_intf_pins vita_unpack_dac_reg_0/M_AXIS]
  connect_bd_intf_net -intf_net vita_unpack_dac_reg_1_M_AXIS [get_bd_intf_pins axis_vita49_unpack_1/S_AXIS] [get_bd_intf_pins vita_unpack_dac_reg_1/M_AXIS]

  # Create port connections
  connect_bd_net -net adc_ddr_tdest_0_dout [get_bd_pins adc_ddr_sw_0/s_axis_tdest] [get_bd_pins adc_ddr_tdest_0/dout]
  connect_bd_net -net adc_ddr_tdest_1_dout [get_bd_pins adc_ddr_sw_1/s_axis_tdest] [get_bd_pins adc_ddr_tdest_1/dout]
  connect_bd_net -net axi_ad9361_0_adc_chan_i1 [get_bd_pins axi_ad9361_0/adc_data_i0] [get_bd_pins util_adc_pack_0/chan_data_0]
  connect_bd_net -net axi_ad9361_0_adc_chan_i2 [get_bd_pins axi_ad9361_0/adc_data_i1] [get_bd_pins util_adc_pack_0/chan_data_2]
  connect_bd_net -net axi_ad9361_0_adc_chan_q1 [get_bd_pins axi_ad9361_0/adc_data_q0] [get_bd_pins util_adc_pack_0/chan_data_1]
  connect_bd_net -net axi_ad9361_0_adc_chan_q2 [get_bd_pins axi_ad9361_0/adc_data_q1] [get_bd_pins util_adc_pack_0/chan_data_3]
  connect_bd_net -net axi_ad9361_0_adc_enable_0 [get_bd_pins axi_ad9361_0/adc_enable_i0] [get_bd_pins util_adc_pack_0/chan_enable_0]
  connect_bd_net -net axi_ad9361_0_adc_enable_1 [get_bd_pins axi_ad9361_0/adc_enable_q0] [get_bd_pins util_adc_pack_0/chan_enable_1]
  connect_bd_net -net axi_ad9361_0_adc_enable_2 [get_bd_pins axi_ad9361_0/adc_enable_i1] [get_bd_pins util_adc_pack_0/chan_enable_2]
  connect_bd_net -net axi_ad9361_0_adc_enable_3 [get_bd_pins axi_ad9361_0/adc_enable_q1] [get_bd_pins util_adc_pack_0/chan_enable_3]
  connect_bd_net -net axi_ad9361_0_adc_valid_0 [get_bd_pins axi_ad9361_0/adc_valid_i0] [get_bd_pins util_adc_pack_0/chan_valid_0]
  connect_bd_net -net axi_ad9361_0_adc_valid_1 [get_bd_pins axi_ad9361_0/adc_valid_q0] [get_bd_pins util_adc_pack_0/chan_valid_1]
  connect_bd_net -net axi_ad9361_0_adc_valid_2 [get_bd_pins axi_ad9361_0/adc_valid_i1] [get_bd_pins util_adc_pack_0/chan_valid_2]
  connect_bd_net -net axi_ad9361_0_adc_valid_3 [get_bd_pins axi_ad9361_0/adc_valid_q1] [get_bd_pins util_adc_pack_0/chan_valid_3]
  connect_bd_net -net axi_ad9361_0_clk [get_bd_pins adi2axis_0/AXIS_ACLK] [get_bd_pins axi_ad9361_0/clk] [get_bd_pins axi_ad9361_0/l_clk] [get_bd_pins axis2adi_0/AXIS_ACLK] [get_bd_pins axis_adc_interconnect_0/ACLK] [get_bd_pins axis_adc_interconnect_0/S00_AXIS_ACLK] [get_bd_pins axis_dac_interconnect_0/M00_AXIS_ACLK] [get_bd_pins util_adc_pack_0/clk] [get_bd_pins util_dac_unpack_0/clk] [get_bd_pins vita49_clk/samp_clk_0]
  connect_bd_net -net axi_ad9361_0_dac_data_0 [get_bd_pins axi_ad9361_0/dac_data_i0] [get_bd_pins util_dac_unpack_0/dac_data_00]
  connect_bd_net -net axi_ad9361_0_dac_data_1 [get_bd_pins axi_ad9361_0/dac_data_q0] [get_bd_pins util_dac_unpack_0/dac_data_01]
  connect_bd_net -net axi_ad9361_0_dac_data_2 [get_bd_pins axi_ad9361_0/dac_data_i1] [get_bd_pins util_dac_unpack_0/dac_data_02]
  connect_bd_net -net axi_ad9361_0_dac_data_3 [get_bd_pins axi_ad9361_0/dac_data_q1] [get_bd_pins util_dac_unpack_0/dac_data_03]
  connect_bd_net -net axi_ad9361_0_dac_drd [get_bd_pins axis2adi_0/dma_rd] [get_bd_pins util_dac_unpack_0/dma_rd]
  connect_bd_net -net axi_ad9361_0_dac_dunf [get_bd_pins axi_ad9361_0/dac_dunf] [get_bd_pins axis2adi_0/dma_unf]
  connect_bd_net -net axi_ad9361_0_dac_enable_0 [get_bd_pins axi_ad9361_0/dac_enable_i0] [get_bd_pins util_dac_unpack_0/dac_enable_00]
  connect_bd_net -net axi_ad9361_0_dac_enable_1 [get_bd_pins axi_ad9361_0/dac_enable_q0] [get_bd_pins util_dac_unpack_0/dac_enable_01]
  connect_bd_net -net axi_ad9361_0_dac_enable_2 [get_bd_pins axi_ad9361_0/dac_enable_i1] [get_bd_pins util_dac_unpack_0/dac_enable_02]
  connect_bd_net -net axi_ad9361_0_dac_enable_3 [get_bd_pins axi_ad9361_0/dac_enable_q1] [get_bd_pins util_dac_unpack_0/dac_enable_03]
  connect_bd_net -net axi_ad9361_0_dac_valid_0 [get_bd_pins axi_ad9361_0/dac_valid_i0] [get_bd_pins util_dac_unpack_0/dac_valid_00]
  connect_bd_net -net axi_ad9361_0_dac_valid_1 [get_bd_pins axi_ad9361_0/dac_valid_q0] [get_bd_pins util_dac_unpack_0/dac_valid_01]
  connect_bd_net -net axi_ad9361_0_dac_valid_2 [get_bd_pins axi_ad9361_0/dac_valid_i1] [get_bd_pins util_dac_unpack_0/dac_valid_02]
  connect_bd_net -net axi_ad9361_0_dac_valid_3 [get_bd_pins axi_ad9361_0/dac_valid_q1] [get_bd_pins util_dac_unpack_0/dac_valid_03]
  connect_bd_net -net axi_ad9361_0_rx_clk_in_n [get_bd_ports rx_clk_in_0_n] [get_bd_pins axi_ad9361_0/rx_clk_in_n]
  connect_bd_net -net axi_ad9361_0_rx_clk_in_p [get_bd_ports rx_clk_in_0_p] [get_bd_pins axi_ad9361_0/rx_clk_in_p]
  connect_bd_net -net axi_ad9361_0_rx_data_in_n [get_bd_ports rx_data_in_0_n] [get_bd_pins axi_ad9361_0/rx_data_in_n]
  connect_bd_net -net axi_ad9361_0_rx_data_in_p [get_bd_ports rx_data_in_0_p] [get_bd_pins axi_ad9361_0/rx_data_in_p]
  connect_bd_net -net axi_ad9361_0_rx_frame_in_n [get_bd_ports rx_frame_in_0_n] [get_bd_pins axi_ad9361_0/rx_frame_in_n]
  connect_bd_net -net axi_ad9361_0_rx_frame_in_p [get_bd_ports rx_frame_in_0_p] [get_bd_pins axi_ad9361_0/rx_frame_in_p]
  connect_bd_net -net axi_ad9361_0_tx_clk_out_n [get_bd_ports tx_clk_out_0_n] [get_bd_pins axi_ad9361_0/tx_clk_out_n]
  connect_bd_net -net axi_ad9361_0_tx_clk_out_p [get_bd_ports tx_clk_out_0_p] [get_bd_pins axi_ad9361_0/tx_clk_out_p]
  connect_bd_net -net axi_ad9361_0_tx_data_out_n [get_bd_ports tx_data_out_0_n] [get_bd_pins axi_ad9361_0/tx_data_out_n]
  connect_bd_net -net axi_ad9361_0_tx_data_out_p [get_bd_ports tx_data_out_0_p] [get_bd_pins axi_ad9361_0/tx_data_out_p]
  connect_bd_net -net axi_ad9361_0_tx_frame_out_n [get_bd_ports tx_frame_out_0_n] [get_bd_pins axi_ad9361_0/tx_frame_out_n]
  connect_bd_net -net axi_ad9361_0_tx_frame_out_p [get_bd_ports tx_frame_out_0_p] [get_bd_pins axi_ad9361_0/tx_frame_out_p]
  connect_bd_net -net axi_ad9361_1_adc_chan_i1 [get_bd_pins axi_ad9361_1/adc_data_i0] [get_bd_pins util_adc_pack_1/chan_data_0]
  connect_bd_net -net axi_ad9361_1_adc_chan_i2 [get_bd_pins axi_ad9361_1/adc_data_i1] [get_bd_pins util_adc_pack_1/chan_data_2]
  connect_bd_net -net axi_ad9361_1_adc_chan_q1 [get_bd_pins axi_ad9361_1/adc_data_q0] [get_bd_pins util_adc_pack_1/chan_data_1]
  connect_bd_net -net axi_ad9361_1_adc_chan_q2 [get_bd_pins axi_ad9361_1/adc_data_q1] [get_bd_pins util_adc_pack_1/chan_data_3]
  connect_bd_net -net axi_ad9361_1_adc_enable_0 [get_bd_pins axi_ad9361_1/adc_enable_i0] [get_bd_pins util_adc_pack_1/chan_enable_0]
  connect_bd_net -net axi_ad9361_1_adc_enable_1 [get_bd_pins axi_ad9361_1/adc_enable_q0] [get_bd_pins util_adc_pack_1/chan_enable_1]
  connect_bd_net -net axi_ad9361_1_adc_enable_2 [get_bd_pins axi_ad9361_1/adc_enable_i1] [get_bd_pins util_adc_pack_1/chan_enable_2]
  connect_bd_net -net axi_ad9361_1_adc_enable_3 [get_bd_pins axi_ad9361_1/adc_enable_q1] [get_bd_pins util_adc_pack_1/chan_enable_3]
  connect_bd_net -net axi_ad9361_1_adc_valid_0 [get_bd_pins axi_ad9361_1/adc_valid_i0] [get_bd_pins util_adc_pack_1/chan_valid_0]
  connect_bd_net -net axi_ad9361_1_adc_valid_1 [get_bd_pins axi_ad9361_1/adc_valid_q0] [get_bd_pins util_adc_pack_1/chan_valid_1]
  connect_bd_net -net axi_ad9361_1_adc_valid_2 [get_bd_pins axi_ad9361_1/adc_valid_i1] [get_bd_pins util_adc_pack_1/chan_valid_2]
  connect_bd_net -net axi_ad9361_1_adc_valid_3 [get_bd_pins axi_ad9361_1/adc_valid_q1] [get_bd_pins util_adc_pack_1/chan_valid_3]
  connect_bd_net -net axi_ad9361_1_clk [get_bd_pins adi2axis_1/AXIS_ACLK] [get_bd_pins axi_ad9361_1/clk] [get_bd_pins axi_ad9361_1/l_clk] [get_bd_pins axis2adi_1/AXIS_ACLK] [get_bd_pins axis_adc_interconnect_1/ACLK] [get_bd_pins axis_adc_interconnect_1/S00_AXIS_ACLK] [get_bd_pins axis_dac_interconnect_1/M00_AXIS_ACLK] [get_bd_pins util_adc_pack_1/clk] [get_bd_pins util_dac_unpack_1/clk] [get_bd_pins vita49_clk/samp_clk_1]
  connect_bd_net -net axi_ad9361_1_dac_data_0 [get_bd_pins axi_ad9361_1/dac_data_i0] [get_bd_pins util_dac_unpack_1/dac_data_00]
  connect_bd_net -net axi_ad9361_1_dac_data_1 [get_bd_pins axi_ad9361_1/dac_data_q0] [get_bd_pins util_dac_unpack_1/dac_data_01]
  connect_bd_net -net axi_ad9361_1_dac_data_2 [get_bd_pins axi_ad9361_1/dac_data_i1] [get_bd_pins util_dac_unpack_1/dac_data_02]
  connect_bd_net -net axi_ad9361_1_dac_data_3 [get_bd_pins axi_ad9361_1/dac_data_q1] [get_bd_pins util_dac_unpack_1/dac_data_03]
  connect_bd_net -net axi_ad9361_1_dac_drd [get_bd_pins axis2adi_1/dma_rd] [get_bd_pins util_dac_unpack_1/dma_rd]
  connect_bd_net -net axi_ad9361_1_dac_dunf [get_bd_pins axi_ad9361_1/dac_dunf] [get_bd_pins axis2adi_1/dma_unf]
  connect_bd_net -net axi_ad9361_1_dac_enable_0 [get_bd_pins axi_ad9361_1/dac_enable_i0] [get_bd_pins util_dac_unpack_1/dac_enable_00]
  connect_bd_net -net axi_ad9361_1_dac_enable_1 [get_bd_pins axi_ad9361_1/dac_enable_q0] [get_bd_pins util_dac_unpack_1/dac_enable_01]
  connect_bd_net -net axi_ad9361_1_dac_enable_2 [get_bd_pins axi_ad9361_1/dac_enable_i1] [get_bd_pins util_dac_unpack_1/dac_enable_02]
  connect_bd_net -net axi_ad9361_1_dac_enable_3 [get_bd_pins axi_ad9361_1/dac_enable_q1] [get_bd_pins util_dac_unpack_1/dac_enable_03]
  connect_bd_net -net axi_ad9361_1_dac_valid_0 [get_bd_pins axi_ad9361_1/dac_valid_i0] [get_bd_pins util_dac_unpack_1/dac_valid_00]
  connect_bd_net -net axi_ad9361_1_dac_valid_1 [get_bd_pins axi_ad9361_1/dac_valid_q0] [get_bd_pins util_dac_unpack_1/dac_valid_01]
  connect_bd_net -net axi_ad9361_1_dac_valid_2 [get_bd_pins axi_ad9361_1/dac_valid_i1] [get_bd_pins util_dac_unpack_1/dac_valid_02]
  connect_bd_net -net axi_ad9361_1_dac_valid_3 [get_bd_pins axi_ad9361_1/dac_valid_q1] [get_bd_pins util_dac_unpack_1/dac_valid_03]
  connect_bd_net -net axi_ad9361_1_rx_clk_in_n [get_bd_ports rx_clk_in_1_n] [get_bd_pins axi_ad9361_1/rx_clk_in_n]
  connect_bd_net -net axi_ad9361_1_rx_clk_in_p [get_bd_ports rx_clk_in_1_p] [get_bd_pins axi_ad9361_1/rx_clk_in_p]
  connect_bd_net -net axi_ad9361_1_rx_data_in_n [get_bd_ports rx_data_in_1_n] [get_bd_pins axi_ad9361_1/rx_data_in_n]
  connect_bd_net -net axi_ad9361_1_rx_data_in_p [get_bd_ports rx_data_in_1_p] [get_bd_pins axi_ad9361_1/rx_data_in_p]
  connect_bd_net -net axi_ad9361_1_rx_frame_in_n [get_bd_ports rx_frame_in_1_n] [get_bd_pins axi_ad9361_1/rx_frame_in_n]
  connect_bd_net -net axi_ad9361_1_rx_frame_in_p [get_bd_ports rx_frame_in_1_p] [get_bd_pins axi_ad9361_1/rx_frame_in_p]
  connect_bd_net -net axi_ad9361_1_tx_clk_out_n [get_bd_ports tx_clk_out_1_n] [get_bd_pins axi_ad9361_1/tx_clk_out_n]
  connect_bd_net -net axi_ad9361_1_tx_clk_out_p [get_bd_ports tx_clk_out_1_p] [get_bd_pins axi_ad9361_1/tx_clk_out_p]
  connect_bd_net -net axi_ad9361_1_tx_data_out_n [get_bd_ports tx_data_out_1_n] [get_bd_pins axi_ad9361_1/tx_data_out_n]
  connect_bd_net -net axi_ad9361_1_tx_data_out_p [get_bd_ports tx_data_out_1_p] [get_bd_pins axi_ad9361_1/tx_data_out_p]
  connect_bd_net -net axi_ad9361_1_tx_frame_out_n [get_bd_ports tx_frame_out_1_n] [get_bd_pins axi_ad9361_1/tx_frame_out_n]
  connect_bd_net -net axi_ad9361_1_tx_frame_out_p [get_bd_ports tx_frame_out_1_p] [get_bd_pins axi_ad9361_1/tx_frame_out_p]
  connect_bd_net -net axi_dma_0_mm2s_introut [get_bd_pins axi_dma_0/mm2s_introut] [get_bd_pins sys_concat_intc/In14]
  connect_bd_net -net axi_dma_0_s2mm_introut [get_bd_pins axi_dma_0/s2mm_introut] [get_bd_pins sys_concat_intc/In15]
  connect_bd_net -net axi_dma_1_mm2s_introut [get_bd_pins axi_dma_1/mm2s_introut] [get_bd_pins sys_concat_intc/In12]
  connect_bd_net -net axi_dma_1_s2mm_introut [get_bd_pins axi_dma_1/s2mm_introut] [get_bd_pins sys_concat_intc/In13]
  connect_bd_net -net axi_gpio_1 [get_bd_ports axi_gpio] [get_bd_pins axi_gpio/gpio_io_i]
  connect_bd_net -net axi_gpio_irq [get_bd_pins axi_gpio/ip2intc_irpt] [get_bd_pins sys_concat_intc/In10]
  connect_bd_net -net axi_srio_initiator_fifo_interrupt [get_bd_pins axi_srio_initiator_fifo/interrupt] [get_bd_pins sys_concat_intc/In8]
  connect_bd_net -net axi_srio_target_fifo_interrupt [get_bd_pins axi_srio_target_fifo/interrupt] [get_bd_pins sys_concat_intc/In9]
  connect_bd_net -net axis_vita49_unpack_0_irq [get_bd_pins axis_vita49_unpack_0/irq] [get_bd_pins sys_concat_intc/In6]
  connect_bd_net -net axis_vita49_unpack_1_irq [get_bd_pins axis_vita49_unpack_1/irq] [get_bd_pins sys_concat_intc/In7]
  connect_bd_net -net c_counter_binary_0_Q [get_bd_pins c_counter_binary_0/Q] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net const_1_dout [get_bd_pins axis_64to32_srio_init/S_AXIS_TSTRB] [get_bd_pins axis_64to32_srio_target/S_AXIS_TSTRB] [get_bd_pins const_1/dout]
  connect_bd_net -net constant_0_dout [get_bd_pins constant_0/dout] [get_bd_pins dac_ddr_tdest_0/In1] [get_bd_pins dac_ddr_tdest_1/In1]
  connect_bd_net -net dac_ddr_tdest_0_dout [get_bd_pins dac_ddr_sw_0/s_axis_tdest] [get_bd_pins dac_ddr_tdest_0/dout]
  connect_bd_net -net dac_ddr_tdest_1_dout [get_bd_pins dac_ddr_sw_1/s_axis_tdest] [get_bd_pins dac_ddr_tdest_1/dout]
  connect_bd_net -net drp_bridge_0_drp0_addr [get_bd_pins drp_bridge_0/drp0_addr] [get_bd_pins drpaddr_concat/In0]
  connect_bd_net -net drp_bridge_0_drp0_di [get_bd_pins drp_bridge_0/drp0_di] [get_bd_pins drpdi_concat/In0]
  connect_bd_net -net drp_bridge_0_drp0_en [get_bd_pins drp_bridge_0/drp0_en] [get_bd_pins drpen_concat/In0]
  connect_bd_net -net drp_bridge_0_drp0_we [get_bd_pins drp_bridge_0/drp0_we] [get_bd_pins drpwe_concat/In0]
  connect_bd_net -net drp_bridge_0_drp1_addr [get_bd_pins drp_bridge_0/drp1_addr] [get_bd_pins drpaddr_concat/In1]
  connect_bd_net -net drp_bridge_0_drp1_di [get_bd_pins drp_bridge_0/drp1_di] [get_bd_pins drpdi_concat/In1]
  connect_bd_net -net drp_bridge_0_drp1_en [get_bd_pins drp_bridge_0/drp1_en] [get_bd_pins drpen_concat/In1]
  connect_bd_net -net drp_bridge_0_drp1_we [get_bd_pins drp_bridge_0/drp1_we] [get_bd_pins drpwe_concat/In1]
  connect_bd_net -net drp_bridge_0_drp2_addr [get_bd_pins drp_bridge_0/drp2_addr] [get_bd_pins drpaddr_concat/In2]
  connect_bd_net -net drp_bridge_0_drp2_di [get_bd_pins drp_bridge_0/drp2_di] [get_bd_pins drpdi_concat/In2]
  connect_bd_net -net drp_bridge_0_drp2_en [get_bd_pins drp_bridge_0/drp2_en] [get_bd_pins drpen_concat/In2]
  connect_bd_net -net drp_bridge_0_drp2_we [get_bd_pins drp_bridge_0/drp2_we] [get_bd_pins drpwe_concat/In2]
  connect_bd_net -net drp_bridge_0_drp3_addr [get_bd_pins drp_bridge_0/drp3_addr] [get_bd_pins drpaddr_concat/In3]
  connect_bd_net -net drp_bridge_0_drp3_di [get_bd_pins drp_bridge_0/drp3_di] [get_bd_pins drpdi_concat/In3]
  connect_bd_net -net drp_bridge_0_drp3_en [get_bd_pins drp_bridge_0/drp3_en] [get_bd_pins drpen_concat/In3]
  connect_bd_net -net drp_bridge_0_drp3_we [get_bd_pins drp_bridge_0/drp3_we] [get_bd_pins drpwe_concat/In3]
  connect_bd_net -net drpaddr_concat_dout [get_bd_pins drpaddr_concat/dout] [get_bd_pins srio_gen2_0/gt_drpaddr_in]
  connect_bd_net -net drpdi_concat_dout [get_bd_pins drpdi_concat/dout] [get_bd_pins srio_gen2_0/gt_drpdi_in]
  connect_bd_net -net drpdo_slice_0_Dout [get_bd_pins drp_bridge_0/drp0_do] [get_bd_pins drpdo_slice_0/Dout]
  connect_bd_net -net drpdo_slice_1_Dout [get_bd_pins drp_bridge_0/drp1_do] [get_bd_pins drpdo_slice_1/Dout]
  connect_bd_net -net drpdo_slice_2_Dout [get_bd_pins drp_bridge_0/drp2_do] [get_bd_pins drpdo_slice_2/Dout]
  connect_bd_net -net drpdo_slice_3_Dout [get_bd_pins drp_bridge_0/drp3_do] [get_bd_pins drpdo_slice_3/Dout]
  connect_bd_net -net drpen_concat_dout [get_bd_pins drpen_concat/dout] [get_bd_pins srio_gen2_0/gt_drpen_in]
  connect_bd_net -net drprdy_slice_0_Dout [get_bd_pins drp_bridge_0/drp0_rdy] [get_bd_pins drprdy_slice_0/Dout]
  connect_bd_net -net drprdy_slice_1_Dout [get_bd_pins drp_bridge_0/drp1_rdy] [get_bd_pins drprdy_slice_1/Dout]
  connect_bd_net -net drprdy_slice_2_Dout [get_bd_pins drp_bridge_0/drp2_rdy] [get_bd_pins drprdy_slice_2/Dout]
  connect_bd_net -net drprdy_slice_3_Dout [get_bd_pins drp_bridge_0/drp3_rdy] [get_bd_pins drprdy_slice_3/Dout]
  connect_bd_net -net drpwe_concat_dout [get_bd_pins drpwe_concat/dout] [get_bd_pins srio_gen2_0/gt_drpwe_in]
  connect_bd_net -net fifo_data_0 [get_bd_pins axis2adi_0/dma_data] [get_bd_pins util_dac_unpack_0/dma_data]
  connect_bd_net -net fifo_data_1 [get_bd_pins axis2adi_1/dma_data] [get_bd_pins util_dac_unpack_1/dma_data]
  connect_bd_net -net fifo_valid_0 [get_bd_pins axis2adi_0/dma_valid] [get_bd_pins util_dac_unpack_0/fifo_valid]
  connect_bd_net -net fifo_valid_1 [get_bd_pins axis2adi_1/dma_valid] [get_bd_pins util_dac_unpack_1/fifo_valid]
  connect_bd_net -net irq_stub0_dout [get_bd_pins irq_stub0/dout] [get_bd_pins sys_concat_intc/In0]
  connect_bd_net -net irq_stub11_dout [get_bd_pins irq_stub11/dout] [get_bd_pins sys_concat_intc/In11]
  connect_bd_net -net irq_stub1_dout [get_bd_pins irq_stub1/dout] [get_bd_pins sys_concat_intc/In1]
  connect_bd_net -net irq_stub2_dout [get_bd_pins irq_stub2/dout] [get_bd_pins sys_concat_intc/In2]
  connect_bd_net -net irq_stub3_dout [get_bd_pins irq_stub3/dout] [get_bd_pins sys_concat_intc/In3]
  connect_bd_net -net routing_reg_0_adc_ddr_sw_0_tdest [get_bd_pins adc_ddr_tdest_0/In1] [get_bd_pins routing_reg_0/adc_ddr_sw_0_tdest]
  connect_bd_net -net routing_reg_0_adc_ddr_sw_1_tdest [get_bd_pins adc_ddr_tdest_1/In1] [get_bd_pins routing_reg_0/adc_ddr_sw_1_tdest]
  connect_bd_net -net routing_reg_0_adc_sw_dest0 [get_bd_pins adc_ddr_tdest_0/In0] [get_bd_pins routing_reg_0/adc_sw_dest0]
  connect_bd_net -net routing_reg_0_adc_sw_dest1 [get_bd_pins adc_ddr_tdest_1/In0] [get_bd_pins routing_reg_0/adc_sw_dest1]
  connect_bd_net -net routing_reg_0_dac_ddr_sw_0_tdest [get_bd_pins dac_ddr_tdest_0/In0] [get_bd_pins routing_reg_0/dac_ddr_sw_0_tdest]
  connect_bd_net -net routing_reg_0_dac_ddr_sw_1_tdest [get_bd_pins dac_ddr_tdest_1/In0] [get_bd_pins routing_reg_0/dac_ddr_sw_1_tdest]
  connect_bd_net -net routing_reg_0_swrite_bypass [get_bd_pins hello_router_0/swrite_bypass] [get_bd_pins routing_reg_0/swrite_bypass]
  connect_bd_net -net spi_csn_1_o [get_bd_ports spi_csn_1_o] [get_bd_pins sys_ps7/SPI0_SS1_O]
  connect_bd_net -net spi_csn_2_o [get_bd_ports spi_csn_2_o] [get_bd_pins sys_ps7/SPI0_SS2_O]
  connect_bd_net -net spi_csn_i [get_bd_ports spi_csn_0_i] [get_bd_pins sys_ps7/SPI0_SS_I]
  connect_bd_net -net spi_csn_o [get_bd_ports spi_csn_0_o] [get_bd_pins sys_ps7/SPI0_SS_O]
  connect_bd_net -net spi_miso_i [get_bd_ports spi_miso_i] [get_bd_pins sys_ps7/SPI0_MISO_I]
  connect_bd_net -net spi_mosi_i [get_bd_ports spi_mosi_i] [get_bd_pins sys_ps7/SPI0_MOSI_I]
  connect_bd_net -net spi_mosi_o [get_bd_ports spi_mosi_o] [get_bd_pins sys_ps7/SPI0_MOSI_O]
  connect_bd_net -net spi_sclk_i [get_bd_ports spi_sclk_i] [get_bd_pins sys_ps7/SPI0_SCLK_I]
  connect_bd_net -net spi_sclk_o [get_bd_ports spi_sclk_o] [get_bd_pins sys_ps7/SPI0_SCLK_O]
  connect_bd_net -net srio_dma_mm2s_introut [get_bd_pins srio_dma/mm2s_introut] [get_bd_pins sys_concat_intc/In4]
  connect_bd_net -net srio_dma_s2mm_introut [get_bd_pins srio_dma/s2mm_introut] [get_bd_pins sys_concat_intc/In5]
  connect_bd_net -net srio_gen2_0_clk_lock_out [get_bd_pins srio_gen2_0/clk_lock_out] [get_bd_pins sys_reg_0/srio_clk_out_lock]
  connect_bd_net -net srio_gen2_0_deviceid [get_bd_pins srio_gen2_0/deviceid] [get_bd_pins sys_reg_0/device_id]
  connect_bd_net -net srio_gen2_0_drpclk_out [get_bd_pins axi_srio_interconnect/M07_ACLK] [get_bd_pins drp_bridge_0/AXI_aclk] [get_bd_pins srio_gen2_0/drpclk_out]
  connect_bd_net -net srio_gen2_0_gt_drpdo_out [get_bd_pins drpdo_slice_0/Din] [get_bd_pins drpdo_slice_1/Din] [get_bd_pins drpdo_slice_2/Din] [get_bd_pins drpdo_slice_3/Din] [get_bd_pins srio_gen2_0/gt_drpdo_out]
  connect_bd_net -net srio_gen2_0_gt_drprdy_out [get_bd_pins drprdy_slice_0/Din] [get_bd_pins drprdy_slice_1/Din] [get_bd_pins drprdy_slice_2/Din] [get_bd_pins drprdy_slice_3/Din] [get_bd_pins srio_gen2_0/gt_drprdy_out]
  connect_bd_net -net srio_gen2_0_gtrx_disperr_or [get_bd_pins srio_gen2_0/gtrx_disperr_or] [get_bd_pins sys_reg_0/gtrx_disperr_or]
  connect_bd_net -net srio_gen2_0_gtrx_notintable_or [get_bd_pins srio_gen2_0/gtrx_notintable_or] [get_bd_pins sys_reg_0/gtrx_notintable_or]
  connect_bd_net -net srio_gen2_0_link_initialized [get_bd_pins srio_gen2_0/link_initialized] [get_bd_pins sys_reg_0/srio_link_initialized]
  connect_bd_net -net srio_gen2_0_log_clk_out [get_bd_pins axi_srio_interconnect/M04_ACLK] [get_bd_pins srio_gen2_0/log_clk_out] [get_bd_pins srio_ireq_intc/M00_AXIS_ACLK] [get_bd_pins srio_iresp_intc/S00_AXIS_ACLK] [get_bd_pins srio_maint_reg/aclk] [get_bd_pins srio_treq_intc/S00_AXIS_ACLK] [get_bd_pins srio_tresp_intc/M00_AXIS_ACLK]
  connect_bd_net -net srio_gen2_0_mode_1x [get_bd_pins srio_gen2_0/mode_1x] [get_bd_pins sys_reg_0/srio_mode_1x]
  connect_bd_net -net srio_gen2_0_phy_rcvd_link_reset [get_bd_pins srio_gen2_0/phy_rcvd_link_reset] [get_bd_pins sys_reg_0/phy_rcvd_link_reset]
  connect_bd_net -net srio_gen2_0_phy_rcvd_mce [get_bd_pins srio_gen2_0/phy_rcvd_mce] [get_bd_pins sys_reg_0/phy_rcvd_mce]
  connect_bd_net -net srio_gen2_0_port_error [get_bd_pins srio_gen2_0/port_error] [get_bd_pins sys_reg_0/port_error]
  connect_bd_net -net srio_gen2_0_port_initialized [get_bd_pins srio_gen2_0/port_initialized] [get_bd_pins sys_reg_0/srio_port_initialized]
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
  connect_bd_net -net sys_100m_clk [get_bd_pins adi2axis_0/S_AXI_ACLK] [get_bd_pins adi2axis_1/S_AXI_ACLK] [get_bd_pins adi_dma_comb_0/S_AXI_ACLK] [get_bd_pins adi_dma_comb_1/S_AXI_ACLK] [get_bd_pins adi_dma_split_0/S_AXI_ACLK] [get_bd_pins adi_dma_split_1/S_AXI_ACLK] [get_bd_pins axi_ad9361_0/s_axi_aclk] [get_bd_pins axi_ad9361_1/s_axi_aclk] [get_bd_pins axi_cpu_interconnect/ACLK] [get_bd_pins axi_cpu_interconnect/M00_ACLK] [get_bd_pins axi_cpu_interconnect/M01_ACLK] [get_bd_pins axi_cpu_interconnect/M02_ACLK] [get_bd_pins axi_cpu_interconnect/M03_ACLK] [get_bd_pins axi_cpu_interconnect/M04_ACLK] [get_bd_pins axi_cpu_interconnect/M05_ACLK] [get_bd_pins axi_cpu_interconnect/M06_ACLK] [get_bd_pins axi_cpu_interconnect/M07_ACLK] [get_bd_pins axi_cpu_interconnect/M08_ACLK] [get_bd_pins axi_cpu_interconnect/M09_ACLK] [get_bd_pins axi_cpu_interconnect/M10_ACLK] [get_bd_pins axi_cpu_interconnect/M11_ACLK] [get_bd_pins axi_cpu_interconnect/M12_ACLK] [get_bd_pins axi_cpu_interconnect/M13_ACLK] [get_bd_pins axi_cpu_interconnect/M14_ACLK] [get_bd_pins axi_cpu_interconnect/M15_ACLK] [get_bd_pins axi_cpu_interconnect/M16_ACLK] [get_bd_pins axi_cpu_interconnect/M17_ACLK] [get_bd_pins axi_cpu_interconnect/M18_ACLK] [get_bd_pins axi_cpu_interconnect/M19_ACLK] [get_bd_pins axi_cpu_interconnect/M20_ACLK] [get_bd_pins axi_cpu_interconnect/M21_ACLK] [get_bd_pins axi_cpu_interconnect/M22_ACLK] [get_bd_pins axi_cpu_interconnect/M23_ACLK] [get_bd_pins axi_cpu_interconnect/M24_ACLK] [get_bd_pins axi_cpu_interconnect/M25_ACLK] [get_bd_pins axi_cpu_interconnect/M26_ACLK] [get_bd_pins axi_cpu_interconnect/M27_ACLK] [get_bd_pins axi_cpu_interconnect/M28_ACLK] [get_bd_pins axi_cpu_interconnect/M29_ACLK] [get_bd_pins axi_cpu_interconnect/S00_ACLK] [get_bd_pins axi_dma_0/s_axi_lite_aclk] [get_bd_pins axi_dma_1/s_axi_lite_aclk] [get_bd_pins axi_gpio/s_axi_aclk] [get_bd_pins axi_srio_interconnect/ACLK] [get_bd_pins axi_srio_interconnect/S00_ACLK] [get_bd_pins axis_vita49_pack_0/S_AXI_ACLK] [get_bd_pins axis_vita49_pack_1/S_AXI_ACLK] [get_bd_pins axis_vita49_unpack_0/S_AXI_ACLK] [get_bd_pins axis_vita49_unpack_1/S_AXI_ACLK] [get_bd_pins c_counter_binary_0/CLK] [get_bd_pins routing_reg_0/S_AXI_ACLK] [get_bd_pins srio_dma/s_axi_lite_aclk] [get_bd_pins srio_dma_comb_0/S_AXI_ACLK] [get_bd_pins srio_dma_split_0/S_AXI_ACLK] [get_bd_pins srio_swrite_pack_0/S_AXI_ACLK] [get_bd_pins srio_swrite_pack_1/S_AXI_ACLK] [get_bd_pins srio_swrite_unpack_0/S_AXI_ACLK] [get_bd_pins sys_ps7/FCLK_CLK0] [get_bd_pins sys_ps7/M_AXI_GP0_ACLK] [get_bd_pins sys_ps7/M_AXI_GP1_ACLK] [get_bd_pins sys_reg_0/S_AXI_ACLK] [get_bd_pins sys_rstgen/slowest_sync_clk] [get_bd_pins vita49_assem_0/S_AXI_ACLK] [get_bd_pins vita49_assem_1/S_AXI_ACLK] [get_bd_pins vita49_clk/S_AXI_ACLK] [get_bd_pins vita49_trig_adc_0/S_AXI_ACLK] [get_bd_pins vita49_trig_adc_1/S_AXI_ACLK] [get_bd_pins vita49_trig_dac_0/S_AXI_ACLK] [get_bd_pins vita49_trig_dac_1/S_AXI_ACLK]
  connect_bd_net -net sys_100m_resetn [get_bd_pins adc_ddr_sw_0/aresetn] [get_bd_pins adc_ddr_sw_1/aresetn] [get_bd_pins adc_fifo_0/s_axis_aresetn] [get_bd_pins adc_fifo_1/s_axis_aresetn] [get_bd_pins adi2axis_0/AXIS_ARESETN] [get_bd_pins adi2axis_0/S_AXI_ARESETN] [get_bd_pins adi2axis_1/AXIS_ARESETN] [get_bd_pins adi2axis_1/S_AXI_ARESETN] [get_bd_pins adi_dma_comb_0/AXIS_ARESETN] [get_bd_pins adi_dma_comb_0/S_AXI_ARESETN] [get_bd_pins adi_dma_comb_1/AXIS_ARESETN] [get_bd_pins adi_dma_comb_1/S_AXI_ARESETN] [get_bd_pins adi_dma_split_0/AXIS_ARESETN] [get_bd_pins adi_dma_split_0/S_AXI_ARESETN] [get_bd_pins adi_dma_split_1/AXIS_ARESETN] [get_bd_pins adi_dma_split_1/S_AXI_ARESETN] [get_bd_pins axi_ad9361_0/s_axi_aresetn] [get_bd_pins axi_ad9361_0_adc_dma_interconnect/ARESETN] [get_bd_pins axi_ad9361_0_adc_dma_interconnect/M00_ARESETN] [get_bd_pins axi_ad9361_0_adc_dma_interconnect/S00_ARESETN] [get_bd_pins axi_ad9361_0_dac_dma_interconnect/ARESETN] [get_bd_pins axi_ad9361_0_dac_dma_interconnect/M00_ARESETN] [get_bd_pins axi_ad9361_0_dac_dma_interconnect/S00_ARESETN] [get_bd_pins axi_ad9361_0_dac_dma_interconnect/S01_ARESETN] [get_bd_pins axi_ad9361_1/s_axi_aresetn] [get_bd_pins axi_ad9361_1_adc_dma_interconnect/ARESETN] [get_bd_pins axi_ad9361_1_adc_dma_interconnect/M00_ARESETN] [get_bd_pins axi_ad9361_1_adc_dma_interconnect/S00_ARESETN] [get_bd_pins axi_ad9361_1_adc_dma_interconnect/S01_ARESETN] [get_bd_pins axi_ad9361_1_dac_dma_interconnect/ARESETN] [get_bd_pins axi_ad9361_1_dac_dma_interconnect/M00_ARESETN] [get_bd_pins axi_ad9361_1_dac_dma_interconnect/S00_ARESETN] [get_bd_pins axi_ad9361_1_dac_dma_interconnect/S01_ARESETN] [get_bd_pins axi_cpu_interconnect/ARESETN] [get_bd_pins axi_cpu_interconnect/M00_ARESETN] [get_bd_pins axi_cpu_interconnect/M01_ARESETN] [get_bd_pins axi_cpu_interconnect/M02_ARESETN] [get_bd_pins axi_cpu_interconnect/M03_ARESETN] [get_bd_pins axi_cpu_interconnect/M04_ARESETN] [get_bd_pins axi_cpu_interconnect/M05_ARESETN] [get_bd_pins axi_cpu_interconnect/M06_ARESETN] [get_bd_pins axi_cpu_interconnect/M07_ARESETN] [get_bd_pins axi_cpu_interconnect/M08_ARESETN] [get_bd_pins axi_cpu_interconnect/M09_ARESETN] [get_bd_pins axi_cpu_interconnect/M10_ARESETN] [get_bd_pins axi_cpu_interconnect/M11_ARESETN] [get_bd_pins axi_cpu_interconnect/M12_ARESETN] [get_bd_pins axi_cpu_interconnect/M13_ARESETN] [get_bd_pins axi_cpu_interconnect/M14_ARESETN] [get_bd_pins axi_cpu_interconnect/M15_ARESETN] [get_bd_pins axi_cpu_interconnect/M16_ARESETN] [get_bd_pins axi_cpu_interconnect/M17_ARESETN] [get_bd_pins axi_cpu_interconnect/M18_ARESETN] [get_bd_pins axi_cpu_interconnect/M19_ARESETN] [get_bd_pins axi_cpu_interconnect/M20_ARESETN] [get_bd_pins axi_cpu_interconnect/M21_ARESETN] [get_bd_pins axi_cpu_interconnect/M22_ARESETN] [get_bd_pins axi_cpu_interconnect/M23_ARESETN] [get_bd_pins axi_cpu_interconnect/M24_ARESETN] [get_bd_pins axi_cpu_interconnect/M25_ARESETN] [get_bd_pins axi_cpu_interconnect/M26_ARESETN] [get_bd_pins axi_cpu_interconnect/M27_ARESETN] [get_bd_pins axi_cpu_interconnect/M28_ARESETN] [get_bd_pins axi_cpu_interconnect/M29_ARESETN] [get_bd_pins axi_cpu_interconnect/S00_ARESETN] [get_bd_pins axi_dma_0/axi_resetn] [get_bd_pins axi_dma_1/axi_resetn] [get_bd_pins axi_gpio/s_axi_aresetn] [get_bd_pins axi_sg_interconnect/ARESETN] [get_bd_pins axi_sg_interconnect/M00_ARESETN] [get_bd_pins axi_sg_interconnect/S00_ARESETN] [get_bd_pins axi_sg_interconnect/S01_ARESETN] [get_bd_pins axi_sg_interconnect/S02_ARESETN] [get_bd_pins axi_srio_initiator_fifo/s_axi_aresetn] [get_bd_pins axi_srio_interconnect/ARESETN] [get_bd_pins axi_srio_interconnect/M00_ARESETN] [get_bd_pins axi_srio_interconnect/M01_ARESETN] [get_bd_pins axi_srio_interconnect/M02_ARESETN] [get_bd_pins axi_srio_interconnect/M03_ARESETN] [get_bd_pins axi_srio_interconnect/M04_ARESETN] [get_bd_pins axi_srio_interconnect/M05_ARESETN] [get_bd_pins axi_srio_interconnect/M06_ARESETN] [get_bd_pins axi_srio_interconnect/M07_ARESETN] [get_bd_pins axi_srio_interconnect/S00_ARESETN] [get_bd_pins axi_srio_target_fifo/s_axi_aresetn] [get_bd_pins axis2adi_0/AXIS_ARESETN] [get_bd_pins axis2adi_1/AXIS_ARESETN] [get_bd_pins axis_32to64_adc_0/AXIS_ARESETN] [get_bd_pins axis_32to64_adc_1/AXIS_ARESETN] [get_bd_pins axis_32to64_dac_0/aresetn] [get_bd_pins axis_32to64_dac_1/aresetn] [get_bd_pins axis_32to64_srio_init/AXIS_ARESETN] [get_bd_pins axis_32to64_srio_target/AXIS_ARESETN] [get_bd_pins axis_64to32_adc_0/AXIS_ARESETN] [get_bd_pins axis_64to32_adc_1/AXIS_ARESETN] [get_bd_pins axis_64to32_dac_0/AXIS_ARESETN] [get_bd_pins axis_64to32_dac_1/AXIS_ARESETN] [get_bd_pins axis_64to32_srio_init/AXIS_ARESETN] [get_bd_pins axis_64to32_srio_target/AXIS_ARESETN] [get_bd_pins axis_adc_interconnect_0/ARESETN] [get_bd_pins axis_adc_interconnect_0/M00_AXIS_ARESETN] [get_bd_pins axis_adc_interconnect_0/S00_AXIS_ARESETN] [get_bd_pins axis_adc_interconnect_1/ARESETN] [get_bd_pins axis_adc_interconnect_1/M00_AXIS_ARESETN] [get_bd_pins axis_adc_interconnect_1/S00_AXIS_ARESETN] [get_bd_pins axis_dac_interconnect_0/ARESETN] [get_bd_pins axis_dac_interconnect_0/M00_AXIS_ARESETN] [get_bd_pins axis_dac_interconnect_0/S00_AXIS_ARESETN] [get_bd_pins axis_dac_interconnect_1/ARESETN] [get_bd_pins axis_dac_interconnect_1/M00_AXIS_ARESETN] [get_bd_pins axis_dac_interconnect_1/S00_AXIS_ARESETN] [get_bd_pins axis_vita49_pack_0/AXIS_ARESETN] [get_bd_pins axis_vita49_pack_0/S_AXI_ARESETN] [get_bd_pins axis_vita49_pack_1/AXIS_ARESETN] [get_bd_pins axis_vita49_pack_1/S_AXI_ARESETN] [get_bd_pins axis_vita49_unpack_0/AXIS_ARESETN] [get_bd_pins axis_vita49_unpack_0/S_AXI_ARESETN] [get_bd_pins axis_vita49_unpack_1/AXIS_ARESETN] [get_bd_pins axis_vita49_unpack_1/S_AXI_ARESETN] [get_bd_pins dac_ddr_sw_0/aresetn] [get_bd_pins dac_ddr_sw_0_reg/aresetn] [get_bd_pins dac_ddr_sw_1/aresetn] [get_bd_pins dac_fifo_0/s_axis_aresetn] [get_bd_pins dac_fifo_1/s_axis_aresetn] [get_bd_pins ddr_fifo/aresetn] [get_bd_pins drp_bridge_0/AXI_aresetn] [get_bd_pins hello_router_0/AXIS_ARESETN] [get_bd_pins routing_reg_0/S_AXI_ARESETN] [get_bd_pins srio_dma/axi_resetn] [get_bd_pins srio_dma_comb_0/AXIS_ARESETN] [get_bd_pins srio_dma_comb_0/S_AXI_ARESETN] [get_bd_pins srio_dma_reg_0_delete/aresetn] [get_bd_pins srio_dma_split_0/AXIS_ARESETN] [get_bd_pins srio_dma_split_0/S_AXI_ARESETN] [get_bd_pins srio_ireq_intc/ARESETN] [get_bd_pins srio_ireq_intc/M00_AXIS_ARESETN] [get_bd_pins srio_ireq_intc/S00_AXIS_ARESETN] [get_bd_pins srio_ireq_sw/aresetn] [get_bd_pins srio_iresp_intc/ARESETN] [get_bd_pins srio_iresp_intc/M00_AXIS_ARESETN] [get_bd_pins srio_iresp_intc/S00_AXIS_ARESETN] [get_bd_pins srio_maint_reg/aresetn] [get_bd_pins srio_swrite_pack_0/AXIS_ARESETN] [get_bd_pins srio_swrite_pack_0/S_AXI_ARESETN] [get_bd_pins srio_swrite_pack_1/AXIS_ARESETN] [get_bd_pins srio_swrite_pack_1/S_AXI_ARESETN] [get_bd_pins srio_swrite_unpack_0/AXIS_ARESETN] [get_bd_pins srio_swrite_unpack_0/S_AXI_ARESETN] [get_bd_pins srio_swrite_unpack_reg/aresetn] [get_bd_pins srio_target_reg/aresetn] [get_bd_pins srio_treq_intc/ARESETN] [get_bd_pins srio_treq_intc/M00_AXIS_ARESETN] [get_bd_pins srio_treq_intc/S00_AXIS_ARESETN] [get_bd_pins srio_treq_sw/aresetn] [get_bd_pins srio_tresp_intc/ARESETN] [get_bd_pins srio_tresp_intc/M00_AXIS_ARESETN] [get_bd_pins srio_tresp_intc/S00_AXIS_ARESETN] [get_bd_pins sys_reg_0/S_AXI_ARESETN] [get_bd_pins sys_rstgen/peripheral_aresetn] [get_bd_pins vita49_assem_0/AXIS_ARESETN] [get_bd_pins vita49_assem_0/S_AXI_ARESETN] [get_bd_pins vita49_assem_1/AXIS_ARESETN] [get_bd_pins vita49_assem_1/S_AXI_ARESETN] [get_bd_pins vita49_clk/S_AXI_ARESETN] [get_bd_pins vita49_trig_adc_0/AXIS_ARESETN] [get_bd_pins vita49_trig_adc_0/S_AXI_ARESETN] [get_bd_pins vita49_trig_adc_1/AXIS_ARESETN] [get_bd_pins vita49_trig_adc_1/S_AXI_ARESETN] [get_bd_pins vita49_trig_dac_0/AXIS_ARESETN] [get_bd_pins vita49_trig_dac_0/S_AXI_ARESETN] [get_bd_pins vita49_trig_dac_1/AXIS_ARESETN] [get_bd_pins vita49_trig_dac_1/S_AXI_ARESETN] [get_bd_pins vita_dac_sw/aresetn] [get_bd_pins vita_pack_adc_reg_0/aresetn] [get_bd_pins vita_pack_adc_reg_1/aresetn] [get_bd_pins vita_trig_dac_reg_0/aresetn] [get_bd_pins vita_trig_dac_reg_1/aresetn] [get_bd_pins vita_unpack_dac_reg_0/aresetn] [get_bd_pins vita_unpack_dac_reg_1/aresetn]
  connect_bd_net -net sys_200m_clk [get_bd_pins axi_ad9361_0/delay_clk] [get_bd_pins axi_ad9361_1/delay_clk] [get_bd_pins sys_ps7/FCLK_CLK1]
  connect_bd_net -net sys_aux_reset [get_bd_pins sys_ps7/FCLK_RESET0_N] [get_bd_pins sys_rstgen/ext_reset_in]
  connect_bd_net -net sys_fmc_dma_clk [get_bd_pins adc_ddr_sw_0/aclk] [get_bd_pins adc_ddr_sw_1/aclk] [get_bd_pins adc_fifo_0/s_axis_aclk] [get_bd_pins adc_fifo_1/s_axis_aclk] [get_bd_pins adi_dma_comb_0/AXIS_ACLK] [get_bd_pins adi_dma_comb_1/AXIS_ACLK] [get_bd_pins adi_dma_split_0/AXIS_ACLK] [get_bd_pins adi_dma_split_1/AXIS_ACLK] [get_bd_pins axi_ad9361_0_adc_dma_interconnect/ACLK] [get_bd_pins axi_ad9361_0_adc_dma_interconnect/M00_ACLK] [get_bd_pins axi_ad9361_0_adc_dma_interconnect/S00_ACLK] [get_bd_pins axi_ad9361_0_dac_dma_interconnect/ACLK] [get_bd_pins axi_ad9361_0_dac_dma_interconnect/M00_ACLK] [get_bd_pins axi_ad9361_0_dac_dma_interconnect/S00_ACLK] [get_bd_pins axi_ad9361_0_dac_dma_interconnect/S01_ACLK] [get_bd_pins axi_ad9361_1_adc_dma_interconnect/ACLK] [get_bd_pins axi_ad9361_1_adc_dma_interconnect/M00_ACLK] [get_bd_pins axi_ad9361_1_adc_dma_interconnect/S00_ACLK] [get_bd_pins axi_ad9361_1_adc_dma_interconnect/S01_ACLK] [get_bd_pins axi_ad9361_1_dac_dma_interconnect/ACLK] [get_bd_pins axi_ad9361_1_dac_dma_interconnect/M00_ACLK] [get_bd_pins axi_ad9361_1_dac_dma_interconnect/S00_ACLK] [get_bd_pins axi_ad9361_1_dac_dma_interconnect/S01_ACLK] [get_bd_pins axi_dma_0/m_axi_mm2s_aclk] [get_bd_pins axi_dma_0/m_axi_s2mm_aclk] [get_bd_pins axi_dma_0/m_axi_sg_aclk] [get_bd_pins axi_dma_1/m_axi_mm2s_aclk] [get_bd_pins axi_dma_1/m_axi_s2mm_aclk] [get_bd_pins axi_dma_1/m_axi_sg_aclk] [get_bd_pins axi_sg_interconnect/ACLK] [get_bd_pins axi_sg_interconnect/M00_ACLK] [get_bd_pins axi_sg_interconnect/S00_ACLK] [get_bd_pins axi_sg_interconnect/S01_ACLK] [get_bd_pins axi_sg_interconnect/S02_ACLK] [get_bd_pins axi_srio_initiator_fifo/s_axi_aclk] [get_bd_pins axi_srio_interconnect/M00_ACLK] [get_bd_pins axi_srio_interconnect/M01_ACLK] [get_bd_pins axi_srio_interconnect/M02_ACLK] [get_bd_pins axi_srio_interconnect/M03_ACLK] [get_bd_pins axi_srio_interconnect/M05_ACLK] [get_bd_pins axi_srio_interconnect/M06_ACLK] [get_bd_pins axi_srio_target_fifo/s_axi_aclk] [get_bd_pins axis_32to64_adc_0/AXIS_ACLK] [get_bd_pins axis_32to64_adc_1/AXIS_ACLK] [get_bd_pins axis_32to64_dac_0/aclk] [get_bd_pins axis_32to64_dac_1/aclk] [get_bd_pins axis_32to64_srio_init/AXIS_ACLK] [get_bd_pins axis_32to64_srio_target/AXIS_ACLK] [get_bd_pins axis_64to32_adc_0/AXIS_ACLK] [get_bd_pins axis_64to32_adc_1/AXIS_ACLK] [get_bd_pins axis_64to32_dac_0/AXIS_ACLK] [get_bd_pins axis_64to32_dac_1/AXIS_ACLK] [get_bd_pins axis_64to32_srio_init/AXIS_ACLK] [get_bd_pins axis_64to32_srio_target/AXIS_ACLK] [get_bd_pins axis_adc_interconnect_0/M00_AXIS_ACLK] [get_bd_pins axis_adc_interconnect_1/M00_AXIS_ACLK] [get_bd_pins axis_dac_interconnect_0/ACLK] [get_bd_pins axis_dac_interconnect_0/S00_AXIS_ACLK] [get_bd_pins axis_dac_interconnect_1/ACLK] [get_bd_pins axis_dac_interconnect_1/S00_AXIS_ACLK] [get_bd_pins axis_vita49_pack_0/AXIS_ACLK] [get_bd_pins axis_vita49_pack_1/AXIS_ACLK] [get_bd_pins axis_vita49_unpack_0/AXIS_ACLK] [get_bd_pins axis_vita49_unpack_1/AXIS_ACLK] [get_bd_pins dac_ddr_sw_0/aclk] [get_bd_pins dac_ddr_sw_0_reg/aclk] [get_bd_pins dac_ddr_sw_1/aclk] [get_bd_pins dac_fifo_0/s_axis_aclk] [get_bd_pins dac_fifo_1/s_axis_aclk] [get_bd_pins ddr_fifo/aclk] [get_bd_pins hello_router_0/AXIS_ACLK] [get_bd_pins srio_dma/m_axi_mm2s_aclk] [get_bd_pins srio_dma/m_axi_s2mm_aclk] [get_bd_pins srio_dma/m_axi_sg_aclk] [get_bd_pins srio_dma_comb_0/AXIS_ACLK] [get_bd_pins srio_dma_reg_0_delete/aclk] [get_bd_pins srio_dma_split_0/AXIS_ACLK] [get_bd_pins srio_ireq_intc/ACLK] [get_bd_pins srio_ireq_intc/S00_AXIS_ACLK] [get_bd_pins srio_ireq_sw/aclk] [get_bd_pins srio_iresp_intc/ACLK] [get_bd_pins srio_iresp_intc/M00_AXIS_ACLK] [get_bd_pins srio_swrite_pack_0/AXIS_ACLK] [get_bd_pins srio_swrite_pack_1/AXIS_ACLK] [get_bd_pins srio_swrite_unpack_0/AXIS_ACLK] [get_bd_pins srio_swrite_unpack_reg/aclk] [get_bd_pins srio_target_reg/aclk] [get_bd_pins srio_treq_intc/ACLK] [get_bd_pins srio_treq_intc/M00_AXIS_ACLK] [get_bd_pins srio_treq_sw/aclk] [get_bd_pins srio_tresp_intc/ACLK] [get_bd_pins srio_tresp_intc/S00_AXIS_ACLK] [get_bd_pins sys_ps7/FCLK_CLK2] [get_bd_pins sys_ps7/S_AXI_GP0_ACLK] [get_bd_pins sys_ps7/S_AXI_HP0_ACLK] [get_bd_pins sys_ps7/S_AXI_HP1_ACLK] [get_bd_pins sys_ps7/S_AXI_HP2_ACLK] [get_bd_pins sys_ps7/S_AXI_HP3_ACLK] [get_bd_pins vita49_assem_0/AXIS_ACLK] [get_bd_pins vita49_assem_1/AXIS_ACLK] [get_bd_pins vita49_trig_adc_0/AXIS_ACLK] [get_bd_pins vita49_trig_adc_1/AXIS_ACLK] [get_bd_pins vita49_trig_dac_0/AXIS_ACLK] [get_bd_pins vita49_trig_dac_1/AXIS_ACLK] [get_bd_pins vita_dac_sw/aclk] [get_bd_pins vita_pack_adc_reg_0/aclk] [get_bd_pins vita_pack_adc_reg_1/aclk] [get_bd_pins vita_trig_dac_reg_0/aclk] [get_bd_pins vita_trig_dac_reg_1/aclk] [get_bd_pins vita_unpack_dac_reg_0/aclk] [get_bd_pins vita_unpack_dac_reg_1/aclk]
  connect_bd_net -net sys_ps7_GPIO_I [get_bd_ports GPIO_I] [get_bd_pins sys_ps7/GPIO_I]
  connect_bd_net -net sys_ps7_GPIO_O [get_bd_pins sys_ps7/GPIO_O] [get_bd_pins xlslice_1/Din]
  connect_bd_net -net sys_ps7_GPIO_T [get_bd_ports GPIO_T] [get_bd_pins sys_ps7/GPIO_T]
  connect_bd_net -net sys_ps7_interrupt [get_bd_pins sys_concat_intc/dout] [get_bd_pins sys_ps7/IRQ_F2P]
  connect_bd_net -net sys_reg_0_force_reinit [get_bd_pins srio_gen2_0/force_reinit] [get_bd_pins sys_reg_0/force_reinit]
  connect_bd_net -net sys_reg_0_gt_diffctrl [get_bd_pins srio_gen2_0/gt0_txdiffctrl_in] [get_bd_pins srio_gen2_0/gt1_txdiffctrl_in] [get_bd_pins srio_gen2_0/gt2_txdiffctrl_in] [get_bd_pins srio_gen2_0/gt3_txdiffctrl_in] [get_bd_pins sys_reg_0/gt_diffctrl]
  connect_bd_net -net sys_reg_0_gt_rxdfelpmreset_in [get_bd_pins srio_gen2_0/gt_rxdfelpmreset_in] [get_bd_pins sys_reg_0/gt_rxdfelpmreset_in]
  connect_bd_net -net sys_reg_0_gt_rxlpmen [get_bd_pins srio_gen2_0/gt_rxlpmen_in] [get_bd_pins sys_reg_0/gt_rxlpmen]
  connect_bd_net -net sys_reg_0_gt_txpostcursor [get_bd_pins srio_gen2_0/gt_txpostcursor_in] [get_bd_pins sys_reg_0/gt_txpostcursor]
  connect_bd_net -net sys_reg_0_gt_txprecursor [get_bd_pins srio_gen2_0/gt_txprecursor_in] [get_bd_pins sys_reg_0/gt_txprecursor]
  connect_bd_net -net sys_reg_0_phy_link_reset [get_bd_pins srio_gen2_0/phy_link_reset] [get_bd_pins sys_reg_0/phy_link_reset]
  connect_bd_net -net sys_reg_0_phy_mce [get_bd_pins srio_gen2_0/phy_mce] [get_bd_pins sys_reg_0/phy_mce]
  connect_bd_net -net sys_reg_0_srio_loopback [get_bd_pins srio_gen2_0/gt_loopback_in] [get_bd_pins sys_reg_0/srio_loopback]
  connect_bd_net -net sys_reg_0_srio_reset [get_bd_pins srio_gen2_0/sys_rst] [get_bd_pins sys_reg_0/srio_reset]
  connect_bd_net -net util_adc_pack_0_ddata [get_bd_pins adi2axis_0/ddata] [get_bd_pins util_adc_pack_0/ddata]
  connect_bd_net -net util_adc_pack_0_dsync [get_bd_pins adi2axis_0/dsync] [get_bd_pins util_adc_pack_0/dsync]
  connect_bd_net -net util_adc_pack_0_dvalid [get_bd_pins adi2axis_0/dvalid] [get_bd_pins util_adc_pack_0/dvalid]
  connect_bd_net -net util_adc_pack_1_ddata [get_bd_pins adi2axis_1/ddata] [get_bd_pins util_adc_pack_1/ddata]
  connect_bd_net -net util_adc_pack_1_dsync [get_bd_pins adi2axis_1/dsync] [get_bd_pins util_adc_pack_1/dsync]
  connect_bd_net -net util_adc_pack_1_dvalid [get_bd_pins adi2axis_1/dvalid] [get_bd_pins util_adc_pack_1/dvalid]
  connect_bd_net -net vita49_clk_tsf_0 [get_bd_pins axis_vita49_pack_0/timestamp_fsec] [get_bd_pins axis_vita49_unpack_0/timestamp_fsec] [get_bd_pins vita49_clk/tsf_0] [get_bd_pins vita49_trig_adc_0/tsf] [get_bd_pins vita49_trig_dac_0/tsf]
  connect_bd_net -net vita49_clk_tsf_1 [get_bd_pins axis_vita49_pack_1/timestamp_fsec] [get_bd_pins axis_vita49_unpack_1/timestamp_fsec] [get_bd_pins vita49_clk/tsf_1] [get_bd_pins vita49_trig_adc_1/tsf] [get_bd_pins vita49_trig_dac_1/tsf]
  connect_bd_net -net vita49_clk_tsi_0 [get_bd_pins axis_vita49_pack_0/timestamp_sec] [get_bd_pins axis_vita49_unpack_0/timestamp_sec] [get_bd_pins vita49_clk/tsi_0] [get_bd_pins vita49_trig_adc_0/tsi] [get_bd_pins vita49_trig_dac_0/tsi]
  connect_bd_net -net vita49_clk_tsi_1 [get_bd_pins axis_vita49_pack_1/timestamp_sec] [get_bd_pins axis_vita49_unpack_1/timestamp_sec] [get_bd_pins vita49_clk/tsi_1] [get_bd_pins vita49_trig_adc_1/tsi] [get_bd_pins vita49_trig_dac_1/tsi]
  connect_bd_net -net vita49_trig_adc_0_trig [get_bd_pins adi2axis_0/trig] [get_bd_pins vita49_trig_adc_0/trig]
  connect_bd_net -net vita49_trig_adc_1_trig [get_bd_pins adi2axis_1/trig] [get_bd_pins vita49_trig_adc_1/trig]
  connect_bd_net -net vita49_trig_dac_0_trig [get_bd_pins axis_vita49_unpack_0/trig] [get_bd_pins vita49_trig_dac_0/trig]
  connect_bd_net -net vita49_trig_dac_1_trig [get_bd_pins axis_vita49_unpack_1/trig] [get_bd_pins vita49_trig_dac_1/trig]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins vita49_clk/pps_clk] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_ports GPIO_O] [get_bd_pins xlslice_1/Dout]

  # Create address segments
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_dma_0/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_DDR_LOWOCM] SEG_sys_ps7_GP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x1000000 -offset 0xFC000000 [get_bd_addr_spaces axi_dma_0/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_QSPI_LINEAR] SEG_sys_ps7_GP0_QSPI_LINEAR
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs sys_ps7/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_sys_ps7_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs sys_ps7/S_AXI_HP1/HP1_DDR_LOWOCM] SEG_sys_ps7_HP1_DDR_LOWOCM
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_dma_1/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_DDR_LOWOCM] SEG_sys_ps7_GP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x1000000 -offset 0xFC000000 [get_bd_addr_spaces axi_dma_1/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_QSPI_LINEAR] SEG_sys_ps7_GP0_QSPI_LINEAR
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs sys_ps7/S_AXI_HP2/HP2_DDR_LOWOCM] SEG_sys_ps7_HP2_DDR_LOWOCM
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs sys_ps7/S_AXI_HP3/HP3_DDR_LOWOCM] SEG_sys_ps7_HP3_DDR_LOWOCM
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces ddr_fifo/Data_S2MM] [get_bd_addr_segs sys_ps7/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_sys_ps7_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces srio_dma/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_DDR_LOWOCM] SEG_sys_ps7_GP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x1000000 -offset 0xFC000000 [get_bd_addr_spaces srio_dma/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_QSPI_LINEAR] SEG_sys_ps7_GP0_QSPI_LINEAR
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces srio_dma/Data_MM2S] [get_bd_addr_segs sys_ps7/S_AXI_HP2/HP2_DDR_LOWOCM] SEG_sys_ps7_HP2_DDR_LOWOCM
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces srio_dma/Data_S2MM] [get_bd_addr_segs sys_ps7/S_AXI_HP3/HP3_DDR_LOWOCM] SEG_sys_ps7_HP3_DDR_LOWOCM
  create_bd_addr_seg -range 0x1000 -offset 0x52800000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs adi_dma_comb_0/S_AXI/reg0] SEG_adi_dma_comb_0_reg0
  create_bd_addr_seg -range 0x1000 -offset 0x52900000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs adi_dma_comb_1/S_AXI/reg0] SEG_adi_dma_comb_1_reg0
  create_bd_addr_seg -range 0x1000 -offset 0x52A00000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs adi_dma_split_0/S_AXI/reg0] SEG_adi_dma_split_0_reg0
  create_bd_addr_seg -range 0x1000 -offset 0x52B00000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs adi_dma_split_1/S_AXI/reg0] SEG_adi_dma_split_1_reg0
  create_bd_addr_seg -range 0x1000 -offset 0x80000000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_srio_initiator_fifo/S_AXI/Mem0] SEG_axi_srio_initiator_fifo_Mem0
  create_bd_addr_seg -range 0x1000 -offset 0x80200000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_srio_target_fifo/S_AXI/Mem0] SEG_axi_srio_target_fifo_Mem0
  create_bd_addr_seg -range 0x1000 -offset 0x53100000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axis_vita49_pack_0/S_AXI/reg0] SEG_axis_vita49_pack_0_reg0
  create_bd_addr_seg -range 0x1000 -offset 0x53200000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axis_vita49_pack_1/S_AXI/reg0] SEG_axis_vita49_pack_1_reg0
  create_bd_addr_seg -range 0x1000 -offset 0x53300000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axis_vita49_unpack_0/S_AXI/reg0] SEG_axis_vita49_unpack_0_reg0
  create_bd_addr_seg -range 0x1000 -offset 0x53400000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axis_vita49_unpack_1/S_AXI/reg0] SEG_axis_vita49_unpack_1_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x79000000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9361_0/s_axi/axi_lite] SEG_data_ad9361_0
  create_bd_addr_seg -range 0x1000 -offset 0x52000000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs adi2axis_0/S_AXI/reg0] SEG_data_ad9361_0_adi2axis
  create_bd_addr_seg -range 0x10000 -offset 0x52100000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_dma_0/S_AXI_LITE/Reg] SEG_data_ad9361_0_dma
  create_bd_addr_seg -range 0x10000 -offset 0x79020000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9361_1/s_axi/axi_lite] SEG_data_ad9361_1
  create_bd_addr_seg -range 0x1000 -offset 0x52200000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs adi2axis_1/S_AXI/reg0] SEG_data_ad9361_1_adi2axis
  create_bd_addr_seg -range 0x10000 -offset 0x52300000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_dma_1/S_AXI_LITE/Reg] SEG_data_ad9361_1_dma
  create_bd_addr_seg -range 0x1000 -offset 0x41200000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_gpio/S_AXI/Reg] SEG_data_axi_gpio
  create_bd_addr_seg -range 0x2000 -offset 0x81000000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs drp_bridge_0/S_AXI/reg0] SEG_drp_bridge_0_reg0
  create_bd_addr_seg -range 0x1000 -offset 0x52400000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs routing_reg_0/S_AXI/reg0] SEG_routing_reg_0_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x52500000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs srio_dma/S_AXI_LITE/Reg] SEG_srio_dma_Reg
  create_bd_addr_seg -range 0x1000 -offset 0x52600000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs srio_dma_comb_0/S_AXI/reg0] SEG_srio_dma_comb_0_reg0
  create_bd_addr_seg -range 0x1000 -offset 0x52700000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs srio_dma_split_0/S_AXI/reg0] SEG_srio_dma_split_0_reg0
  create_bd_addr_seg -range 0x1000000 -offset 0x90000000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs srio_gen2_0/MAINT_IF/Reg] SEG_srio_gen2_0_Reg
  create_bd_addr_seg -range 0x1000 -offset 0x54000000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs srio_swrite_pack_0/S_AXI/reg0] SEG_srio_swrite_pack_0_reg0
  create_bd_addr_seg -range 0x1000 -offset 0x54100000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs srio_swrite_pack_1/S_AXI/reg0] SEG_srio_swrite_pack_1_reg0
  create_bd_addr_seg -range 0x1000 -offset 0x54200000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs srio_swrite_unpack_0/S_AXI/reg0] SEG_srio_swrite_unpack_0_reg0
  create_bd_addr_seg -range 0x1000 -offset 0x42000000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs sys_reg_0/S_AXI/reg0] SEG_sys_reg_0_reg0
  create_bd_addr_seg -range 0x1000 -offset 0x53500000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs vita49_assem_0/S_AXI/reg0] SEG_vita49_assem_0_reg0
  create_bd_addr_seg -range 0x1000 -offset 0x53600000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs vita49_assem_1/S_AXI/reg0] SEG_vita49_assem_1_reg0
  create_bd_addr_seg -range 0x1000 -offset 0x53000000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs vita49_clk/S_AXI/reg0] SEG_vita49_clk_reg0
  create_bd_addr_seg -range 0x1000 -offset 0x53700000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs vita49_trig_adc_0/S_AXI/reg0] SEG_vita49_trig_adc_0_reg0
  create_bd_addr_seg -range 0x1000 -offset 0x53800000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs vita49_trig_adc_1/S_AXI/reg0] SEG_vita49_trig_adc_1_reg0
  create_bd_addr_seg -range 0x1000 -offset 0x53900000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs vita49_trig_dac_0/S_AXI/reg0] SEG_vita49_trig_dac_0_reg0
  create_bd_addr_seg -range 0x1000 -offset 0x53A00000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs vita49_trig_dac_1/S_AXI/reg0] SEG_vita49_trig_dac_1_reg0

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port spi_mosi_i -pg 1 -y 5280 -defaultsOSRD
preplace port spi_csn_2_o -pg 1 -y 5510 -defaultsOSRD
preplace port rx_frame_in_0_n -pg 1 -y 290 -defaultsOSRD
preplace port DDR -pg 1 -y 5290 -defaultsOSRD
preplace port tx_clk_out_1_p -pg 1 -y 1290 -defaultsOSRD
preplace port rx_clk_in_0_n -pg 1 -y 250 -defaultsOSRD
preplace port rx_frame_in_0_p -pg 1 -y 270 -defaultsOSRD
preplace port srio_rxp0 -pg 1 -y 2910 -defaultsOSRD
preplace port rx_clk_in_0_p -pg 1 -y 220 -defaultsOSRD
preplace port srio_rxp1 -pg 1 -y 2970 -defaultsOSRD
preplace port spi_sclk_o -pg 1 -y 5370 -defaultsOSRD
preplace port rx_frame_in_1_n -pg 1 -y 1380 -defaultsOSRD
preplace port tx_frame_out_0_n -pg 1 -y 110 -defaultsOSRD
preplace port srio_sys_clkn -pg 1 -y 2440 -defaultsOSRD
preplace port srio_rxp2 -pg 1 -y 2540 -defaultsOSRD
preplace port srio_txp0 -pg 1 -y 2750 -defaultsOSRD
preplace port spi_csn_0_i -pg 1 -y 5320 -defaultsOSRD
preplace port srio_rxp3 -pg 1 -y 2560 -defaultsOSRD
preplace port srio_txp1 -pg 1 -y 2790 -defaultsOSRD
preplace port spi_mosi_o -pg 1 -y 5410 -defaultsOSRD
preplace port spi_miso_i -pg 1 -y 5300 -defaultsOSRD
preplace port tx_frame_out_1_n -pg 1 -y 1350 -defaultsOSRD
preplace port rx_frame_in_1_p -pg 1 -y 1360 -defaultsOSRD
preplace port tx_frame_out_0_p -pg 1 -y 90 -defaultsOSRD
preplace port tx_clk_out_0_n -pg 1 -y 70 -defaultsOSRD
preplace port srio_sys_clkp -pg 1 -y 2460 -defaultsOSRD
preplace port srio_txp2 -pg 1 -y 2830 -defaultsOSRD
preplace port srio_rxn0 -pg 1 -y 2520 -defaultsOSRD
preplace port srio_txp3 -pg 1 -y 2870 -defaultsOSRD
preplace port srio_txn0 -pg 1 -y 2620 -defaultsOSRD
preplace port tx_frame_out_1_p -pg 1 -y 1330 -defaultsOSRD
preplace port tx_clk_out_0_p -pg 1 -y 40 -defaultsOSRD
preplace port FIXED_IO -pg 1 -y 5310 -defaultsOSRD
preplace port srio_rxn1 -pg 1 -y 2930 -defaultsOSRD
preplace port srio_txn1 -pg 1 -y 2770 -defaultsOSRD
preplace port rx_clk_in_1_n -pg 1 -y 1340 -defaultsOSRD
preplace port srio_rxn2 -pg 1 -y 2990 -defaultsOSRD
preplace port srio_txn2 -pg 1 -y 2810 -defaultsOSRD
preplace port spi_csn_1_o -pg 1 -y 5490 -defaultsOSRD
preplace port srio_rxn3 -pg 1 -y 2950 -defaultsOSRD
preplace port srio_txn3 -pg 1 -y 2850 -defaultsOSRD
preplace port spi_sclk_i -pg 1 -y 5260 -defaultsOSRD
preplace port spi_csn_0_o -pg 1 -y 5470 -defaultsOSRD
preplace port rx_clk_in_1_p -pg 1 -y 1320 -defaultsOSRD
preplace port tx_clk_out_1_n -pg 1 -y 1310 -defaultsOSRD
preplace portBus rx_data_in_1_p -pg 1 -y 1400 -defaultsOSRD
preplace portBus GPIO_T -pg 1 -y 5210 -defaultsOSRD
preplace portBus GPIO_I -pg 1 -y 5860 -defaultsOSRD
preplace portBus tx_data_out_0_n -pg 1 -y 150 -defaultsOSRD
preplace portBus rx_data_in_0_n -pg 1 -y 330 -defaultsOSRD
preplace portBus tx_data_out_0_p -pg 1 -y 130 -defaultsOSRD
preplace portBus axi_gpio -pg 1 -y 3050 -defaultsOSRD
preplace portBus tx_data_out_1_n -pg 1 -y 1390 -defaultsOSRD
preplace portBus rx_data_in_0_p -pg 1 -y 310 -defaultsOSRD
preplace portBus tx_data_out_1_p -pg 1 -y 1370 -defaultsOSRD
preplace portBus GPIO_O -pg 1 -y 5160 -defaultsOSRD
preplace portBus rx_data_in_1_n -pg 1 -y 1420 -defaultsOSRD
preplace inst vita_pack_adc_reg_0 -pg 1 -lvl 8 -y 3120 -defaultsOSRD
preplace inst vita_pack_adc_reg_1 -pg 1 -lvl 8 -y 3350 -defaultsOSRD
preplace inst dac_ddr_sw_0_reg -pg 1 -lvl 12 -y 4240 -defaultsOSRD
preplace inst axis_64to32_adc_0 -pg 1 -lvl 6 -y 2980 -defaultsOSRD
preplace inst sys_rstgen -pg 1 -lvl 1 -y 4790 -defaultsOSRD
preplace inst srio_gen2_0 -pg 1 -lvl 16 -y 2500 -defaultsOSRD
preplace inst axis_64to32_srio_target -pg 1 -lvl 12 -y 4750 -defaultsOSRD
preplace inst axis_64to32_adc_1 -pg 1 -lvl 6 -y 3130 -defaultsOSRD
preplace inst srio_swrite_pack_0 -pg 1 -lvl 13 -y 3680 -defaultsOSRD
preplace inst axis_32to64_srio_init -pg 1 -lvl 13 -y 4240 -defaultsOSRD
preplace inst axi_srio_target_fifo -pg 1 -lvl 13 -y 4460 -defaultsOSRD
preplace inst drpwe_concat -pg 1 -lvl 15 -y 1690 -defaultsOSRD
preplace inst drpen_concat -pg 1 -lvl 15 -y 2080 -defaultsOSRD
preplace inst const_1 -pg 1 -lvl 10 -y 5320 -defaultsOSRD
preplace inst srio_swrite_pack_1 -pg 1 -lvl 13 -y 3270 -defaultsOSRD
preplace inst drpdi_concat -pg 1 -lvl 15 -y 1910 -defaultsOSRD
preplace inst axis_vita49_pack_0 -pg 1 -lvl 9 -y 3120 -defaultsOSRD
preplace inst srio_dma_reg_0_delete -pg 1 -lvl 13 -y 3520 -defaultsOSRD
preplace inst drprdy_slice_0 -pg 1 -lvl 19 -y 1980 -defaultsOSRD
preplace inst c_counter_binary_0 -pg 1 -lvl 2 -y 4780 -defaultsOSRD
preplace inst vita49_clk -pg 1 -lvl 4 -y 3600 -defaultsOSRD
preplace inst axis_vita49_pack_1 -pg 1 -lvl 9 -y 3390 -defaultsOSRD
preplace inst axi_ad9361_0_adc_dma_interconnect -pg 1 -lvl 15 -y 6000 -defaultsOSRD
preplace inst srio_treq_intc -pg 1 -lvl 2 -y 4580 -defaultsOSRD
preplace inst drprdy_slice_1 -pg 1 -lvl 19 -y 1820 -defaultsOSRD
preplace inst dac_fifo_0 -pg 1 -lvl 10 -y 4660 -defaultsOSRD
preplace inst srio_swrite_unpack_0 -pg 1 -lvl 6 -y 3490 -defaultsOSRD
preplace inst drprdy_slice_2 -pg 1 -lvl 19 -y 2190 -defaultsOSRD
preplace inst dac_fifo_1 -pg 1 -lvl 10 -y 3760 -defaultsOSRD
preplace inst axi_sg_interconnect -pg 1 -lvl 15 -y 4730 -defaultsOSRD
preplace inst axi_ad9361_1_dac_dma_interconnect -pg 1 -lvl 15 -y 5060 -defaultsOSRD
preplace inst vita_trig_dac_reg_0 -pg 1 -lvl 16 -y 3510 -defaultsOSRD
preplace inst drprdy_slice_3 -pg 1 -lvl 19 -y 2350 -defaultsOSRD
preplace inst hello_router_0 -pg 1 -lvl 3 -y 4610 -defaultsOSRD
preplace inst vita49_trig_dac_0 -pg 1 -lvl 17 -y 3290 -defaultsOSRD
preplace inst axis_adc_interconnect_0 -pg 1 -lvl 5 -y 2560 -defaultsOSRD
preplace inst adi_dma_split_0 -pg 1 -lvl 10 -y 4480 -defaultsOSRD
preplace inst vita_trig_dac_reg_1 -pg 1 -lvl 15 -y 3090 -defaultsOSRD
preplace inst drpdo_slice_0 -pg 1 -lvl 19 -y 1600 -defaultsOSRD
preplace inst dac_ddr_sw_0 -pg 1 -lvl 11 -y 5330 -defaultsOSRD
preplace inst axis_adc_interconnect_1 -pg 1 -lvl 5 -y 3110 -defaultsOSRD
preplace inst util_dac_unpack_0 -pg 1 -lvl 3 -y 1190 -defaultsOSRD
preplace inst vita49_trig_dac_1 -pg 1 -lvl 16 -y 3260 -defaultsOSRD
preplace inst axi_srio_initiator_fifo -pg 1 -lvl 12 -y 4440 -defaultsOSRD
preplace inst adi_dma_split_1 -pg 1 -lvl 10 -y 3990 -defaultsOSRD
preplace inst srio_iresp_intc -pg 1 -lvl 10 -y 5050 -defaultsOSRD
preplace inst drpdo_slice_1 -pg 1 -lvl 19 -y 1710 -defaultsOSRD
preplace inst dac_ddr_sw_1 -pg 1 -lvl 11 -y 3730 -defaultsOSRD
preplace inst util_dac_unpack_1 -pg 1 -lvl 3 -y 2420 -defaultsOSRD
preplace inst axis_64to32_dac_0 -pg 1 -lvl 13 -y 4120 -defaultsOSRD
preplace inst adi2axis_0 -pg 1 -lvl 4 -y 2310 -defaultsOSRD
preplace inst drpdo_slice_2 -pg 1 -lvl 19 -y 2080 -defaultsOSRD
preplace inst axis_64to32_dac_1 -pg 1 -lvl 12 -y 3220 -defaultsOSRD
preplace inst adi2axis_1 -pg 1 -lvl 4 -y 3330 -defaultsOSRD
preplace inst drpdo_slice_3 -pg 1 -lvl 19 -y 2270 -defaultsOSRD
preplace inst adi_dma_comb_0 -pg 1 -lvl 13 -y 3920 -defaultsOSRD
preplace inst srio_swrite_unpack_reg -pg 1 -lvl 5 -y 3390 -defaultsOSRD
preplace inst irq_stub11 -pg 1 -lvl 14 -y 3990 -defaultsOSRD
preplace inst drpaddr_concat -pg 1 -lvl 15 -y 2250 -defaultsOSRD
preplace inst adi_dma_comb_1 -pg 1 -lvl 8 -y 3660 -defaultsOSRD
preplace inst srio_tresp_intc -pg 1 -lvl 15 -y 4430 -defaultsOSRD
preplace inst srio_treq_sw -pg 1 -lvl 4 -y 4630 -defaultsOSRD
preplace inst util_adc_pack_0 -pg 1 -lvl 3 -y 760 -defaultsOSRD
preplace inst sys_concat_intc -pg 1 -lvl 15 -y 3890 -defaultsOSRD
preplace inst ddr_fifo -pg 1 -lvl 7 -y 3710 -defaultsOSRD
preplace inst vita49_assem_0 -pg 1 -lvl 9 -y 4350 -defaultsOSRD
preplace inst util_adc_pack_1 -pg 1 -lvl 3 -y 1890 -defaultsOSRD
preplace inst axis_vita49_unpack_0 -pg 1 -lvl 15 -y 3430 -defaultsOSRD
preplace inst axis_64to32_srio_init -pg 1 -lvl 11 -y 5500 -defaultsOSRD
preplace inst axi_ad9361_0 -pg 1 -lvl 4 -y 420 -defaultsOSRD
preplace inst srio_ireq_intc -pg 1 -lvl 15 -y 2900 -defaultsOSRD
preplace inst axis_vita49_unpack_1 -pg 1 -lvl 14 -y 3120 -defaultsOSRD
preplace inst axi_ad9361_1 -pg 1 -lvl 4 -y 1520 -defaultsOSRD
preplace inst vita49_trig_adc_0 -pg 1 -lvl 7 -y 2990 -defaultsOSRD
preplace inst vita49_assem_1 -pg 1 -lvl 9 -y 4020 -defaultsOSRD
preplace inst axi_cpu_interconnect -pg 1 -lvl 3 -y 3750 -defaultsOSRD
preplace inst vita49_trig_adc_1 -pg 1 -lvl 7 -y 3280 -defaultsOSRD
preplace inst axis2adi_0 -pg 1 -lvl 20 -y 1000 -defaultsOSRD
preplace inst srio_target_reg -pg 1 -lvl 11 -y 5650 -defaultsOSRD
preplace inst srio_dma -pg 1 -lvl 11 -y 4250 -defaultsOSRD
preplace inst axis_32to64_srio_target -pg 1 -lvl 14 -y 4450 -defaultsOSRD
preplace inst axis2adi_1 -pg 1 -lvl 19 -y 1410 -defaultsOSRD
preplace inst srio_ireq_sw -pg 1 -lvl 14 -y 3420 -defaultsOSRD
preplace inst irq_stub0 -pg 1 -lvl 14 -y 3580 -defaultsOSRD
preplace inst adc_fifo_0 -pg 1 -lvl 11 -y 3400 -defaultsOSRD
preplace inst irq_stub1 -pg 1 -lvl 14 -y 3660 -defaultsOSRD
preplace inst adc_fifo_1 -pg 1 -lvl 11 -y 3210 -defaultsOSRD
preplace inst sys_ps7 -pg 1 -lvl 16 -y 5430 -defaultsOSRD
preplace inst irq_stub2 -pg 1 -lvl 14 -y 3780 -defaultsOSRD
preplace inst constant_0 -pg 1 -lvl 9 -y 4970 -defaultsOSRD
preplace inst sys_reg_0 -pg 1 -lvl 4 -y 2990 -defaultsOSRD
preplace inst irq_stub3 -pg 1 -lvl 14 -y 3860 -defaultsOSRD
preplace inst routing_reg_0 -pg 1 -lvl 4 -y 4140 -defaultsOSRD
preplace inst adc_ddr_tdest_0 -pg 1 -lvl 11 -y 4410 -defaultsOSRD
preplace inst srio_dma_split_0 -pg 1 -lvl 12 -y 3750 -defaultsOSRD
preplace inst axi_ad9361_1_adc_dma_interconnect -pg 1 -lvl 15 -y 5720 -defaultsOSRD
preplace inst adc_ddr_tdest_1 -pg 1 -lvl 11 -y 4040 -defaultsOSRD
preplace inst srio_dma_comb_0 -pg 1 -lvl 10 -y 4260 -defaultsOSRD
preplace inst axi_srio_interconnect -pg 1 -lvl 11 -y 4970 -defaultsOSRD
preplace inst axis_dac_interconnect_0 -pg 1 -lvl 19 -y 1190 -defaultsOSRD
preplace inst dac_ddr_tdest_0 -pg 1 -lvl 10 -y 4820 -defaultsOSRD
preplace inst axis_dac_interconnect_1 -pg 1 -lvl 18 -y 1510 -defaultsOSRD
preplace inst axis_32to64_adc_0 -pg 1 -lvl 10 -y 3210 -defaultsOSRD
preplace inst vita_dac_sw -pg 1 -lvl 8 -y 3990 -defaultsOSRD
preplace inst dac_ddr_tdest_1 -pg 1 -lvl 10 -y 5230 -defaultsOSRD
preplace inst axis_32to64_adc_1 -pg 1 -lvl 10 -y 3530 -defaultsOSRD
preplace inst axis_32to64_dac_0 -pg 1 -lvl 18 -y 2160 -defaultsOSRD
preplace inst xlslice_0 -pg 1 -lvl 3 -y 4780 -defaultsOSRD
preplace inst axis_32to64_dac_1 -pg 1 -lvl 17 -y 2960 -defaultsOSRD
preplace inst xlslice_1 -pg 1 -lvl 20 -y 5160 -defaultsOSRD
preplace inst axi_ad9361_0_dac_dma_interconnect -pg 1 -lvl 15 -y 5370 -defaultsOSRD
preplace inst vita_unpack_dac_reg_0 -pg 1 -lvl 14 -y 4130 -defaultsOSRD
preplace inst const_loopback -pg 1 -lvl 1 -y 5910 -defaultsOSRD
preplace inst adc_ddr_sw_0 -pg 1 -lvl 12 -y 4060 -defaultsOSRD
preplace inst vita_unpack_dac_reg_1 -pg 1 -lvl 13 -y 3080 -defaultsOSRD
preplace inst adc_ddr_sw_1 -pg 1 -lvl 12 -y 3410 -defaultsOSRD
preplace inst axi_gpio -pg 1 -lvl 4 -y 3860 -defaultsOSRD
preplace inst axi_dma_0 -pg 1 -lvl 14 -y 4680 -defaultsOSRD
preplace inst drp_bridge_0 -pg 1 -lvl 12 -y 1850 -defaultsOSRD
preplace inst axi_dma_1 -pg 1 -lvl 9 -y 3670 -defaultsOSRD
preplace inst srio_maint_reg -pg 1 -lvl 15 -y 4260 -defaultsOSRD
preplace netloc axis_64to32_strb_0_M_AXIS 1 11 1 6120
preplace netloc drp_bridge_0_drp1_we 1 12 3 6640 1680 NJ 1680 NJ
preplace netloc axis_vita49_pack_1_M_AXIS 1 9 1 5120
preplace netloc axi_cpu_interconnect_s00_axi 1 2 15 1020 2670 NJ 2670 NJ 2680 NJ 2670 NJ 2670 NJ 2670 NJ 2670 NJ 2670 NJ 2670 NJ 2670 NJ 2670 NJ 2670 NJ 2670 NJ 3010 9110
preplace netloc srio_dma_comb_0_M_AXIS 1 10 1 5580
preplace netloc srio_gen2_0_gtrx_disperr_or 1 3 14 1870 2780 NJ 2780 NJ 2780 NJ 2780 NJ 2780 NJ 2780 NJ 2780 NJ 2780 NJ 2780 NJ 2780 NJ 2770 NJ 2770 NJ 2980 9140
preplace netloc S00_AXIS_1 1 4 1 2410
preplace netloc irq_stub3_dout 1 14 1 7800
preplace netloc axi_dma_1_M_AXI_S2MM 1 9 6 N 3640 NJ 3640 NJ 3640 NJ 3800 NJ 3730 NJ
preplace netloc S00_AXIS_2 1 4 1 2660
preplace netloc axi_ad9361_0_dac_enable_0 1 2 3 960 1030 NJ 1030 2340
preplace netloc srio_rxp3_1 1 0 16 NJ 2560 NJ 2560 NJ 2610 NJ 2610 NJ 2340 NJ 2340 NJ 2340 NJ 2340 NJ 2340 NJ 2340 NJ 2340 NJ 2340 NJ 2340 NJ 2340 NJ 2340 8490
preplace netloc axis_dac_interconnect_1_M00_AXIS 1 18 1 9950
preplace netloc axi_ad9361_0_dac_enable_1 1 2 3 970 1040 NJ 1040 2330
preplace netloc srio_gen2_0_gtrx_notintable_or 1 3 14 1810 2170 NJ 2170 NJ 2170 NJ 2170 NJ 2170 NJ 2170 NJ 2170 NJ 2170 NJ 2180 NJ 2000 NJ 2000 NJ 2000 NJ 2000 9130
preplace netloc axi_ad9361_0_dac_enable_2 1 2 3 980 1050 NJ 1050 2310
preplace netloc sys_reg_0_gt_rxlpmen 1 4 12 2590 2430 NJ 2530 NJ 2530 NJ 2530 NJ 2530 NJ 2530 NJ 2530 NJ 2530 NJ 2530 NJ 2530 NJ 2530 NJ
preplace netloc vita49_trig_dac_1_trig 1 13 4 7270 3250 NJ 3250 NJ 3380 9050
preplace netloc axi_dma_0_mm2s_introut 1 14 1 7620
preplace netloc axi_ad9361_0_dac_enable_3 1 2 3 990 1060 NJ 1060 2290
preplace netloc axi_cpu_interconnect_M21_AXI 1 3 14 NJ 3950 NJ 3860 NJ 3860 NJ 3860 NJ 3860 NJ 3860 NJ 3860 NJ 3860 NJ 3860 NJ 4040 NJ 4040 NJ 3160 NJ 3140 9210
preplace netloc irq_stub11_dout 1 14 1 7840
preplace netloc srio_treq_intc_M00_AXIS 1 2 1 N
preplace netloc axis_vita49_unpack_1_M_AXIS 1 14 1 N
preplace netloc axis_32to64_dac_0_M_AXIS 1 18 1 9940
preplace netloc fifo_valid_0 1 3 18 NJ 1070 NJ 1070 NJ 1070 NJ 1070 NJ 1070 NJ 1070 NJ 1070 NJ 1070 NJ 1070 NJ 1070 NJ 1070 NJ 1070 NJ 1070 NJ 1070 NJ 1070 NJ 1070 NJ 1080 10730
preplace netloc drp_bridge_0_drp1_di 1 12 3 NJ 1760 NJ 1760 7850
preplace netloc adi_dma_split_1_M_AXIS 1 10 1 5470
preplace netloc routing_reg_0_dac_ddr_sw_0_tdest 1 4 6 NJ 4140 NJ 4140 NJ 4140 NJ 4140 NJ 4170 5000
preplace netloc fifo_valid_1 1 3 17 NJ 2450 NJ 2290 NJ 2290 NJ 2290 NJ 2290 NJ 2290 NJ 2290 NJ 2290 NJ 2290 NJ 2290 NJ 2290 NJ 2370 NJ 3030 NJ 3030 NJ 3030 NJ 3030 10380
preplace netloc drpdo_slice_0_Dout 1 12 8 N 1600 NJ 1600 NJ 1600 NJ 1600 NJ 1600 NJ 1630 NJ 1550 10320
preplace netloc vita49_trig_adc_0_M_AXIS 1 7 1 4110
preplace netloc srio_swrite_unpack_0_M_AXIS 1 6 1 3540
preplace netloc fifo_data_0 1 3 18 NJ 920 NJ 920 NJ 920 NJ 920 NJ 920 NJ 920 NJ 920 NJ 920 NJ 920 NJ 920 NJ 920 NJ 920 NJ 920 NJ 920 NJ 920 NJ 920 NJ 920 10730
preplace netloc drpdo_slice_3_Dout 1 12 8 NJ 1790 NJ 1790 NJ 1790 NJ 1870 NJ 1870 NJ 1870 NJ 1870 10350
preplace netloc fifo_data_1 1 3 17 NJ 2160 NJ 2160 NJ 2160 NJ 2160 NJ 2160 NJ 2160 NJ 2160 NJ 2160 NJ 2170 NJ 1990 NJ 1990 NJ 1990 NJ 1910 NJ 1910 NJ 1910 NJ 1910 10370
preplace netloc axis_register_slice_0_M_AXIS 1 13 1 7180
preplace netloc srio_gen2_0_port_initialized 1 3 14 1840 2470 NJ 2410 NJ 2410 NJ 2410 NJ 2410 NJ 2410 NJ 2410 NJ 2410 NJ 2410 NJ 2410 NJ 2410 NJ 2410 NJ 2950 9070
preplace netloc axis_32to64_dac_1_M_AXIS 1 17 1 9560
preplace netloc axi_ad9361_0_clk 1 2 18 900 590 1680 880 2650 1050 NJ 1050 NJ 1050 NJ 1050 NJ 1050 NJ 1050 NJ 1050 NJ 1050 NJ 1050 NJ 1050 NJ 1050 NJ 1050 NJ 1050 NJ 1050 10010 1050 NJ
preplace netloc vita49_assem_0_M_AXIS 1 9 1 5020
preplace netloc hello_router_0_M_AXIS 1 3 1 N
preplace netloc axi_srio_initiator_fifo_AXI_STR_TXD 1 12 1 6780
preplace netloc axi_cpu_interconnect_m13_axi 1 3 13 N 3720 NJ 3720 NJ 3720 NJ 3500 NJ 3500 NJ 3520 NJ 3300 NJ 3300 NJ 3300 NJ 3380 NJ 3280 NJ 3190 NJ
preplace netloc drprdy_slice_3_Dout 1 12 8 NJ 1830 NJ 1830 NJ 1830 NJ 1830 NJ 1830 NJ 1830 NJ 1900 10340
preplace netloc axis_32to64_adc_0_M_AXIS 1 10 1 5470
preplace netloc vita_pack_adc_reg_1_M_AXIS 1 8 1 4560
preplace netloc axis_32to64_strb_0_M_AXIS 1 13 1 7220
preplace netloc sys_reg_0_srio_reset 1 4 12 2630 2810 NJ 2810 NJ 2810 NJ 2810 NJ 2810 NJ 2810 NJ 2810 NJ 2810 NJ 2810 NJ 2810 NJ 2590 NJ
preplace netloc srio_rxp0_1 1 0 16 NJ 2730 NJ 2730 NJ 2730 NJ 2730 NJ 2730 NJ 2730 NJ 2730 NJ 2730 NJ 2730 NJ 2730 NJ 2730 NJ 2730 NJ 2730 NJ 2730 NJ 2730 N
preplace netloc vita49_trig_adc_1_trig 1 3 5 1880 3190 NJ 3230 NJ 3230 NJ 3160 4060
preplace netloc dac_ddr_sw_0_M01_AXIS 1 11 1 6090
preplace netloc adc_ddr_tdest_0_dout 1 11 1 6020
preplace netloc sys_100m_clk 1 0 17 230 4660 570 4440 890 4450 1570 3480 NJ 3480 3110 3620 3530 3580 4110 3560 4550 4190 5120 3890 5590 3600 6130 3600 6780 4030 7210 4060 7880 4090 8550 3420 9240
preplace netloc axi_ad9361_1_adc_enable_0 1 2 3 930 2110 NJ 1960 2320
preplace netloc axis_vita49_unpack_0_M_AXIS 1 15 1 8260
preplace netloc axi_ad9361_1_adc_enable_1 1 2 3 920 2190 NJ 2100 2430
preplace netloc adi_dma_comb_1_M_AXIS 1 8 1 4620
preplace netloc axi_ad9361_0_rx_frame_in_n 1 0 4 NJ 270 NJ 270 NJ 270 1680
preplace netloc util_adc_pack_0_ddata 1 3 1 1700
preplace netloc axi_ad9361_1_adc_enable_2 1 2 3 950 2140 NJ 2110 2400
preplace netloc srio_treq_sw_M00_AXIS 1 4 7 NJ 4600 NJ 4600 NJ 4600 NJ 4600 NJ 4600 NJ 4890 5470
preplace netloc srio_dma_s2mm_introut 1 11 4 NJ 4350 NJ 4350 NJ 4350 NJ
preplace netloc srio_gen2_0_link_initialized 1 3 14 1850 2490 NJ 2390 NJ 2390 NJ 2390 NJ 2390 NJ 2390 NJ 2390 NJ 2390 NJ 2390 NJ 2390 NJ 2390 NJ 2390 NJ 2960 9080
preplace netloc axi_ad9361_1_adc_enable_3 1 2 3 1010 2130 NJ 2130 2380
preplace netloc axi_cpu_interconnect_M27_AXI 1 3 7 NJ 4000 NJ 3830 NJ 3830 NJ 3830 NJ 3820 NJ 3820 5040
preplace netloc axi_ad9361_0_rx_frame_in_p 1 0 4 NJ 280 NJ 280 NJ 280 1280
preplace netloc axi_cpu_interconnect_M26_AXI 1 3 10 NJ 3980 NJ 3870 NJ 3870 NJ 3870 NJ 3870 NJ 3870 NJ 3870 NJ 3870 NJ 3870 N
preplace netloc drp_bridge_0_drp1_en 1 12 3 NJ 1780 NJ 1780 7770
preplace netloc axi_ad9361_0_tx_clk_out_n 1 4 17 N 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ
preplace netloc vita49_clk_tsi_0 1 4 13 NJ 3270 NJ 3060 3500 3110 NJ 3200 4630 3240 NJ 3110 NJ 3110 NJ 3110 NJ 3170 NJ 3530 7890 3560 NJ 3580 NJ
preplace netloc irq_stub0_dout 1 14 1 7760
preplace netloc drp_bridge_0_drp0_di 1 12 3 NJ 1620 NJ 1620 7910
preplace netloc vita49_clk_tsi_1 1 4 12 NJ 3590 NJ 3610 3550 3480 NJ 3480 4630 3810 NJ 3660 NJ 3530 NJ 3530 NJ 3410 7130 3270 NJ 3270 NJ
preplace netloc axi_ad9361_0_tx_clk_out_p 1 4 17 N 40 NJ 40 NJ 40 NJ 40 NJ 40 NJ 40 NJ 40 NJ 40 NJ 40 NJ 40 NJ 40 NJ 40 NJ 40 NJ 40 NJ 40 NJ 40 NJ
preplace netloc sys_fmc_dma_clk 1 1 18 600 4700 1010 4700 1840 3180 2720 2910 3120 2910 3580 3560 4080 3210 4570 3830 5080 3130 5530 3490 6080 3150 6720 4550 7250 4200 7810 3170 8510 3130 9200 2160 9550 1190 9960
preplace netloc axi_cpu_interconnect_m00_axi 1 3 1 1460
preplace netloc vita49_trig_adc_0_trig 1 3 5 1840 2460 NJ 2320 NJ 2320 NJ 2320 4080
preplace netloc axis_64to32_adc_1_M_AXIS 1 6 1 3640
preplace netloc axis_vita49_unpack_1_irq 1 14 1 7770
preplace netloc vita_trig_dac_reg_1_M_AXIS 1 15 1 8230
preplace netloc axi_dma_0_M_AXI_S2MM 1 14 1 7610
preplace netloc drp_bridge_0_drp3_di 1 12 3 NJ 1940 NJ 1940 N
preplace netloc axi_ad9361_1_dac_dunf 1 3 17 1810 1950 NJ 1530 NJ 1530 NJ 1530 NJ 1530 NJ 1530 NJ 1530 NJ 1530 NJ 1530 NJ 1530 NJ 1530 NJ 1530 NJ 1530 NJ 1530 NJ 1650 NJ 1650 10360
preplace netloc srio_ireq_intc_M00_AXIS 1 15 1 8270
preplace netloc srio_rxn0_1 1 0 16 NJ 2520 NJ 2520 NJ 2560 NJ 2560 NJ 2300 NJ 2300 NJ 2300 NJ 2300 NJ 2300 NJ 2300 NJ 2300 NJ 2300 NJ 2300 NJ 2300 NJ 2450 8460
preplace netloc sys_ps7_fixed_io 1 16 5 N 5250 NJ 5250 NJ 5250 NJ 5250 NJ
preplace netloc axi_ad9361_0_dac_dunf 1 3 18 1810 850 NJ 850 NJ 850 NJ 850 NJ 850 NJ 850 NJ 850 NJ 850 NJ 850 NJ 850 NJ 850 NJ 850 NJ 850 NJ 850 NJ 850 NJ 850 NJ 850 10740
preplace netloc axis_vita49_unpack_0_irq 1 14 2 7900 3280 8250
preplace netloc sys_200m_clk 1 3 14 1750 860 NJ 860 NJ 860 NJ 860 NJ 860 NJ 860 NJ 860 NJ 860 NJ 860 NJ 860 NJ 860 NJ 860 NJ 860 9170
preplace netloc adc_ddr_sw_1_M01_AXIS 1 12 1 6650
preplace netloc xlslice_0_Dout 1 3 1 1870
preplace netloc spi_mosi_i 1 0 17 NJ 4700 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4750 NJ 4650 NJ 4650 NJ 4650 NJ 4820 NJ 5870 NJ 5870 9070
preplace netloc axi_gpio_1 1 0 5 NJ 2810 NJ 2810 NJ 2810 NJ 2810 2250
preplace netloc srio_gen2_0_log_clk_out 1 1 16 610 4920 NJ 4920 NJ 4920 NJ 4920 NJ 4920 NJ 4920 NJ 4920 NJ 4920 4980 4920 5600 4560 NJ 4560 NJ 4560 NJ 4560 7780 2650 NJ 2970 9120
preplace netloc srio_gen2_0_TARGET_REQ 1 1 16 610 2550 NJ 2550 NJ 2550 NJ 2380 NJ 2380 NJ 2380 NJ 2380 NJ 2380 NJ 2380 NJ 2380 NJ 2380 NJ 2380 NJ 2380 NJ 2380 NJ 2900 9110
preplace netloc srio_gen2_0_srio_txn0 1 16 5 9190 2620 NJ 2620 NJ 2620 NJ 2620 NJ
preplace netloc axi_cpu_interconnect_m07_axi 1 3 6 1740 2760 NJ 2760 NJ 2760 NJ 2760 NJ 2760 NJ
preplace netloc srio_gen2_0_srio_txn1 1 16 5 N 2740 NJ 2740 NJ 2740 NJ 2740 NJ
preplace netloc srio_rxn1_1 1 0 16 NJ 2720 NJ 2720 NJ 2720 NJ 2720 NJ 2720 NJ 2710 NJ 2710 NJ 2710 NJ 2710 NJ 2710 NJ 2710 NJ 2710 NJ 2710 NJ 2710 NJ 2710 8420
preplace netloc spi_mosi_o 1 16 5 N 5350 NJ 5350 NJ 5350 NJ 5350 NJ
preplace netloc srio_gen2_0_srio_txn2 1 16 5 N 2780 NJ 2780 NJ 2780 NJ 2780 NJ
preplace netloc axi_ad9361_1_tx_frame_out_n 1 4 17 2720 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1500 NJ 1350 NJ
preplace netloc srio_gen2_0_srio_txn3 1 16 5 N 2820 NJ 2820 NJ 2820 NJ 2820 NJ
preplace netloc drp_bridge_0_drp1_addr 1 12 3 NJ 1840 NJ 1840 7630
preplace netloc axi_ad9361_1_tx_frame_out_p 1 4 17 N 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1320 NJ 1320 NJ
preplace netloc srio_tresp_intc_M00_AXIS 1 15 1 8330
preplace netloc srio_swrite_pack_0_M_AXIS 1 13 1 7170
preplace netloc axi_ad9361_1_rx_data_in_n 1 0 4 NJ 1420 NJ 1420 NJ 1420 N
preplace netloc drp_bridge_0_drp0_en 1 12 3 NJ 1640 NJ 1640 7880
preplace netloc axi_cpu_interconnect_M24_AXI 1 3 7 NJ 3960 NJ 3840 NJ 3840 NJ 3840 NJ 3840 NJ 3840 5010
preplace netloc axi_ad9361_1_dac_data_0 1 3 1 1490
preplace netloc axi_srio_target_fifo_interrupt 1 13 2 7150 4520 NJ
preplace netloc axi_cpu_interconnect_M18_AXI 1 3 3 1830 3460 NJ 3460 NJ
preplace netloc constant_0_dout 1 9 1 5130
preplace netloc axi_ad9361_1_rx_data_in_p 1 0 4 NJ 1400 NJ 1400 NJ 1400 N
preplace netloc axi_dma_1_s2mm_introut 1 9 6 5030 3620 NJ 3610 NJ 3650 NJ 3810 NJ 3910 NJ
preplace netloc axi_ad9361_1_dac_data_1 1 3 1 1520
preplace netloc adc_fifo_0_M_AXIS 1 11 1 6020
preplace netloc drpen_concat_dout 1 15 1 8510
preplace netloc axi_ad9361_1_dac_data_2 1 3 1 1550
preplace netloc vita_unpack_dac_reg_1_M_AXIS 1 13 1 7200
preplace netloc axi_dma_1_M_AXI_MM2S 1 9 6 5020 3840 NJ 3840 NJ 3850 NJ 3820 NJ 3930 NJ
preplace netloc axi_cpu_interconnect_M17_AXI 1 3 10 1850 3790 NJ 3790 NJ 3790 NJ 3540 NJ 3540 NJ 3540 NJ 3100 NJ 3100 NJ 3100 NJ
preplace netloc adc_ddr_sw_1_M00_AXIS 1 7 6 4120 2980 NJ 2980 NJ 2980 NJ 2980 NJ 2980 6630
preplace netloc adc_ddr_sw_0_M01_AXIS 1 12 1 6750
preplace netloc drp_bridge_0_drp3_en 1 12 3 NJ 2060 NJ 2060 7620
preplace netloc drpdo_slice_1_Dout 1 12 8 N 1740 NJ 1740 NJ 1770 NJ 1760 NJ 1760 NJ 1760 NJ 1760 10320
preplace netloc axi_ad9361_1_dac_data_3 1 3 1 1590
preplace netloc vita_trig_dac_reg_0_M_AXIS 1 16 1 9210
preplace netloc srio_dma_mm2s_introut 1 11 4 NJ 4330 NJ 4330 NJ 4330 NJ
preplace netloc srio_ireq_sw_M00_AXIS 1 14 1 7610
preplace netloc vita49_assem_1_M_AXIS 1 9 1 5060
preplace netloc axis_32to64_strb_0_M_AXIS1 1 14 1 7610
preplace netloc srio_gen2_0_phy_rcvd_link_reset 1 3 14 1800 2180 NJ 2180 NJ 2180 NJ 2180 NJ 2180 NJ 2180 NJ 2180 NJ 2180 NJ 2200 NJ 2170 NJ 2170 NJ 2170 NJ 2100 9120
preplace netloc vita49_trig_dac_1_M_AXIS 1 16 1 9190
preplace netloc util_adc_pack_0_dsync 1 3 1 1690
preplace netloc vita_unpack_dac_reg_0_M_AXIS 1 14 1 7790
preplace netloc axi_cpu_interconnect_m10_axi 1 3 1 1810
preplace netloc axi_ad9361_0_adc_chan_q1 1 2 3 970 980 NJ 980 2380
preplace netloc axi_ad9361_0_adc_chan_q2 1 2 3 1020 990 NJ 990 2300
preplace netloc drp_bridge_0_drp0_addr 1 12 3 NJ 1700 NJ 1700 7820
preplace netloc adc_ddr_tdest_1_dout 1 11 1 5960
preplace netloc axi_ad9361_1_dac_valid_0 1 2 3 1000 2220 NJ 1990 2260
preplace netloc axis_64to32_strb_0_M_AXIS1 1 12 1 6780
preplace netloc axi_dma_0_M_AXI_MM2S 1 14 1 7650
preplace netloc axi_cpu_interconnect_m04_axi 1 3 11 NJ 3500 NJ 3500 NJ 3600 NJ 3550 NJ 3550 NJ 3790 NJ 3650 NJ 3510 NJ 3510 NJ 3450 7160
preplace netloc axi_ad9361_1_dac_valid_1 1 2 3 1020 2290 NJ 2440 2350
preplace netloc srio_rxn2_1 1 0 16 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2780 NJ 2780 8370
preplace netloc routing_reg_0_adc_sw_dest0 1 4 7 NJ 4160 NJ 4160 NJ 4160 NJ 4160 NJ 4160 NJ 4160 5560
preplace netloc axi_ad9361_1_dac_valid_2 1 2 3 1010 2580 NJ 2580 2340
preplace netloc routing_reg_0_adc_sw_dest1 1 4 7 NJ 4100 NJ 4100 NJ 4100 NJ 4100 NJ 4120 NJ 4090 NJ
preplace netloc drp_bridge_0_drp0_we 1 12 3 N 1660 NJ 1660 NJ
preplace netloc axi_ad9361_1_dac_valid_3 1 2 3 1020 2590 NJ 2590 2330
preplace netloc dac_ddr_sw_0_M00_AXIS 1 11 1 6110
preplace netloc srio_sys_clkn_1 1 0 16 NJ 2240 NJ 2240 NJ 2240 NJ 2140 NJ 2140 NJ 2140 NJ 2140 NJ 2140 NJ 2140 NJ 2140 NJ 2140 NJ 2190 NJ 2160 NJ 2160 NJ 2160 8520
preplace netloc vita49_trig_dac_0_trig 1 14 4 7910 3290 NJ 3410 NJ 3410 9570
preplace netloc routing_reg_0_adc_ddr_sw_0_tdest 1 4 7 NJ 4120 NJ 4120 NJ 4120 NJ 4120 NJ 4130 NJ 4130 5570
preplace netloc axis_32to64_adc_1_M_AXIS 1 10 1 5460
preplace netloc axi_ad9361_0_adc_dma_interconnect_m00_axi 1 15 1 8530
preplace netloc drp_bridge_0_drp3_we 1 12 3 NJ 1720 NJ 1720 N
preplace netloc const_1_dout 1 10 2 5610 5240 NJ
preplace netloc axis_adc_interconnect_1_M00_AXIS 1 5 1 N
preplace netloc axi_ad9361_1_adc_chan_i1 1 2 3 980 2080 NJ 2080 2440
preplace netloc axi_ad9361_1_adc_chan_i2 1 2 3 960 2160 NJ 2150 2410
preplace netloc srio_gen2_0_srio_txp0 1 16 5 N 2720 NJ 2720 NJ 2720 NJ 2720 NJ
preplace netloc srio_dma_M_AXIS_MM2S 1 11 1 6000
preplace netloc srio_gen2_0_srio_txp1 1 16 5 N 2760 NJ 2760 NJ 2760 NJ 2760 NJ
preplace netloc srio_gen2_0_srio_txp2 1 16 5 N 2800 NJ 2800 NJ 2800 NJ 2800 NJ
preplace netloc sys_ps7_ddr 1 16 5 N 5230 NJ 5230 NJ 5230 NJ 5230 NJ
preplace netloc axis_64to32_adc_0_M_AXIS 1 6 1 3500
preplace netloc srio_gen2_0_srio_txp3 1 16 5 N 2840 NJ 2840 NJ 2840 NJ 2840 NJ
preplace netloc vita_dac_sw_M00_AXIS 1 8 1 4480
preplace netloc axi_dma_1_M_AXIS_MM2S 1 9 1 5070
preplace netloc axi_dma_0_M_AXIS_MM2S 1 9 6 5130 2990 NJ 2990 NJ 2990 NJ 2990 NJ 2990 7600
preplace netloc axi_cpu_interconnect_m11_axi 1 3 6 NJ 3710 NJ 3710 NJ 3710 NJ 3510 NJ 3510 4590
preplace netloc sys_ps7_M_AXI_GP1 1 10 7 5620 2760 NJ 2760 NJ 2760 NJ 2760 NJ 2760 NJ 3040 9100
preplace netloc axi_cpu_interconnect_M01_AXI 1 3 1 1500
preplace netloc spi_csn_i 1 0 17 NJ 5170 NJ 5170 NJ 5170 NJ 5170 NJ 5170 NJ 5170 NJ 5170 NJ 5170 NJ 5170 NJ 5170 NJ 5230 NJ 5220 NJ 5220 NJ 5220 NJ 5220 NJ 5080 9050
preplace netloc srio_rxp2_1 1 0 16 NJ 2540 NJ 2540 NJ 2600 NJ 2600 NJ 2310 NJ 2310 NJ 2310 NJ 2310 NJ 2310 NJ 2310 NJ 2310 NJ 2310 NJ 2310 NJ 2310 NJ 2440 8450
preplace netloc adi_dma_comb_0_M_AXIS 1 13 1 7140
preplace netloc sys_ps7_GPIO_I 1 0 17 NJ 5860 NJ 5860 NJ 5860 NJ 5860 NJ 5860 NJ 5860 NJ 5860 NJ 5860 NJ 5860 NJ 5860 NJ 5860 NJ 5860 NJ 5860 NJ 5860 NJ 5880 NJ 5880 9090
preplace netloc dac_ddr_tdest_0_dout 1 10 1 5500
preplace netloc drprdy_slice_2_Dout 1 12 8 NJ 1820 NJ 1820 NJ 1820 NJ 1820 NJ 1820 NJ 1820 NJ 1890 10320
preplace netloc drp_bridge_0_drp2_di 1 12 3 NJ 1900 NJ 1900 7750
preplace netloc srio_gen2_0_INITIATOR_RESP 1 9 8 5140 3000 NJ 3000 NJ 3000 NJ 2980 NJ 2980 NJ 3020 NJ 3020 9160
preplace netloc c_counter_binary_0_Q 1 2 1 N
preplace netloc spi_csn_o 1 16 5 N 5410 NJ 5410 NJ 5410 NJ 5410 NJ
preplace netloc vita49_trig_adc_1_M_AXIS 1 7 1 4110
preplace netloc axi_ad9361_0_dac_dma_interconnect_m00_axi 1 15 1 N
preplace netloc spi_csn_1_o 1 16 5 N 5430 NJ 5430 NJ 5430 NJ 5430 NJ
preplace netloc srio_gen2_0_clk_lock_out 1 3 14 1880 2690 NJ 2690 NJ 2680 NJ 2680 NJ 2680 NJ 2680 NJ 2680 NJ 2680 NJ 2680 NJ 2680 NJ 2680 NJ 2680 NJ 2910 9050
preplace netloc axi_ad9361_1_tx_clk_out_n 1 4 17 N 1160 NJ 1160 NJ 1160 NJ 1160 NJ 1160 NJ 1160 NJ 1160 NJ 1160 NJ 1160 NJ 1160 NJ 1160 NJ 1160 NJ 1160 NJ 1160 NJ 1310 NJ 1310 NJ
preplace netloc sys_ps7_GPIO_O 1 16 4 9250 5160 NJ 5160 NJ 5160 NJ
preplace netloc vita49_trig_dac_0_M_AXIS 1 17 1 9600
preplace netloc axi_ad9361_0_rx_data_in_n 1 0 4 NJ 320 NJ 320 NJ 320 N
preplace netloc axi_cpu_interconnect_m08_axi 1 3 4 1770 2820 NJ 2860 NJ 2860 NJ
preplace netloc srio_gen2_0_gt_drprdy_out 1 15 4 8560 2990 NJ 2350 NJ 2350 10010
preplace netloc axi_ad9361_1_tx_clk_out_p 1 4 17 2620 1060 NJ 1060 NJ 1060 NJ 1060 NJ 1060 NJ 1060 NJ 1060 NJ 1060 NJ 1060 NJ 1060 NJ 1060 NJ 1060 NJ 1060 NJ 1060 NJ 1060 NJ 1090 NJ
preplace netloc ddr_fifo_M_AXIS 1 7 1 4070
preplace netloc axi_cpu_interconnect_M15_AXI 1 3 4 N 3760 NJ 3240 NJ 3210 NJ
preplace netloc axi_ad9361_0_rx_data_in_p 1 0 4 NJ 300 NJ 300 NJ 300 N
preplace netloc sys_reg_0_gt_txpostcursor 1 4 12 2570 2420 NJ 2420 NJ 2420 NJ 2420 NJ 2420 NJ 2420 NJ 2420 NJ 2420 NJ 2420 NJ 2420 NJ 2420 NJ
preplace netloc axi_cpu_interconnect_m02_axi 1 3 1 1410
preplace netloc axi_srio_interconnect_M02_AXI 1 11 2 6100 4520 NJ
preplace netloc sys_ps7_GPIO_T 1 16 5 N 5210 NJ 5210 NJ 5210 NJ 5210 NJ
preplace netloc drp_bridge_0_drp3_addr 1 12 3 NJ 2120 NJ 2120 7600
preplace netloc vita_pack_adc_reg_0_M_AXIS 1 8 1 4510
preplace netloc adi_dma_split_0_M_AXIS 1 10 1 5520
preplace netloc spi_miso_i 1 0 17 NJ 4680 NJ 4710 NJ 4710 NJ 4710 NJ 4710 NJ 4710 NJ 4710 NJ 4710 NJ 4710 NJ 4740 NJ 4630 NJ 4630 NJ 4630 NJ 4800 NJ 5520 NJ 5780 9060
preplace netloc axi_dma_2_M_AXI_S2MM 1 11 4 NJ 4320 NJ 4320 NJ 4320 7630
preplace netloc srio_gen2_0_phy_rcvd_mce 1 3 14 1880 3160 NJ 3260 NJ 3260 NJ 3410 NJ 3250 NJ 3250 NJ 3310 NJ 3310 NJ 3310 NJ 3390 NJ 3290 NJ 3180 NJ 3060 9150
preplace netloc axi_srio_interconnect_M07_AXI 1 11 1 5980
preplace netloc srio_sys_clkp_1 1 0 16 NJ 2460 NJ 2460 NJ 2620 NJ 2620 NJ 2350 NJ 2350 NJ 2350 NJ 2350 NJ 2350 NJ 2350 NJ 2350 NJ 2350 NJ 2350 NJ 2350 NJ 2350 8250
preplace netloc axi_ad9361_1_clk 1 2 17 900 1720 1750 2480 2610 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 9600 1390 9970
preplace netloc axi_cpu_interconnect_M06_AXI 1 3 1 1760
preplace netloc srio_gen2_0_gt_drpdo_out 1 15 4 8560 2080 NJ 2080 NJ 2080 9990
preplace netloc axi_ad9361_0_dac_data_0 1 3 1 1280
preplace netloc axi_ad9361_1_dac_dma_interconnect_m00_axi 1 15 1 8320
preplace netloc axi_ad9361_0_adc_chan_i1 1 2 3 910 960 NJ 960 2430
preplace netloc axi_ad9361_0_dac_data_1 1 3 1 1290
preplace netloc axi_ad9361_0_dac_data_2 1 3 1 1300
preplace netloc srio_gen2_0_deviceid 1 3 14 1830 2710 NJ 2710 NJ 2690 NJ 2690 NJ 2690 NJ 2690 NJ 2690 NJ 2690 NJ 2690 NJ 2690 NJ 2690 NJ 2690 NJ 2920 9090
preplace netloc axi_ad9361_0_adc_chan_i2 1 2 3 1010 970 NJ 970 2320
preplace netloc srio_treq_sw_M02_AXIS 1 4 6 NJ 4230 NJ 4230 NJ 4230 NJ 4230 NJ 4230 N
preplace netloc axi_ad9361_0_dac_data_3 1 3 1 1310
preplace netloc dac_ddr_tdest_1_dout 1 10 1 5460
preplace netloc routing_reg_0_dac_ddr_sw_1_tdest 1 4 6 NJ 4180 NJ 4180 NJ 4180 NJ 4180 NJ 4180 4950
preplace netloc srio_gen2_0_mode_1x 1 3 14 1860 2500 NJ 2330 NJ 2330 NJ 2330 NJ 2330 NJ 2330 NJ 2330 NJ 2330 NJ 2330 NJ 2330 NJ 2330 NJ 2330 NJ 2930 9060
preplace netloc axi_sg_interconnect_M00_AXI 1 15 1 8410
preplace netloc axi_cpu_interconnect_m05_axi 1 3 12 1790 3470 NJ 3320 NJ 3320 NJ 3420 NJ 3420 NJ 3270 NJ 3290 NJ 3290 NJ 3290 NJ 3370 NJ 3310 NJ
preplace netloc irq_stub1_dout 1 14 1 7740
preplace netloc sys_reg_0_gt_diffctrl 1 4 12 2550 2360 NJ 2360 NJ 2360 NJ 2360 NJ 2360 NJ 2360 NJ 2360 NJ 2360 NJ 2360 NJ 2360 NJ 2360 8300
preplace netloc axi_ad9361_1_dac_enable_0 1 2 3 990 2570 NJ 2570 2370
preplace netloc srio_swrite_unpack_reg_M_AXIS 1 5 1 3110
preplace netloc axis_vita49_pack_0_M_AXIS 1 9 1 5090
preplace netloc axis_adc_interconnect_0_M00_AXIS 1 5 1 3110
preplace netloc axi_dma_1_M_AXI_SG 1 9 6 5120 3610 NJ 3580 NJ 3580 NJ 3780 NJ 3720 NJ
preplace netloc util_adc_pack_0_dvalid 1 3 1 1710
preplace netloc axi_ad9361_1_dac_enable_1 1 2 3 1010 2250 NJ 2030 2290
preplace netloc util_adc_pack_1_ddata 1 3 1 1650
preplace netloc dac_fifo_1_M_AXIS 1 10 1 N
preplace netloc axi_ad9361_1_dac_enable_2 1 2 3 970 2200 NJ 2040 2280
preplace netloc axi_ad9361_1_dac_enable_3 1 2 3 980 2210 NJ 1980 2250
preplace netloc axi_cpu_interconnect_m09_axi 1 3 1 1580
preplace netloc drpaddr_concat_dout 1 15 1 8350
preplace netloc adc_fifo_1_M_AXIS 1 11 1 6070
preplace netloc axi_ad9361_0_rx_clk_in_n 1 0 4 NJ 240 NJ 240 NJ 240 N
preplace netloc axi_gpio_irq 1 4 11 N 3880 NJ 3880 NJ 3880 NJ 3880 NJ 3880 NJ 3880 NJ 3880 NJ 3880 NJ 4020 NJ 3940 NJ
preplace netloc axi_ad9361_0_dac_drd 1 3 17 1330 1080 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ
preplace netloc vita_dac_sw_M01_AXIS 1 8 1 N
preplace netloc axi_ad9361_0_rx_clk_in_p 1 0 4 NJ 220 NJ 220 NJ 220 N
preplace netloc axi_ad9361_0_tx_frame_out_n 1 4 17 N 100 NJ 100 NJ 100 NJ 100 NJ 100 NJ 100 NJ 100 NJ 100 NJ 100 NJ 100 NJ 100 NJ 100 NJ 100 NJ 100 NJ 100 NJ 100 NJ
preplace netloc axi_cpu_interconnect_m14_axi 1 3 6 1820 3200 NJ 3250 NJ 3250 NJ 3400 NJ 3280 NJ
preplace netloc axi_cpu_interconnect_M29_AXI 1 3 7 NJ 3990 NJ 3990 NJ 3990 NJ 3990 NJ 3890 NJ 3920 NJ
preplace netloc xlslice_1_Dout 1 20 1 N
preplace netloc axi_ad9361_0_tx_frame_out_p 1 4 17 N 80 NJ 80 NJ 80 NJ 80 NJ 80 NJ 80 NJ 80 NJ 80 NJ 80 NJ 80 NJ 80 NJ 80 NJ 80 NJ 80 NJ 80 NJ 80 NJ
preplace netloc drpdi_concat_dout 1 15 1 8530
preplace netloc srio_dma_split_0_M_AXIS 1 12 1 6710
preplace netloc routing_reg_0_swrite_bypass 1 2 3 1020 4830 NJ 4830 2250
preplace netloc S01_AXI_1 1 7 8 4060 3800 NJ 3800 NJ 3630 NJ 3630 NJ 3630 NJ 3790 NJ 3710 NJ
preplace netloc srio_treq_sw_M01_AXIS 1 4 1 2730
preplace netloc axis_64to32_dac_1_M_AXIS 1 12 1 6650
preplace netloc axi_cpu_interconnect_M22_AXI 1 3 1 1310
preplace netloc axi_cpu_interconnect_M16_AXI 1 3 10 NJ 3770 NJ 3770 NJ 3770 NJ 3530 NJ 3530 NJ 3530 NJ 3440 NJ 3500 NJ 3500 NJ
preplace netloc axi_cpu_interconnect_m12_axi 1 3 11 1780 2770 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ
preplace netloc axi_dma_2_M_AXI_MM2S 1 11 4 NJ 4310 NJ 4310 NJ 4310 7660
preplace netloc adc_ddr_sw_0_M00_AXIS 1 12 1 6640
preplace netloc sys_reg_0_gt_txprecursor 1 4 12 N 2950 NJ 2570 NJ 2570 NJ 2570 NJ 2570 NJ 2570 NJ 2570 NJ 2570 NJ 2570 NJ 2570 NJ 2570 NJ
preplace netloc drp_bridge_0_drp2_we 1 12 3 NJ 1710 NJ 1710 7850
preplace netloc srio_gen2_0_drpclk_out 1 10 7 5610 2470 6020 2470 NJ 2470 NJ 2470 NJ 2470 NJ 3000 9130
preplace netloc routing_reg_0_adc_ddr_sw_1_tdest 1 4 7 NJ 4000 NJ 4000 NJ 4000 NJ 4130 NJ 4140 NJ 4120 5580
preplace netloc axi_cpu_interconnect_M28_AXI 1 3 5 NJ 3700 NJ 3700 NJ 3700 NJ 3590 4060
preplace netloc axi_cpu_interconnect_M25_AXI 1 3 9 NJ 3490 NJ 3490 NJ 3590 NJ 3490 NJ 3490 NJ 3510 NJ 3450 NJ 3480 NJ
preplace netloc axi_srio_interconnect_M00_AXI 1 11 1 6060
preplace netloc spi_sclk_i 1 0 17 NJ 4690 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4760 NJ 4660 NJ 4660 NJ 4660 NJ 4910 NJ 4910 NJ 4910 9060
preplace netloc srio_swrite_pack_1_M_AXIS 1 13 1 7230
preplace netloc axi_cpu_interconnect_M23_AXI 1 3 8 NJ 4010 NJ 4010 NJ 4010 NJ 4010 NJ 4070 NJ 4150 NJ 4150 5580
preplace netloc drpdo_slice_2_Dout 1 12 8 NJ 1810 NJ 1810 NJ 1810 NJ 1810 NJ 1810 NJ 1810 NJ 1880 10330
preplace netloc axi_ad9361_1_dac_drd 1 3 16 NJ 1090 NJ 1090 NJ 1090 NJ 1090 NJ 1090 NJ 1090 NJ 1090 NJ 1090 NJ 1090 NJ 1090 NJ 1090 NJ 1090 NJ 1090 NJ 1090 NJ 1090 9980
preplace netloc dac_fifo_0_M_AXIS 1 10 1 5510
preplace netloc srio_iresp_intc_M00_AXIS 1 10 1 5480
preplace netloc axi_srio_target_fifo_AXI_STR_TXD 1 13 1 N
preplace netloc axi_ad9361_1_adc_chan_q1 1 2 3 970 2120 NJ 2120 2420
preplace netloc axi_ad9361_1_adc_valid_0 1 2 3 910 2170 NJ 2000 2360
preplace netloc spi_sclk_o 1 16 5 N 5310 NJ 5310 NJ 5310 NJ 5310 NJ
preplace netloc axi_ad9361_1_adc_chan_q2 1 2 3 1020 2100 NJ 1970 2270
preplace netloc axi_ad9361_1_adc_valid_1 1 2 3 990 2090 NJ 2070 2390
preplace netloc drp_bridge_0_drp2_addr 1 12 3 NJ 1980 NJ 1980 7610
preplace netloc srio_maint_reg_M_AXI 1 15 1 8360
preplace netloc axi_ad9361_1_adc_valid_2 1 2 3 940 2180 NJ 2010 2310
preplace netloc dac_ddr_sw_0_reg_M_AXIS 1 12 1 6640
preplace netloc drpwe_concat_dout 1 15 1 8550
preplace netloc axi_ad9361_1_adc_valid_3 1 2 3 1000 2150 NJ 2020 2300
preplace netloc axis_64to32_dac_0_M_AXIS 1 13 1 N
preplace netloc axi_srio_interconnect_M04_AXI 1 11 4 6070 4340 NJ 4340 NJ 4240 NJ
preplace netloc sys_reg_0_phy_mce 1 4 12 2560 2370 NJ 2370 NJ 2370 NJ 2370 NJ 2370 NJ 2370 NJ 2370 NJ 2370 NJ 2370 NJ 2370 NJ 2430 NJ
preplace netloc axi_ad9361_1_rx_clk_in_n 1 0 4 NJ 1340 NJ 1340 NJ 1370 1390
preplace netloc axi_dma_2_M_AXI_SG 1 11 4 NJ 4170 NJ 4050 NJ 4050 7680
preplace netloc axi_dma_1_mm2s_introut 1 9 6 5060 3670 NJ 3520 NJ 3520 NJ 3440 NJ 3920 NJ
preplace netloc srio_rxn3_1 1 0 16 NJ 2800 NJ 2800 NJ 2800 NJ 2800 NJ 2800 NJ 2720 NJ 2720 NJ 2720 NJ 2720 NJ 2720 NJ 2720 NJ 2720 NJ 2720 NJ 2720 NJ 2720 8380
preplace netloc axi_ad9361_1_rx_clk_in_p 1 0 4 NJ 1320 NJ 1320 NJ 1330 1390
preplace netloc axi_ad9361_0_adc_valid_0 1 2 3 960 940 NJ 940 2390
preplace netloc sys_reg_0_phy_link_reset 1 4 12 2640 2700 NJ 2700 NJ 2700 NJ 2700 NJ 2700 NJ 2700 NJ 2700 NJ 2700 NJ 2700 NJ 2700 NJ 2700 NJ
preplace netloc srio_target_reg_M_AXIS 1 11 1 6150
preplace netloc axi_srio_initiator_fifo_interrupt 1 12 3 6640 4540 NJ 4540 NJ
preplace netloc axi_ad9361_0_adc_valid_1 1 2 3 990 950 NJ 950 2360
preplace netloc srio_gen2_0_port_error 1 3 14 1820 2520 NJ 2400 NJ 2400 NJ 2400 NJ 2400 NJ 2400 NJ 2400 NJ 2400 NJ 2400 NJ 2400 NJ 2400 NJ 2400 NJ 2940 9100
preplace netloc axi_ad9361_0_adc_valid_2 1 2 3 920 1010 NJ 1010 2410
preplace netloc irq_stub2_dout 1 14 1 N
preplace netloc axi_ad9361_0_adc_valid_3 1 2 3 980 1020 NJ 1020 2370
preplace netloc sys_reg_0_force_reinit 1 4 12 2650 2750 NJ 2750 NJ 2750 NJ 2750 NJ 2750 NJ 2750 NJ 2750 NJ 2750 NJ 2750 NJ 2750 NJ 2750 NJ
preplace netloc sys_100m_resetn 1 1 19 580 4460 960 4690 1630 3170 2710 2990 3090 3050 3600 3570 4090 4060 4540 3910 5090 3680 5540 3540 6050 3540 6760 4360 7200 4210 7820 3200 8560 3120 9230 2180 9590 1380 9920 1010 NJ
preplace netloc dac_ddr_sw_1_M00_AXIS 1 11 1 5950
preplace netloc axi_dma_0_M_AXI_SG 1 14 1 N
preplace netloc axi_ad9361_0_dac_valid_0 1 2 3 960 1340 NJ 870 2280
preplace netloc sys_reg_0_srio_loopback 1 4 12 2480 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 2490 NJ 2490 NJ 2490 NJ 2490 NJ
preplace netloc axi_ad9361_0_dac_valid_1 1 2 3 1020 1320 NJ 890 2270
preplace netloc srio_rxp1_1 1 0 16 NJ 2740 NJ 2740 NJ 2740 NJ 2740 NJ 2740 NJ 2740 NJ 2740 NJ 2740 NJ 2740 NJ 2740 NJ 2740 NJ 2740 NJ 2740 NJ 2740 NJ 2740 8400
preplace netloc axi_ad9361_0_dac_valid_2 1 2 3 1000 1350 NJ 910 2260
preplace netloc axi_ad9361_0_tx_data_out_n 1 4 17 2450 130 NJ 130 NJ 130 NJ 130 NJ 130 NJ 130 NJ 130 NJ 130 NJ 130 NJ 130 NJ 130 NJ 130 NJ 130 NJ 130 NJ 130 NJ 130 NJ
preplace netloc util_adc_pack_1_dvalid 1 3 1 1660
preplace netloc axi_ad9361_0_dac_valid_3 1 2 3 1010 1360 NJ 900 2250
preplace netloc dac_ddr_sw_1_M01_AXIS 1 11 1 5970
preplace netloc axi_ad9361_1_adc_dma_interconnect_m00_axi 1 15 1 8540
preplace netloc axi_ad9361_0_tx_data_out_p 1 4 17 2460 140 NJ 140 NJ 140 NJ 140 NJ 140 NJ 140 NJ 140 NJ 140 NJ 140 NJ 140 NJ 140 NJ 140 NJ 140 NJ 140 NJ 140 NJ 140 NJ
preplace netloc vita49_clk_tsf_0 1 4 13 NJ 3290 NJ 3240 3510 3150 NJ 3190 4620 3260 NJ 3320 NJ 3320 NJ 3320 NJ 3400 NJ 3300 7850 3300 NJ 3390 NJ
preplace netloc util_adc_pack_1_dsync 1 3 1 1600
preplace netloc vita49_clk_tsf_1 1 4 12 NJ 3630 NJ 3630 3590 3460 NJ 3460 4620 3550 NJ 3120 NJ 3120 NJ 3120 NJ 3150 7260 3260 NJ 3260 NJ
preplace netloc drp_bridge_0_drp2_en 1 12 3 NJ 1920 NJ 1920 7670
preplace netloc spi_csn_2_o 1 16 5 N 5450 NJ 5450 NJ 5450 NJ 5450 NJ
preplace netloc axi_ad9361_1_tx_data_out_n 1 4 17 N 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1330 NJ 1330 NJ
preplace netloc axi_cpu_interconnect_m03_axi 1 3 1 1730
preplace netloc sys_reg_0_gt_rxdfelpmreset_in 1 4 12 2620 2440 NJ 2510 NJ 2510 NJ 2510 NJ 2510 NJ 2510 NJ 2510 NJ 2510 NJ 2510 NJ 2510 NJ 2510 NJ
preplace netloc axi_ad9361_0_adc_enable_0 1 2 3 930 930 NJ 930 2400
preplace netloc axi_ad9361_1_tx_data_out_p 1 4 17 2710 1340 NJ 1340 NJ 1340 NJ 1340 NJ 1340 NJ 1340 NJ 1340 NJ 1340 NJ 1340 NJ 1340 NJ 1340 NJ 1340 NJ 1340 NJ 1340 NJ 1490 NJ 1370 NJ
preplace netloc axi_ad9361_0_adc_enable_1 1 2 3 880 2060 NJ 2060 2460
preplace netloc axi_ad9361_0_adc_enable_2 1 2 3 890 2070 NJ 2050 2450
preplace netloc axis_dac_interconnect_0_M00_AXIS 1 19 1 10380
preplace netloc axi_ad9361_0_adc_enable_3 1 2 3 1000 1000 NJ 1000 2350
preplace netloc axi_ad9361_1_rx_frame_in_n 1 0 4 NJ 1380 NJ 1380 NJ 1380 N
preplace netloc axi_cpu_interconnect_M20_AXI 1 3 6 NJ 3940 NJ 3920 NJ 3920 NJ 3920 NJ 3920 4520
preplace netloc axi_cpu_interconnect_M19_AXI 1 3 6 NJ 3930 NJ 3910 NJ 3910 NJ 3910 NJ 3910 4510
preplace netloc sys_aux_reset 1 0 17 230 4880 NJ 4880 NJ 4880 NJ 4880 NJ 4880 NJ 4880 NJ 4880 NJ 4880 NJ 4880 NJ 4880 NJ 4670 NJ 4670 NJ 4670 NJ 4810 NJ 5210 NJ 5060 9080
preplace netloc axi_ad9361_1_rx_frame_in_p 1 0 4 NJ 1390 NJ 1390 NJ 1390 1400
preplace netloc sys_ps7_interrupt 1 15 1 8260
preplace netloc drprdy_slice_1_Dout 1 12 8 6660 1800 NJ 1800 NJ 1780 NJ 1770 NJ 1770 NJ 1770 NJ 1770 10320
preplace netloc axi_dma_0_s2mm_introut 1 14 1 7770
preplace netloc drprdy_slice_0_Dout 1 12 8 NJ 1610 NJ 1610 NJ 1610 NJ 1610 NJ 1610 NJ 1660 NJ 1660 10360
levelinfo -pg 1 160 390 740 1150 2090 2920 3380 3850 4340 4790 5310 5790 6480 6950 7430 8070 8830 9400 9780 10190 10560 10760 -top 0 -bot 6120
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""



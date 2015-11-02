
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
  set GPIO_I [ create_bd_port -dir I -from 63 -to 0 GPIO_I ]
  set GPIO_O [ create_bd_port -dir O -from 63 -to 0 GPIO_O ]
  set GPIO_T [ create_bd_port -dir O -from 63 -to 0 GPIO_T ]
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
CONFIG.C_DATA_INTERFACE_TYPE {1} \
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
CONFIG.C_DATA_INTERFACE_TYPE {1} \
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
CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {733} \
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
CONFIG.PCW_GPIO_EMIO_GPIO_IO {64} \
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
CONFIG.PCW_SD0_GRP_CD_IO {MIO 9} \
CONFIG.PCW_SD0_GRP_WP_ENABLE {0} \
CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SD1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SD1_SD1_IO {MIO 10 .. 15} \
CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SPI1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UART0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UART0_UART0_IO {MIO 46 .. 47} \
CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {.446} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {.448} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {.453} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {.472} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {.196} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {.198} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {.194} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {.143} \
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

  # Create instance: xlslice_2, and set properties
  set xlslice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_2 ]
  set_property -dict [ list \
CONFIG.DIN_FROM {54} \
CONFIG.DIN_TO {54} \
CONFIG.DIN_WIDTH {55} \
 ] $xlslice_2

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
  connect_bd_intf_net -intf_net axi_srio_interconnect_M01_AXI [get_bd_intf_pins axi_srio_initiator_fifo/S_AXI_FULL] [get_bd_intf_pins axi_srio_interconnect/M01_AXI]
  connect_bd_intf_net -intf_net axi_srio_interconnect_M02_AXI [get_bd_intf_pins axi_srio_interconnect/M02_AXI] [get_bd_intf_pins axi_srio_target_fifo/S_AXI]
  connect_bd_intf_net -intf_net axi_srio_interconnect_M03_AXI [get_bd_intf_pins axi_srio_interconnect/M03_AXI] [get_bd_intf_pins axi_srio_target_fifo/S_AXI_FULL]
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
  connect_bd_net -net sys_ps7_GPIO_O [get_bd_ports GPIO_O] [get_bd_pins sys_ps7/GPIO_O] [get_bd_pins xlslice_2/Din]
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

  # Create address segments
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_dma_0/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_DDR_LOWOCM] SEG_sys_ps7_GP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x400000 -offset 0xE0000000 [get_bd_addr_spaces axi_dma_0/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_IOP] SEG_sys_ps7_GP0_IOP
  create_bd_addr_seg -range 0x40000000 -offset 0x40000000 [get_bd_addr_spaces axi_dma_0/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_M_AXI_GP0] SEG_sys_ps7_GP0_M_AXI_GP0
  create_bd_addr_seg -range 0x40000000 -offset 0x80000000 [get_bd_addr_spaces axi_dma_0/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_M_AXI_GP1] SEG_sys_ps7_GP0_M_AXI_GP1
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
  create_bd_addr_seg -range 0x4000 -offset 0x80100000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_srio_initiator_fifo/S_AXI_FULL/Mem1] SEG_axi_srio_initiator_fifo_Mem1
  create_bd_addr_seg -range 0x1000 -offset 0x80200000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_srio_target_fifo/S_AXI/Mem0] SEG_axi_srio_target_fifo_Mem0
  create_bd_addr_seg -range 0x4000 -offset 0x80300000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_srio_target_fifo/S_AXI_FULL/Mem1] SEG_axi_srio_target_fifo_Mem1
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

  # Exclude Address Segments
  create_bd_addr_seg -range 0x400000 -offset 0xE0000000 [get_bd_addr_spaces axi_dma_1/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_IOP] SEG_sys_ps7_GP0_IOP
  exclude_bd_addr_seg [get_bd_addr_segs axi_dma_1/Data_SG/SEG_sys_ps7_GP0_IOP]

  create_bd_addr_seg -range 0x40000000 -offset 0x40000000 [get_bd_addr_spaces axi_dma_1/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_M_AXI_GP0] SEG_sys_ps7_GP0_M_AXI_GP0
  exclude_bd_addr_seg [get_bd_addr_segs axi_dma_1/Data_SG/SEG_sys_ps7_GP0_M_AXI_GP0]

  create_bd_addr_seg -range 0x40000000 -offset 0x80000000 [get_bd_addr_spaces axi_dma_1/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_M_AXI_GP1] SEG_sys_ps7_GP0_M_AXI_GP1
  exclude_bd_addr_seg [get_bd_addr_segs axi_dma_1/Data_SG/SEG_sys_ps7_GP0_M_AXI_GP1]

  create_bd_addr_seg -range 0x400000 -offset 0xE0000000 [get_bd_addr_spaces srio_dma/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_IOP] SEG_sys_ps7_GP0_IOP
  exclude_bd_addr_seg [get_bd_addr_segs srio_dma/Data_SG/SEG_sys_ps7_GP0_IOP]

  create_bd_addr_seg -range 0x40000000 -offset 0x40000000 [get_bd_addr_spaces srio_dma/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_M_AXI_GP0] SEG_sys_ps7_GP0_M_AXI_GP0
  exclude_bd_addr_seg [get_bd_addr_segs srio_dma/Data_SG/SEG_sys_ps7_GP0_M_AXI_GP0]

  create_bd_addr_seg -range 0x40000000 -offset 0x80000000 [get_bd_addr_spaces srio_dma/Data_SG] [get_bd_addr_segs sys_ps7/S_AXI_GP0/GP0_M_AXI_GP1] SEG_sys_ps7_GP0_M_AXI_GP1
  exclude_bd_addr_seg [get_bd_addr_segs srio_dma/Data_SG/SEG_sys_ps7_GP0_M_AXI_GP1]


  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port spi_mosi_i -pg 1 -y 3530 -defaultsOSRD
preplace port spi_csn_2_o -pg 1 -y 4060 -defaultsOSRD
preplace port rx_frame_in_0_n -pg 1 -y 260 -defaultsOSRD
preplace port DDR -pg 1 -y 3880 -defaultsOSRD
preplace port tx_clk_out_1_p -pg 1 -y 1330 -defaultsOSRD
preplace port rx_clk_in_0_n -pg 1 -y 220 -defaultsOSRD
preplace port rx_frame_in_0_p -pg 1 -y 240 -defaultsOSRD
preplace port srio_rxp0 -pg 1 -y 5570 -defaultsOSRD
preplace port rx_clk_in_0_p -pg 1 -y 200 -defaultsOSRD
preplace port srio_rxp1 -pg 1 -y 5590 -defaultsOSRD
preplace port spi_sclk_o -pg 1 -y 4710 -defaultsOSRD
preplace port rx_frame_in_1_n -pg 1 -y 1390 -defaultsOSRD
preplace port tx_frame_out_0_n -pg 1 -y 140 -defaultsOSRD
preplace port srio_sys_clkn -pg 1 -y 4950 -defaultsOSRD
preplace port srio_rxp2 -pg 1 -y 5610 -defaultsOSRD
preplace port srio_txp0 -pg 1 -y 5340 -defaultsOSRD
preplace port spi_csn_0_i -pg 1 -y 3490 -defaultsOSRD
preplace port srio_rxp3 -pg 1 -y 5630 -defaultsOSRD
preplace port srio_txp1 -pg 1 -y 5380 -defaultsOSRD
preplace port spi_mosi_o -pg 1 -y 4690 -defaultsOSRD
preplace port spi_miso_i -pg 1 -y 3510 -defaultsOSRD
preplace port tx_frame_out_1_n -pg 1 -y 1390 -defaultsOSRD
preplace port rx_frame_in_1_p -pg 1 -y 1370 -defaultsOSRD
preplace port tx_frame_out_0_p -pg 1 -y 120 -defaultsOSRD
preplace port tx_clk_out_0_n -pg 1 -y 100 -defaultsOSRD
preplace port srio_sys_clkp -pg 1 -y 4970 -defaultsOSRD
preplace port srio_txp2 -pg 1 -y 5420 -defaultsOSRD
preplace port srio_rxn0 -pg 1 -y 5490 -defaultsOSRD
preplace port srio_txp3 -pg 1 -y 5460 -defaultsOSRD
preplace port srio_txn0 -pg 1 -y 5320 -defaultsOSRD
preplace port tx_frame_out_1_p -pg 1 -y 1370 -defaultsOSRD
preplace port tx_clk_out_0_p -pg 1 -y 80 -defaultsOSRD
preplace port FIXED_IO -pg 1 -y 4040 -defaultsOSRD
preplace port srio_rxn1 -pg 1 -y 5510 -defaultsOSRD
preplace port srio_txn1 -pg 1 -y 5360 -defaultsOSRD
preplace port rx_clk_in_1_n -pg 1 -y 1350 -defaultsOSRD
preplace port srio_rxn2 -pg 1 -y 5530 -defaultsOSRD
preplace port srio_txn2 -pg 1 -y 5400 -defaultsOSRD
preplace port spi_csn_1_o -pg 1 -y 4670 -defaultsOSRD
preplace port srio_rxn3 -pg 1 -y 5550 -defaultsOSRD
preplace port srio_txn3 -pg 1 -y 5440 -defaultsOSRD
preplace port spi_sclk_i -pg 1 -y 3550 -defaultsOSRD
preplace port spi_csn_0_o -pg 1 -y 4630 -defaultsOSRD
preplace port rx_clk_in_1_p -pg 1 -y 1330 -defaultsOSRD
preplace port tx_clk_out_1_n -pg 1 -y 1350 -defaultsOSRD
preplace portBus rx_data_in_1_p -pg 1 -y 1410 -defaultsOSRD
preplace portBus GPIO_T -pg 1 -y 4650 -defaultsOSRD
preplace portBus GPIO_I -pg 1 -y 3470 -defaultsOSRD
preplace portBus tx_data_out_0_n -pg 1 -y 180 -defaultsOSRD
preplace portBus rx_data_in_0_n -pg 1 -y 300 -defaultsOSRD
preplace portBus tx_data_out_0_p -pg 1 -y 160 -defaultsOSRD
preplace portBus axi_gpio -pg 1 -y 3340 -defaultsOSRD
preplace portBus tx_data_out_1_n -pg 1 -y 1430 -defaultsOSRD
preplace portBus rx_data_in_0_p -pg 1 -y 280 -defaultsOSRD
preplace portBus tx_data_out_1_p -pg 1 -y 1410 -defaultsOSRD
preplace portBus GPIO_O -pg 1 -y 4020 -defaultsOSRD
preplace portBus rx_data_in_1_n -pg 1 -y 1430 -defaultsOSRD
preplace inst vita_pack_adc_reg_0 -pg 1 -lvl 22 -y 3860 -defaultsOSRD
preplace inst vita_pack_adc_reg_1 -pg 1 -lvl 8 -y 4410 -defaultsOSRD
preplace inst dac_ddr_sw_0_reg -pg 1 -lvl 31 -y 3710 -defaultsOSRD
preplace inst axis_64to32_adc_0 -pg 1 -lvl 20 -y 3850 -defaultsOSRD
preplace inst sys_rstgen -pg 1 -lvl 1 -y 4550 -defaultsOSRD
preplace inst srio_gen2_0 -pg 1 -lvl 39 -y 5200 -defaultsOSRD
preplace inst axis_64to32_srio_target -pg 1 -lvl 35 -y 4460 -defaultsOSRD
preplace inst axis_64to32_adc_1 -pg 1 -lvl 6 -y 4430 -defaultsOSRD
preplace inst srio_swrite_pack_0 -pg 1 -lvl 36 -y 3400 -defaultsOSRD
preplace inst axis_32to64_srio_init -pg 1 -lvl 36 -y 4170 -defaultsOSRD
preplace inst axi_srio_target_fifo -pg 1 -lvl 36 -y 4560 -defaultsOSRD
preplace inst drpwe_concat -pg 1 -lvl 38 -y 3080 -defaultsOSRD
preplace inst drpen_concat -pg 1 -lvl 38 -y 3280 -defaultsOSRD
preplace inst const_1 -pg 1 -lvl 33 -y 4560 -defaultsOSRD
preplace inst srio_swrite_pack_1 -pg 1 -lvl 36 -y 3630 -defaultsOSRD
preplace inst drpdi_concat -pg 1 -lvl 38 -y 2860 -defaultsOSRD
preplace inst axis_vita49_pack_0 -pg 1 -lvl 23 -y 3840 -defaultsOSRD
preplace inst srio_dma_reg_0_delete -pg 1 -lvl 36 -y 4360 -defaultsOSRD
preplace inst drprdy_slice_0 -pg 1 -lvl 39 -y 3680 -defaultsOSRD
preplace inst c_counter_binary_0 -pg 1 -lvl 22 -y 4120 -defaultsOSRD
preplace inst vita49_clk -pg 1 -lvl 24 -y 4000 -defaultsOSRD
preplace inst axis_vita49_pack_1 -pg 1 -lvl 9 -y 4280 -defaultsOSRD
preplace inst axi_ad9361_0_adc_dma_interconnect -pg 1 -lvl 15 -y 5190 -defaultsOSRD
preplace inst srio_treq_intc -pg 1 -lvl 2 -y 4800 -defaultsOSRD
preplace inst drprdy_slice_1 -pg 1 -lvl 39 -y 3880 -defaultsOSRD
preplace inst dac_fifo_0 -pg 1 -lvl 29 -y 4010 -defaultsOSRD
preplace inst srio_swrite_unpack_0 -pg 1 -lvl 6 -y 4200 -defaultsOSRD
preplace inst drprdy_slice_2 -pg 1 -lvl 39 -y 4100 -defaultsOSRD
preplace inst dac_fifo_1 -pg 1 -lvl 10 -y 4590 -defaultsOSRD
preplace inst axi_sg_interconnect -pg 1 -lvl 15 -y 3610 -defaultsOSRD
preplace inst axi_ad9361_1_dac_dma_interconnect -pg 1 -lvl 15 -y 4900 -defaultsOSRD
preplace inst vita_trig_dac_reg_0 -pg 1 -lvl 35 -y 3540 -defaultsOSRD
preplace inst drprdy_slice_3 -pg 1 -lvl 39 -y 3990 -defaultsOSRD
preplace inst hello_router_0 -pg 1 -lvl 3 -y 4740 -defaultsOSRD
preplace inst vita49_trig_dac_0 -pg 1 -lvl 36 -y 3950 -defaultsOSRD
preplace inst axis_adc_interconnect_0 -pg 1 -lvl 19 -y 3600 -defaultsOSRD
preplace inst adi_dma_split_0 -pg 1 -lvl 29 -y 3670 -defaultsOSRD
preplace inst vita_trig_dac_reg_1 -pg 1 -lvl 25 -y 4030 -defaultsOSRD
preplace inst drpdo_slice_0 -pg 1 -lvl 39 -y 3110 -defaultsOSRD
preplace inst dac_ddr_sw_0 -pg 1 -lvl 30 -y 3710 -defaultsOSRD
preplace inst axis_adc_interconnect_1 -pg 1 -lvl 5 -y 4220 -defaultsOSRD
preplace inst util_dac_unpack_0 -pg 1 -lvl 38 -y 620 -defaultsOSRD
preplace inst vita49_trig_dac_1 -pg 1 -lvl 26 -y 4080 -defaultsOSRD
preplace inst axi_srio_initiator_fifo -pg 1 -lvl 35 -y 4150 -defaultsOSRD
preplace inst adi_dma_split_1 -pg 1 -lvl 10 -y 4030 -defaultsOSRD
preplace inst srio_iresp_intc -pg 1 -lvl 33 -y 4770 -defaultsOSRD
preplace inst drpdo_slice_1 -pg 1 -lvl 39 -y 3590 -defaultsOSRD
preplace inst dac_ddr_sw_1 -pg 1 -lvl 11 -y 4690 -defaultsOSRD
preplace inst util_dac_unpack_1 -pg 1 -lvl 28 -y 2170 -defaultsOSRD
preplace inst axis_64to32_dac_0 -pg 1 -lvl 32 -y 3730 -defaultsOSRD
preplace inst adi2axis_0 -pg 1 -lvl 18 -y 3560 -defaultsOSRD
preplace inst drpdo_slice_2 -pg 1 -lvl 39 -y 3200 -defaultsOSRD
preplace inst axis_64to32_dac_1 -pg 1 -lvl 18 -y 4470 -defaultsOSRD
preplace inst adi2axis_1 -pg 1 -lvl 4 -y 3180 -defaultsOSRD
preplace inst drpdo_slice_3 -pg 1 -lvl 39 -y 3330 -defaultsOSRD
preplace inst adi_dma_comb_0 -pg 1 -lvl 27 -y 3660 -defaultsOSRD
preplace inst srio_swrite_unpack_reg -pg 1 -lvl 5 -y 4430 -defaultsOSRD
preplace inst irq_stub11 -pg 1 -lvl 14 -y 3330 -defaultsOSRD
preplace inst drpaddr_concat -pg 1 -lvl 38 -y 2580 -defaultsOSRD
preplace inst adi_dma_comb_1 -pg 1 -lvl 13 -y 4430 -defaultsOSRD
preplace inst srio_tresp_intc -pg 1 -lvl 38 -y 4570 -defaultsOSRD
preplace inst srio_treq_sw -pg 1 -lvl 4 -y 4760 -defaultsOSRD
preplace inst util_adc_pack_0 -pg 1 -lvl 17 -y 870 -defaultsOSRD
preplace inst sys_concat_intc -pg 1 -lvl 15 -y 2970 -defaultsOSRD
preplace inst ddr_fifo -pg 1 -lvl 7 -y 4210 -defaultsOSRD
preplace inst vita49_assem_0 -pg 1 -lvl 28 -y 4030 -defaultsOSRD
preplace inst util_adc_pack_1 -pg 1 -lvl 3 -y 2190 -defaultsOSRD
preplace inst axis_vita49_unpack_0 -pg 1 -lvl 34 -y 3570 -defaultsOSRD
preplace inst axis_64to32_srio_init -pg 1 -lvl 34 -y 4650 -defaultsOSRD
preplace inst axi_ad9361_0 -pg 1 -lvl 39 -y 390 -defaultsOSRD
preplace inst srio_ireq_intc -pg 1 -lvl 38 -y 4330 -defaultsOSRD
preplace inst axis_vita49_unpack_1 -pg 1 -lvl 24 -y 4430 -defaultsOSRD
preplace inst axi_ad9361_1 -pg 1 -lvl 39 -y 1640 -defaultsOSRD
preplace inst vita49_trig_adc_0 -pg 1 -lvl 21 -y 3900 -defaultsOSRD
preplace inst vita49_assem_1 -pg 1 -lvl 9 -y 4550 -defaultsOSRD
preplace inst axi_cpu_interconnect -pg 1 -lvl 17 -y 2740 -defaultsOSRD
preplace inst vita49_trig_adc_1 -pg 1 -lvl 7 -y 4510 -defaultsOSRD
preplace inst axis2adi_0 -pg 1 -lvl 39 -y 1100 -defaultsOSRD
preplace inst srio_target_reg -pg 1 -lvl 34 -y 4820 -defaultsOSRD
preplace inst srio_dma -pg 1 -lvl 14 -y 4020 -defaultsOSRD
preplace inst axis_32to64_srio_target -pg 1 -lvl 37 -y 4550 -defaultsOSRD
preplace inst axis2adi_1 -pg 1 -lvl 29 -y 2680 -defaultsOSRD
preplace inst srio_ireq_sw -pg 1 -lvl 37 -y 4230 -defaultsOSRD
preplace inst irq_stub0 -pg 1 -lvl 14 -y 2880 -defaultsOSRD
preplace inst adc_fifo_0 -pg 1 -lvl 25 -y 3510 -defaultsOSRD
preplace inst irq_stub1 -pg 1 -lvl 14 -y 2990 -defaultsOSRD
preplace inst adc_fifo_1 -pg 1 -lvl 11 -y 4410 -defaultsOSRD
preplace inst sys_ps7 -pg 1 -lvl 16 -y 3770 -defaultsOSRD
preplace inst irq_stub2 -pg 1 -lvl 14 -y 3100 -defaultsOSRD
preplace inst constant_0 -pg 1 -lvl 9 -y 3410 -defaultsOSRD
preplace inst sys_reg_0 -pg 1 -lvl 24 -y 5320 -defaultsOSRD
preplace inst irq_stub3 -pg 1 -lvl 14 -y 3220 -defaultsOSRD
preplace inst routing_reg_0 -pg 1 -lvl 24 -y 3020 -defaultsOSRD
preplace inst adc_ddr_tdest_0 -pg 1 -lvl 25 -y 2930 -defaultsOSRD
preplace inst srio_dma_split_0 -pg 1 -lvl 35 -y 3870 -defaultsOSRD
preplace inst axi_ad9361_1_adc_dma_interconnect -pg 1 -lvl 15 -y 4180 -defaultsOSRD
preplace inst adc_ddr_tdest_1 -pg 1 -lvl 11 -y 4210 -defaultsOSRD
preplace inst srio_dma_comb_0 -pg 1 -lvl 13 -y 4000 -defaultsOSRD
preplace inst axi_srio_interconnect -pg 1 -lvl 34 -y 4200 -defaultsOSRD
preplace inst axis_dac_interconnect_0 -pg 1 -lvl 38 -y 3970 -defaultsOSRD
preplace inst dac_ddr_tdest_0 -pg 1 -lvl 29 -y 3280 -defaultsOSRD
preplace inst axis_dac_interconnect_1 -pg 1 -lvl 28 -y 4280 -defaultsOSRD
preplace inst axis_32to64_adc_0 -pg 1 -lvl 24 -y 3490 -defaultsOSRD
preplace inst vita_dac_sw -pg 1 -lvl 8 -y 4590 -defaultsOSRD
preplace inst dac_ddr_tdest_1 -pg 1 -lvl 10 -y 3400 -defaultsOSRD
preplace inst axis_32to64_adc_1 -pg 1 -lvl 10 -y 4390 -defaultsOSRD
preplace inst axis_32to64_dac_0 -pg 1 -lvl 37 -y 3910 -defaultsOSRD
preplace inst xlslice_0 -pg 1 -lvl 23 -y 4090 -defaultsOSRD
preplace inst axis_32to64_dac_1 -pg 1 -lvl 27 -y 3990 -defaultsOSRD
preplace inst axi_ad9361_0_dac_dma_interconnect -pg 1 -lvl 15 -y 4570 -defaultsOSRD
preplace inst xlslice_2 -pg 1 -lvl 39 -y 4210 -defaultsOSRD
preplace inst vita_unpack_dac_reg_0 -pg 1 -lvl 33 -y 3740 -defaultsOSRD
preplace inst const_loopback -pg 1 -lvl 32 -y 5710 -defaultsOSRD
preplace inst adc_ddr_sw_0 -pg 1 -lvl 26 -y 3520 -defaultsOSRD
preplace inst vita_unpack_dac_reg_1 -pg 1 -lvl 19 -y 4370 -defaultsOSRD
preplace inst adc_ddr_sw_1 -pg 1 -lvl 12 -y 4420 -defaultsOSRD
preplace inst axi_gpio -pg 1 -lvl 39 -y 3480 -defaultsOSRD
preplace inst axi_dma_0 -pg 1 -lvl 28 -y 3590 -defaultsOSRD
preplace inst drp_bridge_0 -pg 1 -lvl 39 -y 2570 -defaultsOSRD
preplace inst axi_dma_1 -pg 1 -lvl 14 -y 3700 -defaultsOSRD
preplace inst srio_maint_reg -pg 1 -lvl 38 -y 4790 -defaultsOSRD
preplace netloc axis_64to32_strb_0_M_AXIS 1 34 1 14630
preplace netloc drp_bridge_0_drp1_we 1 37 3 15930 2990 NJ 2990 16990
preplace netloc axis_vita49_pack_1_M_AXIS 1 9 1 3350
preplace netloc axi_cpu_interconnect_s00_axi 1 16 1 6780
preplace netloc srio_dma_comb_0_M_AXIS 1 13 1 4730
preplace netloc srio_gen2_0_gtrx_disperr_or 1 23 17 9920 5580 NJ 5580 NJ 5580 NJ 5580 NJ 5580 NJ 5580 NJ 5580 NJ 5580 NJ 5580 NJ 5630 NJ 5630 NJ 5630 NJ 5630 NJ 5630 NJ 5630 NJ 5630 17000
preplace netloc S00_AXIS_1 1 18 1 8050
preplace netloc irq_stub3_dout 1 14 1 5170
preplace netloc axi_dma_1_M_AXI_S2MM 1 14 1 5360
preplace netloc S00_AXIS_2 1 4 1 1550
preplace netloc axi_ad9361_0_dac_enable_0 1 37 3 15900 770 NJ 770 16950
preplace netloc srio_rxp3_1 1 0 39 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5570 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ
preplace netloc axis_dac_interconnect_1_M00_AXIS 1 28 1 12350
preplace netloc axi_ad9361_0_dac_enable_1 1 37 3 15860 810 NJ 810 16960
preplace netloc srio_gen2_0_gtrx_notintable_or 1 23 17 9940 5590 NJ 5590 NJ 5590 NJ 5590 NJ 5590 NJ 5590 NJ 5590 NJ 5590 NJ 5590 NJ 5640 NJ 5640 NJ 5640 NJ 5640 NJ 5640 NJ 5640 NJ 5640 16990
preplace netloc axi_ad9361_0_dac_enable_2 1 37 3 15920 780 NJ 780 16940
preplace netloc sys_reg_0_gt_rxlpmen 1 24 15 10620 5230 NJ 5230 NJ 5230 NJ 5230 NJ 5230 NJ 5230 NJ 5230 NJ 5230 NJ 5230 NJ 5230 NJ 5230 NJ 5230 NJ 5230 NJ 5230 NJ
preplace netloc vita49_trig_dac_1_trig 1 23 4 9960 3770 NJ 3770 NJ 3770 11460
preplace netloc axi_dma_0_mm2s_introut 1 14 15 5500 3790 NJ 4240 NJ 4240 NJ 4240 NJ 4240 NJ 4240 NJ 4240 NJ 4240 NJ 4240 NJ 4260 NJ 4260 NJ 4260 NJ 4140 NJ 4140 12290
preplace netloc axi_ad9361_0_dac_enable_3 1 37 3 15930 790 NJ 790 16930
preplace netloc axi_cpu_interconnect_M21_AXI 1 17 19 NJ 2870 NJ 2870 NJ 2870 NJ 2870 NJ 2870 NJ 2870 NJ 2870 NJ 2870 NJ 2870 NJ 2870 NJ 2870 NJ 2870 NJ 2870 NJ 2870 NJ 2870 NJ 2870 NJ 2870 NJ 2870 15120
preplace netloc irq_stub11_dout 1 14 1 5180
preplace netloc srio_treq_intc_M00_AXIS 1 2 1 880
preplace netloc axis_vita49_unpack_1_M_AXIS 1 24 1 10600
preplace netloc axis_32to64_dac_0_M_AXIS 1 37 1 N
preplace netloc fifo_valid_0 1 37 3 15890 910 NJ 910 16930
preplace netloc drp_bridge_0_drp1_di 1 37 3 15880 2210 NJ 2210 17010
preplace netloc adi_dma_split_1_M_AXIS 1 10 1 3750
preplace netloc routing_reg_0_dac_ddr_sw_0_tdest 1 24 5 N 3020 NJ 3020 NJ 3020 NJ 3020 NJ
preplace netloc fifo_valid_1 1 27 3 11930 2330 NJ 2330 12780
preplace netloc drpdo_slice_0_Dout 1 39 1 17130
preplace netloc vita49_trig_adc_0_M_AXIS 1 21 1 N
preplace netloc srio_swrite_unpack_0_M_AXIS 1 6 1 N
preplace netloc fifo_data_0 1 37 3 15910 900 NJ 900 16940
preplace netloc drpdo_slice_3_Dout 1 39 1 16980
preplace netloc fifo_data_1 1 27 3 11940 2340 NJ 2340 12770
preplace netloc axis_register_slice_0_M_AXIS 1 36 1 15500
preplace netloc srio_gen2_0_port_initialized 1 23 17 9860 5610 NJ 5610 NJ 5610 NJ 5610 NJ 5610 NJ 5610 NJ 5610 NJ 5610 NJ 5610 NJ 5690 NJ 5690 NJ 5690 NJ 5690 NJ 5690 NJ 5690 NJ 5690 16970
preplace netloc axis_32to64_dac_1_M_AXIS 1 27 1 11860
preplace netloc axi_ad9361_0_clk 1 16 24 6910 3600 7600 3690 8040 3450 NJ 3450 NJ 3450 NJ 3450 NJ 3450 9950 3370 NJ 3370 NJ 3370 NJ 3380 NJ 3380 NJ 3380 NJ 3240 NJ 3240 NJ 3240 NJ 3240 NJ 3240 NJ 3240 NJ 3240 NJ 3240 15840 470 16460 750 17010
preplace netloc vita49_assem_0_M_AXIS 1 28 1 12360
preplace netloc hello_router_0_M_AXIS 1 3 1 N
preplace netloc axi_srio_initiator_fifo_AXI_STR_TXD 1 35 1 14960
preplace netloc axi_cpu_interconnect_m13_axi 1 17 9 NJ 2710 NJ 2710 NJ 2710 NJ 2710 NJ 2710 NJ 2710 NJ 2710 NJ 2710 11160
preplace netloc drprdy_slice_3_Dout 1 39 1 17000
preplace netloc axis_32to64_adc_0_M_AXIS 1 24 1 N
preplace netloc vita_pack_adc_reg_1_M_AXIS 1 8 1 2970
preplace netloc axis_32to64_strb_0_M_AXIS 1 36 1 N
preplace netloc sys_reg_0_srio_reset 1 24 15 10570 5030 NJ 5030 NJ 5030 NJ 5030 NJ 5030 NJ 5030 NJ 5030 NJ 5030 NJ 5030 NJ 5290 NJ 5290 NJ 5290 NJ 5290 NJ 5290 NJ
preplace netloc srio_rxp0_1 1 0 39 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5540 NJ 5430 NJ 5430 NJ 5430 NJ 5430 NJ 5430 NJ 5430 NJ 5430 NJ 5430 NJ 5430 NJ 5430 NJ 5430 NJ 5430 NJ 5430 NJ 5430 NJ
preplace netloc vita49_trig_adc_1_trig 1 3 5 1300 3930 NJ 3930 NJ 3930 NJ 3930 2660
preplace netloc dac_ddr_sw_0_M01_AXIS 1 25 6 11180 3410 NJ 3410 NJ 3410 NJ 3410 NJ 3410 13200
preplace netloc adc_ddr_tdest_0_dout 1 25 1 11170
preplace netloc sys_100m_clk 1 0 39 180 4340 NJ 4340 NJ 4340 1260 4340 NJ 4340 1920 4340 2180 4340 NJ 4320 2990 4120 3400 4290 NJ 4290 NJ 4290 4460 4100 4740 3820 NJ 3820 6010 4150 6790 3610 7630 3730 NJ 3770 NJ 3760 8900 3750 9220 3750 9440 3680 9880 4230 NJ 4230 11100 4240 11550 4070 11850 3910 12360 3910 NJ 3950 NJ 3950 NJ 3950 NJ 3950 14150 3780 14650 3620 15130 3280 NJ 3280 NJ 3360 16430
preplace netloc axi_ad9361_1_adc_enable_0 1 2 38 970 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 2020 17070
preplace netloc axis_vita49_unpack_0_M_AXIS 1 34 1 N
preplace netloc axi_ad9361_1_adc_enable_1 1 2 38 950 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 1890 NJ 2030 17050
preplace netloc adi_dma_comb_1_M_AXIS 1 13 1 4720
preplace netloc axi_ad9361_0_rx_frame_in_n 1 0 39 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 N
preplace netloc util_adc_pack_0_ddata 1 17 1 7570
preplace netloc axi_ad9361_1_adc_enable_2 1 2 38 920 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 NJ 2040 16980
preplace netloc srio_treq_sw_M00_AXIS 1 4 30 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4780 NJ 4740 NJ 4740 NJ 4740 NJ 4740 NJ 4740 NJ 4740 NJ 4740 NJ 4740 NJ 4740 NJ 4740 NJ 4740 NJ 4740 NJ 4740 NJ 4740 NJ 4740 NJ 4740 NJ 4740 NJ 4740 NJ 4740 NJ 4740 NJ 4740 NJ 4890 NJ
preplace netloc srio_dma_s2mm_introut 1 14 1 5280
preplace netloc srio_gen2_0_link_initialized 1 23 17 9870 5600 NJ 5600 NJ 5600 NJ 5600 NJ 5600 NJ 5600 NJ 5600 NJ 5600 NJ 5600 NJ 5600 NJ 5600 NJ 5600 NJ 5600 NJ 5600 NJ 5600 NJ 5610 16940
preplace netloc axi_ad9361_1_adc_enable_3 1 2 38 900 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 1910 NJ 2050 16950
preplace netloc axi_cpu_interconnect_M27_AXI 1 17 12 NJ 2910 NJ 2910 NJ 2910 NJ 2910 NJ 2910 NJ 2910 NJ 2910 NJ 3000 NJ 3000 NJ 3000 NJ 3000 12330
preplace netloc axi_ad9361_0_rx_frame_in_p 1 0 39 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 N
preplace netloc axi_cpu_interconnect_M26_AXI 1 17 10 NJ 2900 NJ 2900 NJ 2900 NJ 2900 NJ 2900 NJ 2900 NJ 2900 NJ 3010 NJ 3010 11620
preplace netloc drp_bridge_0_drp1_en 1 37 3 15910 3000 NJ 3000 17050
preplace netloc axi_ad9361_0_tx_clk_out_n 1 39 1 N
preplace netloc vita49_clk_tsi_0 1 20 16 8900 4020 NJ 4020 9410 4020 NJ 4100 10620 4100 NJ 4210 NJ 4150 NJ 4150 NJ 4150 NJ 4150 NJ 4150 NJ 4150 NJ 4150 14050 3760 NJ 3710 NJ
preplace netloc irq_stub0_dout 1 14 1 5140
preplace netloc drp_bridge_0_drp0_di 1 37 3 15870 2190 NJ 2190 17020
preplace netloc vita49_clk_tsi_1 1 6 20 2220 4330 NJ 4330 2980 4400 NJ 4470 NJ 4320 NJ 4320 NJ 4330 NJ 4330 NJ 4340 NJ 4340 NJ 4340 NJ 4340 NJ 4460 NJ 4460 NJ 4460 NJ 4460 NJ 4460 9950 4130 10630 4130 NJ
preplace netloc axi_ad9361_0_tx_clk_out_p 1 39 1 N
preplace netloc sys_fmc_dma_clk 1 1 37 570 4680 920 4820 1300 4430 1590 4100 1900 4300 2190 4350 2700 4340 3000 4150 3370 4480 3780 4490 4120 4510 4440 4110 4750 4180 5440 3830 5980 4200 6680 4310 7480 4310 8100 3810 8540 3780 8870 3780 9200 3780 9430 3670 9830 3580 10650 3590 11150 4220 11580 3790 11900 3750 12380 3790 12800 3620 13230 3630 13440 3630 13750 3870 14080 3420 14590 3430 15040 3820 15480 3820 15810
preplace netloc axi_cpu_interconnect_m00_axi 1 17 22 NJ 2450 NJ 2450 NJ 2450 NJ 2450 NJ 2450 NJ 2450 NJ 2450 NJ 2450 NJ 2450 NJ 2450 NJ 2450 NJ 2450 NJ 2450 NJ 2450 NJ 2450 NJ 2450 NJ 2450 NJ 2450 NJ 2450 NJ 2450 NJ 2450 16290
preplace netloc vita49_trig_adc_0_trig 1 17 5 7640 3740 NJ 3740 NJ 3730 NJ 3730 9190
preplace netloc axis_64to32_adc_1_M_AXIS 1 6 1 2170
preplace netloc axis_vita49_unpack_1_irq 1 14 11 5470 3360 NJ 3360 NJ 3580 NJ 3370 NJ 3380 NJ 3380 NJ 3380 NJ 3380 NJ 3380 NJ 3380 10560
preplace netloc vita_trig_dac_reg_1_M_AXIS 1 25 1 N
preplace netloc axi_dma_0_M_AXI_S2MM 1 14 15 5510 4390 NJ 4390 NJ 4390 NJ 4390 NJ 4440 NJ 4440 NJ 4440 NJ 4440 NJ 4440 NJ 4560 NJ 4560 NJ 4560 NJ 4560 NJ 4560 12300
preplace netloc drp_bridge_0_drp3_di 1 37 3 15930 2950 NJ 2950 16940
preplace netloc axi_ad9361_1_dac_dunf 1 29 10 NJ 1770 NJ 1770 NJ 1770 NJ 1770 NJ 1770 NJ 1770 NJ 1770 NJ 1770 NJ 1770 N
preplace netloc srio_ireq_intc_M00_AXIS 1 38 1 16250
preplace netloc srio_rxn0_1 1 0 39 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5410 NJ 5410 NJ 5410 NJ 5410 NJ 5410 NJ 5410 NJ 5410 NJ 5410 NJ 5410 NJ 5410 NJ 5410 NJ 5410 NJ 5410 NJ 5410 NJ
preplace netloc sys_ps7_fixed_io 1 16 24 6720 3750 NJ 3750 NJ 3750 NJ 3650 NJ 3650 NJ 3650 NJ 3650 NJ 3650 NJ 3650 NJ 3650 NJ 3920 NJ 3920 NJ 3920 NJ 3930 NJ 3930 NJ 3930 NJ 3930 NJ 3930 NJ 4050 NJ 4080 NJ 4080 NJ 4090 NJ 4040 NJ
preplace netloc axi_ad9361_0_dac_dunf 1 38 2 16470 760 16980
preplace netloc axis_vita49_unpack_0_irq 1 14 21 5480 3190 NJ 3190 NJ 3570 NJ 3400 NJ 3400 NJ 3400 NJ 3400 NJ 3400 NJ 3400 NJ 3400 NJ 3400 NJ 3400 NJ 3400 NJ 3400 NJ 3400 NJ 3400 NJ 3400 NJ 3400 NJ 3400 NJ 3400 14490
preplace netloc sys_200m_clk 1 16 23 6770 1590 NJ 1590 NJ 1590 NJ 1590 NJ 1590 NJ 1590 NJ 1590 NJ 1590 NJ 1590 NJ 1590 NJ 1590 NJ 1590 NJ 1590 NJ 1590 NJ 1590 NJ 1590 NJ 1590 NJ 1590 NJ 1590 NJ 1590 NJ 1590 NJ 1590 16280
preplace netloc adc_ddr_sw_1_M01_AXIS 1 12 24 4450 4140 NJ 4140 NJ 4020 NJ 4160 NJ 4160 NJ 4160 NJ 4160 NJ 4160 NJ 4160 NJ 4170 NJ 4160 NJ 4160 NJ 4160 NJ 4200 NJ 4130 NJ 4130 NJ 4130 NJ 3870 NJ 3870 NJ 3870 NJ 3670 NJ 3700 NJ 3610 NJ
preplace netloc xlslice_0_Dout 1 23 1 9940
preplace netloc spi_mosi_i 1 0 17 NJ 3530 NJ 3530 NJ 3530 NJ 3530 NJ 3530 NJ 3530 NJ 3530 NJ 3530 NJ 3530 NJ 3530 NJ 3530 NJ 3530 NJ 3530 NJ 3530 NJ 3380 NJ 3380 6630
preplace netloc axi_gpio_1 1 0 40 NJ 3460 NJ 3460 NJ 3460 NJ 3460 NJ 3460 NJ 3460 NJ 3460 NJ 3460 NJ 3460 NJ 3460 NJ 3460 NJ 3460 NJ 3460 NJ 3460 NJ 3350 NJ 3350 NJ 4040 NJ 4040 NJ 4040 NJ 4040 NJ 4040 NJ 4000 NJ 4000 NJ 3820 NJ 3820 NJ 3820 NJ 3820 NJ 3820 NJ 3820 NJ 3820 NJ 3820 NJ 3820 NJ 3820 NJ 3820 NJ 3650 NJ 3740 NJ 3740 NJ 3740 NJ 3740 16940
preplace netloc srio_gen2_0_log_clk_out 1 1 39 580 4920 NJ 4840 NJ 4840 NJ 4840 NJ 4840 NJ 4840 NJ 4840 NJ 4840 NJ 4840 NJ 4840 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 NJ 4720 13720 4900 14130 4730 NJ 4730 NJ 4730 NJ 4730 15910 4720 NJ 4720 16970
preplace netloc srio_gen2_0_TARGET_REQ 1 1 39 560 3490 NJ 3490 NJ 3490 NJ 3490 NJ 3490 NJ 3490 NJ 3490 NJ 3490 NJ 3490 NJ 3420 NJ 3420 NJ 3420 NJ 3420 NJ 3420 NJ 3420 NJ 3540 NJ 3330 NJ 3330 NJ 3330 NJ 3330 NJ 3330 NJ 3330 NJ 3330 NJ 3330 NJ 3330 NJ 3330 NJ 3330 NJ 3340 NJ 3260 NJ 3260 NJ 3260 NJ 3260 NJ 3260 NJ 3260 NJ 3260 NJ 3260 NJ 3400 NJ 3400 17010
preplace netloc srio_gen2_0_srio_txn0 1 39 1 17040
preplace netloc axi_cpu_interconnect_m07_axi 1 17 6 NJ 2590 NJ 2590 NJ 2590 NJ 2590 NJ 2590 NJ
preplace netloc srio_gen2_0_srio_txn1 1 39 1 17060
preplace netloc srio_rxn1_1 1 0 39 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5500 NJ 5450 NJ 5450 NJ 5450 NJ 5450 NJ 5450 NJ 5450 NJ 5450 NJ 5450 NJ 5450 NJ 5450 NJ 5450 NJ 5450 NJ 5450 NJ 5450 NJ
preplace netloc spi_mosi_o 1 16 24 N 3690 NJ 3700 NJ 3730 NJ 3630 NJ 3630 NJ 3630 NJ 3630 NJ 3630 NJ 3630 NJ 3630 NJ 3870 NJ 3870 NJ 3870 NJ 3890 NJ 3890 NJ 3890 NJ 3890 NJ 3890 NJ 3730 NJ 3810 NJ 3810 NJ 3810 NJ 3810 NJ
preplace netloc srio_gen2_0_srio_txn2 1 39 1 17140
preplace netloc axi_ad9361_1_tx_frame_out_n 1 39 1 N
preplace netloc srio_gen2_0_srio_txn3 1 39 1 17220
preplace netloc drp_bridge_0_drp1_addr 1 37 3 15910 2200 NJ 2200 17080
preplace netloc axi_ad9361_1_tx_frame_out_p 1 39 1 N
preplace netloc srio_tresp_intc_M00_AXIS 1 38 1 16240
preplace netloc srio_swrite_pack_0_M_AXIS 1 36 1 15500
preplace netloc axi_ad9361_1_rx_data_in_n 1 0 39 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 NJ 1410 16420
preplace netloc drp_bridge_0_drp0_en 1 37 3 15930 3170 NJ 3060 17100
preplace netloc axi_cpu_interconnect_M24_AXI 1 12 6 4420 3400 NJ 3400 NJ 3280 NJ 3280 NJ 3480 7400
preplace netloc axi_ad9361_1_dac_data_0 1 28 11 NJ 1670 NJ 1670 NJ 1670 NJ 1670 NJ 1670 NJ 1670 NJ 1670 NJ 1670 NJ 1670 NJ 1670 N
preplace netloc axi_srio_target_fifo_interrupt 1 14 23 5510 3210 NJ 3210 NJ 3550 NJ 3350 NJ 3350 NJ 3350 NJ 3350 NJ 3350 NJ 3350 NJ 3350 NJ 3350 NJ 3350 NJ 3350 NJ 3350 NJ 3350 NJ 3300 NJ 3300 NJ 3300 NJ 3300 NJ 3300 NJ 3300 NJ 3300 15460
preplace netloc axi_cpu_interconnect_M18_AXI 1 5 13 1920 3280 NJ 3280 NJ 3280 NJ 3280 NJ 3280 NJ 3280 NJ 3280 NJ 3280 NJ 3280 NJ 3250 NJ 3250 NJ 3450 7430
preplace netloc constant_0_dout 1 9 20 3360 3310 NJ 3310 NJ 3310 NJ 3310 NJ 3410 NJ 3400 NJ 3400 NJ 3560 NJ 3290 NJ 3290 NJ 3290 NJ 3290 NJ 3290 NJ 3290 NJ 3290 NJ 3290 NJ 3290 NJ 3290 NJ 3290 NJ
preplace netloc axi_ad9361_1_rx_data_in_p 1 0 39 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 16410
preplace netloc axi_dma_1_s2mm_introut 1 14 1 5290
preplace netloc axi_ad9361_1_dac_data_1 1 28 11 NJ 1690 NJ 1690 NJ 1690 NJ 1690 NJ 1690 NJ 1690 NJ 1690 NJ 1690 NJ 1690 NJ 1690 N
preplace netloc adc_fifo_0_M_AXIS 1 25 1 N
preplace netloc drpen_concat_dout 1 38 1 16220
preplace netloc axi_ad9361_1_dac_data_2 1 28 11 NJ 1710 NJ 1710 NJ 1710 NJ 1710 NJ 1710 NJ 1710 NJ 1710 NJ 1710 NJ 1710 NJ 1710 N
preplace netloc vita_unpack_dac_reg_1_M_AXIS 1 19 5 NJ 4370 NJ 4370 NJ 4370 NJ 4370 NJ
preplace netloc axi_dma_1_M_AXI_MM2S 1 14 1 5330
preplace netloc axi_cpu_interconnect_M17_AXI 1 17 19 N 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ 2790 NJ
preplace netloc adc_ddr_sw_1_M00_AXIS 1 12 1 N
preplace netloc adc_ddr_sw_0_M01_AXIS 1 26 10 NJ 3370 NJ 3370 NJ 3370 NJ 3370 NJ 3370 NJ 3370 NJ 3370 NJ 3370 NJ 3370 NJ
preplace netloc drp_bridge_0_drp3_en 1 37 3 15890 2980 NJ 2980 16960
preplace netloc drpdo_slice_1_Dout 1 39 1 17110
preplace netloc axi_ad9361_1_dac_data_3 1 28 11 NJ 1730 NJ 1730 NJ 1730 NJ 1730 NJ 1730 NJ 1730 NJ 1730 NJ 1730 NJ 1730 NJ 1730 N
preplace netloc vita_trig_dac_reg_0_M_AXIS 1 35 1 15090
preplace netloc srio_dma_mm2s_introut 1 14 1 5260
preplace netloc srio_ireq_sw_M00_AXIS 1 37 1 15780
preplace netloc vita49_assem_1_M_AXIS 1 9 1 3350
preplace netloc axis_32to64_strb_0_M_AXIS1 1 37 1 15780
preplace netloc srio_gen2_0_phy_rcvd_link_reset 1 23 17 9890 5640 NJ 5640 NJ 5640 NJ 5640 NJ 5640 NJ 5640 NJ 5640 NJ 5640 NJ 5640 NJ 5660 NJ 5660 NJ 5660 NJ 5660 NJ 5660 NJ 5660 NJ 5660 17020
preplace netloc vita49_trig_dac_1_M_AXIS 1 26 1 11500
preplace netloc util_adc_pack_0_dsync 1 17 1 7540
preplace netloc vita_unpack_dac_reg_0_M_AXIS 1 33 1 14040
preplace netloc axi_cpu_interconnect_m10_axi 1 3 15 1290 3340 NJ 3340 NJ 3340 NJ 3340 NJ 3340 NJ 3340 NJ 3340 NJ 3340 NJ 3340 NJ 3340 NJ 3390 NJ 3290 NJ 3290 NJ 3490 7490
preplace netloc axi_ad9361_0_adc_chan_q1 1 16 24 6950 1210 NJ 1210 NJ 1210 NJ 1210 NJ 1210 NJ 1210 NJ 1210 NJ 1210 NJ 1210 NJ 1210 NJ 1210 NJ 1210 NJ 1210 NJ 1210 NJ 1210 NJ 1210 NJ 1210 NJ 1210 NJ 1210 NJ 1210 NJ 1210 NJ 1210 NJ 1210 17110
preplace netloc axi_ad9361_0_adc_chan_q2 1 16 24 7000 1220 NJ 1220 NJ 1220 NJ 1220 NJ 1220 NJ 1220 NJ 1220 NJ 1220 NJ 1220 NJ 1220 NJ 1220 NJ 1220 NJ 1220 NJ 1220 NJ 1220 NJ 1220 NJ 1220 NJ 1220 NJ 1220 NJ 1220 NJ 1220 NJ 1220 NJ 1220 17070
preplace netloc drp_bridge_0_drp0_addr 1 37 3 15900 2180 NJ 2180 17090
preplace netloc adc_ddr_tdest_1_dout 1 11 1 4100
preplace netloc axi_ad9361_1_dac_valid_0 1 27 13 11910 1960 NJ 1960 NJ 1960 NJ 1960 NJ 1960 NJ 1960 NJ 1960 NJ 1960 NJ 1960 NJ 1960 NJ 1960 NJ 2100 16970
preplace netloc axis_64to32_strb_0_M_AXIS1 1 35 1 14950
preplace netloc axi_dma_0_M_AXI_MM2S 1 14 15 5480 3330 NJ 3330 NJ 3520 NJ 3390 NJ 3390 NJ 3390 NJ 3390 NJ 3390 NJ 3390 NJ 3390 NJ 3390 NJ 3390 NJ 3390 NJ 3390 12300
preplace netloc axi_cpu_interconnect_m04_axi 1 17 11 NJ 2530 NJ 2530 NJ 2530 NJ 2530 NJ 2530 NJ 2530 NJ 2530 NJ 2530 NJ 2530 NJ 2530 11930
preplace netloc axi_ad9361_1_dac_valid_1 1 27 13 11900 1980 NJ 2140 NJ 2140 NJ 2140 NJ 2140 NJ 2140 NJ 2140 NJ 2140 NJ 2140 NJ 2140 NJ 2140 NJ 2140 17020
preplace netloc srio_rxn2_1 1 0 39 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5510 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ 5490 NJ
preplace netloc routing_reg_0_adc_sw_dest0 1 24 1 10590
preplace netloc axi_ad9361_1_dac_valid_2 1 27 13 11890 1990 NJ 2150 NJ 2150 NJ 2150 NJ 2150 NJ 2150 NJ 2150 NJ 2150 NJ 2150 NJ 2150 NJ 2150 NJ 2150 16990
preplace netloc routing_reg_0_adc_sw_dest1 1 10 15 3780 3900 NJ 3900 NJ 3900 NJ 3900 NJ 3900 NJ 4190 NJ 4190 NJ 4190 NJ 4190 NJ 4190 NJ 4190 NJ 4190 NJ 4190 NJ 4190 10590
preplace netloc drp_bridge_0_drp0_we 1 37 3 15920 2970 NJ 2970 17060
preplace netloc axi_ad9361_1_dac_valid_3 1 27 13 11880 1270 NJ 1270 NJ 1270 NJ 1270 NJ 1270 NJ 1270 NJ 1270 NJ 1270 NJ 1270 NJ 1270 NJ 1270 NJ 1270 17080
preplace netloc dac_ddr_sw_0_M00_AXIS 1 30 1 N
preplace netloc srio_sys_clkn_1 1 0 39 NJ 4950 NJ 4950 NJ 4950 NJ 4950 NJ 4950 NJ 4950 NJ 4950 NJ 4950 NJ 4950 NJ 4950 NJ 4950 NJ 4950 NJ 4950 NJ 4950 NJ 4750 NJ 4750 NJ 4750 NJ 4750 NJ 4750 NJ 4750 NJ 4750 NJ 4750 NJ 4750 NJ 4750 NJ 4750 NJ 4750 NJ 4750 NJ 4750 NJ 4750 NJ 4750 NJ 4750 NJ 4750 NJ 4910 NJ 4890 NJ 4870 NJ 4870 NJ 4870 NJ 4870 N
preplace netloc vita49_trig_dac_0_trig 1 33 4 14170 3720 NJ 3690 NJ 3770 15450
preplace netloc routing_reg_0_adc_ddr_sw_0_tdest 1 24 1 10620
preplace netloc axis_32to64_adc_1_M_AXIS 1 10 1 N
preplace netloc axi_ad9361_0_adc_dma_interconnect_m00_axi 1 15 1 5960
preplace netloc drp_bridge_0_drp3_we 1 37 3 15900 2960 NJ 2960 16930
preplace netloc const_1_dout 1 33 2 14170 4460 NJ
preplace netloc axis_adc_interconnect_1_M00_AXIS 1 5 1 1890
preplace netloc axi_ad9361_1_adc_chan_i1 1 2 38 910 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 16930
preplace netloc axi_ad9361_1_adc_chan_i2 1 2 38 870 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 17090
preplace netloc srio_gen2_0_srio_txp0 1 39 1 17050
preplace netloc srio_dma_M_AXIS_MM2S 1 14 21 NJ 4010 NJ 4220 NJ 4220 NJ 4220 NJ 4220 NJ 4220 NJ 4220 NJ 4220 NJ 4220 NJ 3810 NJ 3810 NJ 3810 NJ 3810 NJ 3810 NJ 3850 NJ 3850 NJ 3850 NJ 3850 NJ 3850 NJ 3850 NJ
preplace netloc srio_gen2_0_srio_txp1 1 39 1 17090
preplace netloc srio_gen2_0_srio_txp2 1 39 1 17200
preplace netloc sys_ps7_ddr 1 16 24 6700 3780 NJ 3780 NJ 3780 NJ 3710 NJ 3710 NJ 3710 NJ 3710 NJ 3710 NJ 3710 NJ 3710 NJ 3880 NJ 3880 NJ 3880 NJ 3920 NJ 3920 NJ 3660 NJ 3660 NJ 3750 NJ 3750 NJ 3790 NJ 3790 NJ 3790 NJ 3790 NJ
preplace netloc axis_64to32_adc_0_M_AXIS 1 20 1 8860
preplace netloc srio_gen2_0_srio_txp3 1 39 1 17230
preplace netloc vita_dac_sw_M00_AXIS 1 8 20 NJ 3860 NJ 3860 NJ 3860 NJ 3860 NJ 3860 NJ 3860 NJ 3860 NJ 4120 NJ 4050 NJ 4050 NJ 4050 NJ 4050 NJ 4050 NJ 4050 NJ 4040 NJ 4120 NJ 4120 NJ 3960 NJ 4060 11880
preplace netloc axi_srio_interconnect_M01_AXI 1 34 1 N
preplace netloc axi_dma_1_M_AXIS_MM2S 1 9 6 3420 3150 NJ 3150 NJ 3150 NJ 3150 NJ 3150 5150
preplace netloc axi_dma_0_M_AXIS_MM2S 1 28 1 12310
preplace netloc axi_cpu_interconnect_m11_axi 1 13 5 4760 3430 NJ 3300 NJ 3300 NJ 3500 7480
preplace netloc sys_ps7_M_AXI_GP1 1 16 18 N 3870 NJ 3870 NJ 3870 NJ 3920 NJ 3700 NJ 3700 NJ 3700 NJ 3700 NJ 3700 NJ 3700 NJ 3890 NJ 3890 NJ 3890 NJ 3910 NJ 3910 NJ 3910 NJ 3910 NJ
preplace netloc axi_cpu_interconnect_M01_AXI 1 17 7 NJ 2470 NJ 2470 NJ 2470 NJ 2470 NJ 2470 NJ 2470 9940
preplace netloc spi_csn_i 1 0 17 NJ 3480 NJ 3480 NJ 3480 NJ 3480 NJ 3480 NJ 3480 NJ 3480 NJ 3480 NJ 3480 NJ 3480 NJ 3480 NJ 3480 NJ 3480 NJ 3480 NJ 3410 NJ 3410 6610
preplace netloc srio_rxp2_1 1 0 39 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ 5560 NJ
preplace netloc adi_dma_comb_0_M_AXIS 1 27 1 11840
preplace netloc sys_ps7_GPIO_I 1 0 17 NJ 3470 NJ 3470 NJ 3470 NJ 3470 NJ 3470 NJ 3470 NJ 3470 NJ 3470 NJ 3470 NJ 3470 NJ 3470 NJ 3470 NJ 3470 NJ 3470 NJ 3320 NJ 3320 6650
preplace netloc dac_ddr_tdest_0_dout 1 29 1 12810
preplace netloc drprdy_slice_2_Dout 1 39 1 17080
preplace netloc drp_bridge_0_drp2_di 1 37 3 15890 2230 NJ 2230 17000
preplace netloc srio_gen2_0_INITIATOR_RESP 1 32 8 13760 3290 NJ 3290 NJ 3290 NJ 3290 NJ 3290 NJ 3380 NJ 3380 17020
preplace netloc c_counter_binary_0_Q 1 22 1 9420
preplace netloc spi_csn_o 1 16 24 6690 3760 NJ 3760 NJ 3760 NJ 3740 NJ 3740 NJ 3740 NJ 3720 NJ 3780 NJ 3780 NJ 3780 NJ 3780 NJ 3780 NJ 3800 NJ 3800 NJ 3800 NJ 3800 NJ 3810 NJ 3810 NJ 3670 NJ 3780 NJ 3780 NJ 3780 NJ 3780 NJ
preplace netloc vita49_trig_adc_1_M_AXIS 1 7 1 2690
preplace netloc axi_ad9361_0_dac_dma_interconnect_m00_axi 1 15 1 5900
preplace netloc spi_csn_1_o 1 16 24 N 3770 NJ 3770 NJ 3790 NJ 3600 NJ 3600 NJ 3600 NJ 3600 NJ 3670 NJ 3670 NJ 3670 NJ 3800 NJ 3800 NJ 3810 NJ 3810 NJ 3610 NJ 3610 NJ 3610 NJ 3740 NJ 3740 NJ 3800 NJ 3800 NJ 3800 NJ 3800 NJ
preplace netloc srio_gen2_0_clk_lock_out 1 23 17 9910 5520 NJ 5520 NJ 5520 NJ 5520 NJ 5520 NJ 5520 NJ 5520 NJ 5520 NJ 5520 NJ 5520 NJ 5520 NJ 5520 NJ 5520 NJ 5520 NJ 5520 NJ 5600 16930
preplace netloc axi_ad9361_1_tx_clk_out_n 1 39 1 N
preplace netloc sys_ps7_GPIO_O 1 16 24 6710 3940 NJ 3940 NJ 3940 NJ 3940 NJ 3640 NJ 3640 NJ 3640 NJ 3640 NJ 3640 NJ 3640 NJ 3850 NJ 3850 NJ 3860 NJ 3860 NJ 3620 NJ 3620 NJ 3620 NJ 3770 NJ 3770 NJ 4100 NJ 4100 NJ 4110 16270 4150 NJ
preplace netloc vita49_trig_dac_0_M_AXIS 1 36 1 N
preplace netloc axi_ad9361_0_rx_data_in_n 1 0 39 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 N
preplace netloc axi_cpu_interconnect_m08_axi 1 17 4 NJ 2610 NJ 2610 NJ 2610 NJ
preplace netloc srio_gen2_0_gt_drprdy_out 1 38 1 16470
preplace netloc axi_ad9361_1_tx_clk_out_p 1 39 1 N
preplace netloc ddr_fifo_M_AXIS 1 7 1 2680
preplace netloc axi_cpu_interconnect_M15_AXI 1 6 12 2210 3330 NJ 3330 NJ 3330 NJ 3330 NJ 3330 NJ 3330 NJ 3330 NJ 3380 NJ 3240 NJ 3240 NJ 3440 7440
preplace netloc axi_ad9361_0_rx_data_in_p 1 0 39 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 NJ 280 N
preplace netloc sys_reg_0_gt_txpostcursor 1 24 15 10640 5250 NJ 5250 NJ 5250 NJ 5250 NJ 5250 NJ 5250 NJ 5250 NJ 5250 NJ 5250 NJ 5250 NJ 5250 NJ 5250 NJ 5250 NJ 5250 NJ
preplace netloc axi_cpu_interconnect_m02_axi 1 17 22 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 N
preplace netloc axi_srio_interconnect_M02_AXI 1 34 2 NJ 4250 14970
preplace netloc sys_ps7_GPIO_T 1 16 24 6680 3950 NJ 3950 NJ 3950 NJ 3950 NJ 3690 NJ 3690 NJ 3690 NJ 3690 NJ 3690 NJ 3690 NJ 3900 NJ 3900 NJ 3900 NJ 3900 NJ 3900 NJ 3900 NJ 3900 NJ 3900 NJ 3720 NJ 3750 NJ 3750 NJ 3750 NJ 3750 NJ
preplace netloc drp_bridge_0_drp3_addr 1 37 3 15930 2240 NJ 2240 17030
preplace netloc vita_pack_adc_reg_0_M_AXIS 1 22 1 9400
preplace netloc axi_srio_interconnect_M03_AXI 1 34 2 NJ 4240 14960
preplace netloc adi_dma_split_0_M_AXIS 1 29 1 N
preplace netloc spi_miso_i 1 0 17 NJ 3510 NJ 3510 NJ 3510 NJ 3510 NJ 3510 NJ 3510 NJ 3510 NJ 3510 NJ 3510 NJ 3510 NJ 3510 NJ 3510 NJ 3510 NJ 3510 NJ 3390 NJ 3390 6620
preplace netloc axi_dma_2_M_AXI_S2MM 1 14 1 5350
preplace netloc srio_gen2_0_phy_rcvd_mce 1 23 17 9900 5650 NJ 5650 NJ 5650 NJ 5650 NJ 5650 NJ 5650 NJ 5650 NJ 5650 NJ 5650 NJ 5670 NJ 5670 NJ 5670 NJ 5670 NJ 5670 NJ 5670 NJ 5670 17010
preplace netloc axi_srio_interconnect_M07_AXI 1 34 5 NJ 2660 NJ 2660 NJ 2660 NJ 2660 16310
preplace netloc srio_sys_clkp_1 1 0 39 NJ 4970 NJ 4970 NJ 4850 NJ 4850 NJ 4850 NJ 4850 NJ 4850 NJ 4850 NJ 4850 NJ 4850 NJ 4850 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4730 NJ 4920 NJ 4920 NJ 4920 NJ 4920 NJ 4920 NJ 4920 16410
preplace netloc axi_ad9361_1_clk 1 2 38 930 3050 1250 3050 1560 3870 NJ 3870 NJ 3870 NJ 3870 NJ 3870 NJ 3870 NJ 3870 NJ 3870 NJ 3870 NJ 3870 NJ 3870 NJ 4230 NJ 4230 NJ 4230 NJ 4230 NJ 4230 NJ 4230 NJ 4230 NJ 4230 9840 4250 NJ 4250 NJ 4250 NJ 4250 11870 2350 12380 2160 NJ 2160 NJ 2160 NJ 2160 NJ 2160 NJ 2160 NJ 2160 NJ 2160 NJ 2160 NJ 2160 16380 2160 17120
preplace netloc axi_cpu_interconnect_M06_AXI 1 17 7 NJ 2570 NJ 2570 NJ 2570 NJ 2570 NJ 2570 NJ 2570 9860
preplace netloc srio_gen2_0_gt_drpdo_out 1 38 1 16460
preplace netloc axi_ad9361_0_dac_data_0 1 38 1 16210
preplace netloc axi_ad9361_1_dac_dma_interconnect_m00_axi 1 15 1 5970
preplace netloc axi_ad9361_0_adc_chan_i1 1 16 24 6990 1040 NJ 990 NJ 990 NJ 990 NJ 990 NJ 990 NJ 990 NJ 990 NJ 990 NJ 990 NJ 990 NJ 990 NJ 990 NJ 990 NJ 990 NJ 990 NJ 990 NJ 990 NJ 990 NJ 990 NJ 990 NJ 990 NJ 990 17050
preplace netloc axi_ad9361_0_dac_data_1 1 38 1 16220
preplace netloc axi_ad9361_0_dac_data_2 1 38 1 16230
preplace netloc srio_gen2_0_deviceid 1 23 17 9960 5620 NJ 5620 NJ 5620 NJ 5620 NJ 5620 NJ 5620 NJ 5620 NJ 5620 NJ 5620 NJ 5620 NJ 5620 NJ 5620 NJ 5620 NJ 5620 NJ 5620 NJ 5620 16960
preplace netloc axi_ad9361_0_adc_chan_i2 1 16 24 7010 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1180 17060
preplace netloc srio_treq_sw_M02_AXIS 1 4 9 NJ 4090 NJ 4090 NJ 4090 NJ 4090 NJ 4090 NJ 4130 NJ 3970 NJ 3970 N
preplace netloc axi_ad9361_0_dac_data_3 1 38 1 16260
preplace netloc dac_ddr_tdest_1_dout 1 10 1 3760
preplace netloc routing_reg_0_dac_ddr_sw_1_tdest 1 9 16 3410 4270 NJ 4270 NJ 4270 NJ 4270 NJ 4270 NJ 3980 NJ 4170 NJ 4170 NJ 4170 NJ 4170 NJ 4170 NJ 4170 NJ 4200 NJ 4200 NJ 4200 10580
preplace netloc srio_gen2_0_mode_1x 1 23 17 9820 5630 NJ 5630 NJ 5630 NJ 5630 NJ 5630 NJ 5630 NJ 5630 NJ 5630 NJ 5630 NJ 5650 NJ 5650 NJ 5650 NJ 5650 NJ 5650 NJ 5650 NJ 5650 16950
preplace netloc axi_sg_interconnect_M00_AXI 1 15 1 5990
preplace netloc axi_cpu_interconnect_m05_axi 1 17 17 NJ 2550 NJ 2550 NJ 2550 NJ 2550 NJ 2550 NJ 2550 NJ 2550 NJ 2550 NJ 2550 NJ 2550 NJ 2550 NJ 2550 NJ 2550 NJ 2550 NJ 2550 NJ 2550 14150
preplace netloc irq_stub1_dout 1 14 1 5150
preplace netloc sys_reg_0_gt_diffctrl 1 24 15 10590 5050 NJ 5050 NJ 5050 NJ 5050 NJ 5050 NJ 5050 NJ 5050 NJ 5050 NJ 5050 NJ 5050 NJ 5050 NJ 5050 NJ 5050 NJ 5050 16430
preplace netloc axi_ad9361_1_dac_enable_0 1 27 13 11940 2010 NJ 2110 NJ 2110 NJ 2110 NJ 2110 NJ 2110 NJ 2110 NJ 2110 NJ 2110 NJ 2110 NJ 2110 NJ 2110 17030
preplace netloc srio_swrite_unpack_reg_M_AXIS 1 5 1 1880
preplace netloc axis_vita49_pack_0_M_AXIS 1 23 1 9810
preplace netloc axis_adc_interconnect_0_M00_AXIS 1 19 1 8460
preplace netloc axi_dma_1_M_AXI_SG 1 14 1 5380
preplace netloc util_adc_pack_0_dvalid 1 17 1 7560
preplace netloc axi_ad9361_1_dac_enable_1 1 27 13 11930 2020 NJ 2120 NJ 2120 NJ 2120 NJ 2120 NJ 2120 NJ 2120 NJ 2120 NJ 2120 NJ 2120 NJ 2120 NJ 2120 17000
preplace netloc util_adc_pack_1_ddata 1 3 1 1280
preplace netloc dac_fifo_1_M_AXIS 1 10 1 3740
preplace netloc axi_ad9361_1_dac_enable_2 1 27 13 11920 2000 NJ 2130 NJ 2130 NJ 2130 NJ 2130 NJ 2130 NJ 2130 NJ 2130 NJ 2130 NJ 2130 NJ 2130 NJ 2130 16960
preplace netloc axi_ad9361_1_dac_enable_3 1 27 13 11920 2320 NJ 2170 NJ 2170 NJ 2170 NJ 2170 NJ 2170 NJ 2170 NJ 2170 NJ 2170 NJ 2170 NJ 2170 NJ 2170 17010
preplace netloc axi_cpu_interconnect_m09_axi 1 17 22 NJ 1430 NJ 1430 NJ 1430 NJ 1430 NJ 1430 NJ 1430 NJ 1430 NJ 1430 NJ 1430 NJ 1430 NJ 1430 NJ 1430 NJ 1430 NJ 1430 NJ 1430 NJ 1430 NJ 1430 NJ 1430 NJ 1430 NJ 1430 NJ 1430 N
preplace netloc drpaddr_concat_dout 1 38 1 16280
preplace netloc adc_fifo_1_M_AXIS 1 11 1 N
preplace netloc axi_ad9361_0_rx_clk_in_n 1 0 39 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 N
preplace netloc axi_gpio_irq 1 14 26 5460 3970 NJ 4270 NJ 4270 NJ 4270 NJ 4270 NJ 4270 NJ 4270 NJ 4270 NJ 4270 NJ 4270 NJ 4270 NJ 4270 NJ 4270 NJ 4160 NJ 4160 NJ 3880 NJ 3880 NJ 3640 NJ 3640 NJ 3710 NJ 3640 NJ 3730 NJ 3730 NJ 3730 NJ 3730 16930
preplace netloc axi_ad9361_0_dac_drd 1 38 1 16450
preplace netloc vita_dac_sw_M01_AXIS 1 8 1 3030
preplace netloc axi_ad9361_0_rx_clk_in_p 1 0 39 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 N
preplace netloc axi_ad9361_0_tx_frame_out_n 1 39 1 N
preplace netloc axi_cpu_interconnect_m14_axi 1 8 10 3020 3170 NJ 3170 NJ 3170 NJ 3170 NJ 3170 NJ 3170 NJ 3170 NJ 3170 NJ 3510 7470
preplace netloc axi_cpu_interconnect_M29_AXI 1 9 9 3430 4150 NJ 4150 NJ 4150 NJ 4160 NJ 4160 NJ 4030 NJ 4140 NJ 4140 7450
preplace netloc axi_ad9361_0_tx_frame_out_p 1 39 1 N
preplace netloc drpdi_concat_dout 1 38 1 16260
preplace netloc srio_dma_split_0_M_AXIS 1 35 1 14980
preplace netloc routing_reg_0_swrite_bypass 1 2 23 990 4050 NJ 4050 NJ 4050 NJ 4050 NJ 4050 NJ 4050 NJ 4050 NJ 4280 NJ 4280 NJ 4280 NJ 4280 NJ 4280 NJ 3990 NJ 4210 NJ 4210 NJ 4210 NJ 4210 NJ 4210 NJ 4210 NJ 4210 NJ 4210 NJ 4210 10570
preplace netloc S01_AXI_1 1 7 8 NJ 4140 NJ 4140 NJ 4140 NJ 4140 NJ 4140 NJ 4190 NJ 4190 5170
preplace netloc srio_treq_sw_M01_AXIS 1 4 1 1580
preplace netloc axis_64to32_dac_1_M_AXIS 1 18 1 8040
preplace netloc axi_cpu_interconnect_M22_AXI 1 17 7 NJ 2880 NJ 2880 NJ 2880 NJ 2880 NJ 2880 NJ 2880 9810
preplace netloc axi_cpu_interconnect_M16_AXI 1 17 19 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ 2770 NJ
preplace netloc axi_cpu_interconnect_m12_axi 1 17 7 NJ 2690 NJ 2690 NJ 2690 NJ 2690 NJ 2690 NJ 2690 9910
preplace netloc axi_dma_2_M_AXI_MM2S 1 14 1 5300
preplace netloc adc_ddr_sw_0_M00_AXIS 1 26 1 11610
preplace netloc sys_reg_0_gt_txprecursor 1 24 15 10650 5270 NJ 5270 NJ 5270 NJ 5270 NJ 5270 NJ 5270 NJ 5270 NJ 5270 NJ 5270 NJ 5270 NJ 5270 NJ 5270 NJ 5270 NJ 5270 NJ
preplace netloc drp_bridge_0_drp2_we 1 37 3 15930 3160 NJ 2890 16950
preplace netloc srio_gen2_0_drpclk_out 1 33 7 14160 2670 NJ 2670 NJ 2670 NJ 2670 NJ 2670 16300 2250 17150
preplace netloc routing_reg_0_adc_ddr_sw_1_tdest 1 10 15 3770 3890 NJ 3890 NJ 3890 NJ 3890 NJ 3890 NJ 4180 NJ 4180 NJ 4180 NJ 4180 NJ 4180 NJ 4180 NJ 4180 NJ 4180 NJ 4180 10540
preplace netloc axi_cpu_interconnect_M28_AXI 1 12 6 4480 4150 NJ 4150 NJ 4000 NJ 4130 NJ 4130 7460
preplace netloc axi_cpu_interconnect_M25_AXI 1 17 18 NJ 2890 NJ 2890 NJ 2890 NJ 2890 NJ 2890 NJ 2890 NJ 2880 NJ 2990 NJ 2990 NJ 2990 NJ 2990 NJ 2990 NJ 2990 NJ 2990 NJ 2990 NJ 2990 NJ 2990 14640
preplace netloc axi_srio_interconnect_M00_AXI 1 34 1 14620
preplace netloc spi_sclk_i 1 0 17 NJ 3550 NJ 3550 NJ 3550 NJ 3550 NJ 3550 NJ 3550 NJ 3550 NJ 3550 NJ 3550 NJ 3550 NJ 3550 NJ 3550 NJ 3550 NJ 3550 NJ 3370 NJ 3370 6640
preplace netloc srio_swrite_pack_1_M_AXIS 1 36 1 15470
preplace netloc axi_cpu_interconnect_M23_AXI 1 13 5 4770 3490 NJ 3270 NJ 3270 NJ 3470 7410
preplace netloc drpdo_slice_2_Dout 1 39 1 17040
preplace netloc axi_ad9361_1_dac_drd 1 28 1 12340
preplace netloc dac_fifo_0_M_AXIS 1 29 1 12810
preplace netloc srio_iresp_intc_M00_AXIS 1 33 1 14160
preplace netloc axi_srio_target_fifo_AXI_STR_TXD 1 36 1 N
preplace netloc axi_ad9361_1_adc_chan_q1 1 2 38 890 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 1840 NJ 2000 16940
preplace netloc axi_ad9361_1_adc_valid_0 1 2 38 990 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 NJ 2060 17110
preplace netloc spi_sclk_o 1 16 24 N 3650 NJ 3710 NJ 3720 NJ 3610 NJ 3610 NJ 3610 NJ 3610 NJ 3600 NJ 3600 NJ 3610 NJ 3840 NJ 3840 NJ 3840 NJ 3840 NJ 3840 NJ 3840 NJ 3840 NJ 3840 NJ 3760 NJ 3760 NJ 3760 NJ 3760 NJ 3760 NJ
preplace netloc axi_ad9361_1_adc_chan_q2 1 2 38 880 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 1860 NJ 2010 16930
preplace netloc axi_ad9361_1_adc_valid_1 1 2 38 980 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 1930 NJ 2070 17100
preplace netloc drp_bridge_0_drp2_addr 1 37 3 15920 2220 NJ 2220 17070
preplace netloc srio_maint_reg_M_AXI 1 38 1 16210
preplace netloc axi_ad9361_1_adc_valid_2 1 2 38 960 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 1940 NJ 2080 17060
preplace netloc dac_ddr_sw_0_reg_M_AXIS 1 31 1 N
preplace netloc drpwe_concat_dout 1 38 1 16230
preplace netloc axi_ad9361_1_adc_valid_3 1 2 38 940 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 1950 NJ 2090 17040
preplace netloc axis_64to32_dac_0_M_AXIS 1 32 1 N
preplace netloc axi_srio_interconnect_M04_AXI 1 34 4 NJ 4060 NJ 4070 NJ 4070 15790
preplace netloc sys_reg_0_phy_mce 1 24 15 10640 5360 NJ 5360 NJ 5360 NJ 5360 NJ 5360 NJ 5360 NJ 5360 NJ 5360 NJ 5360 NJ 5360 NJ 5360 NJ 5360 NJ 5360 NJ 5360 NJ
preplace netloc axi_ad9361_1_rx_clk_in_n 1 0 39 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 16460
preplace netloc axi_dma_2_M_AXI_SG 1 14 1 5390
preplace netloc axi_dma_1_mm2s_introut 1 14 1 5270
preplace netloc srio_rxn3_1 1 0 39 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ 5530 NJ
preplace netloc axi_ad9361_1_rx_clk_in_p 1 0 39 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ 1330 16470
preplace netloc axi_ad9361_0_adc_valid_0 1 16 24 6920 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 17150
preplace netloc sys_reg_0_phy_link_reset 1 24 15 10580 5350 NJ 5350 NJ 5350 NJ 5350 NJ 5350 NJ 5350 NJ 5350 NJ 5350 NJ 5350 NJ 5350 NJ 5350 NJ 5350 NJ 5350 NJ 5350 NJ
preplace netloc srio_target_reg_M_AXIS 1 34 1 14650
preplace netloc axi_srio_initiator_fifo_interrupt 1 14 22 5450 3800 NJ 4260 NJ 4260 NJ 4260 NJ 4260 NJ 4260 NJ 4260 NJ 4260 NJ 4260 NJ 3760 NJ 3760 NJ 3760 NJ 3770 NJ 3770 NJ 3770 NJ 3600 NJ 3600 NJ 3600 NJ 3600 NJ 3730 NJ 3660 14950
preplace netloc axi_ad9361_0_adc_valid_1 1 16 24 6930 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 17130
preplace netloc srio_gen2_0_port_error 1 23 17 9840 5660 NJ 5660 NJ 5660 NJ 5660 NJ 5660 NJ 5660 NJ 5660 NJ 5660 NJ 5660 NJ 5680 NJ 5680 NJ 5680 NJ 5680 NJ 5680 NJ 5680 NJ 5680 16980
preplace netloc axi_ad9361_0_adc_valid_2 1 16 24 7020 1060 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ 1010 17000
preplace netloc irq_stub2_dout 1 14 1 5160
preplace netloc axi_ad9361_0_adc_valid_3 1 16 24 7030 1070 NJ 1020 NJ 1020 NJ 1020 NJ 1020 NJ 1020 NJ 1020 NJ 1020 NJ 1020 NJ 1020 NJ 1020 NJ 1020 NJ 1020 NJ 1020 NJ 1020 NJ 1020 NJ 1020 NJ 1020 NJ 1020 NJ 1020 NJ 1020 NJ 1020 NJ 1020 16990
preplace netloc sys_reg_0_force_reinit 1 24 15 N 5380 NJ 5380 NJ 5380 NJ 5380 NJ 5380 NJ 5380 NJ 5380 NJ 5380 NJ 5380 NJ 5380 NJ 5380 NJ 5380 NJ 5380 NJ 5380 NJ
preplace netloc sys_100m_resetn 1 1 38 550 4930 960 4830 1270 4070 1570 4070 1910 4310 2200 4390 2670 4480 3010 4160 3360 4490 3770 4330 4110 4330 4420 4170 4760 4170 5400 3430 NJ 3220 6870 3590 7620 3420 8070 3880 8530 3930 8910 3760 9210 3760 9410 3660 9890 3660 10640 3420 11130 4230 11570 4080 11920 3790 12370 3780 12780 3610 13210 3640 13420 3650 13730 3860 14090 3440 14600 3440 15050 4240 15490 3840 15830 3500 16370
preplace netloc dac_ddr_sw_1_M00_AXIS 1 11 7 N 4670 NJ 4320 NJ 4320 NJ 4330 NJ 4330 NJ 4330 NJ
preplace netloc axi_dma_0_M_AXI_SG 1 14 15 5510 3340 NJ 3340 NJ 3530 NJ 3430 NJ 3430 NJ 3430 NJ 3430 NJ 3430 NJ 3430 NJ 3570 NJ 3430 NJ 3430 NJ 3430 NJ 3430 12290
preplace netloc axi_ad9361_0_dac_valid_0 1 37 3 15850 800 NJ 800 16970
preplace netloc sys_reg_0_srio_loopback 1 24 15 10550 5020 NJ 5020 NJ 5020 NJ 5020 NJ 5020 NJ 5020 NJ 5020 NJ 5020 NJ 5020 NJ 5190 NJ 5190 NJ 5190 NJ 5190 NJ 5190 NJ
preplace netloc axi_ad9361_0_dac_valid_1 1 37 3 15870 10 NJ 10 17040
preplace netloc srio_rxp1_1 1 0 39 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5550 NJ 5470 NJ 5470 NJ 5470 NJ 5470 NJ 5470 NJ 5470 NJ 5470 NJ 5470 NJ 5470 NJ 5470 NJ 5470 NJ 5470 NJ 5470 NJ 5470 NJ
preplace netloc axi_ad9361_0_dac_valid_2 1 37 3 15880 20 NJ 20 17030
preplace netloc axi_ad9361_0_tx_data_out_n 1 39 1 N
preplace netloc util_adc_pack_1_dvalid 1 3 1 1240
preplace netloc axi_ad9361_0_dac_valid_3 1 37 3 15890 30 NJ 30 17020
preplace netloc dac_ddr_sw_1_M01_AXIS 1 11 1 4100
preplace netloc axi_ad9361_1_adc_dma_interconnect_m00_axi 1 15 1 5940
preplace netloc axi_ad9361_0_tx_data_out_p 1 39 1 N
preplace netloc vita49_clk_tsf_0 1 20 16 8910 4030 NJ 4030 9430 4030 NJ 4110 10550 4110 NJ 4280 NJ 4280 NJ 3930 NJ 3930 NJ 3940 NJ 3940 NJ 3940 NJ 3940 14100 3940 NJ 4020 NJ
preplace netloc util_adc_pack_1_dsync 1 3 1 1230
preplace netloc vita49_clk_tsf_1 1 6 20 2220 4660 NJ 4660 3020 4660 NJ 4670 NJ 4590 NJ 4590 NJ 4590 NJ 4590 NJ 4400 NJ 4400 NJ 4400 NJ 4400 NJ 4450 NJ 4450 NJ 4450 NJ 4450 NJ 4450 9810 4150 10610 4150 NJ
preplace netloc drp_bridge_0_drp2_en 1 37 3 15880 2940 NJ 2940 16970
preplace netloc spi_csn_2_o 1 16 24 6670 3800 NJ 3800 NJ 3800 NJ 3620 NJ 3620 NJ 3620 NJ 3620 NJ 3620 NJ 3620 NJ 3620 NJ 3830 NJ 3830 NJ 3830 NJ 3830 NJ 3830 NJ 3830 NJ 3830 NJ 3830 NJ 3700 NJ 4090 NJ 4090 NJ 4100 NJ 4050 NJ
preplace netloc axi_ad9361_1_tx_data_out_n 1 39 1 N
preplace netloc axi_cpu_interconnect_m03_axi 1 17 1 7550
preplace netloc sys_reg_0_gt_rxdfelpmreset_in 1 24 15 10610 5210 NJ 5210 NJ 5210 NJ 5210 NJ 5210 NJ 5210 NJ 5210 NJ 5210 NJ 5210 NJ 5210 NJ 5210 NJ 5210 NJ 5210 NJ 5210 NJ
preplace netloc axi_ad9361_0_adc_enable_0 1 16 24 6960 1050 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ 1000 17080
preplace netloc axi_ad9361_1_tx_data_out_p 1 39 1 N
preplace netloc axi_ad9361_0_adc_enable_1 1 16 24 6940 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1180 NJ 1190 17120
preplace netloc axi_ad9361_0_adc_enable_2 1 16 24 6970 1190 NJ 1190 NJ 1190 NJ 1190 NJ 1190 NJ 1190 NJ 1190 NJ 1190 NJ 1190 NJ 1190 NJ 1190 NJ 1190 NJ 1190 NJ 1190 NJ 1190 NJ 1190 NJ 1190 NJ 1190 NJ 1190 NJ 1190 NJ 1190 NJ 1190 NJ 1200 17100
preplace netloc axis_dac_interconnect_0_M00_AXIS 1 38 1 16320
preplace netloc axi_ad9361_0_adc_enable_3 1 16 24 6980 1230 NJ 1230 NJ 1230 NJ 1230 NJ 1230 NJ 1230 NJ 1230 NJ 1230 NJ 1230 NJ 1230 NJ 1230 NJ 1230 NJ 1230 NJ 1230 NJ 1230 NJ 1230 NJ 1230 NJ 1230 NJ 1230 NJ 1230 NJ 1230 NJ 1230 NJ 1230 17090
preplace netloc axi_ad9361_1_rx_frame_in_n 1 0 39 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 NJ 1390 16440
preplace netloc axi_cpu_interconnect_M20_AXI 1 8 10 3030 3270 NJ 3270 NJ 3270 NJ 3270 NJ 3270 NJ 3270 NJ 3260 NJ 3260 NJ 3460 7420
preplace netloc axi_cpu_interconnect_M19_AXI 1 17 11 NJ 2830 NJ 2830 NJ 2830 NJ 2830 NJ 2830 NJ 2830 NJ 2830 NJ 2830 NJ 2830 NJ 2830 11890
preplace netloc sys_aux_reset 1 0 17 170 3500 NJ 3500 NJ 3500 NJ 3500 NJ 3500 NJ 3500 NJ 3500 NJ 3500 NJ 3500 NJ 3500 NJ 3500 NJ 3500 NJ 3500 NJ 3500 NJ 3310 NJ 3310 6660
preplace netloc axi_ad9361_1_rx_frame_in_p 1 0 39 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 16450
preplace netloc sys_ps7_interrupt 1 15 1 6000
preplace netloc drprdy_slice_1_Dout 1 39 1 17120
preplace netloc axi_dma_0_s2mm_introut 1 14 15 5490 3960 NJ 4250 NJ 4250 NJ 4250 NJ 4250 NJ 4250 NJ 4250 NJ 4250 NJ 4250 NJ 3750 NJ 3750 NJ 3750 NJ 3760 NJ 3760 12280
preplace netloc drprdy_slice_0_Dout 1 39 1 17140
levelinfo -pg 1 150 390 730 1110 1420 1740 2050 2450 2840 3190 3580 3950 4280 4610 4980 5660 6390 7250 7910 8310 8720 9050 9310 9640 10380 10940 11320 11730 12120 12610 13060 13330 13570 13900 14330 14800 15300 15640 16070 16750 17250 -top 0 -bot 5760
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



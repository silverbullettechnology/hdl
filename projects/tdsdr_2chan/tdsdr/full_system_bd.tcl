
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
set scripts_vivado_version 2014.2
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


# CHANGE DESIGN NAME HERE
set design_name system

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}


# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} ne "" && ${cur_design} eq ${design_name} } {

   # Checks if design is empty or not
   if { $list_cells ne "" } {
      set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
      set nRet 1
   } else {
      puts "INFO: Constructing design in IPI design <$design_name>..."
   }
} elseif { ${cur_design} ne "" && ${cur_design} ne ${design_name} } {

   if { $list_cells eq "" } {
      puts "INFO: You have an empty design <${cur_design}>. Will go ahead and create design..."
   } else {
      set errMsg "ERROR: Design <${cur_design}> is not empty! Please do not source this script on non-empty designs."
      set nRet 1
   }
} else {

   if { [get_files -quiet ${design_name}.bd] eq "" } {
      puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

      create_bd_design $design_name

      puts "INFO: Making design <$design_name> as current_bd_design."
      current_bd_design $design_name

   } else {
      set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
      set nRet 3
   }

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
  set GPIO_I [ create_bd_port -dir I -from 54 -to 0 GPIO_I ]
  set GPIO_O [ create_bd_port -dir O -from 54 -to 0 GPIO_O ]
  set GPIO_T [ create_bd_port -dir O -from 54 -to 0 GPIO_T ]
  set axi_gpio [ create_bd_port -dir I -from 15 -to 0 axi_gpio ]
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
  set spi0_csn_i [ create_bd_port -dir I spi0_csn_i ]
  set spi0_miso_i [ create_bd_port -dir I spi0_miso_i ]
  set spi0_mosi_i [ create_bd_port -dir I spi0_mosi_i ]
  set spi0_mosi_o [ create_bd_port -dir O spi0_mosi_o ]
  set spi0_sclk_i [ create_bd_port -dir I spi0_sclk_i ]
  set spi0_sclk_o [ create_bd_port -dir O spi0_sclk_o ]
  set spi1_csn_i [ create_bd_port -dir I spi1_csn_i ]
  set spi1_miso_i [ create_bd_port -dir I spi1_miso_i ]
  set spi1_mosi_i [ create_bd_port -dir I spi1_mosi_i ]
  set spi1_mosi_o [ create_bd_port -dir O spi1_mosi_o ]
  set spi1_sclk_i [ create_bd_port -dir I spi1_sclk_i ]
  set spi1_sclk_o [ create_bd_port -dir O spi1_sclk_o ]
  set srio_rxn0 [ create_bd_port -dir I srio_rxn0 ]
  set srio_rxn1 [ create_bd_port -dir I srio_rxn1 ]
  set srio_rxn2 [ create_bd_port -dir I srio_rxn2 ]
  set srio_rxn3 [ create_bd_port -dir I srio_rxn3 ]
  set srio_rxp0 [ create_bd_port -dir I srio_rxp0 ]
  set srio_rxp1 [ create_bd_port -dir I srio_rxp1 ]
  set srio_rxp2 [ create_bd_port -dir I srio_rxp2 ]
  set srio_rxp3 [ create_bd_port -dir I srio_rxp3 ]
  set srio_sys_clkn [ create_bd_port -dir I srio_sys_clkn ]
  set srio_sys_clkp [ create_bd_port -dir I srio_sys_clkp ]
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

  # Create instance: axi_ad9361_0, and set properties
  set axi_ad9361_0 [ create_bd_cell -type ip -vlnv analog.com:user:axi_ad9361:1.0 axi_ad9361_0 ]
  set_property -dict [ list CONFIG.PCORE_ID {0} CONFIG.PCORE_IODELAY_GROUP {dev_0_if_delay_group}  ] $axi_ad9361_0

  # Create instance: axi_ad9361_0_adc_dma, and set properties
  set axi_ad9361_0_adc_dma [ create_bd_cell -type ip -vlnv analog.com:user:axi_dmac:1.0 axi_ad9361_0_adc_dma ]
  set_property -dict [ list CONFIG.C_2D_TRANSFER {0} CONFIG.C_AXI_SLICE_DEST {0} CONFIG.C_AXI_SLICE_SRC {0} CONFIG.C_CLKS_ASYNC_DEST_REQ {1} CONFIG.C_CLKS_ASYNC_REQ_SRC {1} CONFIG.C_CLKS_ASYNC_SRC_DEST {1} CONFIG.C_CYCLIC {0} CONFIG.C_DMA_DATA_WIDTH_SRC {128} CONFIG.C_DMA_TYPE_DEST {0} CONFIG.C_DMA_TYPE_SRC {2} CONFIG.C_SYNC_TRANSFER_START {1}  ] $axi_ad9361_0_adc_dma

  # Create instance: axi_ad9361_0_adc_dma_interconnect, and set properties
  set axi_ad9361_0_adc_dma_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_ad9361_0_adc_dma_interconnect ]
  set_property -dict [ list CONFIG.NUM_MI {1}  ] $axi_ad9361_0_adc_dma_interconnect

  # Create instance: axi_ad9361_0_dac_dma, and set properties
  set axi_ad9361_0_dac_dma [ create_bd_cell -type ip -vlnv analog.com:user:axi_dmac:1.0 axi_ad9361_0_dac_dma ]
  set_property -dict [ list CONFIG.C_2D_TRANSFER {0} CONFIG.C_AXI_SLICE_DEST {1} CONFIG.C_AXI_SLICE_SRC {0} CONFIG.C_CLKS_ASYNC_DEST_REQ {1} CONFIG.C_CLKS_ASYNC_REQ_SRC {1} CONFIG.C_CLKS_ASYNC_SRC_DEST {1} CONFIG.C_CYCLIC {0} CONFIG.C_DMA_DATA_WIDTH_DEST {128} CONFIG.C_DMA_TYPE_DEST {2} CONFIG.C_DMA_TYPE_SRC {0} CONFIG.C_SYNC_TRANSFER_START {0}  ] $axi_ad9361_0_dac_dma

  # Create instance: axi_ad9361_0_dac_dma_interconnect, and set properties
  set axi_ad9361_0_dac_dma_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_ad9361_0_dac_dma_interconnect ]
  set_property -dict [ list CONFIG.NUM_MI {1}  ] $axi_ad9361_0_dac_dma_interconnect

  # Create instance: axi_ad9361_1, and set properties
  set axi_ad9361_1 [ create_bd_cell -type ip -vlnv analog.com:user:axi_ad9361:1.0 axi_ad9361_1 ]
  set_property -dict [ list CONFIG.PCORE_ID {0} CONFIG.PCORE_IODELAY_GROUP {dev_1_if_delay_group}  ] $axi_ad9361_1

  # Create instance: axi_ad9361_1_adc_dma, and set properties
  set axi_ad9361_1_adc_dma [ create_bd_cell -type ip -vlnv analog.com:user:axi_dmac:1.0 axi_ad9361_1_adc_dma ]
  set_property -dict [ list CONFIG.C_2D_TRANSFER {0} CONFIG.C_AXI_SLICE_DEST {0} CONFIG.C_AXI_SLICE_SRC {0} CONFIG.C_CLKS_ASYNC_DEST_REQ {1} CONFIG.C_CLKS_ASYNC_REQ_SRC {1} CONFIG.C_CLKS_ASYNC_SRC_DEST {1} CONFIG.C_CYCLIC {0} CONFIG.C_DMA_DATA_WIDTH_SRC {128} CONFIG.C_DMA_TYPE_DEST {0} CONFIG.C_DMA_TYPE_SRC {2} CONFIG.C_SYNC_TRANSFER_START {1}  ] $axi_ad9361_1_adc_dma

  # Create instance: axi_ad9361_1_adc_dma_interconnect, and set properties
  set axi_ad9361_1_adc_dma_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_ad9361_1_adc_dma_interconnect ]
  set_property -dict [ list CONFIG.NUM_MI {1}  ] $axi_ad9361_1_adc_dma_interconnect

  # Create instance: axi_ad9361_1_dac_dma, and set properties
  set axi_ad9361_1_dac_dma [ create_bd_cell -type ip -vlnv analog.com:user:axi_dmac:1.0 axi_ad9361_1_dac_dma ]
  set_property -dict [ list CONFIG.C_2D_TRANSFER {0} CONFIG.C_AXI_SLICE_DEST {1} CONFIG.C_AXI_SLICE_SRC {0} CONFIG.C_CLKS_ASYNC_DEST_REQ {1} CONFIG.C_CLKS_ASYNC_REQ_SRC {1} CONFIG.C_CLKS_ASYNC_SRC_DEST {1} CONFIG.C_CYCLIC {0} CONFIG.C_DMA_DATA_WIDTH_DEST {128} CONFIG.C_DMA_TYPE_DEST {2} CONFIG.C_DMA_TYPE_SRC {0} CONFIG.C_SYNC_TRANSFER_START {0}  ] $axi_ad9361_1_dac_dma

  # Create instance: axi_ad9361_1_dac_dma_interconnect, and set properties
  set axi_ad9361_1_dac_dma_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_ad9361_1_dac_dma_interconnect ]
  set_property -dict [ list CONFIG.NUM_MI {1}  ] $axi_ad9361_1_dac_dma_interconnect

  # Create instance: axi_cpu_interconnect, and set properties
  set axi_cpu_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_cpu_interconnect ]
  set_property -dict [ list CONFIG.NUM_MI {10}  ] $axi_cpu_interconnect

  # Create instance: axi_gpio, and set properties
  set axi_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio ]
  set_property -dict [ list CONFIG.C_ALL_INPUTS {1} CONFIG.C_GPIO_WIDTH {16} CONFIG.C_INTERRUPT_PRESENT {1}  ] $axi_gpio

  # Create instance: axi_srio_initiator_fifo, and set properties
  set axi_srio_initiator_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_fifo_mm_s:4.0 axi_srio_initiator_fifo ]
  set_property -dict [ list CONFIG.C_DATA_INTERFACE_TYPE {1} CONFIG.C_HAS_AXIS_TDEST {true} CONFIG.C_USE_RX_CUT_THROUGH {true} CONFIG.C_USE_TX_CTRL {0} CONFIG.C_USE_TX_CUT_THROUGH {1}  ] $axi_srio_initiator_fifo

  # Create instance: axi_srio_initiator_shadowfifo, and set properties
  set axi_srio_initiator_shadowfifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_fifo_mm_s:4.0 axi_srio_initiator_shadowfifo ]
  set_property -dict [ list CONFIG.C_DATA_INTERFACE_TYPE {1} CONFIG.C_HAS_AXIS_TDEST {true} CONFIG.C_USE_TX_DATA {0}  ] $axi_srio_initiator_shadowfifo

  # Create instance: axi_srio_interconnect, and set properties
  set axi_srio_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_srio_interconnect ]
  set_property -dict [ list CONFIG.M00_HAS_REGSLICE {4} CONFIG.M01_HAS_REGSLICE {4} CONFIG.M02_HAS_REGSLICE {4} CONFIG.M03_HAS_REGSLICE {4} CONFIG.M04_HAS_REGSLICE {4} CONFIG.NUM_MI {7} CONFIG.S00_HAS_REGSLICE {4}  ] $axi_srio_interconnect

  # Create instance: axi_srio_target_fifo, and set properties
  set axi_srio_target_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_fifo_mm_s:4.0 axi_srio_target_fifo ]
  set_property -dict [ list CONFIG.C_DATA_INTERFACE_TYPE {1} CONFIG.C_HAS_AXIS_TDEST {true} CONFIG.C_USE_RX_CUT_THROUGH {true} CONFIG.C_USE_TX_CTRL {0} CONFIG.C_USE_TX_CUT_THROUGH {1}  ] $axi_srio_target_fifo

  # Create instance: axis_32to64_srio_init, and set properties
  set axis_32to64_srio_init [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_32to64_strb_tuser:1.0 axis_32to64_srio_init ]

  # Create instance: axis_32to64_srio_target, and set properties
  set axis_32to64_srio_target [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_32to64_strb_tuser:1.0 axis_32to64_srio_target ]

  # Create instance: axis_64to32_srio_init, and set properties
  set axis_64to32_srio_init [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_64to32_strb_tuser:1.0 axis_64to32_srio_init ]

  # Create instance: axis_64to32_srio_target, and set properties
  set axis_64to32_srio_target [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:axis_64to32_strb_tuser:1.0 axis_64to32_srio_target ]

  # Create instance: axis_broadcaster_0, and set properties
  set axis_broadcaster_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0 ]

  # Create instance: const_1, and set properties
  set const_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_1 ]
  set_property -dict [ list CONFIG.CONST_VAL {255} CONFIG.CONST_WIDTH {8}  ] $const_1

  # Create instance: constant_0, and set properties
  set constant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 constant_0 ]
  set_property -dict [ list CONFIG.CONST_VAL {0}  ] $constant_0

  # Create instance: ila_0, and set properties
  set ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:4.0 ila_0 ]
  set_property -dict [ list CONFIG.C_MONITOR_TYPE {Native} CONFIG.C_NUM_OF_PROBES {5} CONFIG.C_PROBE0_WIDTH {128}  ] $ila_0

  # Create instance: ila_adc, and set properties
  set ila_adc [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:4.0 ila_adc ]
  set_property -dict [ list CONFIG.C_EN_STRG_QUAL {1} CONFIG.C_MONITOR_TYPE {Native} CONFIG.C_NUM_OF_PROBES {5} CONFIG.C_PROBE0_WIDTH {1} CONFIG.C_PROBE1_WIDTH {16} CONFIG.C_PROBE2_WIDTH {16} CONFIG.C_PROBE3_WIDTH {16} CONFIG.C_PROBE4_WIDTH {16} CONFIG.C_TRIGIN_EN {false}  ] $ila_adc

  # Create instance: ila_dac, and set properties
  set ila_dac [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:4.0 ila_dac ]
  set_property -dict [ list CONFIG.C_EN_STRG_QUAL {1} CONFIG.C_MONITOR_TYPE {Native} CONFIG.C_NUM_OF_PROBES {5} CONFIG.C_PROBE0_WIDTH {1} CONFIG.C_PROBE1_WIDTH {16} CONFIG.C_PROBE2_WIDTH {16} CONFIG.C_PROBE3_WIDTH {16} CONFIG.C_PROBE4_WIDTH {16} CONFIG.C_TRIGIN_EN {false}  ] $ila_dac

  # Create instance: srio_gen2_0, and set properties
  set srio_gen2_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:srio_gen2:3.1 srio_gen2_0 ]
  set_property -dict [ list CONFIG.assembly_identifier {7045} CONFIG.assembly_revision_level {0001} CONFIG.assembly_vendor_identifier {4242} CONFIG.c_transceivercontrol {1} CONFIG.device_id {02} CONFIG.extended_features_enable_user {true} CONFIG.idle2_support {true} CONFIG.link_width {4} CONFIG.mode_selection {Advanced} CONFIG.silicon_rev {Production} CONFIG.software_assisted_error_recovery {true} CONFIG.unified_clk {true}  ] $srio_gen2_0

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

  # Create instance: sys_concat_intc, and set properties
  set sys_concat_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 sys_concat_intc ]
  set_property -dict [ list CONFIG.NUM_PORTS {8}  ] $sys_concat_intc

  # Create instance: sys_ps7, and set properties
  set sys_ps7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.4 sys_ps7 ]
  set_property -dict [ list CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {600} CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ {40} CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} CONFIG.PCW_ENET1_PERIPHERAL_ENABLE {0} CONFIG.PCW_EN_CLK1_PORT {1} CONFIG.PCW_EN_CLK2_PORT {1} CONFIG.PCW_EN_RST1_PORT {1} CONFIG.PCW_EN_RST2_PORT {1} CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100.0} CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {200.0} CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {250} CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {1} CONFIG.PCW_GPIO_EMIO_GPIO_IO {55} CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} CONFIG.PCW_IRQ_F2P_INTR {1} CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 1.8V} CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {1} CONFIG.PCW_QSPI_GRP_IO1_ENABLE {0} CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} CONFIG.PCW_QSPI_GRP_SS1_ENABLE {0} CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} CONFIG.PCW_SD0_GRP_CD_ENABLE {1} CONFIG.PCW_SD0_GRP_CD_IO {MIO 0} CONFIG.PCW_SD0_GRP_WP_ENABLE {0} CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} CONFIG.PCW_SD1_PERIPHERAL_ENABLE {1} CONFIG.PCW_SD1_SD1_IO {MIO 10 .. 15} CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {1} CONFIG.PCW_SPI1_PERIPHERAL_ENABLE {1} CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} CONFIG.PCW_UART0_PERIPHERAL_ENABLE {1} CONFIG.PCW_UART0_UART0_IO {MIO 46 .. 47} CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K256M16 RE-125} CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.PCW_USE_M_AXI_GP1 {1} CONFIG.PCW_USE_S_AXI_HP0 {1} CONFIG.PCW_USE_S_AXI_HP1 {1} CONFIG.PCW_USE_S_AXI_HP2 {1} CONFIG.PCW_USE_S_AXI_HP3 {1} CONFIG.PCW_WDT_PERIPHERAL_ENABLE {1}  ] $sys_ps7

  # Create instance: sys_reg_0, and set properties
  set sys_reg_0 [ create_bd_cell -type ip -vlnv Silver-Bullet-Tech:user:sys_reg:1.0 sys_reg_0 ]

  # Create instance: sys_rstgen, and set properties
  set sys_rstgen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 sys_rstgen ]
  set_property -dict [ list CONFIG.C_EXT_RST_WIDTH {1}  ] $sys_rstgen

  # Create instance: util_adc_pack_0, and set properties
  set util_adc_pack_0 [ create_bd_cell -type ip -vlnv analog.com:user:util_adc_pack:1.0 util_adc_pack_0 ]

  # Create instance: util_adc_pack_1, and set properties
  set util_adc_pack_1 [ create_bd_cell -type ip -vlnv analog.com:user:util_adc_pack:1.0 util_adc_pack_1 ]

  # Create instance: util_dac_unpack_0, and set properties
  set util_dac_unpack_0 [ create_bd_cell -type ip -vlnv analog.com:user:util_dac_unpack:1.0 util_dac_unpack_0 ]

  # Create instance: util_dac_unpack_1, and set properties
  set util_dac_unpack_1 [ create_bd_cell -type ip -vlnv analog.com:user:util_dac_unpack:1.0 util_dac_unpack_1 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_pins srio_gen2_0/INITIATOR_RESP] [get_bd_intf_pins srio_iresp_intc/S00_AXIS]
  connect_bd_intf_net -intf_net S00_AXIS_2 [get_bd_intf_pins srio_gen2_0/TARGET_REQ] [get_bd_intf_pins srio_treq_intc/S00_AXIS]
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins axi_srio_interconnect/S00_AXI] [get_bd_intf_pins sys_ps7/M_AXI_GP1]
  connect_bd_intf_net -intf_net axi_ad9361_0_adc_dma_interconnect_m00_axi [get_bd_intf_pins axi_ad9361_0_adc_dma_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_HP1]
  connect_bd_intf_net -intf_net axi_ad9361_0_adc_dma_interconnect_s00_axi [get_bd_intf_pins axi_ad9361_0_adc_dma/m_dest_axi] [get_bd_intf_pins axi_ad9361_0_adc_dma_interconnect/S00_AXI]
  connect_bd_intf_net -intf_net axi_ad9361_0_dac_dma_interconnect_m00_axi [get_bd_intf_pins axi_ad9361_0_dac_dma_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_HP0]
  connect_bd_intf_net -intf_net axi_ad9361_0_dac_dma_interconnect_s00_axi [get_bd_intf_pins axi_ad9361_0_dac_dma/m_src_axi] [get_bd_intf_pins axi_ad9361_0_dac_dma_interconnect/S00_AXI]
  connect_bd_intf_net -intf_net axi_ad9361_1_adc_dma_interconnect_m00_axi [get_bd_intf_pins axi_ad9361_1_adc_dma_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_HP3]
  connect_bd_intf_net -intf_net axi_ad9361_1_adc_dma_interconnect_s00_axi [get_bd_intf_pins axi_ad9361_1_adc_dma/m_dest_axi] [get_bd_intf_pins axi_ad9361_1_adc_dma_interconnect/S00_AXI]
  connect_bd_intf_net -intf_net axi_ad9361_1_dac_dma_interconnect_m00_axi [get_bd_intf_pins axi_ad9361_1_dac_dma_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_HP2]
  connect_bd_intf_net -intf_net axi_ad9361_1_dac_dma_interconnect_s00_axi [get_bd_intf_pins axi_ad9361_1_dac_dma/m_src_axi] [get_bd_intf_pins axi_ad9361_1_dac_dma_interconnect/S00_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M06_AXI [get_bd_intf_pins axi_cpu_interconnect/M06_AXI] [get_bd_intf_pins sys_reg_0/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_m00_axi [get_bd_intf_pins axi_cpu_interconnect/M00_AXI] [get_bd_intf_pins axi_gpio/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_m01_axi [get_bd_intf_pins axi_ad9361_1/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M01_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_m02_axi [get_bd_intf_pins axi_ad9361_1_adc_dma/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M02_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_m03_axi [get_bd_intf_pins axi_ad9361_1_dac_dma/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M03_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_m07_axi [get_bd_intf_pins axi_ad9361_0/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M07_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_m08_axi [get_bd_intf_pins axi_ad9361_0_adc_dma/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M08_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_m09_axi [get_bd_intf_pins axi_ad9361_0_dac_dma/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M09_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_s00_axi [get_bd_intf_pins axi_cpu_interconnect/S00_AXI] [get_bd_intf_pins sys_ps7/M_AXI_GP0]
  connect_bd_intf_net -intf_net axi_srio_initiator_fifo_AXI_STR_TXD [get_bd_intf_pins axi_srio_initiator_fifo/AXI_STR_TXD] [get_bd_intf_pins axis_broadcaster_0/S_AXIS]
  connect_bd_intf_net -intf_net axi_srio_interconnect_M00_AXI [get_bd_intf_pins axi_srio_initiator_fifo/S_AXI] [get_bd_intf_pins axi_srio_interconnect/M00_AXI]
  connect_bd_intf_net -intf_net axi_srio_interconnect_M01_AXI [get_bd_intf_pins axi_srio_initiator_fifo/S_AXI_FULL] [get_bd_intf_pins axi_srio_interconnect/M01_AXI]
  connect_bd_intf_net -intf_net axi_srio_interconnect_M02_AXI [get_bd_intf_pins axi_srio_interconnect/M02_AXI] [get_bd_intf_pins axi_srio_target_fifo/S_AXI]
  connect_bd_intf_net -intf_net axi_srio_interconnect_M03_AXI [get_bd_intf_pins axi_srio_interconnect/M03_AXI] [get_bd_intf_pins axi_srio_target_fifo/S_AXI_FULL]
  connect_bd_intf_net -intf_net axi_srio_interconnect_M04_AXI [get_bd_intf_pins axi_srio_interconnect/M04_AXI] [get_bd_intf_pins srio_gen2_0/MAINT_IF]
  connect_bd_intf_net -intf_net axi_srio_interconnect_M05_AXI [get_bd_intf_pins axi_srio_initiator_shadowfifo/S_AXI] [get_bd_intf_pins axi_srio_interconnect/M05_AXI]
  connect_bd_intf_net -intf_net axi_srio_interconnect_M06_AXI [get_bd_intf_pins axi_srio_initiator_shadowfifo/S_AXI_FULL] [get_bd_intf_pins axi_srio_interconnect/M06_AXI]
  connect_bd_intf_net -intf_net axi_srio_target_fifo_AXI_STR_TXD [get_bd_intf_pins axi_srio_target_fifo/AXI_STR_TXD] [get_bd_intf_pins axis_32to64_srio_target/S_AXIS]
  connect_bd_intf_net -intf_net axis_32to64_srio_init_M_AXIS [get_bd_intf_pins axis_32to64_srio_init/M_AXIS] [get_bd_intf_pins srio_ireq_intc/S00_AXIS]
  connect_bd_intf_net -intf_net axis_32to64_srio_target_M_AXIS [get_bd_intf_pins axis_32to64_srio_target/M_AXIS] [get_bd_intf_pins srio_tresp_intc/S00_AXIS]
  connect_bd_intf_net -intf_net axis_64to32_srio_init_M_AXIS [get_bd_intf_pins axi_srio_initiator_fifo/AXI_STR_RXD] [get_bd_intf_pins axis_64to32_srio_init/M_AXIS]
  connect_bd_intf_net -intf_net axis_64to32_srio_target_M_AXIS [get_bd_intf_pins axi_srio_target_fifo/AXI_STR_RXD] [get_bd_intf_pins axis_64to32_srio_target/M_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M00_AXIS [get_bd_intf_pins axis_32to64_srio_init/S_AXIS] [get_bd_intf_pins axis_broadcaster_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M01_AXIS [get_bd_intf_pins axi_srio_initiator_shadowfifo/AXI_STR_RXD] [get_bd_intf_pins axis_broadcaster_0/M01_AXIS]
  connect_bd_intf_net -intf_net srio_ireq_intc_M00_AXIS [get_bd_intf_pins srio_gen2_0/INITIATOR_REQ] [get_bd_intf_pins srio_ireq_intc/M00_AXIS]
  connect_bd_intf_net -intf_net srio_iresp_intc_M00_AXIS [get_bd_intf_pins axis_64to32_srio_init/S_AXIS] [get_bd_intf_pins srio_iresp_intc/M00_AXIS]
  connect_bd_intf_net -intf_net srio_treq_intc_M00_AXIS [get_bd_intf_pins axis_64to32_srio_target/S_AXIS] [get_bd_intf_pins srio_treq_intc/M00_AXIS]
  connect_bd_intf_net -intf_net srio_tresp_intc_M00_AXIS [get_bd_intf_pins srio_gen2_0/TARGET_RESP] [get_bd_intf_pins srio_tresp_intc/M00_AXIS]
  connect_bd_intf_net -intf_net sys_ps7_ddr [get_bd_intf_ports DDR] [get_bd_intf_pins sys_ps7/DDR]
  connect_bd_intf_net -intf_net sys_ps7_fixed_io [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins sys_ps7/FIXED_IO]

  # Create port connections
  connect_bd_net -net M04_ACLK_1 [get_bd_pins axi_srio_interconnect/M04_ACLK] [get_bd_pins srio_gen2_0/log_clk_out] [get_bd_pins srio_ireq_intc/M00_AXIS_ACLK] [get_bd_pins srio_iresp_intc/S00_AXIS_ACLK] [get_bd_pins srio_treq_intc/S00_AXIS_ACLK] [get_bd_pins srio_tresp_intc/M00_AXIS_ACLK]
  connect_bd_net -net axi_ad9361_0_adc_chan_i1 [get_bd_pins axi_ad9361_0/adc_data_i0] [get_bd_pins ila_adc/probe1] [get_bd_pins util_adc_pack_0/chan_data_0]
  connect_bd_net -net axi_ad9361_0_adc_chan_i2 [get_bd_pins axi_ad9361_0/adc_data_i1] [get_bd_pins ila_adc/probe3] [get_bd_pins util_adc_pack_0/chan_data_2]
  connect_bd_net -net axi_ad9361_0_adc_chan_q1 [get_bd_pins axi_ad9361_0/adc_data_q0] [get_bd_pins ila_adc/probe2] [get_bd_pins util_adc_pack_0/chan_data_1]
  connect_bd_net -net axi_ad9361_0_adc_chan_q2 [get_bd_pins axi_ad9361_0/adc_data_q1] [get_bd_pins ila_adc/probe4] [get_bd_pins util_adc_pack_0/chan_data_3]
  connect_bd_net -net axi_ad9361_0_adc_dma_irq [get_bd_pins axi_ad9361_0_adc_dma/irq] [get_bd_pins sys_concat_intc/In0]
  connect_bd_net -net axi_ad9361_0_adc_dovf [get_bd_pins axi_ad9361_0/adc_dovf] [get_bd_pins axi_ad9361_0_adc_dma/fifo_wr_overflow]
  connect_bd_net -net axi_ad9361_0_adc_enable_0 [get_bd_pins axi_ad9361_0/adc_enable_i0] [get_bd_pins util_adc_pack_0/chan_enable_0]
  connect_bd_net -net axi_ad9361_0_adc_enable_1 [get_bd_pins axi_ad9361_0/adc_enable_q0] [get_bd_pins util_adc_pack_0/chan_enable_1]
  connect_bd_net -net axi_ad9361_0_adc_enable_2 [get_bd_pins axi_ad9361_0/adc_enable_i1] [get_bd_pins util_adc_pack_0/chan_enable_2]
  connect_bd_net -net axi_ad9361_0_adc_enable_3 [get_bd_pins axi_ad9361_0/adc_enable_q1] [get_bd_pins util_adc_pack_0/chan_enable_3]
  connect_bd_net -net axi_ad9361_0_adc_valid_0 [get_bd_pins axi_ad9361_0/adc_valid_i0] [get_bd_pins ila_adc/probe0] [get_bd_pins util_adc_pack_0/chan_valid_0]
  connect_bd_net -net axi_ad9361_0_adc_valid_1 [get_bd_pins axi_ad9361_0/adc_valid_q0] [get_bd_pins util_adc_pack_0/chan_valid_1]
  connect_bd_net -net axi_ad9361_0_adc_valid_2 [get_bd_pins axi_ad9361_0/adc_valid_i1] [get_bd_pins util_adc_pack_0/chan_valid_2]
  connect_bd_net -net axi_ad9361_0_adc_valid_3 [get_bd_pins axi_ad9361_0/adc_valid_q1] [get_bd_pins util_adc_pack_0/chan_valid_3]
  connect_bd_net -net axi_ad9361_0_clk [get_bd_pins axi_ad9361_0/clk] [get_bd_pins axi_ad9361_0/l_clk] [get_bd_pins axi_ad9361_0_adc_dma/fifo_wr_clk] [get_bd_pins axi_ad9361_0_dac_dma/fifo_rd_clk] [get_bd_pins ila_0/clk] [get_bd_pins ila_adc/clk] [get_bd_pins ila_dac/clk] [get_bd_pins util_adc_pack_0/clk] [get_bd_pins util_dac_unpack_0/clk]
  connect_bd_net -net axi_ad9361_0_dac_data_0 [get_bd_pins axi_ad9361_0/dac_data_i0] [get_bd_pins ila_dac/probe1] [get_bd_pins util_dac_unpack_0/dac_data_00]
  connect_bd_net -net axi_ad9361_0_dac_data_1 [get_bd_pins axi_ad9361_0/dac_data_q0] [get_bd_pins ila_dac/probe2] [get_bd_pins util_dac_unpack_0/dac_data_01]
  connect_bd_net -net axi_ad9361_0_dac_data_2 [get_bd_pins axi_ad9361_0/dac_data_i1] [get_bd_pins ila_dac/probe3] [get_bd_pins util_dac_unpack_0/dac_data_02]
  connect_bd_net -net axi_ad9361_0_dac_data_3 [get_bd_pins axi_ad9361_0/dac_data_q1] [get_bd_pins ila_dac/probe4] [get_bd_pins util_dac_unpack_0/dac_data_03]
  connect_bd_net -net axi_ad9361_0_dac_dma_irq [get_bd_pins axi_ad9361_0_dac_dma/irq] [get_bd_pins ila_0/probe1] [get_bd_pins sys_concat_intc/In1]
  connect_bd_net -net axi_ad9361_0_dac_drd [get_bd_pins axi_ad9361_0_dac_dma/fifo_rd_en] [get_bd_pins ila_0/probe4] [get_bd_pins ila_dac/probe0] [get_bd_pins util_dac_unpack_0/dma_rd]
  connect_bd_net -net axi_ad9361_0_dac_dunf [get_bd_pins axi_ad9361_0/dac_dunf] [get_bd_pins axi_ad9361_0_dac_dma/fifo_rd_underflow] [get_bd_pins ila_0/probe3]
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
  connect_bd_net -net axi_ad9361_1_adc_dma_irq [get_bd_pins axi_ad9361_1_adc_dma/irq] [get_bd_pins sys_concat_intc/In2]
  connect_bd_net -net axi_ad9361_1_adc_dovf [get_bd_pins axi_ad9361_1/adc_dovf] [get_bd_pins axi_ad9361_1_adc_dma/fifo_wr_overflow]
  connect_bd_net -net axi_ad9361_1_adc_enable_0 [get_bd_pins axi_ad9361_1/adc_enable_i0] [get_bd_pins util_adc_pack_1/chan_enable_0]
  connect_bd_net -net axi_ad9361_1_adc_enable_1 [get_bd_pins axi_ad9361_1/adc_enable_q0] [get_bd_pins util_adc_pack_1/chan_enable_1]
  connect_bd_net -net axi_ad9361_1_adc_enable_2 [get_bd_pins axi_ad9361_1/adc_enable_i1] [get_bd_pins util_adc_pack_1/chan_enable_2]
  connect_bd_net -net axi_ad9361_1_adc_enable_3 [get_bd_pins axi_ad9361_1/adc_enable_q1] [get_bd_pins util_adc_pack_1/chan_enable_3]
  connect_bd_net -net axi_ad9361_1_adc_valid_0 [get_bd_pins axi_ad9361_1/adc_valid_i0] [get_bd_pins util_adc_pack_1/chan_valid_0]
  connect_bd_net -net axi_ad9361_1_adc_valid_1 [get_bd_pins axi_ad9361_1/adc_valid_q0] [get_bd_pins util_adc_pack_1/chan_valid_1]
  connect_bd_net -net axi_ad9361_1_adc_valid_2 [get_bd_pins axi_ad9361_1/adc_valid_i1] [get_bd_pins util_adc_pack_1/chan_valid_2]
  connect_bd_net -net axi_ad9361_1_adc_valid_3 [get_bd_pins axi_ad9361_1/adc_valid_q1] [get_bd_pins util_adc_pack_1/chan_valid_3]
  connect_bd_net -net axi_ad9361_1_clk [get_bd_pins axi_ad9361_1/clk] [get_bd_pins axi_ad9361_1/l_clk] [get_bd_pins axi_ad9361_1_adc_dma/fifo_wr_clk] [get_bd_pins axi_ad9361_1_dac_dma/fifo_rd_clk] [get_bd_pins util_adc_pack_1/clk] [get_bd_pins util_dac_unpack_1/clk]
  connect_bd_net -net axi_ad9361_1_dac_data_0 [get_bd_pins axi_ad9361_1/dac_data_i0] [get_bd_pins util_dac_unpack_1/dac_data_00]
  connect_bd_net -net axi_ad9361_1_dac_data_1 [get_bd_pins axi_ad9361_1/dac_data_q0] [get_bd_pins util_dac_unpack_1/dac_data_01]
  connect_bd_net -net axi_ad9361_1_dac_data_2 [get_bd_pins axi_ad9361_1/dac_data_i1] [get_bd_pins util_dac_unpack_1/dac_data_02]
  connect_bd_net -net axi_ad9361_1_dac_data_3 [get_bd_pins axi_ad9361_1/dac_data_q1] [get_bd_pins util_dac_unpack_1/dac_data_03]
  connect_bd_net -net axi_ad9361_1_dac_dma_irq [get_bd_pins axi_ad9361_1_dac_dma/irq] [get_bd_pins sys_concat_intc/In3]
  connect_bd_net -net axi_ad9361_1_dac_drd [get_bd_pins axi_ad9361_1_dac_dma/fifo_rd_en] [get_bd_pins util_dac_unpack_1/dma_rd]
  connect_bd_net -net axi_ad9361_1_dac_dunf [get_bd_pins axi_ad9361_1/dac_dunf] [get_bd_pins axi_ad9361_1_dac_dma/fifo_rd_underflow]
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
  connect_bd_net -net axi_gpio_1 [get_bd_ports axi_gpio] [get_bd_pins axi_gpio/gpio_io_i]
  connect_bd_net -net axi_gpio_irq [get_bd_pins axi_gpio/ip2intc_irpt] [get_bd_pins sys_concat_intc/In4]
  connect_bd_net -net axi_srio_initiator_fifo_interrupt [get_bd_pins axi_srio_initiator_fifo/interrupt] [get_bd_pins sys_concat_intc/In5]
  connect_bd_net -net axi_srio_initiator_shadowfifo_interrupt [get_bd_pins axi_srio_initiator_shadowfifo/interrupt] [get_bd_pins sys_concat_intc/In7]
  connect_bd_net -net axi_srio_target_fifo_interrupt [get_bd_pins axi_srio_target_fifo/interrupt] [get_bd_pins sys_concat_intc/In6]
  connect_bd_net -net const_1_dout [get_bd_pins axis_64to32_srio_init/S_AXIS_TSTRB] [get_bd_pins axis_64to32_srio_target/S_AXIS_TSTRB] [get_bd_pins const_1/dout]
  connect_bd_net -net fifo_data_0 [get_bd_pins axi_ad9361_0_dac_dma/fifo_rd_dout] [get_bd_pins ila_0/probe0] [get_bd_pins util_dac_unpack_0/dma_data]
  connect_bd_net -net fifo_data_1 [get_bd_pins axi_ad9361_1_dac_dma/fifo_rd_dout] [get_bd_pins util_dac_unpack_1/dma_data]
  connect_bd_net -net fifo_valid_0 [get_bd_pins axi_ad9361_0_dac_dma/fifo_rd_valid] [get_bd_pins ila_0/probe2] [get_bd_pins util_dac_unpack_0/fifo_valid]
  connect_bd_net -net fifo_valid_1 [get_bd_pins axi_ad9361_1_dac_dma/fifo_rd_valid] [get_bd_pins util_dac_unpack_1/fifo_valid]
  connect_bd_net -net gnd [get_bd_pins util_adc_pack_0/chan_enable_4] [get_bd_pins util_adc_pack_0/chan_enable_5] [get_bd_pins util_adc_pack_0/chan_enable_6] [get_bd_pins util_adc_pack_0/chan_enable_7] [get_bd_pins util_adc_pack_0/chan_valid_4] [get_bd_pins util_adc_pack_0/chan_valid_5] [get_bd_pins util_adc_pack_0/chan_valid_6] [get_bd_pins util_adc_pack_0/chan_valid_7] [get_bd_pins util_adc_pack_1/chan_enable_4] [get_bd_pins util_adc_pack_1/chan_enable_5] [get_bd_pins util_adc_pack_1/chan_enable_6] [get_bd_pins util_adc_pack_1/chan_enable_7] [get_bd_pins util_adc_pack_1/chan_valid_4] [get_bd_pins util_adc_pack_1/chan_valid_5] [get_bd_pins util_adc_pack_1/chan_valid_6] [get_bd_pins util_adc_pack_1/chan_valid_7] [get_bd_pins util_dac_unpack_0/dac_enable_04] [get_bd_pins util_dac_unpack_0/dac_enable_05] [get_bd_pins util_dac_unpack_0/dac_enable_06] [get_bd_pins util_dac_unpack_0/dac_enable_07] [get_bd_pins util_dac_unpack_0/dac_valid_04] [get_bd_pins util_dac_unpack_0/dac_valid_05] [get_bd_pins util_dac_unpack_0/dac_valid_06] [get_bd_pins util_dac_unpack_0/dac_valid_07] [get_bd_pins util_dac_unpack_1/dac_enable_04] [get_bd_pins util_dac_unpack_1/dac_enable_05] [get_bd_pins util_dac_unpack_1/dac_enable_06] [get_bd_pins util_dac_unpack_1/dac_enable_07] [get_bd_pins util_dac_unpack_1/dac_valid_04] [get_bd_pins util_dac_unpack_1/dac_valid_05] [get_bd_pins util_dac_unpack_1/dac_valid_06] [get_bd_pins util_dac_unpack_1/dac_valid_07]
  connect_bd_net -net spi0_csn_i [get_bd_ports spi0_csn_i] [get_bd_pins sys_ps7/SPI0_SS_I]
  connect_bd_net -net spi0_miso_i [get_bd_ports spi0_miso_i] [get_bd_pins sys_ps7/SPI0_MISO_I]
  connect_bd_net -net spi0_mosi_i [get_bd_ports spi0_mosi_i] [get_bd_pins sys_ps7/SPI0_MOSI_I]
  connect_bd_net -net spi0_mosi_o [get_bd_ports spi0_mosi_o] [get_bd_pins sys_ps7/SPI0_MOSI_O]
  connect_bd_net -net spi0_sclk_i [get_bd_ports spi0_sclk_i] [get_bd_pins sys_ps7/SPI0_SCLK_I]
  connect_bd_net -net spi0_sclk_o [get_bd_ports spi0_sclk_o] [get_bd_pins sys_ps7/SPI0_SCLK_O]
  connect_bd_net -net spi1_csn_i [get_bd_ports spi1_csn_i] [get_bd_pins sys_ps7/SPI1_SS_I]
  connect_bd_net -net spi1_miso_i [get_bd_ports spi1_miso_i] [get_bd_pins sys_ps7/SPI1_MISO_I]
  connect_bd_net -net spi1_mosi_i [get_bd_ports spi1_mosi_i] [get_bd_pins sys_ps7/SPI1_MOSI_I]
  connect_bd_net -net spi1_mosi_o [get_bd_ports spi1_mosi_o] [get_bd_pins sys_ps7/SPI1_MOSI_O]
  connect_bd_net -net spi1_sclk_i [get_bd_ports spi1_sclk_i] [get_bd_pins sys_ps7/SPI1_SCLK_I]
  connect_bd_net -net spi1_sclk_o [get_bd_ports spi1_sclk_o] [get_bd_pins sys_ps7/SPI1_SCLK_O]
  connect_bd_net -net srio_gen2_0_clk_lock_out [get_bd_pins srio_gen2_0/clk_lock_out] [get_bd_pins sys_reg_0/srio_clk_out_lock]
  connect_bd_net -net srio_gen2_0_deviceid [get_bd_pins srio_gen2_0/deviceid] [get_bd_pins sys_reg_0/device_id]
  connect_bd_net -net srio_gen2_0_gtrx_disperr_or [get_bd_pins srio_gen2_0/gtrx_disperr_or] [get_bd_pins sys_reg_0/gtrx_disperr_or]
  connect_bd_net -net srio_gen2_0_gtrx_notintable_or [get_bd_pins srio_gen2_0/gtrx_notintable_or] [get_bd_pins sys_reg_0/gtrx_notintable_or]
  connect_bd_net -net srio_gen2_0_link_initialized [get_bd_pins srio_gen2_0/link_initialized] [get_bd_pins sys_reg_0/srio_link_initialized]
  connect_bd_net -net srio_gen2_0_mode_1x [get_bd_pins srio_gen2_0/mode_1x] [get_bd_pins sys_reg_0/srio_mode_1x]
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
  connect_bd_net -net sys_100m_clk [get_bd_pins axi_ad9361_0/s_axi_aclk] [get_bd_pins axi_ad9361_0_adc_dma/s_axi_aclk] [get_bd_pins axi_ad9361_0_dac_dma/s_axi_aclk] [get_bd_pins axi_ad9361_1/s_axi_aclk] [get_bd_pins axi_ad9361_1_adc_dma/s_axi_aclk] [get_bd_pins axi_ad9361_1_dac_dma/s_axi_aclk] [get_bd_pins axi_cpu_interconnect/ACLK] [get_bd_pins axi_cpu_interconnect/M00_ACLK] [get_bd_pins axi_cpu_interconnect/M01_ACLK] [get_bd_pins axi_cpu_interconnect/M02_ACLK] [get_bd_pins axi_cpu_interconnect/M03_ACLK] [get_bd_pins axi_cpu_interconnect/M04_ACLK] [get_bd_pins axi_cpu_interconnect/M05_ACLK] [get_bd_pins axi_cpu_interconnect/M06_ACLK] [get_bd_pins axi_cpu_interconnect/M07_ACLK] [get_bd_pins axi_cpu_interconnect/M08_ACLK] [get_bd_pins axi_cpu_interconnect/M09_ACLK] [get_bd_pins axi_cpu_interconnect/S00_ACLK] [get_bd_pins axi_gpio/s_axi_aclk] [get_bd_pins axi_srio_interconnect/ACLK] [get_bd_pins axi_srio_interconnect/S00_ACLK] [get_bd_pins sys_ps7/FCLK_CLK0] [get_bd_pins sys_ps7/M_AXI_GP0_ACLK] [get_bd_pins sys_ps7/M_AXI_GP1_ACLK] [get_bd_pins sys_reg_0/S_AXI_ACLK] [get_bd_pins sys_rstgen/slowest_sync_clk]
  connect_bd_net -net sys_100m_resetn [get_bd_pins axi_ad9361_0/s_axi_aresetn] [get_bd_pins axi_ad9361_0_adc_dma/m_dest_axi_aresetn] [get_bd_pins axi_ad9361_0_adc_dma/s_axi_aresetn] [get_bd_pins axi_ad9361_0_adc_dma_interconnect/ARESETN] [get_bd_pins axi_ad9361_0_adc_dma_interconnect/M00_ARESETN] [get_bd_pins axi_ad9361_0_adc_dma_interconnect/S00_ARESETN] [get_bd_pins axi_ad9361_0_dac_dma/m_src_axi_aresetn] [get_bd_pins axi_ad9361_0_dac_dma/s_axi_aresetn] [get_bd_pins axi_ad9361_0_dac_dma_interconnect/ARESETN] [get_bd_pins axi_ad9361_0_dac_dma_interconnect/M00_ARESETN] [get_bd_pins axi_ad9361_0_dac_dma_interconnect/S00_ARESETN] [get_bd_pins axi_ad9361_1/s_axi_aresetn] [get_bd_pins axi_ad9361_1_adc_dma/m_dest_axi_aresetn] [get_bd_pins axi_ad9361_1_adc_dma/s_axi_aresetn] [get_bd_pins axi_ad9361_1_adc_dma_interconnect/ARESETN] [get_bd_pins axi_ad9361_1_adc_dma_interconnect/M00_ARESETN] [get_bd_pins axi_ad9361_1_adc_dma_interconnect/S00_ARESETN] [get_bd_pins axi_ad9361_1_dac_dma/m_src_axi_aresetn] [get_bd_pins axi_ad9361_1_dac_dma/s_axi_aresetn] [get_bd_pins axi_ad9361_1_dac_dma_interconnect/ARESETN] [get_bd_pins axi_ad9361_1_dac_dma_interconnect/M00_ARESETN] [get_bd_pins axi_ad9361_1_dac_dma_interconnect/S00_ARESETN] [get_bd_pins axi_cpu_interconnect/ARESETN] [get_bd_pins axi_cpu_interconnect/M00_ARESETN] [get_bd_pins axi_cpu_interconnect/M01_ARESETN] [get_bd_pins axi_cpu_interconnect/M02_ARESETN] [get_bd_pins axi_cpu_interconnect/M03_ARESETN] [get_bd_pins axi_cpu_interconnect/M04_ARESETN] [get_bd_pins axi_cpu_interconnect/M05_ARESETN] [get_bd_pins axi_cpu_interconnect/M06_ARESETN] [get_bd_pins axi_cpu_interconnect/M07_ARESETN] [get_bd_pins axi_cpu_interconnect/M08_ARESETN] [get_bd_pins axi_cpu_interconnect/M09_ARESETN] [get_bd_pins axi_cpu_interconnect/S00_ARESETN] [get_bd_pins axi_gpio/s_axi_aresetn] [get_bd_pins axi_srio_initiator_fifo/s_axi_aresetn] [get_bd_pins axi_srio_initiator_shadowfifo/s_axi_aresetn] [get_bd_pins axi_srio_interconnect/ARESETN] [get_bd_pins axi_srio_interconnect/M00_ARESETN] [get_bd_pins axi_srio_interconnect/M01_ARESETN] [get_bd_pins axi_srio_interconnect/M02_ARESETN] [get_bd_pins axi_srio_interconnect/M03_ARESETN] [get_bd_pins axi_srio_interconnect/M04_ARESETN] [get_bd_pins axi_srio_interconnect/M05_ARESETN] [get_bd_pins axi_srio_interconnect/M06_ARESETN] [get_bd_pins axi_srio_interconnect/S00_ARESETN] [get_bd_pins axi_srio_target_fifo/s_axi_aresetn] [get_bd_pins axis_32to64_srio_init/AXIS_ARESETN] [get_bd_pins axis_32to64_srio_target/AXIS_ARESETN] [get_bd_pins axis_64to32_srio_init/AXIS_ARESETN] [get_bd_pins axis_64to32_srio_target/AXIS_ARESETN] [get_bd_pins axis_broadcaster_0/aresetn] [get_bd_pins srio_ireq_intc/ARESETN] [get_bd_pins srio_ireq_intc/M00_AXIS_ARESETN] [get_bd_pins srio_ireq_intc/S00_AXIS_ARESETN] [get_bd_pins srio_iresp_intc/ARESETN] [get_bd_pins srio_iresp_intc/M00_AXIS_ARESETN] [get_bd_pins srio_iresp_intc/S00_AXIS_ARESETN] [get_bd_pins srio_treq_intc/ARESETN] [get_bd_pins srio_treq_intc/M00_AXIS_ARESETN] [get_bd_pins srio_treq_intc/S00_AXIS_ARESETN] [get_bd_pins srio_tresp_intc/ARESETN] [get_bd_pins srio_tresp_intc/M00_AXIS_ARESETN] [get_bd_pins srio_tresp_intc/S00_AXIS_ARESETN] [get_bd_pins sys_reg_0/S_AXI_ARESETN] [get_bd_pins sys_rstgen/peripheral_aresetn]
  connect_bd_net -net sys_200m_clk [get_bd_pins axi_ad9361_0/delay_clk] [get_bd_pins axi_ad9361_1/delay_clk] [get_bd_pins sys_ps7/FCLK_CLK1]
  connect_bd_net -net sys_aux_reset [get_bd_pins sys_ps7/FCLK_RESET0_N] [get_bd_pins sys_rstgen/ext_reset_in]
  connect_bd_net -net sys_clkn_1 [get_bd_ports srio_sys_clkn] [get_bd_pins srio_gen2_0/sys_clkn]
  connect_bd_net -net sys_clkp_1 [get_bd_ports srio_sys_clkp] [get_bd_pins srio_gen2_0/sys_clkp]
  connect_bd_net -net sys_fmc_dma_clk [get_bd_pins axi_ad9361_0_adc_dma/m_dest_axi_aclk] [get_bd_pins axi_ad9361_0_adc_dma_interconnect/ACLK] [get_bd_pins axi_ad9361_0_adc_dma_interconnect/M00_ACLK] [get_bd_pins axi_ad9361_0_adc_dma_interconnect/S00_ACLK] [get_bd_pins axi_ad9361_0_dac_dma/m_src_axi_aclk] [get_bd_pins axi_ad9361_0_dac_dma_interconnect/ACLK] [get_bd_pins axi_ad9361_0_dac_dma_interconnect/M00_ACLK] [get_bd_pins axi_ad9361_0_dac_dma_interconnect/S00_ACLK] [get_bd_pins axi_ad9361_1_adc_dma/m_dest_axi_aclk] [get_bd_pins axi_ad9361_1_adc_dma_interconnect/ACLK] [get_bd_pins axi_ad9361_1_adc_dma_interconnect/M00_ACLK] [get_bd_pins axi_ad9361_1_adc_dma_interconnect/S00_ACLK] [get_bd_pins axi_ad9361_1_dac_dma/m_src_axi_aclk] [get_bd_pins axi_ad9361_1_dac_dma_interconnect/ACLK] [get_bd_pins axi_ad9361_1_dac_dma_interconnect/M00_ACLK] [get_bd_pins axi_ad9361_1_dac_dma_interconnect/S00_ACLK] [get_bd_pins axi_srio_initiator_fifo/s_axi_aclk] [get_bd_pins axi_srio_initiator_shadowfifo/s_axi_aclk] [get_bd_pins axi_srio_interconnect/M00_ACLK] [get_bd_pins axi_srio_interconnect/M01_ACLK] [get_bd_pins axi_srio_interconnect/M02_ACLK] [get_bd_pins axi_srio_interconnect/M03_ACLK] [get_bd_pins axi_srio_interconnect/M05_ACLK] [get_bd_pins axi_srio_interconnect/M06_ACLK] [get_bd_pins axi_srio_target_fifo/s_axi_aclk] [get_bd_pins axis_32to64_srio_init/AXIS_ACLK] [get_bd_pins axis_32to64_srio_target/AXIS_ACLK] [get_bd_pins axis_64to32_srio_init/AXIS_ACLK] [get_bd_pins axis_64to32_srio_target/AXIS_ACLK] [get_bd_pins axis_broadcaster_0/aclk] [get_bd_pins srio_ireq_intc/ACLK] [get_bd_pins srio_ireq_intc/S00_AXIS_ACLK] [get_bd_pins srio_iresp_intc/ACLK] [get_bd_pins srio_iresp_intc/M00_AXIS_ACLK] [get_bd_pins srio_treq_intc/ACLK] [get_bd_pins srio_treq_intc/M00_AXIS_ACLK] [get_bd_pins srio_tresp_intc/ACLK] [get_bd_pins srio_tresp_intc/S00_AXIS_ACLK] [get_bd_pins sys_ps7/FCLK_CLK2] [get_bd_pins sys_ps7/S_AXI_HP0_ACLK] [get_bd_pins sys_ps7/S_AXI_HP1_ACLK] [get_bd_pins sys_ps7/S_AXI_HP2_ACLK] [get_bd_pins sys_ps7/S_AXI_HP3_ACLK]
  connect_bd_net -net sys_ps7_GPIO_I [get_bd_ports GPIO_I] [get_bd_pins sys_ps7/GPIO_I]
  connect_bd_net -net sys_ps7_GPIO_O [get_bd_ports GPIO_O] [get_bd_pins sys_ps7/GPIO_O]
  connect_bd_net -net sys_ps7_GPIO_T [get_bd_ports GPIO_T] [get_bd_pins sys_ps7/GPIO_T]
  connect_bd_net -net sys_ps7_interrupt [get_bd_pins sys_concat_intc/dout] [get_bd_pins sys_ps7/IRQ_F2P]
  connect_bd_net -net sys_reg_0_gt_diffctrl [get_bd_pins srio_gen2_0/gt0_txdiffctrl_in] [get_bd_pins srio_gen2_0/gt1_txdiffctrl_in] [get_bd_pins srio_gen2_0/gt2_txdiffctrl_in] [get_bd_pins srio_gen2_0/gt3_txdiffctrl_in] [get_bd_pins sys_reg_0/gt_diffctrl]
  connect_bd_net -net sys_reg_0_gt_rxlpmen [get_bd_pins srio_gen2_0/gt_rxlpmen_in] [get_bd_pins sys_reg_0/gt_rxlpmen]
  connect_bd_net -net sys_reg_0_gt_txpostcursor [get_bd_pins srio_gen2_0/gt_txpostcursor_in] [get_bd_pins sys_reg_0/gt_txpostcursor]
  connect_bd_net -net sys_reg_0_gt_txprecursor [get_bd_pins srio_gen2_0/gt_txprecursor_in] [get_bd_pins sys_reg_0/gt_txprecursor]
  connect_bd_net -net sys_reg_0_srio_loopback [get_bd_pins srio_gen2_0/gt_loopback_in] [get_bd_pins sys_reg_0/srio_loopback]
  connect_bd_net -net sys_reg_0_srio_reset [get_bd_pins srio_gen2_0/sys_rst] [get_bd_pins sys_reg_0/srio_reset]
  connect_bd_net -net util_adc_pack_0_ddata [get_bd_pins axi_ad9361_0_adc_dma/fifo_wr_din] [get_bd_pins util_adc_pack_0/ddata]
  connect_bd_net -net util_adc_pack_0_dsync [get_bd_pins axi_ad9361_0_adc_dma/fifo_wr_sync] [get_bd_pins util_adc_pack_0/dsync]
  connect_bd_net -net util_adc_pack_0_dvalid [get_bd_pins axi_ad9361_0_adc_dma/fifo_wr_en] [get_bd_pins util_adc_pack_0/dvalid]
  connect_bd_net -net util_adc_pack_1_ddata [get_bd_pins axi_ad9361_1_adc_dma/fifo_wr_din] [get_bd_pins util_adc_pack_1/ddata]
  connect_bd_net -net util_adc_pack_1_dsync [get_bd_pins axi_ad9361_1_adc_dma/fifo_wr_sync] [get_bd_pins util_adc_pack_1/dsync]
  connect_bd_net -net util_adc_pack_1_dvalid [get_bd_pins axi_ad9361_1_adc_dma/fifo_wr_en] [get_bd_pins util_adc_pack_1/dvalid]

  # Create address segments
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_ad9361_0_adc_dma/m_dest_axi] [get_bd_addr_segs sys_ps7/S_AXI_HP1/HP1_DDR_LOWOCM] SEG_sys_ps7_hp1_ddr_lowocm
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_ad9361_0_dac_dma/m_src_axi] [get_bd_addr_segs sys_ps7/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_sys_ps7_hp0_ddr_lowocm
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_ad9361_1_adc_dma/m_dest_axi] [get_bd_addr_segs sys_ps7/S_AXI_HP3/HP3_DDR_LOWOCM] SEG_sys_ps7_hp3_ddr_lowocm
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_ad9361_1_dac_dma/m_src_axi] [get_bd_addr_segs sys_ps7/S_AXI_HP2/HP2_DDR_LOWOCM] SEG_sys_ps7_hp2_ddr_lowocm
  create_bd_addr_seg -range 0x10000 -offset 0x83C00000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_srio_initiator_fifo/S_AXI/Mem0] SEG_axi_srio_initiator_fifo_Mem0
  create_bd_addr_seg -range 0x10000 -offset 0x83C10000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_srio_initiator_fifo/S_AXI_FULL/Mem1] SEG_axi_srio_initiator_fifo_Mem1
  create_bd_addr_seg -range 0x10000 -offset 0x83C50000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_srio_initiator_shadowfifo/S_AXI/Mem0] SEG_axi_srio_initiator_shadowfifo_Mem0
  create_bd_addr_seg -range 0x10000 -offset 0x83C60000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_srio_initiator_shadowfifo/S_AXI_FULL/Mem1] SEG_axi_srio_initiator_shadowfifo_Mem1
  create_bd_addr_seg -range 0x10000 -offset 0x83C20000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_srio_target_fifo/S_AXI/Mem0] SEG_axi_srio_target_fifo_Mem0
  create_bd_addr_seg -range 0x10000 -offset 0x83C30000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_srio_target_fifo/S_AXI_FULL/Mem1] SEG_axi_srio_target_fifo_Mem1
  create_bd_addr_seg -range 0x10000 -offset 0x79000000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9361_0/s_axi/axi_lite] SEG_data_ad9361_0
  create_bd_addr_seg -range 0x10000 -offset 0x7C400000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9361_0_adc_dma/s_axi/axi_lite] SEG_data_ad9361_0_adc_dma
  create_bd_addr_seg -range 0x10000 -offset 0x7C420000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9361_0_dac_dma/s_axi/axi_lite] SEG_data_ad9361_0_dac_dma
  create_bd_addr_seg -range 0x10000 -offset 0x79020000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9361_1/s_axi/axi_lite] SEG_data_ad9361_1
  create_bd_addr_seg -range 0x10000 -offset 0x7C440000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9361_1_adc_dma/s_axi/axi_lite] SEG_data_ad9361_1_adc_dma
  create_bd_addr_seg -range 0x10000 -offset 0x7C460000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9361_1_dac_dma/s_axi/axi_lite] SEG_data_ad9361_1_dac_dma
  create_bd_addr_seg -range 0x10000 -offset 0x41200000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_gpio/S_AXI/Reg] SEG_data_axi_gpio
  create_bd_addr_seg -range 0x10000 -offset 0x83C40000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs srio_gen2_0/MAINT_IF/Reg] SEG_srio_gen2_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C00000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs sys_reg_0/S_AXI/reg0] SEG_sys_reg_0_reg0
  

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""



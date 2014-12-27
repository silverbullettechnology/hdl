
# create board design
# interface ports

set DDR [create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR]
set FIXED_IO [create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO]

set GPIO_I [create_bd_port -dir I -from 31 -to 0 GPIO_I]
set GPIO_O [create_bd_port -dir O -from 31 -to 0 GPIO_O]
set GPIO_T [create_bd_port -dir O -from 31 -to 0 GPIO_T]


# instance: sys_ps7

set sys_ps7  [create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.4 sys_ps7]


set_property -dict [list CONFIG.PCW_EN_CLK1_PORT {1}] $sys_ps7
set_property -dict [list CONFIG.PCW_EN_RST1_PORT {1}] $sys_ps7
set_property -dict [list CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100.0}] $sys_ps7
set_property -dict [list CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {200.0}] $sys_ps7
set_property -dict [list CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {250.0}] $sys_ps7

set_property -dict [list CONFIG.PCW_USE_FABRIC_INTERRUPT {1}] $sys_ps7
set_property -dict [list CONFIG.PCW_USE_S_AXI_HP0 {1}] $sys_ps7
set_property -dict [list CONFIG.PCW_IRQ_F2P_INTR {1}] $sys_ps7
#set_property -dict [list CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {1}] $sys_ps7
#set_property -dict [list CONFIG.PCW_GPIO_EMIO_GPIO_IO {32}] $sys_ps7
#set_property -dict [list CONFIG.PCW_USE_DMA0 {1}] $sys_ps7

# zynq clock settings

set_property -dict [list CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ {38.4}] $sys_ps7
set_property -dict [list CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {600}]      $sys_ps7
#set_property -dict [list CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {250}]    $sys_ps7

# Zynq MIO settings 
set_property -dict [list CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1}]    $sys_ps7
set_property -dict [list CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1}] $sys_ps7
set_property -dict [list CONFIG.PCW_QSPI_GRP_SS1_ENABLE {0}]       $sys_ps7
set_property -dict [list CONFIG.PCW_QSPI_GRP_IO1_ENABLE {0}]       $sys_ps7
set_property -dict [list CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {1}]     $sys_ps7

set_property -dict [list CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1}] $sys_ps7
set_property -dict [list CONFIG.PCW_SD0_GRP_CD_ENABLE {1}]     $sys_ps7
set_property -dict [list CONFIG.PCW_SD0_GRP_CD_IO {MIO 0}]     $sys_ps7
set_property -dict [list CONFIG.PCW_SD0_GRP_WP_ENABLE {1}]     $sys_ps7
set_property -dict [list CONFIG.PCW_SD0_GRP_WP_IO {MIO 15}]    $sys_ps7

set_property -dict [list CONFIG.PCW_SD1_PERIPHERAL_ENABLE {1}] $sys_ps7
set_property -dict [list CONFIG.PCW_SD1_SD1_IO {MIO 22 .. 27}] $sys_ps7

set_property -dict [list CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1}] $sys_ps7
set_property -dict [list CONFIG.PCW_WDT_PERIPHERAL_ENABLE {1}]   $sys_ps7
set_property -dict [list CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1}]  $sys_ps7
set_property -dict [list CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1}]  $sys_ps7
set_property -dict [list CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1}]    $sys_ps7
set_property -dict [list CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {1}]   $sys_ps7
set_property -dict [list CONFIG.PCW_GPIO_EMIO_GPIO_IO {54}]      $sys_ps7


set sys_concat_intc [create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 sys_concat_intc]
set_property -dict [list CONFIG.NUM_PORTS {5}] $sys_concat_intc

set axi_cpu_interconnect [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_cpu_interconnect]
set_property -dict [list CONFIG.NUM_MI {7}] $axi_cpu_interconnect

set sys_rstgen [create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 sys_rstgen]
set_property -dict [list CONFIG.C_EXT_RST_WIDTH {1}] $sys_rstgen


# system reset/clock definitions

set sys_100m_clk_source [get_bd_pins sys_ps7/FCLK_CLK0]
set sys_200m_clk_source [get_bd_pins sys_ps7/FCLK_CLK1]

connect_bd_net -net sys_100m_clk $sys_100m_clk_source
connect_bd_net -net sys_200m_clk $sys_200m_clk_source

connect_bd_net -net sys_100m_clk [get_bd_pins sys_rstgen/slowest_sync_clk]
connect_bd_net -net sys_aux_reset [get_bd_pins sys_rstgen/ext_reset_in] [get_bd_pins sys_ps7/FCLK_RESET0_N]

set sys_100m_resetn_source [get_bd_pins sys_rstgen/peripheral_aresetn]
set sys_200m_resetn_source [get_bd_pins sys_rstgen/interconnect_aresetn]
connect_bd_net -net sys_100m_resetn $sys_100m_resetn_source
connect_bd_net -net sys_200m_resetn $sys_200m_resetn_source
# interface connections

connect_bd_intf_net -intf_net sys_ps7_ddr [get_bd_intf_ports DDR] [get_bd_intf_pins sys_ps7/DDR]
connect_bd_net -net sys_ps7_GPIO_I [get_bd_ports GPIO_I] [get_bd_pins sys_ps7/GPIO_I]
connect_bd_net -net sys_ps7_GPIO_O [get_bd_ports GPIO_O] [get_bd_pins sys_ps7/GPIO_O]
connect_bd_net -net sys_ps7_GPIO_T [get_bd_ports GPIO_T] [get_bd_pins sys_ps7/GPIO_T]
connect_bd_intf_net -intf_net sys_ps7_fixed_io [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins sys_ps7/FIXED_IO]

connect_bd_net -net sys_100m_clk [get_bd_pins sys_ps7/M_AXI_GP0_ACLK]
connect_bd_net -net sys_100m_clk [get_bd_pins axi_cpu_interconnect/ACLK] $sys_100m_clk_source
connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/ARESETN] $sys_100m_resetn_source

connect_bd_intf_net -intf_net axi_cpu_interconnect_s00_axi [get_bd_intf_pins axi_cpu_interconnect/S00_AXI] [get_bd_intf_pins sys_ps7/M_AXI_GP0]
connect_bd_net -net sys_100m_clk [get_bd_pins axi_cpu_interconnect/S00_ACLK] $sys_100m_clk_source
connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/S00_ARESETN] $sys_100m_resetn_source

connect_bd_net -net sys_100m_clk [get_bd_pins axi_cpu_interconnect/M00_ACLK] $sys_100m_clk_source
connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M00_ARESETN] $sys_100m_resetn_source

connect_bd_net -net sys_ps7_interrupt [get_bd_pins sys_concat_intc/dout] [get_bd_pins sys_ps7/IRQ_F2P]


# match up interconnects
# connect_bd_net -net sys_100m_clk [get_bd_pins axi_cpu_interconnect/M04_ACLK] $sys_100m_clk_source
# connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M04_ARESETN] $sys_100m_resetn_source
# connect_bd_net -net sys_100m_clk [get_bd_pins axi_cpu_interconnect/M05_ACLK] $sys_100m_clk_source
# connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M05_ARESETN] $sys_100m_resetn_source
# connect_bd_net -net sys_100m_clk [get_bd_pins axi_cpu_interconnect/M06_ACLK] $sys_100m_clk_source
# connect_bd_net -net sys_100m_resetn [get_bd_pins axi_cpu_interconnect/M06_ARESETN] $sys_100m_resetn_source

# address map

set sys_zynq 1
set sys_mem_size 0x20000000
set sys_addr_cntrl_space [get_bd_addr_spaces sys_ps7/Data]


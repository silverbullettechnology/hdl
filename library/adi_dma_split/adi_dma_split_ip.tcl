# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create adi_dma_split
adi_ip_files adi_dma_split [list \
  "adi_dma_split_if.v"  \
  "adi_dma_split_logic.v"  \
  "adi_dma_split.v"   ]

adi_ip_properties_lite adi_dma_split
  set_property vendor {Silver-Bullet-Tech} [ipx::current_core]
  set_property vendor_display_name {Silver-Bullet-Tech} [ipx::current_core]
  set_property company_url {} [ipx::current_core]
  
ipx::save_core [ipx::current_core]


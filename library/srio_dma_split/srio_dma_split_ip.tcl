# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create srio_dma_split
adi_ip_files srio_dma_split [list \
  "srio_dma_split_if.v"  \
  "srio_dma_split_logic.v"  \
  "srio_dma_split.v"   ]

adi_ip_properties_lite srio_dma_split
  set_property vendor {Silver-Bullet-Tech} [ipx::current_core]
  set_property vendor_display_name {Silver-Bullet-Tech} [ipx::current_core]
  set_property company_url {} [ipx::current_core]
  
ipx::save_core [ipx::current_core]


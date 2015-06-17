# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create adi_dma_comb
adi_ip_files adi_dma_comb [list \
  "adi_dma_comb_logic.v" \
  "adi_dma_comb_if.v" \
  "adi_dma_comb.v"   ]

adi_ip_properties_lite adi_dma_comb
  set_property vendor {Silver-Bullet-Tech} [ipx::current_core]
  set_property vendor_display_name {Silver-Bullet-Tech} [ipx::current_core]
  set_property company_url {} [ipx::current_core]
  
ipx::save_core [ipx::current_core]


# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create vita49_tsfclk
adi_ip_files vita49_tsfclk [list \
  "vita49_tsfclk_logic.v" \
  "vita49_tsfclk_if.v" \
  "vita49_tsfclk.v"  ]

adi_ip_properties_lite vita49_tsfclk
  set_property vendor {Silver-Bullet-Tech} [ipx::current_core]
  set_property vendor_display_name {Silver-Bullet-Tech} [ipx::current_core]
  set_property company_url {} [ipx::current_core]
  
ipx::save_core [ipx::current_core]


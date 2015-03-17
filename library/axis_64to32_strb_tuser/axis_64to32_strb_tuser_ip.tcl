# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create axis_64to32_strb_tuser
adi_ip_files axis_64to32_strb_tuser [list \
  "axis_64to32_strb_tuser.v"  ]

adi_ip_properties_lite axis_64to32_strb_tuser
  set_property vendor {Silver-Bullet-Tech} [ipx::current_core]
  set_property vendor_display_name {Silver-Bullet-Tech} [ipx::current_core]
  set_property company_url {} [ipx::current_core]
  
ipx::save_core [ipx::current_core]


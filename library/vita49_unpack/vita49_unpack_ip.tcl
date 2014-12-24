# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create axis_vita49_unpack
adi_ip_files axis_vita49_unpack [list \
  "vita49_unpack.v" \
  "vita49_unpack_if.v" \
  "axis_vita49_unpack.v"  ]

adi_ip_properties_lite axis_vita49_pack
  set_property vendor {Silver-Bullet-Tech} [ipx::current_core]
  set_property vendor_display_name {Silver-Bullet-Tech} [ipx::current_core]
  set_property company_url {} [ipx::current_core]
  
ipx::save_core [ipx::current_core]


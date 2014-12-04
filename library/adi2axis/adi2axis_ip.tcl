# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create adi2axis
adi_ip_files adi2axis [list \
  "adi2axis_conv.v" \
  "adi2axis_if.v" \
  "adi2axis.v"  ]

adi_ip_properties_lite adi2axis
  set_property vendor {Silver-Bullet-Tech} [ipx::current_core]
  set_property vendor_display_name {Silver-Bullet-Tech} [ipx::current_core]
  set_property company_url {} [ipx::current_core]

ipx::save_core [ipx::current_core]


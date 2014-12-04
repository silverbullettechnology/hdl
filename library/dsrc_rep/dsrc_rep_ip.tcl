# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create dsrc_rep
adi_ip_files dsrc_rep [list \
  "axis_dsrc_rep.v" \
  "dsrc_rep_if.v" \
  "dsrc_rep.v"  ]

adi_ip_properties_lite dsrc_rep
  set_property vendor {Silver-Bullet-Tech} [ipx::current_core]
  set_property vendor_display_name {Silver-Bullet-Tech} [ipx::current_core]
  set_property company_url {} [ipx::current_core]
  
ipx::save_core [ipx::current_core]


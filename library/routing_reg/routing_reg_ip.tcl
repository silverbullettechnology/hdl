# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create routing_reg
adi_ip_files routing_reg [list \
  "routing_reg.v"  ]

adi_ip_properties_lite routing_reg
  set_property vendor {Silver-Bullet-Tech} [ipx::current_core]
  set_property vendor_display_name {Silver-Bullet-Tech} [ipx::current_core]
  set_property company_url {} [ipx::current_core]
  
ipx::save_core [ipx::current_core]


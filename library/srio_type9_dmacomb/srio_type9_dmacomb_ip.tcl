# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create srio_type9_dmacomb
adi_ip_files srio_type9_dmacomb [list \
  "srio_type9_dmacomb.v"  ]

adi_ip_properties_lite srio_type9_dmacomb
  set_property vendor {Silver-Bullet-Tech} [ipx::current_core]
  set_property vendor_display_name {Silver-Bullet-Tech} [ipx::current_core]
  set_property company_url {} [ipx::current_core]
  
ipx::save_core [ipx::current_core]

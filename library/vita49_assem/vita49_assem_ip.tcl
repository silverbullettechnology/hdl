# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create vita49_assem
adi_ip_files vita49_assem [list \
  "vita49_assem_logic.v" \
  "vita49_assem_if.v" \
  "vita49_assem.v" \
  ]

adi_ip_properties_lite vita49_assem
  set_property vendor {Silver-Bullet-Tech} [ipx::current_core]
  set_property vendor_display_name {Silver-Bullet-Tech} [ipx::current_core]
  set_property company_url {} [ipx::current_core]
  
ipx::save_core [ipx::current_core]


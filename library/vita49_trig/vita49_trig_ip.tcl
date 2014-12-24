# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create vita49_trig
adi_ip_files vita49_trig [list \
  "vita49_trig_logic.v" \
  "vita49_trig_if.v" \
  "vita49_trig.v"  ]

adi_ip_properties_lite vita49_trig
  set_property vendor {Silver-Bullet-Tech} [ipx::current_core]
  set_property vendor_display_name {Silver-Bullet-Tech} [ipx::current_core]
  set_property company_url {} [ipx::current_core]
  
ipx::save_core [ipx::current_core]


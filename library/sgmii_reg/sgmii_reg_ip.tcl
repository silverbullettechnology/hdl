# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create sgmii_reg
adi_ip_files sgmii_reg [list \
  "sgmii_reg_logic.v" \
  "sgmii_reg_if.v" \
  "sgmii_reg.v"  ]

adi_ip_properties_lite sgmii_reg
  set_property vendor {Silver-Bullet-Tech} [ipx::current_core]
  set_property vendor_display_name {Silver-Bullet-Tech} [ipx::current_core]
  set_property company_url {} [ipx::current_core]
  
ipx::save_core [ipx::current_core]


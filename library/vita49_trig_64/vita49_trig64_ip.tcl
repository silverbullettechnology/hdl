# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create vita49_trig64
adi_ip_files vita49_trig64 [list \
  "vita49_trig64_logic.v" \
  "vita49_trig64_if.v" \
  "vita49_trig64.v"  ]

create_ip -name c_addsub -vendor xilinx.com -library ip -version 12.0 -module_name sub_64
set_property -dict [list CONFIG.A_Width {64} CONFIG.B_Width {64} CONFIG.Add_Mode {Subtract} CONFIG.Out_Width {64} CONFIG.Latency {1} CONFIG.B_Value {0000000000000000000000000000000000000000000000000000000000000000}] [get_ips sub_64]  
set_property -dict [list CONFIG.CE {false}] [get_ips sub_64]

  
adi_ip_properties_lite vita49_trig64
  set_property vendor {Silver-Bullet-Tech} [ipx::current_core]
  set_property vendor_display_name {Silver-Bullet-Tech} [ipx::current_core]
  set_property company_url {} [ipx::current_core]
  
ipx::save_core [ipx::current_core]


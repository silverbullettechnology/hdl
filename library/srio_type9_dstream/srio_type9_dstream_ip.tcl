# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create srio_type9_dstream
adi_ip_files srio_type9_dstream [list \
  "dstream_seg_srio_gen2_0.v"  \
  "axis_reg.v"  \
  "srio_type9_dstream.v"  ]

adi_ip_properties_lite srio_type9_dstream
  set_property vendor {Silver-Bullet-Tech} [ipx::current_core]
  set_property vendor_display_name {Silver-Bullet-Tech} [ipx::current_core]
  set_property company_url {} [ipx::current_core]

ipx::infer_bus_interface {ireq_tvalid ireq_tready ireq_tlast ireq_tdata ireq_tkeep ireq_tuser} xilinx.com:interface:axis_rtl:1.0 [ipx::current_core]
ipx::infer_bus_interface {user_ireq_tvalid user_ireq_tready user_ireq_tlast user_ireq_tdata user_ireq_tkeep user_ireq_tuser} xilinx.com:interface:axis_rtl:1.0 [ipx::current_core]
ipx::infer_bus_interface clk xilinx.com:signal:clock_rtl:1.0 [ipx::current_core]
ipx::infer_bus_interfaces xilinx.com:signal:reset_rtl:1.0 [ipx::current_core]
 
set_property value ACTIVE_HIGH [ipx::get_bus_parameters POLARITY -of_objects [ipx::get_bus_interfaces reset -of_objects [ipx::current_core]]]
 
ipx::save_core [ipx::current_core]


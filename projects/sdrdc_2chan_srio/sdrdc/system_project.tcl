


source ../../scripts/adi_env.tcl
source $ad_hdl_dir/projects/scripts/adi_project.tcl

adi_project_create sdrdc_2chan_srio_sdrdc
adi_project_files sdrdc_2chan_srio_sdrdc [list \
  "system_top.v" \
  "system_constr.xdc"\
  "$ad_hdl_dir/projects/common/sdrdc/sdrdc_system_constr.xdc" ]

adi_project_run sdrdc_2chan_srio_sdrdc



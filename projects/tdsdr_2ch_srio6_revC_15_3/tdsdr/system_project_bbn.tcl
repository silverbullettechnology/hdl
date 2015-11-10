


source ../../scripts/adi_env.tcl
source $ad_hdl_dir/projects/scripts/adi_project.tcl

localbd_project_create tdsdr_2chan_srio_tdsdr
adi_project_files tdsdr_2chan_srio_tdsdr [list \
  "system_top_bbn.v" \
  "system_constr_bbn.xdc"\
  "$ad_hdl_dir/library/common/ad_iobuf.v" \
  "$ad_hdl_dir/projects/common/tdsdr/tdsdr_system_constr.xdc" ]

adi_project_run tdsdr_2chan_srio_tdsdr



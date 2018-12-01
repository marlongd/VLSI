###############################################################
#  Generated by:      Cadence Innovus 17.11-s080_1
#  OS:                Linux x86_64(Host ID lab2-34.eng.utah.edu)
#  Generated on:      Fri Nov 30 19:58:20 2018
#  Design:            snake_top_top
#  Command:           create_ccopt_clock_tree_spec -file ccopt.spec
###############################################################
#-------------------------------------------------------------------------------
# Clock tree setup script - dialect: Innovus
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

namespace eval ::ccopt {}
namespace eval ::ccopt::ilm {}
set ::ccopt::ilm::ccoptSpecRestoreData {}
# Start by checking for unflattened ILMs.
# Will flatten if so and then check the db sync.
if { [catch {ccopt_check_and_flatten_ilms_no_restore}] } {
  return -code error
}
# cache the value of the restore command output by the ILM flattening code
set ::ccopt::ilm::ccoptSpecRestoreData $::ccopt::ilm::ccoptRestoreILMState

# Clocks present at pin clk
#   clk (period 20.000ns) in timing_config constraint([../synopsys_dc/SDC/snake_top_mapped.sdc])
create_ccopt_clock_tree -name clk -source clk -no_skew_group

# Clock period setting for source pin of clk
set_ccopt_property clock_period -pin clk 20

# Skew group to balance non generated clock:clk in timing_config:constraint (sdc ../synopsys_dc/SDC/snake_top_mapped.sdc)
create_ccopt_skew_group -name clk/constraint -sources clk -auto_sinks
set_ccopt_property include_source_latency -skew_group clk/constraint true
set_ccopt_property extracted_from_clock_name -skew_group clk/constraint clk
set_ccopt_property extracted_from_constraint_mode_name -skew_group clk/constraint constraint
set_ccopt_property extracted_from_delay_corners -skew_group clk/constraint {wc bc}


check_ccopt_clock_tree_convergence
# Restore the ILM status if possible
if { [get_ccopt_property auto_design_state_for_ilms] == 0 } {
  if {$::ccopt::ilm::ccoptSpecRestoreData != {} } {
    eval $::ccopt::ilm::ccoptSpecRestoreData
  }
}


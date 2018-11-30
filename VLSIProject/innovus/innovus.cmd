#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Thu Nov 29 20:25:18 2018                
#                                                     
#######################################################

#@(#)CDS: Innovus v17.11-s080_1 (64bit) 08/04/2017 11:13 (Linux 2.6.18-194.el5)
#@(#)CDS: NanoRoute 17.11-s080_1 NR170721-2155/17_11-UB (database version 2.30, 390.7.1) {superthreading v1.44}
#@(#)CDS: AAE 17.11-s034 (64bit) 08/04/2017 (Linux 2.6.18-194.el5)
#@(#)CDS: CTE 17.11-s053_1 () Aug  1 2017 23:31:41 ( )
#@(#)CDS: SYNTECH 17.11-s012_1 () Jul 21 2017 02:29:12 ( )
#@(#)CDS: CPE v17.11-s095
#@(#)CDS: IQRC/TQRC 16.1.1-s215 (64bit) Thu Jul  6 20:18:10 PDT 2017 (Linux 2.6.18-194.el5)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getDrawView
loadWorkspace -name Physical
win
set init_design_uniquify 1
set init_gnd_net VSS
set init_pwr_net VDD
set init_top_cell snake_top_top
set init_verilog ../HDL/GATE/snake_top_mapped.v
set init_lef_file {/research/ece/lnis-teaching/Designkits/tsmc180nm/full_custom_lib/lef/tech.lef /research/ece/lnis-teaching/Designkits/tsmc180nm/full_custom_lib/lef/sclib_tsmc180.lef /research/ece/lnis-teaching/Designkits/tsmc180nm/full_custom_lib/lef/padlib_tsmc180.lef}
set init_mmmc_file CONF/design.view
init_design
init_design
set init_design_uniquify 1
init_design
set init_design_uniquify 1
init_design
init_design
set init_design_uniquify 1
init_design
set init_design_uniquify 1
init_design
set init_design_uniquify 1
init_design
floorPlan -site core7T -r 1.0 0.50 12 12 12 12
fit
saveDesign DBS/snake_top-fplan.enc
globalNetConnect VDD -type pgpin -pin VDD -all -verbose
globalNetConnect VSS -type pgpin -pin VSS -all -verbose
globalNetConnect VDD -type tiehi
globalNetConnect VSS -type tielo
loadIoFile SCRIPTS/place_io.io
addIoFiller -cell pad_fill_32 -prefix FILLER -side n
addIoFiller -cell pad_fill_16 -prefix FILLER -side n
addIoFiller -cell pad_fill_8 -prefix FILLER -side n
addIoFiller -cell pad_fill_4 -prefix FILLER -side n
addIoFiller -cell pad_fill_2 -prefix FILLER -side n
addIoFiller -cell pad_fill_1 -prefix FILLER -side n
addIoFiller -cell pad_fill_01 -prefix FILLER -side n
addIoFiller -cell pad_fill_005 -prefix FILLER -side n -fillAnyGap
addIoFiller -cell pad_fill_32 -prefix FILLER -side s
addIoFiller -cell pad_fill_16 -prefix FILLER -side s
addIoFiller -cell pad_fill_8 -prefix FILLER -side s
addIoFiller -cell pad_fill_4 -prefix FILLER -side s
addIoFiller -cell pad_fill_2 -prefix FILLER -side s
addIoFiller -cell pad_fill_1 -prefix FILLER -side s
addIoFiller -cell pad_fill_01 -prefix FILLER -side s
addIoFiller -cell pad_fill_005 -prefix FILLER -side s -fillAnyGap
addIoFiller -cell pad_fill_32 -prefix FILLER -side e
addIoFiller -cell pad_fill_16 -prefix FILLER -side e
addIoFiller -cell pad_fill_8 -prefix FILLER -side e
addIoFiller -cell pad_fill_4 -prefix FILLER -side e
addIoFiller -cell pad_fill_2 -prefix FILLER -side e
addIoFiller -cell pad_fill_1 -prefix FILLER -side e
addIoFiller -cell pad_fill_01 -prefix FILLER -side e
addIoFiller -cell pad_fill_005 -prefix FILLER -side e -fillAnyGap
addIoFiller -cell pad_fill_32 -prefix FILLER -side w
addIoFiller -cell pad_fill_16 -prefix FILLER -side w
addIoFiller -cell pad_fill_8 -prefix FILLER -side w
addIoFiller -cell pad_fill_4 -prefix FILLER -side w
addIoFiller -cell pad_fill_2 -prefix FILLER -side w
addIoFiller -cell pad_fill_1 -prefix FILLER -side w
addIoFiller -cell pad_fill_01 -prefix FILLER -side w
addIoFiller -cell pad_fill_005 -prefix FILLER -side w -fillAnyGap
deleteAllPowerPreroutes
addRing -type core_rings -follow core -nets {VSS VDD} -center 1 -width 3.0 -spacing 2 -layer {top METAL1 bottom METAL1 left METAL2 right METAL2} -extend_corner {} -jog_distance 0 -snap_wire_center_to_grid None -threshold 0
sroute -connect { padPin } -layerChangeRange { METAL1(1) METAL6(6) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -padPinLayerRange { METAL3(3) METAL3(3) } -allowJogging 0 -crossoverViaLayerRange { METAL1(1) METAL6(6) } -nets {VSS VDD} -allowLayerChange 0 -targetViaLayerRange { METAL1(1) METAL6(6) }
fit
saveDesign DBS/snake_top-power.enc
sroute -connect { blockPin corePin } -layerChangeRange { METAL1(1) METAL6(6) } -blockPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -crossoverViaLayerRange { METAL1(1) METAL6(6) } -nets {VSS VDD} -allowJogging 1 -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { METAL1(1) METAL6(6) }
fit
saveDesign DBS/snake_top-power-routed.enc
setMultiCpuUsage -localCpu 4 -keepLicense true -acquireLicense 4
setDesignMode -process 180
setRouteMode -earlyGlobalMaxRouteLayer 5
setPlaceMode -timingDriven true -congEffort auto -doCongOpt false -placeIOPins 1
placeDesign -noPrePlaceOpt
set init_gnd_net VSS
set init_pwr_net VDD
set init_top_cell snake_top_top
set init_verilog ../HDL/GATE/snake_top_mapped.v
set init_lef_file {/research/ece/lnis-teaching/Designkits/tsmc180nm/full_custom_lib/lef/tech.lef /research/ece/lnis-teaching/Designkits/tsmc180nm/full_custom_lib/lef/sclib_tsmc180.lef /research/ece/lnis-teaching/Designkits/tsmc180nm/full_custom_lib/lef/padlib_tsmc180.lef}
set init_mmmc_file CONF/design.view
init_design
saveDesign DBS/snake_top-import.enc
setDrawView fplan
fit
set init_gnd_net VSS
set init_pwr_net VDD
set init_top_cell snake_top_top
set init_verilog ../HDL/GATE/snake_top_mapped.v
set init_lef_file {/research/ece/lnis-teaching/Designkits/tsmc180nm/full_custom_lib/lef/tech.lef /research/ece/lnis-teaching/Designkits/tsmc180nm/full_custom_lib/lef/sclib_tsmc180.lef /research/ece/lnis-teaching/Designkits/tsmc180nm/full_custom_lib/lef/padlib_tsmc180.lef}
set init_mmmc_file CONF/design.view
init_design

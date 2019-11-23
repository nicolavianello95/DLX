#*****************************************************************************
# This script is used to synthesize the DLX
#*****************************************************************************
#list all possible file used by the block under synthesis
analyze {.} -autoread

#elaborate top entity
elaborate DLX -architecture structural -library WORK -parameters "BPU_TAG_FIELD_SIZE = 8 , BPU_SET_FIELD_SIZE = 3, BPU_LINES_PER_SET = 4"
#wires model
set_wire_load_model -name 5K_hvratio_1_4
#**************** CONSTRAINT THE SYNTHESIS ***********************
set WCP 2.4
# create a clock signal with a period equal to the worst critical path
create_clock -name "CLOCK" -period $WCP CLK
#forces a combinational max delay from each of the inputs
#to each of th output in case combinational paths are present 
set_max_delay $WCP -from [all_inputs] -to [all_outputs]
#constraint the area
set_max_area 0.0
ungroup -all -flatten
compile_ultra -area_high_effort_script
#write report
report_timing >  timing_area_wcp2.4.rpt
report_area >  area_area_wcp2.4.rpt
report_power >  power_area_wcp2.4.rpt
#******************************************************

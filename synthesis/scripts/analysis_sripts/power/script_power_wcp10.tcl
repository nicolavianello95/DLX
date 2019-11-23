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
set_dynamic_optimization true
set_leakage_optimization true
set WCP 10
# create a clock signal with a period equal to the worst critical path
create_clock -name "CLOCK" -period $WCP CLK
#verify the creation correctness of the clock
report_clock
#forces a combinational max delay from each of the inputs
#to each of the output
set_max_delay $WCP -from [all_inputs] -to [all_outputs]
set max_fanout 32
set minbit 1
set_clock_gating_style -minimum_bitwidth $minbit -max_fanout $max_fanout -control_point before -positive_edge_logic {latch and}
#compile  
compile_ultra -gate_clock
#write report
report_timing > timing_power_wcp10.rpt
report_area > area_power_wcp10.rpt
report_power > power_power_wcp10.rpt
#******************************************************


#*****************************************************************************
# This script is used to synthesize the DLX 
#*****************************************************************************
#analyze all possible files contained in the work folder 
analyze {.} -autoread

#elaborate top entity, set the variable
elaborate DLX -architecture structural -library WORK -parameters "BPU_TAG_FIELD_SIZE = 8 , BPU_SET_FIELD_SIZE = 3, BPU_LINES_PER_SET = 4"
#wires model
set_wire_load_model -name 5K_hvratio_1_4
#**************** CONSTRAINT THE SYNTHESIS ***********************
#timing constraint. WCP holds the minimum value of the delay
set WCP 2.43
# create a clock signal with a period equal to the worst critical path
create_clock -name "CLOCK" -period $WCP CLK
#forces a combinational max delay from each of the inputs
#to each of th output in case combinational paths are present 
set_max_delay $WCP -from [all_inputs] -to [all_outputs]
#clock gating setting
set max_fanout 32
set minbit 1
set_clock_gating_style -minimum_bitwidth $minbit -max_fanout $max_fanout -control_point before -positive_edge_logic {latch and}

#compile ultra command, in order to perform an exact synthesis
#no_autoungroup is put in order to doesn't lost the hierarchy of the design
compile_ultra -timing_high_effort_script -no_autoungroup -gate_clock

#function to write the first 1000 critical path found
proc custom_report {} {
  echo [format "%-20s %-20s %7s" "From" "To" "Slack"]
     echo "--------------------------------------------------------"
      foreach_in_collection path [get_timing_paths -nworst 1000] {
        set slack [get_attribute $path slack]
        set startpoint [get_attribute $path startpoint]
        set endpoint [get_attribute $path endpoint]
        echo [format "%-20s %-20s %s" [get_attribute $startpoint full_name] \
             [get_attribute $endpoint full_name] $slack]
							}
			}
#write the reports
report_timing > timing_DLX.rpt
report_area > area_DLX.rpt
report_power > power_DLX.rpt
# report that holds all the information for each block
report_area -hierarchy > area_DLX.rpt
report_power -hierarchy > power_DLX.rpt

#******************************************************
#write the netlist in verilog and vhdl languages
write -hierarchy -format verilog -output p4add_32bit_post_syn.v
write -hierarchy -format vhdl -output p4add_32bit_post_syn.vhdl
#generate the SDC file subsequently used in the Place and Route phase
write_sdc P4ADD.sdc


vsim work.tb_dlx

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider clock
add wave -noupdate /tb_dlx/clk
add wave -noupdate -divider {IF stage}
add wave -noupdate -radix unsigned /tb_dlx/dut/datapath_instance/pc_out
add wave -noupdate -radix hexadecimal /tb_dlx/dut/iram_out
add wave -noupdate -radix unsigned /tb_dlx/dut/datapath_instance/npc
add wave -noupdate -radix unsigned /tb_dlx/dut/datapath_instance/pc_in
add wave -noupdate -divider {ID stage}
add wave -noupdate /tb_dlx/dut/misprediction
add wave -noupdate /tb_dlx/dut/cu_instance/opcode
add wave -noupdate /tb_dlx/dut/cu_instance/func
add wave -noupdate -divider {EXE stage}
add wave -noupdate /tb_dlx/dut/datapath_instance/alu_instance/func
add wave -noupdate -radix unsigned /tb_dlx/dut/datapath_instance/alu_in1
add wave -noupdate -radix unsigned /tb_dlx/dut/datapath_instance/alu_in2
add wave -noupdate -radix decimal /tb_dlx/dut/datapath_instance/alu_out
add wave -noupdate -divider {MEM stage}
add wave -noupdate -radix decimal /tb_dlx/dram_instance/data_in
add wave -noupdate -radix decimal /tb_dlx/dram_instance/data_out
add wave -noupdate /tb_dlx/dut/dram_wr_en
add wave -noupdate -divider WB_stage
add wave -noupdate -radix decimal /tb_dlx/dut/datapath_instance/rf_data_in
add wave -noupdate -divider registers
add wave -noupdate -radix decimal /tb_dlx/dut/datapath_instance/rf_instance/registers(1)
add wave -noupdate -radix decimal /tb_dlx/dut/datapath_instance/rf_instance/registers(2)
add wave -noupdate -radix decimal /tb_dlx/dut/datapath_instance/rf_instance/registers(31)
add wave -noupdate -divider DRAM
add wave -noupdate -radix decimal /tb_dlx/dram_instance/mem(0)
add wave -noupdate -radix decimal /tb_dlx/dram_instance/mem(4)
add wave -noupdate -radix decimal /tb_dlx/dram_instance/mem(8)
add wave -noupdate -radix decimal /tb_dlx/dram_instance/mem(12)
TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 363
configure wave -valuecolwidth 78
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {700 ns}

run 700 ns

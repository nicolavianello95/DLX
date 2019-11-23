###################################################################

# Created by write_sdc

###################################################################
set sdc_version 1.9

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
set_wire_load_model -name 5K_hvratio_1_4 -library NangateOpenCellLibrary
create_clock [get_ports CLK]  -name CLOCK  -period 2.43  -waveform {0 1.215}
set_max_delay 2.43  -from [list [get_ports {IRAM_OUT[31]}] [get_ports {IRAM_OUT[30]}] [get_ports  \
{IRAM_OUT[29]}] [get_ports {IRAM_OUT[28]}] [get_ports {IRAM_OUT[27]}]          \
[get_ports {IRAM_OUT[26]}] [get_ports {IRAM_OUT[25]}] [get_ports               \
{IRAM_OUT[24]}] [get_ports {IRAM_OUT[23]}] [get_ports {IRAM_OUT[22]}]          \
[get_ports {IRAM_OUT[21]}] [get_ports {IRAM_OUT[20]}] [get_ports               \
{IRAM_OUT[19]}] [get_ports {IRAM_OUT[18]}] [get_ports {IRAM_OUT[17]}]          \
[get_ports {IRAM_OUT[16]}] [get_ports {IRAM_OUT[15]}] [get_ports               \
{IRAM_OUT[14]}] [get_ports {IRAM_OUT[13]}] [get_ports {IRAM_OUT[12]}]          \
[get_ports {IRAM_OUT[11]}] [get_ports {IRAM_OUT[10]}] [get_ports               \
{IRAM_OUT[9]}] [get_ports {IRAM_OUT[8]}] [get_ports {IRAM_OUT[7]}] [get_ports  \
{IRAM_OUT[6]}] [get_ports {IRAM_OUT[5]}] [get_ports {IRAM_OUT[4]}] [get_ports  \
{IRAM_OUT[3]}] [get_ports {IRAM_OUT[2]}] [get_ports {IRAM_OUT[1]}] [get_ports  \
{IRAM_OUT[0]}] [get_ports {DRAM_OUT[31]}] [get_ports {DRAM_OUT[30]}]           \
[get_ports {DRAM_OUT[29]}] [get_ports {DRAM_OUT[28]}] [get_ports               \
{DRAM_OUT[27]}] [get_ports {DRAM_OUT[26]}] [get_ports {DRAM_OUT[25]}]          \
[get_ports {DRAM_OUT[24]}] [get_ports {DRAM_OUT[23]}] [get_ports               \
{DRAM_OUT[22]}] [get_ports {DRAM_OUT[21]}] [get_ports {DRAM_OUT[20]}]          \
[get_ports {DRAM_OUT[19]}] [get_ports {DRAM_OUT[18]}] [get_ports               \
{DRAM_OUT[17]}] [get_ports {DRAM_OUT[16]}] [get_ports {DRAM_OUT[15]}]          \
[get_ports {DRAM_OUT[14]}] [get_ports {DRAM_OUT[13]}] [get_ports               \
{DRAM_OUT[12]}] [get_ports {DRAM_OUT[11]}] [get_ports {DRAM_OUT[10]}]          \
[get_ports {DRAM_OUT[9]}] [get_ports {DRAM_OUT[8]}] [get_ports {DRAM_OUT[7]}]  \
[get_ports {DRAM_OUT[6]}] [get_ports {DRAM_OUT[5]}] [get_ports {DRAM_OUT[4]}]  \
[get_ports {DRAM_OUT[3]}] [get_ports {DRAM_OUT[2]}] [get_ports {DRAM_OUT[1]}]  \
[get_ports {DRAM_OUT[0]}] [get_ports CLK] [get_ports RST]]  -to [list [get_ports {IRAM_ADDR[31]}] [get_ports {IRAM_ADDR[30]}] [get_ports  \
{IRAM_ADDR[29]}] [get_ports {IRAM_ADDR[28]}] [get_ports {IRAM_ADDR[27]}]       \
[get_ports {IRAM_ADDR[26]}] [get_ports {IRAM_ADDR[25]}] [get_ports             \
{IRAM_ADDR[24]}] [get_ports {IRAM_ADDR[23]}] [get_ports {IRAM_ADDR[22]}]       \
[get_ports {IRAM_ADDR[21]}] [get_ports {IRAM_ADDR[20]}] [get_ports             \
{IRAM_ADDR[19]}] [get_ports {IRAM_ADDR[18]}] [get_ports {IRAM_ADDR[17]}]       \
[get_ports {IRAM_ADDR[16]}] [get_ports {IRAM_ADDR[15]}] [get_ports             \
{IRAM_ADDR[14]}] [get_ports {IRAM_ADDR[13]}] [get_ports {IRAM_ADDR[12]}]       \
[get_ports {IRAM_ADDR[11]}] [get_ports {IRAM_ADDR[10]}] [get_ports             \
{IRAM_ADDR[9]}] [get_ports {IRAM_ADDR[8]}] [get_ports {IRAM_ADDR[7]}]          \
[get_ports {IRAM_ADDR[6]}] [get_ports {IRAM_ADDR[5]}] [get_ports               \
{IRAM_ADDR[4]}] [get_ports {IRAM_ADDR[3]}] [get_ports {IRAM_ADDR[2]}]          \
[get_ports {IRAM_ADDR[1]}] [get_ports {IRAM_ADDR[0]}] [get_ports               \
{DRAM_ADDR[31]}] [get_ports {DRAM_ADDR[30]}] [get_ports {DRAM_ADDR[29]}]       \
[get_ports {DRAM_ADDR[28]}] [get_ports {DRAM_ADDR[27]}] [get_ports             \
{DRAM_ADDR[26]}] [get_ports {DRAM_ADDR[25]}] [get_ports {DRAM_ADDR[24]}]       \
[get_ports {DRAM_ADDR[23]}] [get_ports {DRAM_ADDR[22]}] [get_ports             \
{DRAM_ADDR[21]}] [get_ports {DRAM_ADDR[20]}] [get_ports {DRAM_ADDR[19]}]       \
[get_ports {DRAM_ADDR[18]}] [get_ports {DRAM_ADDR[17]}] [get_ports             \
{DRAM_ADDR[16]}] [get_ports {DRAM_ADDR[15]}] [get_ports {DRAM_ADDR[14]}]       \
[get_ports {DRAM_ADDR[13]}] [get_ports {DRAM_ADDR[12]}] [get_ports             \
{DRAM_ADDR[11]}] [get_ports {DRAM_ADDR[10]}] [get_ports {DRAM_ADDR[9]}]        \
[get_ports {DRAM_ADDR[8]}] [get_ports {DRAM_ADDR[7]}] [get_ports               \
{DRAM_ADDR[6]}] [get_ports {DRAM_ADDR[5]}] [get_ports {DRAM_ADDR[4]}]          \
[get_ports {DRAM_ADDR[3]}] [get_ports {DRAM_ADDR[2]}] [get_ports               \
{DRAM_ADDR[1]}] [get_ports {DRAM_ADDR[0]}] [get_ports {DRAM_IN[31]}]           \
[get_ports {DRAM_IN[30]}] [get_ports {DRAM_IN[29]}] [get_ports {DRAM_IN[28]}]  \
[get_ports {DRAM_IN[27]}] [get_ports {DRAM_IN[26]}] [get_ports {DRAM_IN[25]}]  \
[get_ports {DRAM_IN[24]}] [get_ports {DRAM_IN[23]}] [get_ports {DRAM_IN[22]}]  \
[get_ports {DRAM_IN[21]}] [get_ports {DRAM_IN[20]}] [get_ports {DRAM_IN[19]}]  \
[get_ports {DRAM_IN[18]}] [get_ports {DRAM_IN[17]}] [get_ports {DRAM_IN[16]}]  \
[get_ports {DRAM_IN[15]}] [get_ports {DRAM_IN[14]}] [get_ports {DRAM_IN[13]}]  \
[get_ports {DRAM_IN[12]}] [get_ports {DRAM_IN[11]}] [get_ports {DRAM_IN[10]}]  \
[get_ports {DRAM_IN[9]}] [get_ports {DRAM_IN[8]}] [get_ports {DRAM_IN[7]}]     \
[get_ports {DRAM_IN[6]}] [get_ports {DRAM_IN[5]}] [get_ports {DRAM_IN[4]}]     \
[get_ports {DRAM_IN[3]}] [get_ports {DRAM_IN[2]}] [get_ports {DRAM_IN[1]}]     \
[get_ports {DRAM_IN[0]}] [get_ports {DRAM_WR_EN[1]}] [get_ports                \
{DRAM_WR_EN[0]}]]
set_clock_gating_check -rise -setup 0 [get_cells                               \
clk_gate_INSTR_EXE_reg_0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
clk_gate_INSTR_EXE_reg_0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
clk_gate_INSTR_EXE_reg_0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
clk_gate_INSTR_EXE_reg_0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
clk_gate_INSTR_EXE_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
clk_gate_INSTR_EXE_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
clk_gate_INSTR_EXE_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
clk_gate_INSTR_EXE_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
clk_gate_INSTR_ID_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
clk_gate_INSTR_ID_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells clk_gate_INSTR_ID_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells clk_gate_INSTR_ID_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
datapath_instance/REG_RF_WR_ADDR_EXE/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
datapath_instance/REG_RF_WR_ADDR_EXE/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
datapath_instance/REG_RF_WR_ADDR_EXE/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
datapath_instance/REG_RF_WR_ADDR_EXE/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
datapath_instance/REG_DRAM_IN/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
datapath_instance/REG_DRAM_IN/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
datapath_instance/REG_DRAM_IN/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
datapath_instance/REG_DRAM_IN/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
datapath_instance/REG_NPC_EXE/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
datapath_instance/REG_NPC_EXE/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
datapath_instance/REG_NPC_EXE/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
datapath_instance/REG_NPC_EXE/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
datapath_instance/REG_ALU_OUT_EXE/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
datapath_instance/REG_ALU_OUT_EXE/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
datapath_instance/REG_ALU_OUT_EXE/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
datapath_instance/REG_ALU_OUT_EXE/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/MULT/clk_gate_add_out_s3_reg[8]_0/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/MULT/clk_gate_add_out_s3_reg[8]_0/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/MULT/clk_gate_add_out_s3_reg[8]_0/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/MULT/clk_gate_add_out_s3_reg[8]_0/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/MULT/clk_gate_add_out_s2_reg[4]_0/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/MULT/clk_gate_add_out_s2_reg[4]_0/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/MULT/clk_gate_add_out_s2_reg[4]_0/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/MULT/clk_gate_add_out_s2_reg[4]_0/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/MULT/clk_gate_add_out_s4_reg[12]_0/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/MULT/clk_gate_add_out_s4_reg[12]_0/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/MULT/clk_gate_add_out_s4_reg[12]_0/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/MULT/clk_gate_add_out_s4_reg[12]_0/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
datapath_instance/REG_IMM/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
datapath_instance/REG_IMM/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
datapath_instance/REG_IMM/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
datapath_instance/REG_IMM/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
datapath_instance/REG_RF_OUT2/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
datapath_instance/REG_RF_OUT2/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
datapath_instance/REG_RF_OUT2/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
datapath_instance/REG_RF_OUT2/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
datapath_instance/REG_RF_OUT1/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
datapath_instance/REG_RF_OUT1/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
datapath_instance/REG_RF_OUT1/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
datapath_instance/REG_RF_OUT1/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[31]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[31]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[31]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[31]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[30]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[30]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[30]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[30]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[29]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[29]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[29]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[29]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[28]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[28]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[28]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[28]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[27]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[27]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[27]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[27]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[26]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[26]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[26]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[26]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[25]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[25]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[25]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[25]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[24]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[24]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[24]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[24]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[23]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[23]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[23]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[23]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[22]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[22]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[22]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[22]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[21]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[21]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[21]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[21]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[20]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[20]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[20]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[20]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[19]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[19]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[19]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[19]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[18]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[18]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[18]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[18]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[17]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[17]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[17]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[17]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[16]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[16]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[16]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[16]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[15]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[15]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[15]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[15]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[14]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[14]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[14]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[14]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[13]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[13]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[13]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[13]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[12]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[12]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[12]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[12]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[11]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[11]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[11]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[11]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[10]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[10]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[10]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[10]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[9]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[9]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[9]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[9]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[8]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[8]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[8]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[8]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/RF_instance/clk_gate_REGISTERS_reg[1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
datapath_instance/REG_RF_WR_ADDR_ID/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
datapath_instance/REG_RF_WR_ADDR_ID/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
datapath_instance/REG_RF_WR_ADDR_ID/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
datapath_instance/REG_RF_WR_ADDR_ID/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
datapath_instance/REG_NPC_ID/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
datapath_instance/REG_NPC_ID/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
datapath_instance/REG_NPC_ID/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
datapath_instance/REG_NPC_ID/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
datapath_instance/IR/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
datapath_instance/IR/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
datapath_instance/IR/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
datapath_instance/IR/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
datapath_instance/REG_NPC_IF/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
datapath_instance/REG_NPC_IF/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
datapath_instance/REG_NPC_IF/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
datapath_instance/REG_NPC_IF/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
datapath_instance/BPU_instance/clk_gate_last_prediction_reg_0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
datapath_instance/BPU_instance/clk_gate_last_prediction_reg_0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
datapath_instance/BPU_instance/clk_gate_last_prediction_reg_0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
datapath_instance/BPU_instance/clk_gate_last_prediction_reg_0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
datapath_instance/BPU_instance/clk_gate_last_prediction_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
datapath_instance/BPU_instance/clk_gate_last_prediction_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
datapath_instance/BPU_instance/clk_gate_last_prediction_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
datapath_instance/BPU_instance/clk_gate_last_prediction_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
datapath_instance/BPU_instance/clk_gate_verify_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
datapath_instance/BPU_instance/clk_gate_verify_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
datapath_instance/BPU_instance/clk_gate_verify_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
datapath_instance/BPU_instance/clk_gate_verify_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][3][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][3][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][3][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][3][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][3][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][3][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][3][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][3][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][3][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][3][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][3][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][3][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][2][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][2][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][2][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][2][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][2][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][2][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][2][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][2][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][2][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][2][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][2][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][2][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][1][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][1][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][1][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][1][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][1][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][1][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][1][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][1][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][1][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][1][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][1][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][1][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][0][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][0][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][0][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][0][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][0][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][0][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][0][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][0][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][0][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][0][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][0][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[7][0][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][3][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][3][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][3][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][3][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][3][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][3][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][3][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][3][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][3][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][3][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][3][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][3][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][2][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][2][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][2][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][2][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][2][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][2][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][2][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][2][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][2][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][2][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][2][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][2][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][1][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][1][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][1][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][1][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][1][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][1][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][1][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][1][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][1][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][1][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][1][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][1][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][0][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][0][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][0][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][0][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][0][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][0][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][0][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][0][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][0][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][0][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][0][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[6][0][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][3][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][3][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][3][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][3][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][3][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][3][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][3][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][3][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][3][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][3][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][3][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][3][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][2][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][2][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][2][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][2][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][2][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][2][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][2][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][2][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][2][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][2][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][2][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][2][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][1][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][1][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][1][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][1][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][1][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][1][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][1][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][1][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][1][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][1][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][1][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][1][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][0][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][0][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][0][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][0][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][0][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][0][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][0][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][0][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][0][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][0][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][0][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[5][0][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][3][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][3][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][3][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][3][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][3][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][3][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][3][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][3][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][3][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][3][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][3][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][3][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][2][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][2][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][2][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][2][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][2][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][2][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][2][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][2][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][2][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][2][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][2][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][2][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][1][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][1][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][1][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][1][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][1][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][1][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][1][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][1][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][1][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][1][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][1][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][1][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][0][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][0][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][0][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][0][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][0][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][0][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][0][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][0][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][0][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][0][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][0][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[4][0][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][3][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][3][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][3][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][3][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][3][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][3][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][3][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][3][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][3][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][3][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][3][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][3][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][2][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][2][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][2][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][2][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][2][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][2][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][2][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][2][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][2][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][2][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][2][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][2][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][1][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][1][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][1][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][1][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][1][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][1][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][1][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][1][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][1][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][1][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][1][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][1][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][0][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][0][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][0][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][0][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][0][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][0][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][0][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][0][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][0][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][0][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][0][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[3][0][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][3][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][3][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][3][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][3][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][3][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][3][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][3][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][3][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][3][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][3][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][3][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][3][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][2][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][2][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][2][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][2][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][2][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][2][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][2][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][2][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][2][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][2][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][2][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][2][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][1][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][1][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][1][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][1][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][1][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][1][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][1][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][1][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][1][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][1][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][1][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][1][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][0][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][0][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][0][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][0][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][0][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][0][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][0][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][0][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][0][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][0][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][0][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[2][0][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][3][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][3][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][3][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][3][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][3][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][3][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][3][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][3][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][3][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][3][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][3][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][3][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][2][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][2][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][2][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][2][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][2][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][2][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][2][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][2][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][2][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][2][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][2][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][2][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][1][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][1][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][1][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][1][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][1][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][1][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][1][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][1][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][1][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][1][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][1][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][1][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][0][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][0][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][0][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][0][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][0][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][0][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][0][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][0][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][0][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][0][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][0][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[1][0][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][3][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][3][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][3][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][3][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][3][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][3][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][3][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][3][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][3][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][3][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][3][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][3][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][2][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][2][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][2][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][2][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][2][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][2][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][2][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][2][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][2][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][2][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][2][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][2][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][1][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][1][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][1][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][1][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][1][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][1][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][1][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][1][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][1][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][1][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][1][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][1][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][0][YOUTH]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][0][YOUTH]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][0][YOUTH]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][0][YOUTH]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][0][DATA]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][0][DATA]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][0][DATA]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][0][DATA]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][0][TAG]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][0][TAG]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][0][TAG]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{datapath_instance/BPU_instance/clk_gate_cache_reg[0][0][TAG]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
datapath_instance/PC/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
datapath_instance/PC/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
datapath_instance/PC/clk_gate_Q_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
datapath_instance/PC/clk_gate_Q_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
HDU_instance/clk_gate_count_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
HDU_instance/clk_gate_count_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
HDU_instance/clk_gate_count_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
HDU_instance/clk_gate_count_reg/main_gate]

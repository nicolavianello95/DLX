library ieee;
use ieee.std_logic_1164.all;
use work.DLX_package.all;		--for get_opcode and constants

package FU_and_HDU_package is

	--FU package
	type FU_OUTS_type is record
		MUX_RF_OUT1_sel				: std_logic_vector(2 downto 0);
		MUX_RF_OUT2_sel				: std_logic_vector(2 downto 0);
		MUX_DRAM_IN_sel				: std_logic;
	end record FU_OUTS_type;

	constant RF_forward_NO			: std_logic_vector(2 downto 0):= "000";
	constant RF_forward_EXE_ALU		: std_logic_vector(2 downto 0):= "001";
	constant RF_forward_MEM_ALU		: std_logic_vector(2 downto 0):= "010";
	constant RF_forward_MEM_DRAM	: std_logic_vector(2 downto 0):= "011";
	constant RF_forward_WB			: std_logic_vector(2 downto 0):= "100";
	constant RF_forward_MEM_NPC		: std_logic_vector(2 downto 0):= "101";
	constant RF_forward_EXE_NPC		: std_logic_vector(2 downto 0):= "110";
	constant DRAM_forward_NO		: std_logic:= '0';
	constant DRAM_forward_WB		: std_logic:= '1';

	function is_not_a_jump (INSTR: word) return boolean;
	function is_not_a_jump_imm (INSTR: word) return boolean;
	function is_not_a_store (INSTR: word) return boolean;
	function is_a_load (INSTR: word) return boolean;
	function is_a_subroutine_call (INSTR: word) return boolean;
	function is_a_mult (INSTR: word) return boolean;

	--HDU package
	type HDU_OUTS_type is record
		PC_EN	: std_logic;
		IF_EN	: std_logic;
		ID_EN	: std_logic;
		EXE_EN	: std_logic;
		MEM_EN	: std_logic;
		WB_EN	: std_logic;
		ID_bubble: std_logic;
		EXE_bubble: std_logic;
		MEM_bubble: std_logic;
		WB_bubble: std_logic;
	end record HDU_OUTS_type;

end package FU_and_HDU_package;

package body FU_and_HDU_package is

	function is_not_a_jump(instr: word) return boolean is
		variable opcode: OPCODE_type;
	begin
		opcode:=get_opcode(instr);
		return opcode/=OPCODE_BEQZ and opcode/=OPCODE_BNEZ and opcode/=OPCODE_JAL and opcode/=OPCODE_J and opcode/=OPCODE_JR and opcode/=OPCODE_JALR;
	end function is_not_a_jump;
	
	function is_not_a_jump_imm(instr: word) return boolean is
		variable opcode: OPCODE_type;
	begin
		opcode:=get_opcode(instr);
		return opcode/=OPCODE_JAL and opcode/=OPCODE_J;
	end function is_not_a_jump_imm;
	
	function is_not_a_store (INSTR: word) return boolean is
	begin
		return get_opcode(INSTR)/=OPCODE_SW and get_opcode(INSTR)/=OPCODE_SH and get_opcode(INSTR)/=OPCODE_SB;
	end function is_not_a_store;
	
	function is_a_load (INSTR: word) return boolean is
		variable OPCODE: OPCODE_type;
	begin
		OPCODE:=get_opcode(INSTR);
		return OPCODE=OPCODE_LW or OPCODE=OPCODE_LH or OPCODE=OPCODE_LHU or OPCODE=OPCODE_LB or OPCODE=OPCODE_LBU or OPCODE=OPCODE_LHI;
	end function is_a_load;
	
	function is_a_subroutine_call (INSTR: word) return boolean is
	begin
		return get_opcode(INSTR)=OPCODE_JAL or get_opcode(INSTR)=OPCODE_JALR;
	end function is_a_subroutine_call;

	function is_a_mult (INSTR: word) return boolean is
	begin
		return (get_opcode(INSTR)=OPCODE_RTYPE and get_func(INSTR)=FUNC_MULT) or get_opcode(INSTR)=OPCODE_MULTI;
	end function is_a_mult;

end package body FU_and_HDU_package;
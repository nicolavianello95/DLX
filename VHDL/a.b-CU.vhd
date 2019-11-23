library ieee;
use ieee.std_logic_1164.all;
use work.DLX_package.all;		--for word type, OPCODE_type, FUNC_type and constants
use work.ALU_package.all;		--for ALU_OP_type
use work.CU_package.all;		--for CU_OUTS_type and constants

entity CU is
	port(
		INSTR_ID	: in word;					--instruction register output
		CU_OUTS		: out CU_outs_type			--CU outs to datapath
	);
end entity CU;

architecture behavioral of CU is

	constant LUT_RTYPE: LUT_RTYPE_type :=(
		FUNC_type'pos(FUNC_ADD)		=>	ADD_outs,
		FUNC_type'pos(FUNC_ADDU)	=>	ADDU_outs,
		FUNC_type'pos(FUNC_AND)		=>	AND_outs,
		FUNC_type'pos(FUNC_OR)		=>	OR_outs,
		FUNC_type'pos(FUNC_SGE)		=>	SGE_outs,
		FUNC_type'pos(FUNC_SLE)		=>	SLE_outs,
		FUNC_type'pos(FUNC_SLL)		=>	SLL_outs,
		FUNC_type'pos(FUNC_SNE)		=>	SNE_outs,
		FUNC_type'pos(FUNC_SRL)		=>	SRL_outs,
		FUNC_type'pos(FUNC_SUB)		=>	SUB_outs,
		FUNC_type'pos(FUNC_SUBU)	=>	SUBU_outs,
		FUNC_type'pos(FUNC_XOR)		=>	XOR_outs,
		FUNC_type'pos(FUNC_SGEU)	=>	SGEU_outs,
		FUNC_type'pos(FUNC_SGT)		=>	SGT_outs,
		FUNC_type'pos(FUNC_SGTU)	=>	SGTU_outs,
		FUNC_type'pos(FUNC_SLEU)	=>	SLEU_outs,
		FUNC_type'pos(FUNC_SLT)		=>	SLT_outs,
		FUNC_type'pos(FUNC_SLTU)	=>	SLTU_outs,
		FUNC_type'pos(FUNC_SRA)		=>	SRA_outs,
		FUNC_type'pos(FUNC_SEQ)		=>	SEQ_outs,
		FUNC_type'pos(FUNC_ROR)		=>	ROR_outs,
		FUNC_type'pos(FUNC_ROL)		=>	ROL_outs,
		FUNC_type'pos(FUNC_MULT)	=>	MULT_outs,
		others	=> NOP_outs
	);
	
	constant LUT_ITYPE: LUT_ITYPE_type :=(
		OPCODE_type'pos(OPCODE_NOP)		=>	NOP_outs,
		OPCODE_type'pos(OPCODE_ADDI)	=>	ADDI_outs,
		OPCODE_type'pos(OPCODE_ADDUI)	=>	ADDUI_outs,
		OPCODE_type'pos(OPCODE_SUBI)	=>	SUBI_outs,
		OPCODE_type'pos(OPCODE_SUBUI)	=>	SUBUI_outs,
		OPCODE_type'pos(OPCODE_ANDI)	=>	ANDI_outs,
		OPCODE_type'pos(OPCODE_ORI)		=>	ORI_outs,
		OPCODE_type'pos(OPCODE_XORI)	=>	XORI_outs,
		OPCODE_type'pos(OPCODE_SGEI)	=>	SGEI_outs,
		OPCODE_type'pos(OPCODE_SGEUI)	=>	SGEUI_outs,
		OPCODE_type'pos(OPCODE_SGTI)	=>	SGTI_outs,
		OPCODE_type'pos(OPCODE_SGTUI)	=>	SGTUI_outs,
		OPCODE_type'pos(OPCODE_SLEI)	=>	SLEI_outs,
		OPCODE_type'pos(OPCODE_SLEUI)	=>	SLEUI_outs,
		OPCODE_type'pos(OPCODE_SLTI)	=>	SLTI_outs,
		OPCODE_type'pos(OPCODE_SLTUI)	=>	SLTUI_outs,
		OPCODE_type'pos(OPCODE_SLLI)	=>	SLLI_outs,
		OPCODE_type'pos(OPCODE_SRLI)	=>	SRLI_outs,
		OPCODE_type'pos(OPCODE_SRAI)	=>	SRAI_outs,
		OPCODE_type'pos(OPCODE_SNEI)	=>	SNEI_outs,
		OPCODE_type'pos(OPCODE_SEQI)	=>	SEQI_outs,
		OPCODE_type'pos(OPCODE_J)		=>	J_outs,
		OPCODE_type'pos(OPCODE_JR)		=>	JR_outs,
		OPCODE_type'pos(OPCODE_JAL)		=>	JAL_outs,
		OPCODE_type'pos(OPCODE_JALR)	=>	JAL_outs,
		OPCODE_type'pos(OPCODE_BEQZ)	=>	BEQZ_outs,
		OPCODE_type'pos(OPCODE_BNEZ)	=>	BNEZ_outs,
		OPCODE_type'pos(OPCODE_LW)		=>	LW_outs,
		OPCODE_type'pos(OPCODE_LH)		=>	LH_outs,
		OPCODE_type'pos(OPCODE_LHU)		=>	LHU_outs,
		OPCODE_type'pos(OPCODE_LB)		=>	LB_outs,
		OPCODE_type'pos(OPCODE_LBU)		=>	LBU_outs,
		OPCODE_type'pos(OPCODE_SW)		=>	SW_outs,
		OPCODE_type'pos(OPCODE_SH)		=>	SH_outs,
		OPCODE_type'pos(OPCODE_SB)		=>	SB_outs,
		OPCODE_type'pos(OPCODE_ROLI)	=>	ROLI_outs,
		OPCODE_type'pos(OPCODE_RORI)	=>	RORI_outs,
		OPCODE_type'pos(OPCODE_MULTI)	=>	MULTI_outs,
		others	=> NOP_outs
	);

	signal OPCODE: OPCODE_type;
	signal FUNC: FUNC_type;

begin

	OPCODE<=get_opcode(INSTR_ID);
	FUNC<=get_func(INSTR_ID);

	CU_OUTS <=	LUT_RTYPE(to_integer(FUNC)) when OPCODE=OPCODE_RTYPE else
				LUT_ITYPE(to_integer(OPCODE));

end architecture behavioral;
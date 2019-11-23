library ieee;
use ieee.std_logic_1164.all;
use work.ALU_package.all;		--for ALU_OP_type
use work.datapath_package.all;	--for BRANCH_COND_type
use work.DLX_package.all;		--for FUNC_SIZE, OPCODE_SIZE and constants
use work.DRAM_package.all;		--for DRAM_WR_EN_type

package CU_package is

	type CU_OUTS_ID_type is record
		-- ID outputs		
		MUX_BRANCH_sel: std_logic;					--select whether the jump offset is taken from the immediate value or from a register
		MUX_IMM_EXT_sel		: std_logic;					--extend from 16 bit or from 26 bit
		MUX_RF_WR_ADDR_sel	: std_logic_vector(1 downto 0);	--select whether the RF write address is taken from bits 20-16 or from bits 15-11 of the instruction register out, or whether it is 31 
		BRANCH_COND			: BRANCH_COND_type;				--branch condition
	end record CU_OUTS_ID_type;

	type CU_OUTS_EXE_type is record
		-- EX outputs		
		MULT_EN				: std_logic;
		MUX_MULT_sel		: std_logic;		--select whether the output is taken from the alu or from the multiplier
		MUX_ALU_IN2_sel		: std_logic;		--select whether the second operand is B or IMM
		ALU_OP				: ALU_OP_type;		--ALU operation selector
	end record CU_OUTS_EXE_type;

	type CU_OUTS_MEM_type is record
		-- MEM outputs					
		DRAM_WR_EN			: DRAM_WR_EN_type;				--data RAM write enable
		MUX_DRAM_OUT_EXT_sel: std_logic_vector(2 downto 0);	--select size and type of extension of data out from DRAM
	end record CU_OUTS_MEM_type;

	type CU_OUTS_WB_type is record
		-- WB outputs					
		MUX_WB_SEL			: std_logic_vector(1 downto 0);	--write back MUX sel
		RF_WR_EN			: std_logic;					--register file write enable 
	end record CU_OUTS_WB_type;

	type CU_OUTS_type is record	
		ID	: CU_OUTS_ID_type;
		EXE	: CU_OUTS_EXE_type;			
		MEM	: CU_OUTS_MEM_type;
		WB	: CU_OUTS_WB_type;
	end record CU_OUTS_type;

	type LUT_RTYPE_type is array (0 to N_RTYPE-1) of CU_OUTS_type;
	type LUT_ITYPE_type is array (1 to N_ITYPE-1) of CU_OUTS_type;	--start from 1 because if OPCODE=0 the instruction is R-type	
	
	--ID outputs constants
	constant BRANCH_REG		: std_logic:= '0';
	constant BRANCH_IMM		: std_logic:= '1';
	constant IMM_EXT_16		: std_logic:= '0';
	constant IMM_EXT_26		: std_logic:= '1';
	constant RF_WR_2ND		: std_logic_vector:= "00";
	constant RF_WR_3TH		: std_logic_vector:= "01";
	constant RF_WR_31		: std_logic_vector:= "10";
	--EX outputs constants
	constant MULT_OFF		: std_logic:= '0';
	constant MULT_ON		: std_logic:= '1';
	constant OUT_ALU		: std_logic:= '0';
	constant OUT_MULT		: std_logic:= '1';
	constant ALU_IN1_PC_4	: std_logic:= '0';
	constant ALU_IN1_RF		: std_logic:= '1';
	constant ALU_IN2_RF		: std_logic:= '0';
	constant ALU_IN2_IMM	: std_logic:= '1';
	--MEM outputs
	constant EXT_SB			: std_logic_vector:= "000";
	constant EXT_UB			: std_logic_vector:= "001";
	constant EXT_SH			: std_logic_vector:= "010";
	constant EXT_UH			: std_logic_vector:= "011";
	constant EXT_W			: std_logic_vector:= "100";
	--WB outputs	
	constant WB_NPC			: std_logic_vector:= "00";
	constant WB_LMD			: std_logic_vector:= "01";
	constant WB_ALU			: std_logic_vector:= "10";
	constant RF_WR_OFF		: std_logic:= '0';
	constant RF_WR_ON		: std_logic:= '1';
	
	--										ID																	EXE														MEM										WB
	--										MUX_BRANCH_sel	MUX_IMM_EXT_sel	MUX_RF_WR_ADDR_sel	BRANCH_COND		MULT_EN		MUX_MULT	MUX_ALU_IN2_sel	ALU_OP			DRAM_WR_EN		MUX_DRAM_OUT_EXT_sel	MUX_WB_SEL	RF_WR_EN
	--R-type instruction outs				                                            
	constant NOP_outs	:CU_OUTS_type:=(	('-',			'-',			"--",				BRANCH_NO),		(MULT_OFF,	'-',		'-',			ALU_DONT_CARE),	(DRAM_WR_OFF,	"---"),					("--",		RF_WR_OFF	));
	constant ADD_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_ADD),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant ADDU_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_ADD),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SUB_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_SUB),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SUBU_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_SUB),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant AND_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_AND),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant OR_outs 	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_OR),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant XOR_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_XOR),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SGE_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_SGE),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SGEU_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_SGEU),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SGT_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_SGT),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SGTU_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_SGTU),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SLE_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_SLE),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SLEU_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_SLEU),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SLT_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_SLT),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SLTU_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_SLTU),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SLL_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_SLL),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SRL_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_SRL),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SRA_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_SRA),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant ROR_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_ROR),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant ROL_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_ROL),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SNE_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_SNE),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SEQ_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_RF,		ALU_SEQ),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));	
	constant MULT_outs	:CU_OUTS_type:=(	('-',			'-',			RF_WR_3TH,			BRANCH_NO),		(MULT_ON,	OUT_MULT,	ALU_IN2_RF,		ALU_DONT_CARE),	(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	--I-type instruction outs				                                                                     						                                                                          
	constant ADDI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_ADD),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant ADDUI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_ADD),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SUBI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_SUB),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SUBUI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_SUB),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant ANDI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_AND),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant ORI_outs 	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_OR),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant XORI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_XOR),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SGEI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_SGE),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SGEUI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_SGEU),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SGTI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_SGT),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SGTUI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_SGTU),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SLEI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_SLE),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SLEUI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_SLEU),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SLTI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_SLT),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SLTUI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_SLTU),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SLLI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_SLL),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SRLI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_SRL),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SRAI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_SRA),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant ROLI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_ROR),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant RORI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_ROL),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SNEI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_SNE),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant SEQI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_SEQ),		(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	constant MULTI_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_ON,	OUT_MULT,	ALU_IN2_IMM,	ALU_DONT_CARE),	(DRAM_WR_OFF,	"---"),					(WB_ALU,	RF_WR_ON	));
	--jump and DRAM instruction outs		                                                                     						                                                                          
	constant J_outs		:CU_OUTS_type:=(	(BRANCH_IMM,	IMM_EXT_26,		"--",				BRANCH_ALWAYS),	(MULT_OFF,	'-',		'-',			ALU_DONT_CARE),	(DRAM_WR_OFF,	"---"),					("--",		RF_WR_OFF	));
	constant JR_outs	:CU_OUTS_type:=(	(BRANCH_REG,	'-',			"--",				BRANCH_ALWAYS),	(MULT_OFF,	'-',		'-',			ALU_DONT_CARE),	(DRAM_WR_OFF,	"---"),					("--",		RF_WR_OFF	));
	constant JAL_outs	:CU_OUTS_type:=(	(BRANCH_IMM,	IMM_EXT_26,		RF_WR_31,			BRANCH_ALWAYS),	(MULT_OFF,	'-',		'-',			ALU_DONT_CARE),	(DRAM_WR_OFF,	"---"),					(WB_NPC,	RF_WR_ON	));
	constant JALR_outs	:CU_OUTS_type:=(	(BRANCH_REG,	IMM_EXT_26,		RF_WR_31,			BRANCH_ALWAYS),	(MULT_OFF,	'-',		'-',			ALU_DONT_CARE),	(DRAM_WR_OFF,	"---"),					(WB_NPC,	RF_WR_ON	));
	constant BEQZ_outs	:CU_OUTS_type:=(	(BRANCH_IMM,	IMM_EXT_16,		"--",				BRANCH_EQZ),	(MULT_OFF,	'-',		'-',			ALU_DONT_CARE),	(DRAM_WR_OFF,	"---"),					("--",		RF_WR_OFF	));
	constant BNEZ_outs	:CU_OUTS_type:=(	(BRANCH_IMM,	IMM_EXT_16,		"--",				BRANCH_NEZ),	(MULT_OFF,	'-',		'-',			ALU_DONT_CARE),	(DRAM_WR_OFF,	"---"),					("--",		RF_WR_OFF	));
	constant LW_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_ADD),		(DRAM_WR_OFF,	EXT_W),					(WB_LMD,	RF_WR_ON	));
	constant LH_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_ADD),		(DRAM_WR_OFF,	EXT_SH),				(WB_LMD,	RF_WR_ON	));
	constant LHU_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_ADD),		(DRAM_WR_OFF,	EXT_UH),				(WB_LMD,	RF_WR_ON	));
	constant LB_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_ADD),		(DRAM_WR_OFF,	EXT_SB),				(WB_LMD,	RF_WR_ON	));
	constant LBU_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		RF_WR_2ND,			BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_ADD),		(DRAM_WR_OFF,	EXT_UB),				(WB_LMD,	RF_WR_ON	));
	constant SW_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		"--",				BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_ADD),		(DRAM_WR_W,		"---"),					("--",		RF_WR_OFF	));
	constant SH_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		"--",				BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_ADD),		(DRAM_WR_H,		"---"),					("--",		RF_WR_OFF	));
	constant SB_outs	:CU_OUTS_type:=(	('-',			IMM_EXT_16,		"--",				BRANCH_NO),		(MULT_OFF,	OUT_ALU,	ALU_IN2_IMM,	ALU_ADD),		(DRAM_WR_B,		"---"),					("--",		RF_WR_OFF	));

end package CU_package;

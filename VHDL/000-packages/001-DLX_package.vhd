library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package DLX_package is

	constant BYTE_SIZE : integer := 8;
	constant HALFWORD_SIZE : integer := 2*BYTE_SIZE;
	constant WORD_SIZE : integer := 4*BYTE_SIZE;
	constant DOUBLEWORD_SIZE : integer := 8*BYTE_SIZE;
	subtype BYTE_range is integer range BYTE_SIZE-1 downto 0;
	subtype BYTE1_range is integer range 2*BYTE_SIZE-1 downto BYTE_SIZE;
	subtype BYTE2_range is integer range 3*BYTE_SIZE-1 downto 2*BYTE_SIZE;
	subtype BYTE3_range is integer range 4*BYTE_SIZE-1 downto 3*BYTE_SIZE;
	subtype HALFWORD_range is integer range HALFWORD_SIZE-1 downto 0;
	subtype HALFWORD1_range is integer range 2*HALFWORD_SIZE-1 downto HALFWORD_SIZE;
	subtype WORD_range is integer range WORD_SIZE-1 downto 0;
	subtype DOUBLEWORD_range is integer range DOUBLEWORD_SIZE-1 downto 0;
	subtype byte is std_logic_vector(BYTE_range);
	subtype halfword is std_logic_vector(HALFWORD_range);
	subtype word is std_logic_vector(WORD_range);
	subtype doubleword is std_logic_vector(DOUBLEWORD_range);

	constant IF_STAGE	: integer := 0;
	constant ID_STAGE	: integer := 1;
	constant EXE_STAGE	: integer := 2;
	constant MEM_STAGE	: integer := 3;
	constant WB_STAGE	: integer := 4;
	constant N_STAGE 	: integer := 5;

	--all possible R-type instruction
	type FUNC_type is (
		FUNC_00,
		FUNC_01,
		FUNC_02,
		FUNC_03,
		FUNC_SLL,			-- shift left logical
		FUNC_05, 
		FUNC_SRL,			-- shift right logical 
		FUNC_SRA,   		-- shift right arithmetical
		FUNC_ROL,			-- rotate left
		FUNC_ROR,			-- rotate right
		FUNC_0A,
		FUNC_0B,
		FUNC_0C,
		FUNC_0D,
		FUNC_0E,
		FUNC_0F,
		FUNC_10,
		FUNC_11,
		FUNC_12,
		FUNC_13,
		FUNC_14,
		FUNC_15,
		FUNC_16,
		FUNC_17,
		FUNC_18,
		FUNC_19,
		FUNC_1A,
		FUNC_1B,
		FUNC_1C,
		FUNC_1D,
		FUNC_MULT,			-- multiplication (signed)
		FUNC_1F,
		FUNC_ADD,			-- addition	(with overflow trap)
		FUNC_ADDU,			-- addition (without overflow trap)
		FUNC_SUB,			-- subtraction	(with overflow trap)
		FUNC_SUBU,			-- subtruction (without overflow trap)
		FUNC_AND,			-- bitwise and
		FUNC_OR,			-- bitwise or
		FUNC_XOR,			-- bitwise xor
		FUNC_NOT,			-- bitwise not
		FUNC_SEQ,			-- Set if equal to
		FUNC_SNE,			-- Set if not equal to
		FUNC_SLT,   		-- set if less than (signed)
		FUNC_SGT,   		-- set if greather than (signed)
		FUNC_SLE,   		-- set if less than or equal to (signed) 
		FUNC_SGE,			-- set if greater than or equal to
		FUNC_2E,
		FUNC_2F,
		FUNC_MOVI2S,		--NOT IMPLEMENTED
		FUNC_MOVS2I,		--NOT IMPLEMENTED
		FUNC_MOVF,			--NOT IMPLEMENTED
		FUNC_MOVD,			--NOT IMPLEMENTED
		FUNC_MOVFP2I,		--NOT IMPLEMENTED
		FUNC_MOVI2FP,		--NOT IMPLEMENTED
		FUNC_MOVI2T,		--NOT IMPLEMENTED
		FUNC_MOVT2I,		--NOT IMPLEMENTED
		FUNC_38,
		FUNC_39,
		FUNC_SLTU,  		-- set if less than (unsigned)
		FUNC_SGTU,  		-- set if greather than (unsigned)
		FUNC_SLEU,  		-- set if less than or equal to (unsigned)
		FUNC_SGEU,			-- set if greather than or equal to (unsigned)
		FUNC_3E,
		FUNC_3F
	);
	
	--all possible I-type instruction
	type OPCODE_type is (
		OPCODE_RTYPE,		-- if the OPCODE is equal to this the instrution is a R-type
		OPCODE_01,
		OPCODE_J,			-- jump
		OPCODE_JAL,			-- jump and link
		OPCODE_BEQZ,		-- branch if equal to zero
		OPCODE_BNEZ,		-- branch if not equal to zero
		OPCODE_BFPT,		--NOT IMPLEMENTED
		OPCODE_BFPF,
		OPCODE_ADDI,		-- addition immediate (with overflow trap)
		OPCODE_ADDUI,		-- addition immediate (without overflow trap)
		OPCODE_SUBI,		-- subtraction immediate (with overflow trap)
		OPCODE_SUBUI,		-- subtraction immediate (without overflow trap)
		OPCODE_ANDI,		-- bitwise and immediate
		OPCODE_ORI,			-- bitwise or immediate
		OPCODE_XORI,		-- bitwise xor immediate
		OPCODE_LHI,			--NOT IMPLEMENTED
		OPCODE_RFE,			--NOT IMPLEMENTED
		OPCODE_TRAP,		--NOT IMPLEMENTED
		OPCODE_JR,			-- jump register
		OPCODE_JALR,		-- jump and link register
		OPCODE_SLLI,		-- shift left logical immediate
		OPCODE_NOP,			-- no operation
		OPCODE_SRLI,		-- shift right logical immediate
		OPCODE_SRAI,   		-- shift right arithmetical immediate
		OPCODE_SEQI,		-- set if equal to immediate
		OPCODE_SNEI,		-- set if not equal to immediate
		OPCODE_SLTI,   		-- set if less than immediate (signed)
		OPCODE_SGTI,   		-- set if greather than immediate (signed)
		OPCODE_SLEI,		-- set if less than or equal to immediate
		OPCODE_SGEI,		-- set if greather than or equal to immediate
		OPCODE_ROLI,		-- rotate left immediate
		OPCODE_RORI,		-- rotate right immediate
		OPCODE_LB,			-- load byte (signed)
		OPCODE_LH,			-- load halfword (signed)
		OPCODE_22,
		OPCODE_LW,			-- load word
		OPCODE_LBU,			-- load byte (unsigned)
		OPCODE_LHU,			-- load halfword (unsigned)
		OPCODE_LF,			--NOT IMPLEMENTED
		OPCODE_LD,			--NOT IMPLEMENTED
		OPCODE_SB,			-- store byte
		OPCODE_SH,			-- store halfword
		OPCODE_2A,
		OPCODE_SW,			-- store word
		OPCODE_2C,
		OPCODE_2D,
		OPCODE_SF,			--NOT IMPLEMENTED
		OPCODE_SD,			--NOT IMPLEMENTED
		OPCODE_30,
		OPCODE_31,
		OPCODE_32,
		OPCODE_33,
		OPCODE_34,
		OPCODE_35,
		OPCODE_36,
		OPCODE_37,
		OPCODE_ITLB,		--NOT IMPLEMENTED
		OPCODE_39,
		OPCODE_SLTUI,  		-- set if less than immediate (unsigned) 
		OPCODE_SGTUI,  		-- set if greather than immediate (unsigned)
		OPCODE_SLEUI,  		-- set if less than or equal to immediate (unsigned)
		OPCODE_SGEUI,		-- set if greather than or equal to immediate(unsigned)
		OPCODE_MULTI,		-- multiplication immediate
		OPCODE_3F
	);

	subtype OPCODE_range	is integer range 31 downto 26;
	subtype REG1_range		is integer range 25 downto 21;
	subtype REG2_range		is integer range 20 downto 16;
	subtype REG3_range		is integer range 15 downto 11;
	subtype FUNC_range		is integer range 5 downto 0;
	subtype IMM_range		is integer range 15 downto 0;
	subtype J_OFFSET_range	is integer range 25 downto 0;
	
    constant OPCODE_SIZE	: integer := OPCODE_range'high-OPCODE_range'low+1;			--OPCODE field size
	constant RF_ADDR_SIZE	: integer := REG1_range'high-REG1_range'low+1;				--register address field size
    constant FUNC_SIZE		: integer := FUNC_range'high-FUNC_range'low+1;				--FUNC field size
    constant IMM_SIZE		: integer := IMM_range'high-IMM_range'low+1;				--IMM field size
    constant J_OFFSET_SIZE	: integer := J_OFFSET_range'high-J_OFFSET_range'low+1;		--OFFSET field size
	
	constant N_REG			: integer := 2**RF_ADDR_SIZE;

	constant N_RTYPE	: integer := 2**FUNC_SIZE;		--number of possible R-type instructions
	constant N_ITYPE	: integer := 2**OPCODE_SIZE;	--number of possible I-type instructions

	--type conversion functions for FUNC_type
	function to_integer (FUNC: FUNC_type) return natural;
	function to_std_logic_vector (FUNC: FUNC_type) return std_logic_vector;
	function to_func_type (FUNC_N: integer range 0 to N_RTYPE-1) return FUNC_type;
	function to_func_type (FUNC_FIELD: std_logic_vector(FUNC_SIZE-1 downto 0)) return FUNC_type;
	
	--type conversion functions for OPCODE_type
	function to_integer (OPCODE: OPCODE_type) return natural;
	function to_std_logic_vector (OPCODE: OPCODE_type) return std_logic_vector;
	function to_opcode_type	(OPCODE_N: integer range 0 to N_ITYPE-1) return OPCODE_type;
	function to_opcode_type (OPCODE_FIELD: std_logic_vector(OPCODE_SIZE-1 downto 0)) return OPCODE_type;

	--function to get directly opcode, func or registers number from an instruction
	function get_opcode (INSTR: word) return OPCODE_type;
	function get_func (INSTR: word) return FUNC_type;
	function get_Rs1 (INSTR: word) return natural;
	function get_Rs2 (INSTR: word) return natural;
	function get_Rd (INSTR: word) return natural;

	--instruction encoding functions
	function INSTR_RTYPE (FUNC: FUNC_type; RS1,RS2,RD: integer range 0 to N_REG) return word;
	function INSTR_ITYPE (OPCODE: OPCODE_type; RS, RD: integer range 0 to N_REG; IMM: integer range -2**(IMM_SIZE-1) to 2**(IMM_SIZE-1)-1) return word;
	function INSTR_JTYPE (OPCODE: OPCODE_type; OFFSET: integer range -2**(J_OFFSET_SIZE-1) to 2**(J_OFFSET_SIZE-1)-1) return word;

end package DLX_package;

package body DLX_package is

	function to_integer (FUNC: FUNC_type) return natural is
	begin
		return FUNC_type'pos(FUNC);
	end function to_integer;
	
	function to_std_logic_vector (FUNC: FUNC_type) return std_logic_vector is
	begin
		return std_logic_vector(to_unsigned(to_integer(FUNC), FUNC_SIZE));
	end function to_std_logic_vector;
	
	function to_func_type (FUNC_N: integer range 0 to N_RTYPE-1) return FUNC_type is
	begin
			return FUNC_type'val(FUNC_N);
	end function to_func_type;
		
	function to_func_type (FUNC_FIELD: std_logic_vector(FUNC_SIZE-1 downto 0)) return FUNC_type is
	begin
		return to_func_type(to_integer(unsigned(FUNC_FIELD)));
	end function to_func_type;
		
	function to_integer (OPCODE: OPCODE_type) return natural is
	begin
		return OPCODE_type'pos(OPCODE);
	end function to_integer;	
	
	function to_std_logic_vector (OPCODE: OPCODE_type) return std_logic_vector is
	begin
		return std_logic_vector(to_unsigned(to_integer(OPCODE), OPCODE_SIZE));
	end function to_std_logic_vector;
	
	function to_opcode_type (OPCODE_N: integer range 0 to N_ITYPE-1) return OPCODE_type is
	begin
			return OPCODE_type'val(OPCODE_N);
	end function to_opcode_type;	
		
	function to_opcode_type (OPCODE_FIELD: std_logic_vector(OPCODE_SIZE-1 downto 0)) return OPCODE_type is
	begin
		return to_opcode_type(to_integer(unsigned(OPCODE_FIELD)));
	end function to_opcode_type;

	function get_opcode (INSTR: word) return OPCODE_type is
	begin
		return to_opcode_type(INSTR(OPCODE_range));
	end function get_opcode;
	
	function get_func (INSTR: word) return FUNC_type is
	begin
		return to_func_type(INSTR(FUNC_range));
	end function get_func;

	function get_Rs1 (INSTR: word) return natural is
	begin
		return to_integer(unsigned(INSTR(REG1_range)));
	end function get_Rs1;
	
	function get_Rs2 (INSTR: word) return natural is
	begin
		return to_integer(unsigned(INSTR(REG2_range)));
	end function get_Rs2;
	
	function get_Rd (INSTR: word) return natural is
	begin
		if get_opcode(INSTR)=OPCODE_RTYPE then
			return to_integer(unsigned(INSTR(REG3_range)));
		else
			return to_integer(unsigned(INSTR(REG2_range)));
		end if;
	end function get_Rd;

	function INSTR_RTYPE (FUNC: FUNC_type; RS1,RS2,RD: integer range 0 to N_REG) return word is
	begin
		return to_std_logic_vector(OPCODE_RTYPE) & std_logic_vector(to_unsigned(RS1,RF_ADDR_SIZE)) & std_logic_vector(to_unsigned(RS2,RF_ADDR_SIZE)) & std_logic_vector(to_unsigned(RD,RF_ADDR_SIZE)) & "00000" & to_std_logic_vector(FUNC);
	end function INSTR_RTYPE;

	function INSTR_ITYPE (OPCODE: OPCODE_type; RS, RD: integer range 0 to N_REG; IMM: integer range -2**(IMM_SIZE-1) to 2**(IMM_SIZE-1)-1) return word is
	begin
		return to_std_logic_vector(OPCODE) & std_logic_vector(to_unsigned(RS,RF_ADDR_SIZE)) & std_logic_vector(to_unsigned(RD,RF_ADDR_SIZE)) & std_logic_vector(to_signed(IMM,IMM_SIZE));
	end function INSTR_ITYPE;
	
	function INSTR_JTYPE (OPCODE: OPCODE_type; OFFSET: integer range -2**(J_OFFSET_SIZE-1) to 2**(J_OFFSET_SIZE-1)-1) return word is
	begin
		return to_std_logic_vector(OPCODE) & std_logic_vector(to_signed(OFFSET,J_OFFSET_SIZE));			
	end function INSTR_JTYPE;

end package body DLX_package;

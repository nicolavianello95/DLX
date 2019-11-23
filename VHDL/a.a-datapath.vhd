library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.datapath_package.all;	--for BRANCH_COND_type and constants
use work.CU_package.all;		--for control_from_CU_type
use work.ALU_package.all;		--for ALU_OP_type
use work.DLX_package.all;		--for word type and constants
use work.my_package.all;		--for log2_ceiling
use work.FU_and_HDU_package.all;		--for FU_outs_type and HDU_outs_type

entity datapath is
	generic(
		BPU_TAG_FIELD_SIZE	: integer :=8;
		BPU_SET_FIELD_SIZE	: integer :=3;
		BPU_LINES_PER_SET	: integer :=4
	);
	port(
		IRAM_ADDR		: out	word;
		IRAM_OUT		: in	word;
		DRAM_ADDR		: out	word;
		DRAM_IN			: out	word;
		DRAM_OUT		: in	word;
		control_from_CU	: in	CU_OUTS_type;
		control_from_FU : in	FU_OUTS_type;
		control_from_HDU: in	HDU_OUTS_type;
		misprediction	: out	std_logic;
		CLK				: in	std_logic;
		RST				: in	std_logic
	);
end entity datapath;

architecture structural of datapath is

	component reg is
		Generic (N : positive:= 1 );								--number of bits
		Port(	D		: In	std_logic_vector(N-1 downto 0);		--data input
				Q		: Out	std_logic_vector(N-1 downto 0);		--data output
				EN		: In 	std_logic;							--enable active high
				CLK		: In	std_logic;							--clock
				RST		: In	std_logic);							--asynchronous reset active low
	end component reg;

	component RCA is 
		generic (N:  integer := 8);							--number of bits
		port (	A:	In	std_logic_vector(N-1 downto 0); 	--data input 1
				B:	In	std_logic_vector(N-1 downto 0);		--data input 2
				Ci:	In	std_logic;							--carry in
				S:	Out	std_logic_vector(N-1 downto 0);		--data output
				Co:	Out	std_logic);							--carry out
	end component RCA; 

	component  ADDER_P4 is
		GENERIC (N_BIT	: integer := 32);	--number of bits. Must be a number from 4 to 32 and a multiple of 4
		PORT   (A		: in  std_logic_vector(N_BIT - 1 downto 0);		-- input operand 1
				B		: in  std_logic_vector(N_BIT - 1 downto 0);		-- input operand 2
				add_sub	: in  std_logic;								-- carry-in
				Cout	: out std_logic;								-- carry-out
				SUM		: out std_logic_vector(N_BIT -1 downto 0));		-- ouput sum
	end component ADDER_P4;

	component RF is
		generic(N_bit:		positive := 64;		--bitwidth
				N_reg:		positive := 32);	--number of address bits, the number of registers is equal to 2**N_address
		port(	CLK: 		IN std_logic;		--clock
				RST: 		IN std_logic;		--asynchronous reset, active low
				WR_EN: 		IN std_logic;		--synchronous write, active high
				ADD_WR: 	IN std_logic_vector(log2_ceiling(N_reg)-1 downto 0);	--writing register address 
				ADD_RD1: 	IN std_logic_vector(log2_ceiling(N_reg)-1 downto 0);	--reading register address 1
				ADD_RD2: 	IN std_logic_vector(log2_ceiling(N_reg)-1 downto 0);	--reading register address 2
				DATA_IN: 	IN std_logic_vector(N_bit-1 downto 0);		--data to write
				OUT1: 		OUT std_logic_vector(N_bit-1 downto 0);		--data to read 1
				OUT2: 		OUT std_logic_vector(N_bit-1 downto 0));	--data to read 2
	end component RF;

	component MUX_2to1 is
		Generic (N: integer:= 1);								--number of bits
		Port (	IN0:	In	std_logic_vector(N-1 downto 0);		--data input 1
				IN1:	In	std_logic_vector(N-1 downto 0);		--data input 2
				SEL:	In	std_logic;							--selection input
				Y:		Out	std_logic_vector(N-1 downto 0));	--data output
	end component MUX_2to1;
	
	component MUX_4to1 is
	Generic (N: integer:= 1);	--number of bits
	Port (	IN0, IN1, IN2, IN3	: In	std_logic_vector(N-1 downto 0);		--data inputs
			SEL					: In	std_logic_vector(1 downto 0);		--selection input
			Y					: Out	std_logic_vector(N-1 downto 0));	--data output
	end component MUX_4to1;

	component MUX_8to1 is
		Generic (N: integer:= 1);	--number of bits
		Port (	IN0, IN1, IN2, IN3, IN4, IN5, IN6, IN7	: In	std_logic_vector(N-1 downto 0);		--data inputs
				SEL					: In	std_logic_vector(2 downto 0);		--selection input
				Y					: Out	std_logic_vector(N-1 downto 0));	--data output
	end component MUX_8to1;

	component ALU is
		generic (N : integer := 32);										-- number of bit
		port(	FUNC			: IN ALU_OP_type;							-- operation to do
				DATA1, DATA2	: IN std_logic_vector(N-1 downto 0);		-- data inputs
				OUT_ALU			: OUT std_logic_vector(N-1 downto 0));		-- data output
	end component ALU;

	component boothmul_4stage is
		generic(N: positive :=8);							--number of input bits
		port(
			A, B: in std_logic_vector(N-1 downto 0);		--input operands
			EN: in std_logic;
			CLK: in std_logic;							--clock signal
			RST: in std_logic;							-- reset signal
			P: out std_logic_vector(2*N-1 downto 0)		--output product
		);
	end component boothmul_4stage;

	component branch_comp
		generic(N: integer:= 32);	--number of data-in bits
		port(
			BRANCH_COND		: in BRANCH_COND_type;					--condition to take branch
			DATA_IN			: in std_logic_vector(N-1 downto 0);	--data to test
			BRANCH_IS_TAKEN	: out std_logic);						--high if the branch is taken
	end component branch_comp;

	component BPU is
		generic(
			TAG_FIELD_SIZE	: integer := 8;
			SET_FIELD_SIZE	: integer := 3;	
			LINES_PER_SET 	: integer := 4
		);
		port(		
			clk				: in std_logic;				
			rst				: in std_logic;				
			instr_fetch		: in word;	
			pc_fetch		: in word;	
			pc_in			: in word;	
			pc_out			: out word;
			misprediction	: out std_logic;
			actual_addr		: in word;
			IF_EN			: in std_logic;
			ID_EN			: in std_logic
		);
	end component BPU;

	signal PC_IN, PC_OUT, ADDER_BRANCH_out, NPC_BRANCH, NPC, NPC_ID, NPC_EXE, NPC_MEM, NPC_WB, actual_addr	: word;
	signal IR_in, IR_out, IR_out_ext16, IR_out_ext26														: word;
	signal IMM_ID, IMM_EXE																					: word;
	signal RF_WR_ADDR_ID, RF_WR_ADDR_EXE, RF_WR_ADDR_MEM, RF_WR_ADDR_WB										: RF_addr;
	signal RF_OUT1, RF_OUT1_fw, RF_OUT2, RF_OUT2_fw, RF_OUT2_EXE											: word;
	signal ALU_IN1, ALU_IN2, ALU_OUT, ALU_OUT_EXE, ALU_OUT_MEM, ALU_OUT_WB									: word;
	signal MULT_OUT																							: doubleword;
	signal branch_is_taken																					: std_logic;
	signal LMD_in, LMD_out																					: word;
	signal DRAM_IN_EXE, DRAM_IN_MEM, DRAM_OUT_sb, DRAM_OUT_ub, DRAM_OUT_sh, DRAM_OUT_uh, DRAM_OUT_w			: word;
	signal RF_DATA_IN																						: word;

	constant word_4: word:= std_logic_vector(to_unsigned(4,WORD_SIZE));

begin

	-------------------------------------IF stage
	
	IRAM_ADDR<=PC_out;
	IR_in<=IRAM_OUT;
	
	PC: reg
		generic map(N=>WORD_SIZE)
		port map(
			D=>PC_IN,
			Q=>PC_OUT,
			EN=>control_from_HDU.PC_EN,
			CLK=>clk,
			RST=>rst
		);

	ADDER_PC: RCA
		generic map(N=>WORD_SIZE)
		port map(
			A=>PC_out,
			B=>word_4,
			S=>NPC,
			Ci=>'0',
			Co=>open
		);	
			
	BPU_instance: BPU
		generic map(
			TAG_FIELD_SIZE=>BPU_TAG_FIELD_SIZE,
			SET_FIELD_SIZE=>BPU_SET_FIELD_SIZE,
			LINES_PER_SET=>BPU_LINES_PER_SET
		)
		port map(
			clk=>clk,
			rst=>rst,
			instr_fetch=>IR_in,
			pc_fetch=>PC_OUT,
			pc_in=>NPC,
			pc_out=>PC_IN,
			misprediction=>misprediction,
			actual_addr=>actual_addr,
			IF_EN=>control_from_HDU.IF_EN,
			ID_EN=>control_from_HDU.ID_EN
		);
			
	REG_NPC_IF: reg
		generic map(N=>WORD_SIZE)
		port map(
			D=>NPC,
			Q=>NPC_ID,
			EN=>control_from_HDU.IF_EN,
			CLK=>clk,
			RST=>rst
		);
			
	IR: reg
		generic map(N=>WORD_SIZE)
		port map(
			D=>IR_in,
			Q=>IR_out,
			EN=>control_from_HDU.IF_EN,
			CLK=>clk,
			RST=>rst
		);
			
	-------------------------------------------------ID stage
	
	MUX_BRANCH: MUX_2to1
		generic map(N=>WORD_SIZE)
		port map(
			IN0=>RF_OUT1_fw,
			IN1=>ADDER_BRANCH_out,
			SEL=>control_from_CU.ID.MUX_BRANCH_sel,
			Y=>NPC_BRANCH
		);
	
	ADDER_BRANCH: ADDER_P4
		generic map(N_BIT=>WORD_SIZE)
		port map(
			A=>NPC_ID,
			B=>IMM_ID,
			add_sub=>'0',
			Cout=>open,
			SUM=>ADDER_BRANCH_out
		);
		
	branch_comp_instance: branch_comp
		generic map(N=>WORD_SIZE)
		port map(
			BRANCH_COND=>control_from_CU.ID.BRANCH_COND,
			DATA_IN=>RF_OUT1_fw,
			BRANCH_IS_TAKEN=>branch_is_taken
		);
		
	MUX_actual_addr: MUX_2to1
		generic map(N=>WORD_SIZE)
		port map(
			IN0=>NPC_ID,
			IN1=>NPC_branch,
			SEL=>branch_is_taken,
			Y=>actual_addr
		);
		
	MUX_RF_OUT1_fw: MUX_8to1
		generic map(N=>WORD_SIZE)
		port map(
			IN0=>RF_OUT1,
			IN1=>ALU_OUT_EXE,
			IN2=>ALU_OUT_MEM,
			IN3=>LMD_IN,
			IN4=>RF_DATA_IN,
			IN5=>NPC_MEM,
			IN6=>NPC_EXE,
			IN7=>(others=>'-'),
			SEL=>control_from_FU.MUX_RF_OUT1_sel,
			Y=>RF_OUT1_fw
		);
		
	MUX_RF_OUT2_fw: MUX_8to1
		generic map(N=>WORD_SIZE)
		port map(
			IN0=>RF_OUT2,
			IN1=>ALU_OUT_EXE,
			IN2=>ALU_OUT_MEM,
			IN3=>LMD_IN,
			IN4=>RF_DATA_IN,
			IN5=>NPC_MEM,
			IN6=>NPC_EXE,
			IN7=>(others=>'-'),
			SEL=>control_from_FU.MUX_RF_OUT2_sel,
			Y=>RF_OUT2_fw
		);
		
	REG_NPC_ID: reg
		generic map(N=>WORD_SIZE)
		port map(
			D=>NPC_ID,
			Q=>NPC_EXE,
			EN=>control_from_HDU.ID_EN,
			CLK=>clk,
			RST=>rst
		);
		
	MUX_RF_WR_ADDR: MUX_4to1
		generic map(N=>RF_ADDR_SIZE)
		port map(
			IN0=>IR_out(REG2_range),
			IN1=>IR_out(REG3_range),
			IN2=>RF_ADDR_LR,
			IN3=>(others=>'-'),
			SEL=>control_from_CU.ID.MUX_RF_WR_ADDR_sel,
			Y=>RF_WR_ADDR_ID
		);
		
	REG_RF_WR_ADDR_ID: reg
		generic map(N=>RF_ADDR_SIZE)
		port map(
			D=>RF_WR_ADDR_ID,
			Q=>RF_WR_ADDR_EXE,
			EN=>control_from_HDU.ID_EN,
			CLK=>clk,
			RST=>rst
		);

	RF_instance: RF
		generic map(
			N_bit=>WORD_SIZE,
			N_reg=>N_REG
		)	
		port map(
			CLK=>clk,
			RST=>rst,
			WR_EN=>control_from_CU.WB.RF_WR_EN,
			ADD_WR=>RF_WR_ADDR_WB,
			ADD_RD2=>IR_out(REG2_range),
			ADD_RD1=>IR_out(REG1_range),
			DATA_IN=>RF_data_in,
			OUT1=>RF_OUT1,
			OUT2=>RF_OUT2
		);
		
	REG_RF_OUT1: reg
		generic map(N=>WORD_SIZE)
		port map(
			D=>RF_OUT1_fw,
			Q=>ALU_IN1,
			EN=>control_from_HDU.ID_EN,
			CLK=>clk,
			RST=>rst
		);
		
	REG_RF_OUT2: reg
		generic map(N=>WORD_SIZE)
		port map(
			D=>RF_OUT2_fw,
			Q=>RF_OUT2_EXE,
			EN=>control_from_HDU.ID_EN,
			CLK=>clk,
			RST=>rst
		);
		
	IR_out_ext16<=std_logic_vector(resize(signed(IR_out(IMM_range)), WORD_SIZE));
	IR_out_ext26<=std_logic_vector(resize(signed(IR_out(J_OFFSET_range)), WORD_SIZE));

	MUX_IMM_EXT: MUX_2to1
		generic map(N=>WORD_SIZE)
		port map(
			IN0=>IR_out_ext16,
			IN1=>IR_out_ext26,
			SEL=>control_from_CU.ID.MUX_IMM_EXT_sel,
			Y=>IMM_ID
		);
				
	REG_IMM: reg
		generic map(N=>WORD_SIZE)
		port map(
			D=>IMM_ID,
			Q=>IMM_EXE,
			EN=>control_from_HDU.ID_EN,
			CLK=>clk,
			RST=>rst
		);
		
	---------------------------------------EXE stage

	MUX_DRAM_IN_fw: MUX_2to1
		generic map(N=>WORD_SIZE)
		port map(
			IN0=>RF_OUT2_EXE,
			IN1=>LMD_IN,
			SEL=>control_from_FU.MUX_DRAM_IN_sel,
			Y=>DRAM_IN_EXE
		);

	MUX_ALU_IN2: MUX_2to1
		generic map(N=>WORD_SIZE)
		port map(
			IN0=>RF_OUT2_EXE,
			IN1=>IMM_EXE,
			SEL=>control_from_CU.EXE.MUX_ALU_IN2_sel,
			Y=>ALU_IN2
		);

	ALU_instance: ALU
		generic map(N=>WORD_SIZE)
		port map(
			FUNC=>control_from_CU.EXE.ALU_OP,
			DATA1=>ALU_IN1,
			DATA2=>ALU_IN2,
			OUT_ALU=>ALU_OUT
		);
			
	MULT: boothmul_4stage
		generic map(N=>WORD_SIZE)
		port map(
			A=>ALU_IN1,
			B=>ALU_IN2,
			EN=>control_from_CU.EXE.MULT_EN,
			CLK=>CLK,
			RST=>RST,
			P=>MULT_OUT
		);
			
	MUX_MULT: MUX_2to1
		generic map(N=>WORD_SIZE)
		port map(
			IN0=>ALU_OUT,
			IN1=>MULT_OUT(WORD_range),
			SEL=>control_from_CU.EXE.MUX_MULT_sel,
			Y=>ALU_OUT_EXE
		);
			
	REG_ALU_OUT_EXE: reg
		generic map(N=>WORD_SIZE)
		port map(
			D=>ALU_OUT_EXE,
			Q=>ALU_OUT_MEM,
			EN=>control_from_HDU.EXE_EN,
			CLK=>clk,
			RST=>rst
		);
		
	REG_NPC_EXE: reg
		generic map(N=>WORD_SIZE)
		port map(
			D=>NPC_EXE,
			Q=>NPC_MEM,
			EN=>control_from_HDU.EXE_EN,
			CLK=>clk,
			RST=>rst
		);
				
	REG_DRAM_IN: reg
		generic map(N=>WORD_SIZE)
		port map(
			D=>DRAM_IN_EXE,
			Q=>DRAM_IN_MEM,
			EN=>control_from_HDU.EXE_EN,
			CLK=>clk,
			RST=>rst
		);
				
	REG_RF_WR_ADDR_EXE: reg
		generic map(N=>RF_ADDR_SIZE)
		port map(
			D=>RF_WR_ADDR_EXE,
			Q=>RF_WR_ADDR_MEM,
			EN=>control_from_HDU.EXE_EN,
			CLK=>clk,
			RST=>rst
		);
		
	----------------------------------------------------------------MEM stage

	DRAM_ADDR<=ALU_OUT_MEM;
	DRAM_IN<=DRAM_IN_MEM;
	
	DRAM_OUT_sb<=std_logic_vector(resize(signed(DRAM_OUT(byte_range)), WORD_SIZE));
	DRAM_OUT_ub<=std_logic_vector(resize(unsigned(DRAM_OUT(byte_range)), WORD_SIZE));
	DRAM_OUT_sh<=std_logic_vector(resize(signed(DRAM_OUT(halfword_range)), WORD_SIZE));
	DRAM_OUT_uh<=std_logic_vector(resize(unsigned(DRAM_OUT(halfword_range)), WORD_SIZE));
	DRAM_OUT_w<=DRAM_OUT;
	
	MUX_DRAM_OUT_EXT: MUX_8to1
		generic map(N=>WORD_SIZE)
		port map(
			IN0=>DRAM_OUT_sb,
			IN1=>DRAM_OUT_ub,
			IN2=>DRAM_OUT_sh,
			IN3=>DRAM_OUT_uh,
			IN4=>DRAM_OUT_w,
			IN5=>(others=>'-'),
			IN6=>(others=>'-'),
			IN7=>(others=>'-'),
			SEL=>control_from_CU.MEM.MUX_DRAM_OUT_EXT_sel,
			Y=>LMD_in
		);
	
	LMD: reg
		generic map(N=>WORD_SIZE)
		port map(
			D=>LMD_in,
			Q=>LMD_out,
			EN=>control_from_HDU.MEM_EN,
			CLK=>clk,
			RST=>rst
		);
		
	REG_NPC_MEM: reg
		generic map(N=>WORD_SIZE)
		port map(
			D=>NPC_MEM,
			Q=>NPC_WB,
			EN=>control_from_HDU.MEM_EN,
			CLK=>clk,
			RST=>rst
		);
		
	REG_ALU_OUT_MEM: reg
		generic map(N=>WORD_SIZE)
		port map(
			D=>ALU_OUT_MEM,
			Q=>ALU_OUT_WB,
			EN=>control_from_HDU.MEM_EN,
			CLK=>clk,
			RST=>rst
		);
	
	REG_RF_WR_ADDR_MEM: reg
		generic map(N=>RF_ADDR_SIZE)
		port map(
			D=>RF_WR_ADDR_MEM,
			Q=>RF_WR_ADDR_WB,
			EN=>control_from_HDU.MEM_EN,
			CLK=>clk,
			RST=>rst
		);

	------------------------------------------------------------WB stage
	
	MUX_WB: MUX_4to1
		generic map(N=>WORD_SIZE)
		port map(
			IN0=>NPC_WB,
			IN1=>LMD_out,
			IN2=>ALU_OUT_WB,
			IN3=>(others=>'-'),
			SEL=>control_from_CU.WB.MUX_WB_sel,
			Y=>RF_data_in
		);

end architecture structural;
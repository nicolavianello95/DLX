library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ALU_package.all;	--for ALU_OP_type

entity ALU is
	generic (N : integer := 32);										-- number of bit
	port(	FUNC			: IN ALU_OP_type;							-- operation to do
			DATA1, DATA2	: IN std_logic_vector(N-1 downto 0);		-- data inputs
			OUT_ALU			: OUT std_logic_vector(N-1 downto 0));		-- data output
end ALU;

architecture BEHAVIORAL of ALU is

	COMPONENT barrel_shifter is
		generic (Nbit 		: integer 	:= 32);								-- number of bits
		port 	(A			: IN std_logic_vector(Nbit-1 downto 0);			-- operand that we want modify
				B			: IN std_logic_vector(Nbit-1 downto 0);			-- number of position of modification
				SHIFT_ROTATE: IN std_logic;									-- select if it is a shift=0 or a rotate=1 operation 
				LOGIC_ARITH	: IN std_logic;									-- logic 0 arith 1
				LEFT_RIGHT	: IN std_logic;									-- left 0 right 1
				OUTPUT		: OUT std_logic_vector(Nbit-1 downto 0)); 		-- operand modified
	END COMPONENT barrel_shifter;
	
	COMPONENT  ADDER_P4 IS
		GENERIC (N_BIT	: integer := 32);								-- number of bits
		PORT   (A		: in  std_logic_vector(N_BIT - 1 downto 0);		-- input operand 1
				B		: in  std_logic_vector(N_BIT - 1 downto 0);		-- input operand 2
				add_sub	: in  std_logic;								-- carry-in: 0 for ADD, 1 for SUB
				Cout	: out std_logic;								-- carry-out
				SUM		: out std_logic_vector(N_BIT -1 downto 0));		-- ouput sum
	END COMPONENT ADDER_P4;
	
	COMPONENT LOGIC_BLOCK is
		Generic (N: integer:= 32);										-- number of bits
	Port (	SUM		:	In	std_logic_vector(N-1 downto 0);		-- sum provided by the sparse tree
			C_OUT	:	In	std_logic;							-- carry out provided by sparse tree
			A		:	In	std_logic_vector(N-1 downto 0);		-- input 1
			B		:	In	std_logic_vector(N-1 downto 0);		-- input 2
			A_GEU_B :	Out	std_logic_vector(N-1 downto 0);		-- comparison A >= B for unsigned, if true flag = 1, otherwise = 0
			A_GE_B	:	Out	std_logic_vector(N-1 downto 0);		-- comparison A >= B for signed, if true flag = 1, otherwise = 0
			A_GT_B	:	Out	std_logic_vector(N-1 downto 0);		-- comparison A > B for signed, if true flag = 1, otherwise = 0
			A_GTU_B :	Out	std_logic_vector(N-1 downto 0);     -- comparison A > B for unsigned, if true flag = 1, otherwise = 0
			A_LEU_B :	Out	std_logic_vector(N-1 downto 0);		-- comparison A <= B for unsigned, if true flag = 1, otherwise = 0
			A_LE_B	:	Out	std_logic_vector(N-1 downto 0);     -- comparison A <= B for signed, if true flag = 1, otherwise = 0
			A_LT_B	:	Out	std_logic_vector(N-1 downto 0);		-- comparison A < B for signed, if true flag = 1, otherwise = 0
			A_LTU_B :	Out	std_logic_vector(N-1 downto 0);     -- comparison A < B for unsigned , if true flag = 1, otherwise = 0
			A_NE_B	:	Out	std_logic_vector(N-1 downto 0);		-- if A is different from B, if true flag = 1, otherwise = 0
			A_EQ_B  :	Out	std_logic_vector(N-1 downto 0);		-- if A is equal to B, if true flag = 1, otherwise = 0
			NOT_A	:	Out	std_logic_vector(N-1 downto 0);		-- make the bitwise not of the input operand A
			A_AND_B	:	Out	std_logic_vector(N-1 downto 0);		-- make the bitwise AND between input 1 and input 2
			A_XOR_B	:	Out	std_logic_vector(N-1 downto 0);		-- make the bitwise XOR between input 1 and input 2
			A_OR_B	:	Out	std_logic_vector(N-1 downto 0));	-- make the bitwise OR between input 1 and input 2
	END COMPONENT LOGIC_BLOCK;
	
	-- signals that manage the shifting type
	signal logic_arith, left_right,shift_rotate	: std_logic; 
	
	-- signal that manage the sparse tree
	signal add_sub 		: std_logic;																				
	
	-- ouput signal of component                                                                                       
	signal carry_out 						: std_logic; 						-- from adder                                  
	signal out_st							: std_logic_vector(N-1 downto 0); 	-- from adder                                  
	signal out_barrel_shifter				: std_logic_vector(N-1 downto 0); 	-- from barrel shifter   
	signal out_and,out_or,out_xor, out_not	: std_logic_vector(N-1 downto 0); 	-- from logic block 	
	signal out_sge,out_sle					: std_logic_vector(N-1 downto 0); 		-- form logic block                     		 
	signal out_sgeu,out_sleu				: std_logic_vector(N-1 downto 0); 		-- form logic block 
	signal out_sgt,out_slt					: std_logic_vector(N-1 downto 0); 		-- form logic block 
	signal out_sgtu,out_sltu				: std_logic_vector(N-1 downto 0); 		-- form logic block 
	signal out_seq,out_sne					: std_logic_vector(N-1 downto 0); 		-- form logic block                            

	BEGIN                                                                                                    
	
		-- place the component for barrel shifter
		BRRL_SHFT : barrel_shifter 	
					Generic map (N)
					Port map(LOGIC_ARITH=>logic_arith, LEFT_RIGHT=>left_right,SHIFT_ROTATE=>shift_rotate, 
							A=> DATA1, B=>DATA2, OUTPUT=> out_barrel_shifter);
		
		-- place the component for addition and subtraction
		SPARSE_TREE_ADDER: ADDER_P4
					Generic map(N)
					Port map(A=>DATA1, B=>DATA2, add_sub=>add_sub, Cout=>carry_out, SUM=>out_st);		

		-- place the logic block, used to make all implemented logic function
		LGC_BLOCK: LOGIC_BLOCK
					Generic Map (N)
					Port Map(SUM=>out_st, C_OUT=>carry_out,A=>DATA1,B=>DATA2,
							A_GE_B=>out_sge ,A_GEU_B=>out_sgeu,
							A_GT_B=>out_sgt ,A_GTU_B =>out_sgtu,
							A_LE_B=>out_sle, A_LEU_B =>out_sleu,
							A_LT_B	=> out_slt, A_LTU_B => out_sltu,
							A_NE_B=>out_sne, A_EQ_B=> out_seq, NOT_A => out_not,
							A_AND_B=>out_and, A_XOR_B=>out_xor, A_OR_B=>out_or);
		
		-- statement that define the output of the alu 
		with FUNC select OUT_ALU <=
			out_st 	when ALU_ADD,
			out_st 	when ALU_SUB,
			out_xor when ALU_XOR,
			out_and when ALU_AND,
			out_or 	when ALU_OR,
			out_not when ALU_NOT,
			out_barrel_shifter when ALU_SLL,
			out_barrel_shifter when ALU_SRL,
			out_barrel_shifter when ALU_SRA,
			out_barrel_shifter when ALU_ROL,
			out_barrel_shifter when ALU_ROR,
			out_sge when ALU_SGE,
			out_sgeu when ALU_SGEU,
			out_sgt when ALU_SGT,
			out_sgtu when ALU_SGTU,			
			out_sle when ALU_SLE,
			out_sleu when ALU_SLEU,
			out_slt when ALU_SLT,
			out_sltu when ALU_SLTU,
			out_sne when ALU_SNE,
			out_seq when ALU_SEQ,
			(others=>'-') when others;
		
		-- define if the operation needed a subtraction or an addition
		with FUNC select add_sub <=
			'0' when ALU_ADD,
			'1' when ALU_SUB,
			'1' when others;
			
		-- define if shift or rotate operation
		with FUNC select shift_rotate <=
			'0' when ALU_SLL,
			'0' when ALU_SRL,
			'0' when ALU_SRA,
			'1' when ALU_ROL,
			'1' when ALU_ROR,
			'-' when others;
		
		-- define if the operation is a shift 
		with FUNC select logic_arith <=
			'0' when ALU_SLL,
			'0' when ALU_SRL,
			'1' when ALU_SRA,
			'1' when ALU_ROL,
			'1' when ALU_ROR,
			'-' when others;
		
		-- define the type of shift	
		with FUNC select left_right <=
			'0' when ALU_SLL,
			'1' when ALU_SRL,
			'1' when ALU_SRA,
			'0' when ALU_ROL,
			'1' when ALU_ROR,
			'-' when others;

end BEHAVIORAL;

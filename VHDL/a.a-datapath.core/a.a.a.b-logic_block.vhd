library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity LOGIC_BLOCK is
	Generic (N: integer:= 32);									-- number of bits
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
end LOGIC_BLOCK;

architecture Behavioural of LOGIC_BLOCK is

signal nor_sum	: std_logic;
signal geu, ge 	: std_logic;
signal gt, gtu	: std_logic;
signal leu, le 	: std_logic;
signal lt, ltu	: std_logic;
signal neq, eq	: std_logic;
signal vector_zero:std_logic_vector(N-2 downto 0);
begin
	-- create the zero vector
	vector_zero <= (others=>'0');
	--simpler operation
	A_AND_B	<= A and B;
    A_XOR_B	<= A xor B;
    A_OR_B	<= A or  B;
	NOT_A	<= not(A);

	--nor all bits of the sum
	nor_sum <= nor_vector(sum);
	
	-- Now, thanks to the created signal nor_s3, it is possible make some comparison 
	geu	<= C_OUT; 
	ge 	<= C_OUT xor (A(N-1) xor B(N-1));
	gt	<= ge and neq;	 									-- ge = 1 and neq = 1
	gtu	<= geu and neq; 									-- geu = 1 and neq = 1
	
	leu	<= nor_sum or (not(C_OUT));
	le  <= (nor_sum or (not(C_OUT))) xor (A(N-1) xor B(N-1));
	lt	<= le and neq;	
	ltu	<= leu and neq; 
	
	neq <= not(nor_sum);
	eq 	<= nor_sum;

	A_GEU_B	<= vector_zero & geu;
	A_GE_B	<= vector_zero & ge;
	A_GT_B	<= vector_zero & gt;
	A_GTU_B	<= vector_zero & gtu;
	
	A_LEU_B	<= vector_zero & leu;
	A_LE_B	<= vector_zero & le;
	A_LT_B	<= vector_zero & lt;
	A_LTU_B	<= vector_zero & ltu;
	
	A_NE_B	<= vector_zero & neq;
	A_EQ_B 	<= vector_zero & eq;
end Behavioural;


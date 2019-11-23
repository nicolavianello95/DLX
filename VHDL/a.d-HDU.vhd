library ieee;
use ieee.std_logic_1164.all;
use work.DLX_package.all;		--for constants, types and functions
use work.FU_and_HDU_package.all;	--for HDU_OUTS_type

entity HDU is	--hazard detection unit
	port(
		INSTR_ID		: in word;
		INSTR_EXE		: in word;
		misprediction	: in std_logic;
		HDU_OUTS		: out HDU_OUTS_type;
		clk				: in std_logic;
		rst				: in std_logic
	);
end entity HDU;

architecture behavioral of HDU is

	signal count: integer range 0 to 3;

begin

	HDU_proc: process(INSTR_ID, INSTR_EXE, misprediction, count) is
	
		variable Rs1_ID, Rs2_ID, Rd_EXE : integer range 0 to N_REG;
	
	begin
		
		--compute useful constants
		Rs1_ID	:=	get_Rs1(INSTR_ID);
		Rs2_ID	:=	get_Rs2(INSTR_ID);
		Rd_EXE	:=	get_Rd(INSTR_EXE);
		
		--default assignment
		HDU_OUTS.PC_EN		<='1';
		HDU_OUTS.IF_EN		<='1';
		HDU_OUTS.ID_EN		<='1';
		HDU_OUTS.EXE_EN		<='1';
		HDU_OUTS.MEM_EN		<='1';
		HDU_OUTS.WB_EN		<='1';
		HDU_OUTS.ID_bubble	<='0';
		HDU_OUTS.EXE_bubble	<='0';
		HDU_OUTS.MEM_bubble	<='0';
		HDU_OUTS.WB_bubble	<='0';
		
		--multicycle operations structural hazard
		if is_a_mult(INSTR_EXE) and count/=3 then
			HDU_OUTS.PC_EN<='0';
			HDU_OUTS.IF_EN<='0';
			HDU_OUTS.ID_EN<='0';
			HDU_OUTS.EXE_EN<='0';
			HDU_OUTS.MEM_bubble<='1';
		--load from DRAM data hazard
		elsif Rd_EXE/=0 and is_a_load(INSTR_EXE) and is_not_a_jump_imm(INSTR_ID) and		--immediate jumps does not need register file
		(Rs1_ID=Rd_EXE or (get_opcode(INSTR_ID)=OPCODE_RTYPE and Rs2_ID=Rd_EXE)) then		--stores can forward the value to store in the next pipeline stage but they need the register in which is cointain the address to proceed 
			HDU_OUTS.PC_EN<='0';
			HDU_OUTS.IF_EN<='0';
			HDU_OUTS.ID_EN<='0';
			HDU_OUTS.EXE_bubble<='1';
		--branch misprediction control hazard
		elsif misprediction='1' then
			HDU_OUTS.IF_EN<='0';
			HDU_OUTS.ID_bubble<='1';
		end if;
		
	end process HDU_proc;
	
	count_proc: process(clk, rst)
	begin
		if rst='0' then
			count<=0;
		elsif rising_edge(clk) then
			if is_a_mult(INSTR_EXE) then
				if count=3 then
					count<=0;
				else
					count<=count+1;
				end if;
			end if;
		end if;
	end process count_proc;
	
end architecture behavioral;
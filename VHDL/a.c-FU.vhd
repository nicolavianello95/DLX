library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.DLX_package.all;		--for constants, types and functions
use work.FU_and_HDU_package.all;	--for FU_OUTS_type

entity FU is
	port(
		INSTR_ID	: in word;
		INSTR_EXE	: in word;
		INSTR_MEM	: in word;
		INSTR_WB	: in word;
		FU_OUTS		: out FU_OUTS_type
	);
end entity FU;

architecture behavioral of FU is

begin

	FU_process: process(INSTR_ID, INSTR_EXE, INSTR_MEM, INSTR_WB) is
	
		variable Rs1_ID, Rs2_ID, Rs2_EXE, Rd_EXE, Rd_MEM, Rd_WB : integer range 0 to N_REG;
	
	begin
	
		--compute usefull constants
		Rs1_ID	:=	get_Rs1(INSTR_ID);
		Rs2_ID	:=	get_Rs2(INSTR_ID);
		Rs2_EXE	:=	get_Rs2(INSTR_EXE);
		Rd_EXE	:=	get_Rd(INSTR_EXE);
		Rd_MEM	:=	get_Rd(INSTR_MEM);
		Rd_WB	:=	get_Rd(INSTR_WB);
	
		--default assignment
		FU_OUTS.MUX_RF_OUT1_sel<=RF_forward_NO;
		FU_OUTS.MUX_RF_OUT2_sel<=RF_forward_NO;
		FU_OUTS.MUX_DRAM_IN_sel<=DRAM_forward_NO;

		--RF_OUT1 forwarding
		if Rs1_ID/=0 and Rs1_ID=Rd_EXE and is_not_a_jump(INSTR_EXE) and is_not_a_store(INSTR_EXE) then
			FU_OUTS.MUX_RF_OUT1_sel<=RF_forward_EXE_ALU;
		elsif Rs1_ID=31 and is_a_subroutine_call(INSTR_EXE) then
			FU_OUTS.MUX_RF_OUT1_sel<=RF_forward_EXE_NPC;
		elsif Rs1_ID/=0 and Rs1_ID=Rd_MEM and is_a_load(INSTR_MEM) then
			FU_OUTS.MUX_RF_OUT1_sel<=RF_forward_MEM_DRAM;
		elsif Rs1_ID/=0 and Rs1_ID=Rd_MEM and is_not_a_jump(INSTR_MEM) and is_not_a_store(INSTR_MEM) then
			FU_OUTS.MUX_RF_OUT1_sel<=RF_forward_MEM_ALU;
		elsif Rs1_ID=31 and is_a_subroutine_call(INSTR_MEM) then
			FU_OUTS.MUX_RF_OUT1_sel<=RF_forward_MEM_NPC;
		elsif Rs1_ID/=0 and Rs1_ID=Rd_WB and is_not_a_jump(INSTR_WB) and is_not_a_store(INSTR_WB) then
			FU_OUTS.MUX_RF_OUT1_sel<=RF_forward_WB;
		elsif Rs1_ID=31 and is_a_subroutine_call(INSTR_WB) then
			FU_OUTS.MUX_RF_OUT1_sel<=RF_forward_WB;
		end if;
		
		--RF_OUT2 forwarding
		if Rs2_ID/=0 and Rs2_ID=Rd_EXE and is_not_a_jump(INSTR_EXE) and is_not_a_store(INSTR_EXE) then
			FU_OUTS.MUX_RF_OUT2_sel<=RF_forward_EXE_ALU;
		elsif Rs2_ID=31 and is_a_subroutine_call(INSTR_EXE) then
			FU_OUTS.MUX_RF_OUT2_sel<=RF_forward_EXE_NPC;
		elsif Rs2_ID/=0 and Rs2_ID=Rd_MEM and is_a_load(INSTR_MEM) then
			FU_OUTS.MUX_RF_OUT2_sel<=RF_forward_MEM_DRAM;
		elsif Rs2_ID/=0 and Rs2_ID=Rd_MEM and is_not_a_jump(INSTR_MEM) and is_not_a_store(INSTR_MEM) then
			FU_OUTS.MUX_RF_OUT2_sel<=RF_forward_MEM_ALU;
		elsif Rs2_ID=31 and is_a_subroutine_call(INSTR_MEM) then
			FU_OUTS.MUX_RF_OUT2_sel<=RF_forward_MEM_NPC;
		elsif Rs2_ID/=0 and Rs2_ID=Rd_WB and is_not_a_jump(INSTR_WB) and is_not_a_store(INSTR_WB) then
			FU_OUTS.MUX_RF_OUT2_sel<=RF_forward_WB;
		elsif Rs2_ID=31 and is_a_subroutine_call(INSTR_WB) then
			FU_OUTS.MUX_RF_OUT2_sel<=RF_forward_WB;
		end if;
		
		--DRAM IN forwarding
		if Rs2_EXE/=0 then
			if Rs2_EXE=Rd_MEM and is_a_load(INSTR_MEM) then
				FU_OUTS.MUX_DRAM_IN_sel<=DRAM_forward_WB;
			end if;
		end if;
		
	end process FU_process;
	
end architecture behavioral;
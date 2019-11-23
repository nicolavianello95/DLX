library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.DLX_package.all;		--for types and functions
use work.datapath_package.all;	--for constants

entity IRAM_test is
	generic(MEM_SIZE : integer := 1024);
	port(
		DATA_OUT	: out word;
		ADDR		: in word
		);
end entity IRAM_test;

architecture behavioral of IRAM_test is

	type IRAM_mem_type is array (0 to MEM_SIZE-1) of word;
	
	constant test_simple_add: IRAM_mem_type:=(
		INSTR_ITYPE(OPCODE_ADDUI,0,1,10),		--R1<-1
		INSTR_ITYPE(OPCODE_ADDUI,0,2,7),		--R2<-7
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_RTYPE(FUNC_ADDU,1,2,3),			--R3<-R1+R2
		others=>INSTR_ITYPE(OPCODE_NOP,0,0,0)
	);	
	
	constant test_simple_dram: IRAM_mem_type:=(
		INSTR_ITYPE(OPCODE_ADDUI,0,1,32767),	--R1<-32767
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_RTYPE(FUNC_ADDU,1,1,1),			--R1<-R1+R1
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_RTYPE(FUNC_ADDU,1,1,1),			--R1<-R1+R1
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_SW,0,1,0),			--MEM(0+R0)<-R1 (word)
		INSTR_ITYPE(OPCODE_SH,0,1,4),			--MEM(4+R0)<-R1 (halfword)
		INSTR_ITYPE(OPCODE_SB,0,1,6),			--MEM(6+R0)<-R1 (byte)
		INSTR_ITYPE(OPCODE_LW,0,2,0),			--R2<-MEM(0+R0) (word)
		INSTR_ITYPE(OPCODE_LH,0,3,4),			--R3<-MEM(4+R0) (halfword)
		INSTR_ITYPE(OPCODE_LBU,0,4,6),			--R4<-MEM(6+R0) (byte)
		others=>INSTR_ITYPE(OPCODE_NOP,0,0,0)
	);

	constant test_simple_jump: IRAM_mem_type:=(
		INSTR_ITYPE(OPCODE_ADDUI,2,2,1),		--R2<-R2+1
		INSTR_ITYPE(OPCODE_ADDUI,1,1,1),		--R1<-R1+1
		INSTR_JTYPE(OPCODE_J, -8),				--jump to first instruction
		others=>INSTR_ITYPE(OPCODE_NOP,0,0,0)
	);
	
	constant test_simple_conditional_branch: IRAM_mem_type:=(
		INSTR_ITYPE(OPCODE_ADDUI,0,1,3),		--R1<-3
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_ADDUI,1,1,-1),		--R1<-R1-1
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_BEQZ,1,0,400),		--if R1=0 branch forward
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_BNEZ,1,0,-36),		--if R1!=0 branch behind	
		others=>INSTR_ITYPE(OPCODE_NOP,0,0,0)
	);

	constant test_forwarding_ALU: IRAM_mem_type:=(
		--test ALU output at EXE to ALU input 1
		INSTR_ITYPE(OPCODE_ADDUI,0,1,5),		--R1<-5
		INSTR_ITYPE(OPCODE_ADDUI,1,2,1),		--R2<-R1+1
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0), 
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		--test ALU output at MEM to ALU input 1
		INSTR_ITYPE(OPCODE_ADDUI,0,1,1),		--R1<-1
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_ADDUI,1,2,1),		--R2<-R1+1
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		--test ALU output at WB to ALU input 1
		INSTR_ITYPE(OPCODE_ADDUI,0,1,7),		--R1<-7
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_ADDUI,1,2,1),		--R2<-R1+1
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		--test DRAM output at MEM to ALU input 1
		INSTR_ITYPE(OPCODE_SW,0,2,0),			--MEM(0+R0)<-R2 (word)
		INSTR_ITYPE(OPCODE_LW,0,1,0),			--R1<-MEM(0+R0) (word)
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_ADDUI,1,2,1),		--R2<-R1+1
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		--test DRAM output at WB to ALU input 1
		INSTR_ITYPE(OPCODE_SW,0,2,0),			--MEM(0+R0)<-R2 (word)
		INSTR_ITYPE(OPCODE_LW,0,1,0),			--R1<-MEM(0+R0) (word)
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_ADDUI,1,2,1),		--R2<-R1+1
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		--test ALU output at EXE to ALU input 2
		INSTR_ITYPE(OPCODE_ADDUI,0,1,5),		--R1<-5
		INSTR_RTYPE(FUNC_ADDU,0,1,2),			--R2<-R0+R1
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		--test ALU output at MEM to ALU input 2
		INSTR_ITYPE(OPCODE_ADDUI,0,1,1),		--R1<-1
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_RTYPE(FUNC_ADDU,0,1,2),			--R2<-R0+R1
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		--test ALU output at WB to ALU input 2
		INSTR_ITYPE(OPCODE_ADDUI,0,1,7),		--R1<-7
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_RTYPE(FUNC_ADDU,0,1,2),			--R2<-R0+R1
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		--test DRAM output at MEM to ALU input 2
		INSTR_ITYPE(OPCODE_SW,0,1,0),			--MEM(0+R0)<-R1 (word)
		INSTR_ITYPE(OPCODE_LW,0,3,0),			--R3<-MEM(0+R0) (word)
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_RTYPE(FUNC_ADDU,2,3,1),			--R1<-R2+R3
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		--test DRAM output at WB to ALU input 2
		INSTR_ITYPE(OPCODE_SW,0,1,0),			--MEM(0+R0)<-R1 (word)
		INSTR_ITYPE(OPCODE_LW,0,3,0),			--R3<-MEM(0+R0) (word)
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_RTYPE(FUNC_ADDU,2,3,1),			--R1<-R2+R3
		others=>INSTR_ITYPE(OPCODE_NOP,0,0,0)
	);
	
	constant test_forwarding_branch: IRAM_mem_type:=(
		--test ALU output at EXE to branch comparator
		INSTR_ITYPE(OPCODE_ADDUI,0,1,1),		--R1<-1
		INSTR_ITYPE(OPCODE_BNEZ,1,0,+12),		--if R1!=0 branch to next test
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		--test ALU output at MEM to branch comparator
		INSTR_ITYPE(OPCODE_ADDUI,0,1,0),		--R1<-0
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_BEQZ,1,0,+12),		--if R1=0 branch to next test
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		--test ALU output at WB to branch comparator
		INSTR_ITYPE(OPCODE_ADDUI,0,1,1),		--R1<-1
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_BNEZ,1,0,+12),		--if R1!=0 branch to next test
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		--test DRAM output at MEM to branch comparator
		INSTR_ITYPE(OPCODE_SW,0,1,0),			--MEM(0+R0)<-R1 (word)
		INSTR_ITYPE(OPCODE_LW,0,2,0),			--R2<-MEM(0+R0) (word)
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_BNEZ,2,0,+12),		--if R2!=0 branch to next test
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		--test DRAM output at WB to branch comparator
		INSTR_ITYPE(OPCODE_LW,0,3,0),			--R3<-MEM(0+R0) (word)
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_BNEZ,3,0,+100),		--if R3!=0 branch forward
		others=>INSTR_ITYPE(OPCODE_NOP,0,0,0)
	);

	constant test_forwarding_DRAM: IRAM_mem_type:=(
		--initialize dram
		INSTR_ITYPE(OPCODE_ADDUI,0,1,1),		--R1<-1
		INSTR_ITYPE(OPCODE_SB,0,1,100),			--MEM(100+R0)<-R1 (byte)
		--test DRAM output at MEM to DRAM in
		INSTR_ITYPE(OPCODE_LB,0,2,100),			--R2<-MEM(100+R0) (byte)
		INSTR_ITYPE(OPCODE_SB,0,2,0),			--MEM(0+R0)<-R2 (byte)
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		--test DRAM output at WB to DRAM in
		INSTR_ITYPE(OPCODE_LB,0,3,100),			--R3<-MEM(100+R0) (byte)
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_SB,0,3,1),			--MEM(1+R0)<-R3 (byte)
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		--test ALU output at MEM to DRAM in
		INSTR_ITYPE(OPCODE_ADDUI,0,1,5),		--R1<-5
		INSTR_ITYPE(OPCODE_SB,0,1,0),			--MEM(0+R0)<-R1 (byte)
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		--test ALU output at WB to DRAM in
		INSTR_ITYPE(OPCODE_ADDUI,0,2,8),		--R2<-8
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_SB,0,2,1),			--MEM(1+R0)<-R2 (byte)
		others=>INSTR_ITYPE(OPCODE_NOP,0,0,0)
	);

	constant test_HDU_load: IRAM_mem_type:=(
		--initialize dram
		INSTR_ITYPE(OPCODE_ADDUI,0,1,1),		--R1<-1
		INSTR_ITYPE(OPCODE_SB,0,1,0),			--MEM(0+R0)<-R1 (byte)
		--test
		INSTR_ITYPE(OPCODE_LB,0,2,0),			--R2<-MEM(0+R0) (byte)
		INSTR_ITYPE(OPCODE_ADDUI,2,1,1),		--R1<-R2+1
		others=>INSTR_ITYPE(OPCODE_NOP,0,0,0)
	);

	constant test_HDU_branch: IRAM_mem_type:=(
		INSTR_ITYPE(OPCODE_ADDUI,0,1,1),		--R1<-1
		INSTR_ITYPE(OPCODE_BNEZ,1,0,+4),		--if R1!=0 branch
		--the next instruction should not be executed
		INSTR_ITYPE(OPCODE_ADDUI,0,2,1),		--R2<-1
		--the next instruction should be executed
		INSTR_ITYPE(OPCODE_ADDUI,0,3,1),		--R3<-1
		others=>INSTR_ITYPE(OPCODE_NOP,0,0,0)
	);

	constant test_HDU_subroutine: IRAM_mem_type:=(
		INSTR_ITYPE(OPCODE_ADDUI,0,1,5),		--R1<-5
		INSTR_ITYPE(OPCODE_ADDUI,0,2,4),		--R2<-4
		INSTR_JTYPE(OPCODE_JAL,32),				--subroutine call
		INSTR_ITYPE(OPCODE_ADDUI,3,1,0),		--R1<-R3
		INSTR_JTYPE(OPCODE_J,-4),				--trap
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_ITYPE(OPCODE_NOP,0,0,0),
		INSTR_RTYPE(FUNC_ADDU,1,2,3),			--R3<-R1+R2
		INSTR_ITYPE(OPCODE_JR,31,0,0),			--return to subroutine
		others=>INSTR_ITYPE(OPCODE_NOP,0,0,0)
	);

	constant test_mult: IRAM_mem_type:=(
		INSTR_ITYPE(OPCODE_ADDUI,0,1,5),		--R1<-5
		INSTR_ITYPE(OPCODE_ADDUI,0,2,7),		--R2<-7
		INSTR_RTYPE(FUNC_MULT,1,2,3),			--R3<-R1*R2
		INSTR_ITYPE(OPCODE_MULTI,1,1,3),		--R1<-R1*3
		INSTR_ITYPE(OPCODE_ADDUI,0,1,0),		--R1<-0
		others=>INSTR_ITYPE(OPCODE_NOP,0,0,0)
	);
	
	constant test_BPU: IRAM_mem_type:=(
		INSTR_ITYPE(OPCODE_ADDUI,0,1,5),		--R1<-5
		INSTR_ITYPE(OPCODE_ADDUI,1,1,-1),		--R1<-R1-1
		INSTR_ITYPE(OPCODE_BEQZ,1,0,100),		--if R1=0 branch forward
		INSTR_ITYPE(OPCODE_BNEZ,1,0,-12),		--if R1!=0 branch behind	
		others=>INSTR_ITYPE(OPCODE_NOP,0,0,0)
	);

	constant program_to_run: IRAM_mem_type:= test_BPU;

begin  

	DATA_OUT <=	program_to_run(to_integer(unsigned(Addr))/4) when to_integer(unsigned(ADDR))<=MEM_SIZE else
				(others=>'-');

end behavioral;

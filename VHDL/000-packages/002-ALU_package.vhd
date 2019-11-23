use work.my_package.all;		--for log2_ceiling

package ALU_package is
	
	--all possible ALU operation
	type ALU_OP_type is (
		ALU_DONT_CARE,	-- The operation don't care									
		ALU_ADD,		-- Addition
		ALU_SUB,		-- Subtraction
		ALU_XOR,		-- Bitwise xor
		ALU_AND,		-- Bitwise and
		ALU_OR,			-- Bitwise or
		ALU_NOT,		-- Bitwise not
		ALU_SLL,		-- Shift left logical
		ALU_SRL,		-- Shift right logical 
		ALU_SRA,        -- Shift right arithmetical
		ALU_ROL,		-- Rotate left
		ALU_ROR,		-- Rotate right
		ALU_SGE,		-- Set if greather than or equal to (SIGNED)
		ALU_SGEU,		-- Set if greather than or equal to (UNSIGNED) 
		ALU_SGT,        -- Set if greather to (SIGNED)   
		ALU_SGTU,       -- Set if greather to (UNSIGNED)   		                   
		ALU_SLE,		-- Set if less than or equal to (SIGNED)
		ALU_SLEU,       -- Set if less than or equal to (UNSIGNED)
		ALU_SLT,        -- Set if less to (SIGNED)   
		ALU_SLTU,       -- Set if less to (UNSIGNED)   		                   
		ALU_SNE,		-- Set if not equal to
		ALU_SEQ  		-- Set if equal to
		);

	constant N_ALU_OP : integer := ALU_OP_type'pos(ALU_OP_type'high)+1;		--number of possible ALU operations
	constant ALU_OP_SEL_SIZE : integer := log2_ceiling(N_ALU_OP);			--ALU operation selector size
	
end package ALU_package;

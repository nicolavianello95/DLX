library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.DLX_package.all;	--for constants

package datapath_package is
	
	type BRANCH_COND_type is (
		BRANCH_NO,		--don't jump
		BRANCH_ALWAYS,	--jump always
		BRANCH_EQZ,		--jump if equal to zero
		BRANCH_NEZ		--jump if not equal to zero
	);
	
	subtype RF_addr is std_logic_vector(RF_ADDR_SIZE-1 downto 0);
	
	constant RF_ADDR_LR_n: integer:= 31;
	constant RF_ADDR_LR: RF_addr:= std_logic_vector(to_unsigned(RF_ADDR_LR_n, RF_ADDR_SIZE));
	
end package datapath_package;
library ieee;
use ieee.std_logic_1164.all;
use work.datapath_package.all;	--for BRANCH_COND_type

entity branch_comp is
	generic(N: integer:= 32);	--number of data-in bits
	port(
		BRANCH_COND		: in BRANCH_COND_type;					--condition to take branch
		DATA_IN			: in std_logic_vector(N-1 downto 0);	--data to test
		BRANCH_IS_TAKEN	: out std_logic);						--high if the branch is taken
end entity branch_comp;

architecture behavioral of branch_comp is
begin

	branch_comparator_process: process(BRANCH_COND, DATA_IN)
	begin
		case BRANCH_COND is
			when BRANCH_NO =>
				BRANCH_IS_TAKEN<='0';
			when BRANCH_ALWAYS =>
				BRANCH_IS_TAKEN<='1';
			when BRANCH_EQZ =>
				if DATA_IN=(DATA_IN'range=>'0') then
					BRANCH_IS_TAKEN<='1';
				else
					BRANCH_IS_TAKEN<='0';
				end if;
			when BRANCH_NEZ =>
				if DATA_IN=(DATA_IN'range=>'0') then
					BRANCH_IS_TAKEN<='0';
				else
					BRANCH_IS_TAKEN<='1';
				end if;
		end case;
	end process branch_comparator_process;

end architecture behavioral;
library ieee;
library work;
use ieee.std_logic_1164.all;
use work.my_package.all;	--for std_logic_vector_intrange

entity booth_encoder is	--encoder to correctly drive booth multiplier MUXes
	Port (	input:	In	std_logic_vector_intrange(1 downto -1);	--three bits of the number to multiplicate
			output: out std_logic_vector(2 downto 0));			--multiplexer input selector
end entity booth_encoder;

architecture behavioral of booth_encoder is

begin

	with input select
		output <=	"000" when "000",	--select 0
					"001" when "001",	--select +A
					"001" when "010",	--select +A
					"011" when "011",	--select +2A
					"100" when "100",	--select -2A
					"010" when "101",	--select -A
					"010" when "110",	--select -A
					"000" when "111",	--select 0
					"---" when others;	--don't care

end architecture behavioral;
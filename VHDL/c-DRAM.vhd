library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;		--for log2_ceiling
use work.DLX_package.all;		--for types
use work.DRAM_package.all;		--for DRAM_WR_type

entity DRAM is
	generic(
		MEM_SIZE: positive:= 1024);
	port(
		DATA_IN		: in word;
		DATA_OUT	: out word;
		ADDR		: in word;
		WR_EN		: in DRAM_WR_EN_type;
		CLK			: in std_logic);
end entity DRAM;
	
architecture behavioral of DRAM is

	type MEM_type is array (0 to MEM_SIZE-1) of byte;
	
	signal MEM: MEM_type;
	signal ADDR_to_int: natural;
	signal byte0_out, byte1_out, byte2_out, byte3_out: byte;

begin

	ADDR_to_int<=to_integer(unsigned(ADDR(29 downto 0)));		--max 30 bits otherwise integer can overflow

	byte0_out <= MEM(ADDR_to_int) when ADDR_to_int<=MEM_SIZE-1 and ADDR(31 downto 30)="00" else
				 (others=>'0');
				
	byte1_out <= MEM(ADDR_to_int+1) when ADDR_to_int+1<=MEM_SIZE-1 and ADDR(31 downto 30)="00"  else
				 (others=>'0');
				
	byte2_out <= MEM(ADDR_to_int+2) when ADDR_to_int+2<=MEM_SIZE-1 and ADDR(31 downto 30)="00"  else
				 (others=>'0');
				
	byte3_out <= MEM(ADDR_to_int+3) when ADDR_to_int+3<=MEM_SIZE-1 and ADDR(31 downto 30)="00"  else
				 (others=>'0');
				
	DATA_OUT <= byte3_out & byte2_out & byte1_out & byte0_out;
	
	write_proc: process(CLK)
	begin
		if rising_edge(CLK) then
			if WR_EN=DRAM_WR_B or WR_EN=DRAM_WR_H or WR_EN=DRAM_WR_W then
				if ADDR_to_int<=MEM_SIZE-1 and ADDR(31 downto 30)="00" then
					MEM(ADDR_to_int)<=DATA_IN(byte_range);
				end if;
			end if;
			if WR_EN=DRAM_WR_H or WR_EN=DRAM_WR_W then
				if ADDR_to_int+1<=MEM_SIZE-1 and ADDR(31 downto 30)="00" then
					MEM(ADDR_to_int+1)<=DATA_IN(byte1_range);
				end if;
			end if;
			if WR_EN=DRAM_WR_W then
				if ADDR_to_int+2<=MEM_SIZE-1 and ADDR(31 downto 30)="00" then
					MEM(ADDR_to_int+2)<=DATA_IN(byte2_range);
				end if;
				if ADDR_to_int+3<=MEM_SIZE-1 and ADDR(31 downto 30)="00" then
					MEM(ADDR_to_int+3)<=DATA_IN(byte3_range);
				end if;
			end if;
		end if;
	end process write_proc;

end architecture behavioral;
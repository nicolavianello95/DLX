library ieee;
use ieee.std_logic_1164.all;
use work.DRAM_package.all;		--for DRAM_WR_EN_type
use work.DLX_package.all;		--for word type

entity TB_DLX is
end entity TB_DLX;

architecture test of TB_DLX is

	component DLX is
		generic(
			BPU_TAG_FIELD_SIZE	: integer :=8;
			BPU_SET_FIELD_SIZE	: integer :=3;
			BPU_LINES_PER_SET	: integer :=4
		);
		port(
			IRAM_ADDR	: out	word;
			IRAM_OUT	: in	word;
			DRAM_ADDR	: out	word;
			DRAM_IN		: out	word;
			DRAM_OUT	: in	word;
			DRAM_WR_EN  : out	DRAM_WR_EN_type;
			CLK			: in	std_logic;
			RST			: in	std_logic
		);
	end component DLX;

	component IRAM_test is
		generic(MEM_SIZE : integer := 1024);
		port(
			DATA_OUT	: out word;
			ADDR		: in word
			);
	end component IRAM_test;

	component IRAM_file is
		generic(MEM_SIZE : integer := 1024);
		port(
			DATA_OUT	: out word;
			ADDR		: in word
			);
	end component IRAM_file;

	component DRAM is
		generic(
			MEM_SIZE: positive:= 1024);
		port(
			DATA_IN		: in word;
			DATA_OUT	: out word;
			ADDR		: in word;
			WR_EN		: in DRAM_WR_EN_type;
			CLK			: in std_logic);
	end component DRAM;

	signal IRAM_ADDR, IRAM_OUT, DRAM_ADDR, DRAM_IN, DRAM_OUT: word;
	signal DRAM_WR_EN : DRAM_WR_EN_type;
	signal CLK, RST : std_logic;
	
	constant clk_period : time := 10ns;
	constant BPU_TAG_FIELD_SIZE : integer:=8;
	constant BPU_SET_FIELD_SIZE : integer:=3;
	constant BPU_LINES_PER_SET : integer:=4;
	constant DRAM_SIZE	: integer := 1024;
	constant IRAM_SIZE	: integer := 1024;
	constant IRAM_test_or_file : string := "file";
	
begin

	DUT: DLX
		generic map(
			BPU_TAG_FIELD_SIZE=>BPU_TAG_FIELD_SIZE,
			BPU_SET_FIELD_SIZE=>BPU_SET_FIELD_SIZE,
			BPU_LINES_PER_SET=>BPU_LINES_PER_SET
		)
		port map(
			IRAM_ADDR=>IRAM_ADDR,
			IRAM_OUT=>IRAM_OUT,
			DRAM_ADDR=>DRAM_ADDR,
			DRAM_IN=>DRAM_IN,
			DRAM_OUT=>DRAM_OUT,
			DRAM_WR_EN=>DRAM_WR_EN,
			CLK=>CLK,
			RST=>RST
		);

	IRAM_test_gen: if IRAM_test_or_file="test" generate
		IRAM_instance: IRAM_test
			generic map(MEM_SIZE=>IRAM_SIZE)
			port map(
				DATA_OUT=>IRAM_OUT,
				ADDR=>IRAM_ADDR
			);
	end generate IRAM_test_gen;
	
	IRAM_file_gen: if IRAM_test_or_file="file" generate
		IRAM_instance: IRAM_file
			generic map(MEM_SIZE=>IRAM_SIZE)
			port map(
				DATA_OUT=>IRAM_OUT,
				ADDR=>IRAM_ADDR
			);
	end generate IRAM_file_gen;
		
	DRAM_instance: DRAM
		generic map(
			MEM_SIZE=>DRAM_SIZE
		)
		port map(
			DATA_IN=>DRAM_IN,
			DATA_OUT=>DRAM_OUT,
			ADDR=>DRAM_ADDR,
			WR_EN=>DRAM_WR_EN,
			CLK=>CLK
		);

	clk_proc: process
	begin
		CLK<='0';
		wait for clk_period/2;
		CLK<='1';
		wait for clk_period/2;
	end process clk_proc;

	RST<='0', '1' after clk_period;

end architecture test;
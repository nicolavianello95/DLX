library ieee; 
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;		--for types conversions and numeric functions
use work.my_package.all;		--for std_logic_vector_intrange

entity boothmul_4stage is
	generic(N: positive :=8);							--number of input bits
	port(
		A, B: in std_logic_vector(N-1 downto 0);		--input operands
		EN: in std_logic;
		CLK: in std_logic;							--clock signal
		RST: in std_logic;							-- reset signal
		P: out std_logic_vector(2*N-1 downto 0)		--output product
	);
end entity boothmul_4stage;

architecture structural of boothmul_4stage is
	
	component MUX_8to1 is
		Generic (N: integer:= 1);	--number of bits
		Port (	IN0, IN1, IN2, IN3, IN4, IN5, IN6, IN7	: In	std_logic_vector(N-1 downto 0);		--data inputs
				SEL					: In	std_logic_vector(2 downto 0);		--selection input
				Y					: Out	std_logic_vector(N-1 downto 0));	--data output
	end component MUX_8to1;
	
	component ADDER_P4 IS
	GENERIC (N_BIT	: integer := 32);	--number of bits. Must be a number from 4 to 32 and a multiple of 4
    PORT   (A		: in  std_logic_vector(N_BIT - 1 downto 0);		-- input operand 1
			B		: in  std_logic_vector(N_BIT - 1 downto 0);		-- input operand 2
			add_sub	: in  std_logic;								-- carry-in
			Cout	: out std_logic;								-- carry-out
			SUM		: out std_logic_vector(N_BIT -1 downto 0));		-- ouput sum
	end component ADDER_P4; 
	
	component booth_encoder is	--encoder to correctly drive booth multiplier MUXes
		Port (	input:	In	std_logic_vector_intrange(1 downto -1);	--three bits of the number to multiplicate
				output: out std_logic_vector(2 downto 0));			--multiplexer input selector
	end component booth_encoder; 
	
	type mux_out_type is array (N/2-1 downto 0) of std_logic_vector(2*N-1 downto 0);	--type used for signal mux_out
	type add_out_type is array (N/2-1 downto 0) of std_logic_vector(2*N-1 downto 0);	--type used for signal add_out
	type encoder_out_type is array (N/2-1 downto 0) of std_logic_vector(2 downto 0);	--type used for signal encoder_out
	type A_shifted_type is array (-N to N) of std_logic_vector(2*N-1 downto 0);			--type used for signal A_shifted
	
	signal encoder_out: encoder_out_type;					--encoders outputs
	signal mux_out: mux_out_type;							--MUXes outputs
	signal add_out_s1: add_out_type;						--RCAs outputs
	signal add_out_s2: add_out_type;						--RCAs outputs
	signal add_out_s3: add_out_type;
	signal add_out_s4: add_out_type;                        --RCAs outputs	
	signal A_shifted: A_shifted_type;						--signal that contains input A shifted to left of i-1 positions if i is positive,
															--or contains -A shifted to left of |i|-1 positions if i is negative,
															--where i is the array index. A_shifted(0) contains all zeros.
	signal B_ext: std_logic_vector_intrange(N-1 downto -1);	--equal to input B but with the additional bit number -1, which is equal to 0.
	
begin
	-- process used to propagate the partial sum between the stages
	process(CLK, RST)
		begin
			if RST = '0' then							-- asynchronous reset, active low
				add_out_s2(4) <=(others=>'0');
				add_out_s3(8) <=(others=>'0');
				add_out_s4(12)<=(others=>'0');
			elsif rising_edge(CLK) then 				-- positive edge triggered:	
				if EN='1' then
					add_out_s2(4) 	<= add_out_s1(4);		-- output of stage one, pass to stage two			
					add_out_s3(8) 	<= add_out_s2(8);		-- output of stage two, pass to stage three
					add_out_s4(12) 	<= add_out_s3(12);		-- output of stage three, pass to stage four	
				end if;
			end if;
	end process;
	
	
	B_ext(-1)<='0';								--connect bit -1 of B_ext to zero
	B_ext_generate: for i in 0 to N-1 generate	--connect all other bits to input B
		B_ext(i)<=B(i);
	end generate B_ext_generate;

	A_shifted_generate_positive: for i in 1 to N generate	--generate all A_shifted positive index
		A_shifted(i)<=std_logic_vector(shift_left(resize(signed(A), 2*N), (i-1)));
	end generate A_shifted_generate_positive;
	
	A_shifted(0)<=(others=>'0');	--connect A_shifted(0) to zero
	
	A_shifted_generate_negative: for i in -N to -1 generate	--generate all A_shifted negative index
		A_shifted(i)<=std_logic_vector(shift_left(-resize(signed(A), 2*N), (-i-1)));
	end generate A_shifted_generate_negative;
	
	adder_generate_s1: for i in 1 to N/8 generate	--generate RCAs for stage 1
		adder: ADDER_P4 generic map(2*N)
			port map(
				A		=>	mux_out(i),
				B		=>	add_out_s1(i-1),
				add_sub	=>	'0',
				SUM		=>	add_out_s1(i),
				Cout	=>	open );
	end generate adder_generate_s1;
	
	adder_generate_s2: for i in N/8+1 to N/4 generate	--generate RCAs for stage 1
		adder: ADDER_P4 generic map(2*N)
			port map(
				A		=>	mux_out(i),
				B		=>	add_out_s2(i-1),
				add_sub	=>	'0',
				SUM		=>	add_out_s2(i),
				Cout	=>	open );
	end generate adder_generate_s2;
	
	adder_generate_s3: for i in N/4+1 to N/4+4 generate	--generate RCAs for stage 1
		adder: ADDER_P4 generic map(2*N)
			port map(
				A		=>	mux_out(i),
				B		=>	add_out_s3(i-1),
				add_sub	=>	'0',
				SUM		=>	add_out_s3(i),
				Cout	=>	open );
	end generate adder_generate_s3;
	
	adder_generate_s4: for i in N/4+5 to N/2-1 generate	--generate RCAs for stage 4
		adder: ADDER_P4 generic map(2*N)
			port map(
				A		=>mux_out(i),
				B		=>add_out_s4(i-1),
				add_sub	=>'0',
				SUM		=>add_out_s4(i),
				Cout	=>open );
	end generate adder_generate_s4;

	mux_generate: for i in 0 to N/2-1 generate	--generate all MUXes
		mux: MUX_8to1 generic map(2*N)
			port map(
				SEL=>encoder_out(i),
				Y=>mux_out(i),
				IN0=>A_shifted(0),
				IN1=>A_shifted(2*i+1),
				IN2=>A_shifted(-2*i-1),
				IN3=>A_shifted(2*i+2),
				IN4=>A_shifted(-2*i-2),
				IN5=>(others=>'-'),
				IN6=>(others=>'-'),
				IN7=>(others=>'-')
			);
	end generate mux_generate;
	
	encoder_generate: for i in 0 to N/2-1 generate	--generate all encoders
		encoder: booth_encoder
			port map(
				output=>encoder_out(i),
				input=>B_ext(2*i+1 downto 2*i-1)
			); 
	end generate encoder_generate;
	
	add_out_s1(0)<=mux_out(0);	--there are no adder with index 0, the output of mux with index 0 is directly connected to the second input of the adder with index 1
	
	P <= add_out_s4(N/2-1);	--the final product is the output of the last adder

end architecture structural;
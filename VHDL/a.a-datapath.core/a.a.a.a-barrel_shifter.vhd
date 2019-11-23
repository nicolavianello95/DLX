library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity barrel_shifter is
generic (Nbit 		: integer 	:= 32);								-- number of bits
port 	(
		A			: IN std_logic_vector(Nbit-1 downto 0);			-- operand that we want modify
		B			: IN std_logic_vector(Nbit-1 downto 0);			-- number of position of modification
		SHIFT_ROTATE: IN std_logic;									-- select if it is a shift=0 or a rotate=1 operation 
		LOGIC_ARITH	: IN std_logic;									-- logic 0 arith 1
		LEFT_RIGHT	: IN std_logic;									-- left 0 right 1
		OUTPUT		: OUT std_logic_vector(Nbit-1 downto 0)); 		-- operand modified
end  barrel_shifter;

architecture structural of  barrel_shifter is

	component MUX_2to1 is
		Generic (N: integer:= 1);								--number of bits
		Port (	IN0:	In	std_logic_vector(N-1 downto 0);		--data input 1
				IN1:	In	std_logic_vector(N-1 downto 0);		--data input 2
				SEL:	In	std_logic;							--selection input
				Y:		Out	std_logic_vector(N-1 downto 0));	--data output
	end component MUX_2to1;

	component MUX_8to1 is
		Generic (N: integer:= 1);	--number of bits
		Port (	IN0, IN1, IN2, IN3, IN4, IN5, IN6, IN7	: In	std_logic_vector(N-1 downto 0);		--data inputs
				SEL					: In	std_logic_vector(2 downto 0);		--selection input
				Y					: Out	std_logic_vector(N-1 downto 0));	--data output
	end component MUX_8to1;

	type matrix is array (Nbit/4 downto 1) of std_logic_vector(Nbit+3 downto 0);
	signal out_left, out_right, out_mux_right, out_first_stage: matrix ;
	
	-- signal to manage the mask creation
	signal zero_vector, MSB_vector,fill_vector_left, fill_vector_right : std_logic_vector(Nbit-1 downto 0);
	
	-- signal used to propagate result from stage two to stage three
	signal out_second_stage : std_logic_vector(Nbit+3 downto 0);
	
	-- signal used to manage the mux of the third stage and the ouput stage
	signal out_barrel, out_control	: std_logic_vector(Nbit-1 downto 0);
	signal sel_mux_out				: std_logic;
	signal select_mux_3s			:std_logic_vector(2 downto 0);
	
 	-- it holds only five bits of the B input signal because on 32 bit, it is possible has a max shift of 32 bit (log2(32) = 5)
	signal shift_pos 				: std_logic_vector ( 4 downto 0);
	
BEGIN

	-- create a vector of all 0
	zero_vector <= (others => '0');
	
	-- Determine the mux control signal. 
	-- If it is found that one bit is equal 1 between 31 and 6, means that the required shift is over 31 (max shift allowed)
	sel_mux_out<=not( 	B(31) or B(30) or B(29) or B(28) or B(27) or B(26) or 
						B(25) or B(24) or B(23) or B(22) or B(21) or B(20) or
						B(19) or B(18) or B(17) or B(16) or B(15) or B(14) or
						B(13) or B(12) or B(11) or B(10) or B(9)  or B(8)  or
						B(7)  or B(6));
	
	-- cut or saturate the signal provide on B port
	-- if a number major than 32 is detected, it saturate the output to the shifter
	cut_sat: process (B,LOGIC_ARITH,LEFT_RIGHT)
		begin                        	
		if B > "00000000000000000000000000011111" then 
				if LOGIC_ARITH='1' and LEFT_RIGHT='1' then -- if an arithmetic right shift is required, it fill the output with all 1s
					out_control<= (others=>'1');
				else 
					out_control<= (others=>'0');			-- in the other case with 0
				end if;
		else
			shift_pos <= B(4 downto 0);	-- simple assignement if it is not detected a value greater than 31
			end if;
	end process cut_sat;
	
	-- it generates a signal with all the bits equal to the MSB. It is used in the arithmetical shift
	MSB_fill: for x in 0 to Nbit-1 generate
	MSB_vector (x)<= A(31);
	end generate MSB_fill;

	-- FIRST STAGE --------------------------------------------------------------------------------------------------------
	-- select if create the mask with zeros or with the bit received as operand for LEFT operation
	 mux_shift_rotate_left: MUX_2to1
							Generic map(N => Nbit )
							Port map(IN0=> zero_vector, IN1=> A, SEL=> SHIFT_ROTATE, Y=> fill_vector_left);
							
	-- create the eight possible general mask for left shift
	-- mask 0 : A(31 downto 0) & ("0000" or A(31 downto 28))
	-- mask 4 : A(27 downto 0) & ("00000000"or A(27 downto 24))
	-- ...other mask...
	-- mask 28: A(3 downto 0) & ("00000000000000000000000000000000" or A(31 downto 0))
	FIRST_STAGE_1: for x in 1 to Nbit/4 generate	
		out_left(x) <= (A(35-4*x downto 0) & fill_vector_left(Nbit-1 downto Nbit-4*x));
	end generate FIRST_STAGE_1;	
	
	
	-- select if create the mask with zeros or with the bit received as operand for RIGHT operation
	mux_shift_rotate_right: MUX_2to1
							Generic map(N => Nbit )
							Port map(IN0=> MSB_vector, IN1=> A, SEL=> SHIFT_ROTATE, Y=> fill_vector_right);

	-- it select the type of filling. If rotate op must be at 1, as a ARITH operation
	FIRST_STAGE_2: for x in 1 to Nbit/4 generate
		right_MUX2to1 : MUX_2to1
						Generic map(N => 4*x)
						Port map(IN0=> (others=>'0'), IN1=> fill_vector_right(4*x-1 downto 0), SEL=> LOGIC_ARITH, Y=> out_mux_right(x)(4*x-1 downto 0));	
	end generate FIRST_STAGE_2;
	
	--  create the eight possible general mask for right shift
	-- if LOGIC shift:
	-- mask 0 : "0000" & A(31 downto 0)
	-- mask 4 : "00000000" & A(31 downto 4)
	-- ...other mask...
	-- mask 28: "00000000000000000000000000000000" & A(31 downto 28)  
	-- if ARITHMETIC shift:
	-- mask 0 : ("1111" or A(3 downto 0)) & A(31 downto 0)
	-- mask 4 : ("11111111" or A(7 downto 0)) & A(31 downto 4)
	-- ...other mask...
	-- mask 28: ("11111111111111111111111111111111"or A(31 downto 0)) & A(31 downto 28)  
	FIRST_STAGE_3: for x in 1 to Nbit/4 generate	
		out_right(x) <= (out_mux_right(x)(4*x-1 downto 0) & A(Nbit-1 downto 4*x-4));
	end generate FIRST_STAGE_3;	
	
	-- it select if it is a mask for right shift or a mask for left shift
	FIRST_STAGE_4: for x in 1 to Nbit/4 generate
		MASK_MUX2to1 : MUX_2to1
					Generic map(N => Nbit + 4)
					Port map(IN0=> out_left(x), IN1=> out_right(x), SEL=> LEFT_RIGHT, Y=>out_first_stage(x));
	end generate FIRST_STAGE_4;
	
	-- SECOND STAGE -------------------------------------------------------------------------------------
	-- select the best mask approximation based on the 3 upper bits of shift_pos
	mux_second_stage: MUX_8to1 
					Generic map(N => Nbit + 4)
					Port map(IN0=>out_first_stage(1),IN1=>out_first_stage(2),IN2=>out_first_stage(3),
					IN3=>out_first_stage(4),IN4=>out_first_stage(5),IN5=>out_first_stage(6),
					IN6=>out_first_stage(7),IN7=>out_first_stage(8),SEL=>shift_pos(4 downto 2),Y=> out_second_stage);	
				 
	-- THIRD STAGE --------------------------------------------------------------------------------------
	-- It select the right mask based on the last two bit of shift_pos and on the LEFT_RIGHT signal.
	-- if LEFT_RIGHT = LEFT it select one mask between input A and D
	-- if LEFT_RIGHT = RIGHT it select one mask between input E and H
	-- The different entries cut the input signal in order to provide the correct shifting
	select_mux_3s <= (LEFT_RIGHT & shift_pos(1) & shift_pos(0));
	mux_third_stage: MUX_8to1 
					Generic map(N => Nbit)
					Port map(IN0=>out_second_stage(Nbit+3 downto 4),IN1=>out_second_stage(Nbit+2 downto 3),
					IN2=>out_second_stage(Nbit+1 downto 2),IN3=>out_second_stage(Nbit downto 1),
					IN4=>out_second_stage(Nbit -1 downto 0),IN5=>out_second_stage(Nbit downto 1),
					IN6=>out_second_stage(Nbit+1 downto 2),IN7=>out_second_stage(Nbit+2 downto 3),
					SEL=>select_mux_3s,Y=> out_barrel);

	-- OUTPUT STAGE --------------------------------------------------------------------------------------
	-- if sel_mux_out is = 0 -> pass A -> output obtained with the saturation
	-- if sel_mux_out is = 1 -> pass B -> output obtained with the three
	mux_out : MUX_2to1
			Generic map(N => Nbit)
			Port map(IN0=> out_control,IN1=> out_barrel,SEL=> sel_mux_out,Y=> OUTPUT);	

end structural;



library ieee;
use ieee.std_logic_1164.all;


entity SolucionerOperator is
port( 	clk,
		clear,
		en_PosCount, 
		en_NumCount,
		set_NumCount,
		set_position,
		--en_reading,
		sign_position : in std_logic;
		
		
		pos_x, 
		pos_y,
		number: out std_logic_vector(3 downto 0);
		Impossible_solution,
		carry_number,
		Done_solution : out std_logic);
	end SolucionerOperator;
	
architecture behavior of SolucionerOperator is

component count_adder IS
	GENERIC(modulo: Integer := 8);
	PORT(Clock: IN STD_LOGIC ;
	     E, Set, LOAD, CLEAR, sign_negative: IN STD_LOGIC ;
         BCD: BUFFER STD_LOGIC_VECTOR(3 DOWNTO 0) := (others =>'0');
         PAR_IN: in STD_LOGIC_VECTOR(3 DOWNTO 0);
         CARRY_OUT: out STD_LOGIC);
	END component ;
signal carry_num, carry_x, carry_y : std_logic;
signal temp_number, temp_pos_x, temp_pos_y : std_logic_vector(3 downto 0) := (others => '0');
signal reset : std_logic;

begin
	reset <= carry_num or set_NumCount;
	MovX: count_adder generic map(modulo=> 8) port map(clk, en_PosCount,set_position, set_position, clear, sign_position, temp_pos_x,"0000",carry_x);
	MovY: count_adder generic map(modulo=> 8) port map(clk or carry_x, carry_x,set_position, set_position, clear, sign_position, temp_pos_y,"0000", carry_y);
	NumCounter: count_adder generic map (modulo => 9) port map (clk, en_NumCount, reset, reset, clear, '0',temp_number, "0001", carry_num);
	
	Impossible_solution <= carry_y and sign_position;
	Done_solution		<= carry_y and not sign_position;
	number				<= temp_number;
	pos_x				<= temp_pos_x;
	pos_y				<= temp_pos_y;
	carry_number 		<= carry_num;
end behavior;
	
	
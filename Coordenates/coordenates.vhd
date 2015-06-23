library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity coordenates is 
port (	x,
		y: in std_logic_vector(3 downto 0);
		number : out std_logic_vector(7 downto 0));
	end coordenates;
architecture behavior of coordenates is
signal operation : std_logic_vector(7 downto 0); 
	begin
	process(x, y)
	variable a, b, c : integer := 0;
		begin
		a := to_integer(unsigned(y));
		b := to_integer(unsigned(x));
		c := 9*a + b;
		operation <= std_logic_vector(to_unsigned(c, number'length));
	end process;
	
	number <= operation;
end behavior;
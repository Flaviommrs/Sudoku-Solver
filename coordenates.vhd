library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity coordenates is 
port (	x,
		y: in std_logic_vector(3 downto 0);
		number : out std_logic_vector(6 downto 0));
	end coordenates;
architecture behavior of coordenates is
begin
	number <= 9*y + x;
end behavior;
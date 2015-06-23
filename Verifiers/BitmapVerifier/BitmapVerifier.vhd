LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

--Entity With the responsability to verify if the actual position is registered in sudoku or not.
entity BitmapVerifier is
	port(vecline, vecoluwn, vecregion: in std_logic_vector(8 downto 0);
		enable	: in std_logic;
		pos_x, pos_y: in std_logic_vector(3 downto 0);
		approve:	out std_logic);
	end BitmapVerifier;
	
architecture behavior of BitmapVerifier is
signal l, c, r : std_logic;
signal operator : std_logic;

begin 
READING_BMAPS:
process(pos_x, pos_y, enable, vecline, vecoluwn, vecregion, l, c, r, operator)
	variable li, ci, ri : integer := 0;
	begin
		if enable = '1' then
			li := to_integer(unsigned(pos_x));
			ci := to_integer(unsigned(pos_y));
			ri := (li/3)*3 + ci/3;
			l <= vecline(li);
			c <= vecoluwn(ci);
			r <= vecregion(ri);
			
		else 
			l <= '0';
			c <= '0';
			r <= '0';
		end if;
end process;

operator <= l or c or r;
approve <= not operator;

end behavior;
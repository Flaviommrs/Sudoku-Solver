<<<<<<< HEAD
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity verify_sudoku is
	port(vecline, vecoluwn, vecregion: in std_logic_vector(8 downto 0);
		enable	: in std_logic;
		position: in std_logic;
		result:	out std_logic);
	end verify_sudoku;
	
architecture behavior of verify_sudoku is
signal l, c, r : std_logic;
signal operator : std_logic;

begin 
READING_BMAPS:
process(position, enable)
	variable li, ci, ri : integer := 0;
	begin
		if enable = '1' then
			li := to_integer(unsigned(position)) / 9;
			ci := to_integer(unsigned(position)) rem 9;
			ri := (li/3)*3 + ci/3;
			l <= vecline(li);
			c <= vecoluwn(ci);
			r <= vecregion(ri);
		end if;
	end if;
end process;

operator <= l or c or r;
result <= '0' when operator,
			'1' when others;

=======
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity verify_sudoku is
	port(vecline, vecoluwn, vecregion: in std_logic_vector(8 downto 0);
		enable	: in std_logic;
		position: in std_logic;
		result:	out std_logic);
	end verify_sudoku;
	
architecture behavior of verify_sudoku is
signal l, c, r : std_logic;
signal operator : std_logic;

begin 
READING_BMAPS:
process(position, enable)
	variable li, ci, ri : integer := 0;
	begin
		if enable = '1' then
			li := to_integer(unsigned(position)) / 9;
			ci := to_integer(unsigned(position)) rem 9;
			ri := (li/3)*3 + ci/3;
			l <= vecline(li);
			c <= vecoluwn(ci);
			r <= vecregion(ri);
		end if;
	end if;
end process;

operator <= l or c or r;
result <= '0' when operator,
			'1' when others;

>>>>>>> cf3fe3396710313f3f45ce3d966964f33a2a8bbf
end behavior;
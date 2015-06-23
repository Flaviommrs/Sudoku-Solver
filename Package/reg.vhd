library ieee;
use ieee.std_logic_1164.all;

entity reg is
	GENERIC ( N : INTEGER ) ;
	port(x: in std_logic_vector(N-1 downto 0);
		 load, clear, clk: in std_logic;
		 player_in: in std_logic;
		 y: out std_logic_vector(N-1 downto 0));
		 player_out: in std_logic;
	end reg;
	
architecture behavior of reg is
		 
begin
		 	
	process( clk, clear, load)
	begin
		IF clear = '1' THEN
			y <= (others => '0') ;
			player_out <= '0';
		ELSIF clk'EVENT AND clk = '1' THEN 
			if  load = '1' then
				y <= x;
				player_out <= player_in;
			END IF;
		end IF;
	end process;
		 
		 
end behavior;
		 
	
library ieee;

use ieee.std_logic_1164.all;

entity reg is
	GENERIC ( N : INTEGER ) ;
	port(data_in: in std_logic_vector(N-1 downto 0);
		 load, clear, clk: in std_logic;
		 player_in: in std_logic;
		 data_out: out std_logic_vector(N-1 downto 0);
		 player_out: out std_logic );
	end reg;
	
architecture behavior of reg is
		 
begin
		 	
	process( clk, clear, load)
	begin
		IF clear = '1' THEN
			if load = '1' then				
				data_out <= (others => '0') ;
				player_out <= '0';
			end if;
		ELSIF clk'EVENT AND clk = '1' THEN 
			if  load = '1' then
				data_out<= data_in;
				player_out <= player_in;
			END IF;
		end IF;
	end process;
		 
		 
end behavior;
		 
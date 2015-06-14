library ieee;
use ieee.std_logic_1164.all;

Entity InputInterface is
	port(enter,
		 	 backspace,
		 	 clear,
		 	 y,
		 	 x,
		 	 xdir,
		 	 ydir,
		 	 done: in std_logic;
		 	 data: in std_logic_vector(3 downto 0);
		 	 clr_out,
		 	 load,
		 	 go,
			 erase: out std_logic;
			 data_out: out std_logic_vector(3 downto 0);
		 	 position: out std_logic_vector(6 downto 0));
end InputInterface;

Architecture behavior of InputInterface is



begin

	Movement:
	process (x, y)

	variable pos:integer:= 0;

	begin

		if x'EVENT and x = '1' then
			if xdir = '1' then
				pos:= pos + 1;
			elsif xdir = '0' then
				pos:= pos - 1;
			end if;
		elsif y'EVENT and y = '1' then
			if ydir = '1' then
				pos:= pos + 9;
			elsif ydir = '0' then
				pos:= pos - 9;
			end if;
		end if;

		if pos >= 80 then
			pos:= pos - 81;
		elsif pos <= 0 then
			pos:= pos + 81;
		end if;

		position <= pos;
	end process;

end behavior;

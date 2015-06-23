library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

Entity InputInterface is
	port(enter,
		 clear,
		 y,
	 	 x,
	 	 xdir,
	 	 ydir,
	 	 done: in std_logic;
	 	 data: in std_logic_vector(3 downto 0);
	 	 load,
	 	 go,
		 erase: out std_logic;
		 data_out: out std_logic_vector(3 downto 0);
	 	 position: out std_logic_vector(6 downto 0)
	 	);
end InputInterface;

Architecture behavior of InputInterface is

	signal temp_pos: std_logic_vector(6 downto 0);

begin

	load <= enter;
	erase <= clear;
	go <= done;

	data_out <= data;


	Movement:
	process (x, y)

	begin

		if x = '1' then
			if xdir = '1' then
				temp_pos <= temp_pos + '1';
			elsif xdir = '0' then
				temp_pos<= temp_pos - '1';
			end if;
		elsif y = '1' then
			if ydir = '1' then
				temp_pos<= temp_pos + "1001";
			elsif ydir = '0' then
				temp_pos<= temp_pos - "1001";
			end if;
		end if;

		if temp_pos >= 80 then
			temp_pos<= temp_pos - to_unsigned(81, position'LENGTH);
		elsif temp_pos <= 0 then
			temp_pos<= temp_pos + to_unsigned(81, position'LENGTH);
		end if;

	end process;
	
	position <= temp_pos;

end behavior;

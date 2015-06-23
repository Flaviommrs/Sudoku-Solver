library ieee;
use ieee.std_logic_1164.all;

entity Mux4to1 is 
	port(vec1, vec2 :in  std_logic_vector(3 downto 0);
		param: in std_logic;
		answer: out std_logic_vector(3 downto 0));
	 end Mux4to1;
	 
Architecture behavior of Mux4to1 is 
begin
	with param select
	answer	<= vec1 when '0',
				vec2 when '1';
	end behavior;
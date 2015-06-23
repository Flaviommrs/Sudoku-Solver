library ieee;
use ieee.std_logic_1164.all

entity ChooseData is 
port( 	data1, data2 : in std_logic_vector(3 downto 0);
		inputPhase, solucionerPhase : in std_logic;
		dataOut 	:	out std_logic_vector(3 downto 0));
	end ChooseData;

architecture behavior of ChooseData is
begin
	dataOut <= data1 when inputPhase = '1' else
				data2 when solucionerPhase = '1' else
				(others => '1') when others;
end behavior;
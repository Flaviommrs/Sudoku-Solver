library ieee;
use ieee.std_logic_1164.all;

Entity EntryVerifier is

	port(enable: in std_logic;
		 data: in std_logic_vector(3 downto 0);
		 valid: out std_logic;
		 data_out: out std_logic_vector(3 downto 0)
	);

end EntryVerifier;

Architecture behavior of EntryVerifier is

begin

	Verification:
	process (enable)
	begin

		if enable = '1' then

			if data > "1001" or data = "0000"  then 
				valid <= '0';
			else 
				valid <= '1';

			end if;

		end if;

	end process;


	data_out <= data;

end behavior;
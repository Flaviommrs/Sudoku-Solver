LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


entity Mux9to1 is
	port(vec1, vec2, vec3, vec4, vec5, vec6, vec7, vec8, vec9 : std_logic_vector(8 downto 0);
		 number: std_logic_vector(4 downto 0);
		 vec_out: std_logic_vector(8 downto 0)
		 );
	end Mux9to1;

architecture behavior of Mux9to1 is
	begin 
	vec_out <= vec9 when number = '1001'
			else vec1 when number = '0001'
			else vec2 when number = '0010'
			else vec3 when number = '0011'
			else vec4 when number = '0100'
			else vec5 when number = '0101'
			else vec6 when number = '0110'
			else vec7 when number = '0111'
			else vec8 when number = '1000'
			else (others =>'1') when others;
end behavior;
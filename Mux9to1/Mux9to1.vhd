LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


entity Mux9to1 is
	port(vec1, vec2, vec3, vec4, vec5, vec6, vec7, vec8, vec9 : std_logic_vector(8 downto 0);
		 number: in std_logic_vector(3 downto 0);
		 vec_out: out std_logic_vector(8 downto 0)
		 );
	end Mux9to1;

architecture behavior of Mux9to1 is
	begin 
	with number select
	vec_out <= vec9 when "1001",
			 vec1 when "0001",
			 vec2 when "0010",
			 vec3 when "0011",
			 vec4 when "0100",
			 vec5 when "0101",
			 vec6 when "0110",
			 vec7 when "0111", 
			 vec8 when "1000",
			 (others =>'1') when others;
end behavior;
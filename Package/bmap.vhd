LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

Entity bmap is
  port(
	position: in std_logic_vector(6 downto 0);
	clk, enable, clear: std_logic;
	x, y, region :out  std_logic_vector(8 downto 0)
  );
  end bmap;
architecture behavior of bmap is
signal l, c, r : std_logic_vector(8 downto 0) := (others => '0');


begin 
process(clk, enable)
	variable li, ci, ri : integer := 0;
	begin
	if clear = '1' then
		l <= (others => '0');
		c <= (others => '0');
		r <= (others => '0');

	elsif clk'Event and clk = '1' then
		if enable = '1' then
			li := to_integer(unsigned(position)) / 9;
			ci := to_integer(unsigned(position)) rem 9;
			ri := (li/3)*3 + ci/3;
			l(li) <= '1';
			c(ci) <= '1';
			r(ri) <= '1';
		end if;
	end if;
end process;

x <= l;
y <= c;
region <= r;

end behavior;

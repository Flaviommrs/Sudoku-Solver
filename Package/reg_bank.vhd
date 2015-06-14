LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY bank IS
	GENERIC (
		WORDSIZE : NATURAL := 4
	);
	PORT (
		WR_EN, RD_EN,
		clear,
		clock		: IN 	STD_LOGIC;
		WR_ADDR,
		RD_ADDR1	: IN	STD_LOGIC_VECTOR (6 DOWNTO 0);
		DATA_IN		: IN	STD_LOGIC_VECTOR (WORDSIZE-1 DOWNTO 0);
		Player_in	: in std_logic;
		DATA_OUT1	: OUT	STD_LOGIC_VECTOR (WORDSIZE-1 DOWNTO 0);
		Player_out	: out std_logic;
	);
END ENTITY;

ARCHITECTURE Behavior OF bank IS
	TYPE TArrayReg IS ARRAY (80 DOWNTO 0) OF STD_LOGIC_VECTOR (WORDSIZE-1 DOWNTO 0);
	
	SIGNAL D2R	: STD_LOGIC_VECTOR (80 DOWNTO 0);
	SIGNAL R2D	: TArrayReg;
	SIGNAL PLAYER : std_logic_vector (80 downto 0);
BEGIN
	Registers:
	FOR i IN 0 TO 80 GENERATE
		regs:
		reg GENERIC MAP (WORDSIZE) PORT MAP (DATA_IN,D2R(i), clear, clock,Player_in, R2D(i), PLAYER(i) );
	END GENERATE;
	
	WriteDecoder:
	PROCESS (WR_EN, WR_ADDR)
	BEGIN
		FOR i IN 0 TO 80 LOOP
			D2R(i) <= '0';
		END LOOP;
		IF (WR_EN = '1') THEN
			D2R(TO_INTEGER(UNSIGNED(WR_ADDR))) <= '1';
		ELSE
			D2R(TO_INTEGER(UNSIGNED(WR_ADDR))) <= '0';
		END IF;
	END PROCESS;

	ReadDecoder:
	PROCESS (RD_EN, RD_ADDR1, R2D)
	BEGIN
		IF (RD_EN = '1') THEN
			DATA_OUT1 <= R2D(TO_INTEGER(UNSIGNED(RD_ADDR1)));
			player_out <= PLAYER (TO_INTEGER(UNSIGNED(RD_ADDR1)));
		ELSE
			DATA_OUT1 <= (OTHERS => 'Z');
			player_out <= (OTHERS => 'Z');
		END IF;
	END PROCESS;
END ARCHITECTURE;
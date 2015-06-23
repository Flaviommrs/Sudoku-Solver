LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

ENTITY count_adder IS
	GENERIC(modulo: Integer := 8);
	PORT(Clock: IN STD_LOGIC ;
	     En, Set, LOAD, CLEAR, sign_negative: IN STD_LOGIC ;
         BCD: BUFFER STD_LOGIC_VECTOR(3 DOWNTO 0) := (others =>'0');
         PAR_IN: in STD_LOGIC_VECTOR(3 DOWNTO 0);
         CARRY_OUT: out STD_LOGIC := '0');
	END count_adder ;

ARCHITECTURE Behavior OF count_adder IS
	BEGIN
		
		PROCESS
		BEGIN
			
			wait until Clock'EVENT AND Clock = '1';
			
			if set = '1' then
				if LOAD = '1' THEN
					IF PAR_IN <= modulo then
						BCD <= PAR_IN;
					end if;	
				end if;
			elsIF CLEAR = '1' THEN
				BCD <= "0000";	
			elsif En = '1' then	
				if sign_negative = '1' then
					IF BCD = modulo THEN
						BCD <= "0000" ;
						CARRY_OUT <= '1';
					ELSE
						BCD <= BCD + '1' ;
						CARRY_OUT <= '0';
					END IF ;
				else
					if BCD = "0000" then
						BCD <= std_logic_vector(to_unsigned(modulo, BCD'length));
						CARRY_OUT <= '1';
					else
						BCD <= BCD - '1';
						CARRY_OUT <= '0';
					end if;
				end if;
			
			end if;
			
		END PROCESS;
		
	end behavior;
library ieee;
use ieee.std_logic_1164.all;

entity UnitControlSudoku is 
	port (	clk,
			gbl_clear,
			load_Im,
			go_Im_Sol,
			erase_Im,
			ver_bmap,
			ver_entry,
			ver_updatable_Im,
			ver_updatable_Sol, 
			Impossible_sol,
			Possible_sol,
			Sol_number_carry,
			Sol_sign: in std_logic;

			en_Im,
			en_bmapVer,
			en_entrVer,
			en_updVer,
			en_wr_bmaps,
			en_wr_regs,
			en_rd_regs,
			en_rd_bmaps,
			en_Sol_pos,
			en_Sol_number,
			en_Sol_sign,
			en_Sol_reset_num,
			en_Sol_reset_pos,
			is_Im: out std_logic);
	end UnitControlSudoku;
		
	
architecture behavior of UnitControlSudoku is
	TYPE states_UnitC IS (Input, Input_Verifications, InputRecording, InputErasing,Sol_reset,Sol_Verify, Sol_Judge,Sol_Num_Upg, Sol_upPos, Sol_downPos, Sol_Record, Sol_Finish);
	SIGNAL current_state : states_UnitC := Input;


begin
	StateMachine:
	PROCESS (gbl_clear, clk, load_Im, go_Im_Sol, erase_Im, ver_bmap, ver_entry, ver_updatable_Im, ver_updatable_Sol, Impossible_sol, Possible_sol, Sol_number_carry, Sol_sign , current_state)
	BEGIN
	--Update for Sol_Finish!
	--Uma interface de navegação, que permite o usuário verificar o sudoku, mas sem poder editar os valores do mesmo, e qqer sinal do mesmo será um sinal de clear.
	
		IF (gbl_clear = '1') THEN
			en_bmapVer			<= '0';
			en_entrVer			<= '0';
			en_updVer			<= '0';
			en_wr_bmaps			<= '0';
			en_wr_regs			<= '0';
			en_rd_bmaps			<= '0';
			en_rd_regs			<= '0';
			en_Im				<= '0';
			en_Sol_pos			<= '0';
			en_Sol_number		<= '0';
			en_Sol_sign			<= '0';
			en_Sol_reset_num	<= '1';
			en_Sol_reset_pos	<= '1';
			current_state <= Input;
		ELSIF (clk'EVENT AND clk = '1') THEN
			en_bmapVer			<= '0'; 
			en_entrVer			<= '0';
			en_updVer			<= '0';
			en_wr_bmaps			<= '0';
			en_wr_regs			<= '0';
			en_rd_bmaps			<= '0';
			en_rd_regs			<= '0';
			en_Im				<= '0';
			en_Sol_pos			<= '0';
			en_Sol_number		<= '0';
			en_Sol_sign			<= '0';
			en_Sol_reset_num	<= '0';
			en_Sol_reset_pos	<= '0';
			CASE current_state IS
			WHEN Input =>
				en_Im	<= '1';
				is_Im	<=	'1';
				if load_Im	= '1' then
					current_state <= Input_Verifications;
				elsif go_Im_Sol = '1' then
					current_state	<= Sol_reset;
				elsif erase_Im = '1' then
					current_state <= InputErasing;
				else
					current_state <= Input;
				end if;
			when Input_Verifications =>
				is_Im		<= '1';
				en_bmapVer	<= '1';
				en_entrVer	<= '1';
				en_updVer	<= '1';
				en_rd_bmaps <= '1';
				en_rd_regs	<= '1';
				current_state	<= InputRecording;
			WHEN InputRecording	=>
				is_Im		<= '1';
				if 	ver_bmap = '1' and ver_entry = '1' and ver_updatable_Im = '1' then 
					en_wr_bmaps	<=	'1';
					en_wr_regs	<=	'1';
					
				end if;
				current_state	<= Input;
			when InputErasing =>
				is_Im		<= '1';
				en_wr_bmaps	<='1';
				en_wr_regs	<='1';
				current_state	<= Input;
			when Sol_reset =>
				is_Im				<= '0';
				en_Sol_reset_num	<= '1';
				en_Sol_reset_pos	<= '1';
				current_state		<= Sol_Verify;
			
			when Sol_Verify =>
				is_Im		<= '0';
				en_bmapVer 	<= '1';
				en_entrVer	<= '1';
				en_updVer	<= '1';
				en_rd_bmaps	<= '1';
				en_rd_regs	<= '1';
				current_state	<= Sol_Judge;
			
			when Sol_Judge =>
				is_Im			<='0';
				if Possible_sol = '1' then
					current_state	<= Sol_Finish;
				elsif Impossible_sol = '1' then 
					current_state	<= Sol_Finish;
				elsif ver_updatable_Sol = '0' then
					if Sol_sign = '0' then
						current_state	<= Sol_upPos;
					else
						current_state	<= Sol_downPos;
					end if;
				elsif Sol_number_carry = '0' then
					en_Sol_reset_num	<= '1';
					current_state	<= Sol_downPos;
				elsif ver_bmap = '0' then
					current_state <= Sol_Num_Upg;
				else
					current_state	<= Sol_Record;
				end if;
			when Sol_Record =>
				is_Im		<= '0';
				en_wr_bmaps	<= '1';
				en_wr_regs	<= '1';
				current_state	<= Sol_upPos;
			when Sol_upPos =>
				is_Im		<= '0';
				en_Sol_pos	<= '1';
				en_Sol_sign <= '0';
				current_state	<= Sol_Verify;
			when Sol_downPos =>
				is_Im		<= '0';
				en_Sol_pos	<= '1';
				en_Sol_sign <= '1';
				current_state	<= Sol_Verify;
			when Sol_Num_Upg =>
				is_Im			<= '0';
				en_Sol_number	<= '1';
				current_state	<= Sol_Verify;
			when Sol_Finish =>
				--Criar uma unidade de controle que não cadastra nenhum número, e que ativa o clear global em algum trigger
				current_state	<= Input;
			
			END CASE;
		END IF;
	END PROCESS;

end behavior;

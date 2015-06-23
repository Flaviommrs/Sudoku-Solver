Library ieee;
use ieee.std_logic_1164.all;

--isUpdate: Verify if is on Input_manager state or not (1 is true);
--player : Verify the current position, and says that if was a player that eddicted or not (1 is true);
--Returns :
	-- Updatable : return 1 if is fine to update the actual number
	-- Regret_Solution_Player : return 1 if it can't be updated (not Updatable);
	-- Updated_inSolution 	: return 1 if can be updated in Solucioner.
entity verifierPlayerUpdate is
	port(	en,
			isManager,
			player : in std_logic;
			--data: in std_logic_vector(3 downto 0);
			regretSolution_Player,
			Updatable,
			Updated_inSolution: out std_logic);
		end verifierPlayerUpdate;
		
architecture behavior of verifierPlayerUpdate is
begin
	regretSolution_Player <= not (isManager or not player) and en;
	Updatable <=				 (isManager or (not player)) and en;
	Updated_inSolution <= not (isManager and player) and en; 
end behavior;
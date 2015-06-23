--Componente Sudoku: Top level principal, interliga as máquinas de estado do projeto. 
--Como entrada, pode receber um número de 4 bits, um pino pra setar esse número em uma determinada posição do sudoku,
-- outro pino para iniciar a máquina de estado seguinte, 4 pinos (dois para incrementar cada sentido, e outros 2 para definir o sentido);
-- Como saídas, recebe um pino para afirmar se o sudoku é possível ou não, e a solução corresponde a solução do sudoku ou não.
component Sudoku is
port(	number : in std_logic_vector(3 downto 0);
		set,start: in std_logic;
		changeX, changeY, directionX, directionY: in std_logic;
		possible: out std_logic;
		solution: out std_logic_vector(324 downto 0)
	);
	end Sudoku;
--Register sudoku: Ele cadastra os números do usuário na matriz do sudoku
Component registerSudoku is
component puzzle is
	port map (clear, set, horizont, vertical, direction_X, direction_Y: in std_logic;
			  number: in std_logic_vector(3 downto 0);
			  puzzle: out std_logic_vector(324 downto 0 );
			  user_puzzle: out std_logic_vector(80 downto 0);
			  )
	end component;
--Verifier 1: Verifica se o sudoku cadastrado pelo usuário é válido ou não
component vefifier_1 is
	port map (puzzle: in std_logic_vector(324 downto 0);
			  user_puzzle: in std_logic_vector(80 downto 0);
			  enable: in std_logic;
			  valid: out std_logic);
	end component;
--Verifier 2: verifica se o número atualmente incrementado no sudoku é válido ou não, na posição atual
component vefifier_2 is
	port map (puzzle: in std_logic_vector(324 downto 0);
			  user_puzzle: in std_logic_vector(80 downto 0);
			  enable: in std_logic;
			  x, y: in std_logic_vector(4 downto 0);
			  number: in std_logic_vector(4 downto 0);
			  valid: out std_logic;
			  operate_position: out std_logic;
			  operate_number: out std_logic);
	end component;
--Operator: ele faz operações de incrementação ou no número atualmente verificado, ou no índice localizado na matriz, em coordenadas em linha e coluna,
--Dependendo da resposta do verifier_2.
--Os números serão escritos na base bcd
component operator  is
	port map (puzzle: in std_logic_vector(324 downto 0);
			  user_puzzle: in std_logic_vector(80 downto 0);
			  valid: out std_logic);
	end component;
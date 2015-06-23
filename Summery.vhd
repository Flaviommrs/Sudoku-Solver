--Componente Sudoku: Top level principal, interliga as m�quinas de estado do projeto. 
--Como entrada, pode receber um n�mero de 4 bits, um pino pra setar esse n�mero em uma determinada posi��o do sudoku,
-- outro pino para iniciar a m�quina de estado seguinte, 4 pinos (dois para incrementar cada sentido, e outros 2 para definir o sentido);
-- Como sa�das, recebe um pino para afirmar se o sudoku � poss�vel ou n�o, e a solu��o corresponde a solu��o do sudoku ou n�o.
component Sudoku is
port(	number : in std_logic_vector(3 downto 0);
		set,start: in std_logic;
		changeX, changeY, directionX, directionY: in std_logic;
		possible: out std_logic;
		solution: out std_logic_vector(324 downto 0)
	);
	end Sudoku;
--Register sudoku: Ele cadastra os n�meros do usu�rio na matriz do sudoku
Component registerSudoku is
component puzzle is
	port map (clear, set, horizont, vertical, direction_X, direction_Y: in std_logic;
			  number: in std_logic_vector(3 downto 0);
			  puzzle: out std_logic_vector(324 downto 0 );
			  user_puzzle: out std_logic_vector(80 downto 0);
			  )
	end component;
--Verifier 1: Verifica se o sudoku cadastrado pelo usu�rio � v�lido ou n�o
component vefifier_1 is
	port map (puzzle: in std_logic_vector(324 downto 0);
			  user_puzzle: in std_logic_vector(80 downto 0);
			  enable: in std_logic;
			  valid: out std_logic);
	end component;
--Verifier 2: verifica se o n�mero atualmente incrementado no sudoku � v�lido ou n�o, na posi��o atual
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
--Operator: ele faz opera��es de incrementa��o ou no n�mero atualmente verificado, ou no �ndice localizado na matriz, em coordenadas em linha e coluna,
--Dependendo da resposta do verifier_2.
--Os n�meros ser�o escritos na base bcd
component operator  is
	port map (puzzle: in std_logic_vector(324 downto 0);
			  user_puzzle: in std_logic_vector(80 downto 0);
			  valid: out std_logic);
	end component;
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;
ENTITY Adder_sequential_tb IS
END Adder_sequential_tb;
ARCHITECTURE myarch_tb OF Adder_sequential_tb IS
	COMPONENT Adder_sequential IS 
		GENERIC(n : INTEGER); 
	    PORT(
	         a     : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	         b     : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		     start : IN  STD_LOGIC;
		     clk   : IN  STD_LOGIC;
		     nrst  : IN  STD_LOGIC;
		     sum   : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		     cout  : OUT STD_LOGIC;
		     done  : OUT STD_LOGIC
		    );
	END COMPONENT;
	SIGNAL a_tb     : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL b_tb     : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL start_tb : STD_LOGIC;
	SIGNAL clk_tb   : STD_LOGIC := '0';
	SIGNAL nrst_tb  : STD_LOGIC;
	SIGNAL sum_tb   : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL cout_tb  : STD_LOGIC;
	SIGNAL done_tb  : STD_LOGIC;
BEGIN
	cut : Adder_sequential GENERIC MAP (4)		
						   PORT MAP (a_tb, b_tb, start_tb, clk_tb, nrst_tb, sum_tb, cout_tb, done_tb);
	clk_tb   <= NOT clk_tb AFTER 10 ns;
	nrst_tb  <= '1', '0' AFTER 15 ns, '1' AFTER 35 ns;
	start_tb <= '0', '1' AFTER 25 ns;
	a_tb	 <= "0001";
	b_tb	 <= "0011";
END myarch_tb;

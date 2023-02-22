LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
ENTITY miniproc_tb IS 
END miniproc_tb; 
ARCHITECTURE mytest OF miniproc_tb IS
	COMPONENT miniproc IS 
		PORT (
			  clk, nrst   : IN    std_logic;
			  opcode      : IN    std_logic_vector(3 DOWNTO 0)
		      );
	END COMPONENT; 
	SIGNAL opcode_tb 	: std_logic_vector(3 DOWNTO 0);
	SIGNAL clk_tb 		: std_logic := '0';
	SIGNAL nrst_tb		: std_logic;
BEGIN
	cut: miniproc PORT MAP (clk_tb, nrst_tb, opcode_tb);
	clk_tb <= NOT clk_tb AFTER 5 ns;
	nrst_tb <= '0', '1' AFTER 12 ns;
    --opcode_tb <= "0000", "0001" AFTER 17 ns, "0010" AFTER 27 ns, "0011" AFTER 37 ns, "0100" AFTER 47 ns, "0101" AFTER 57 ns, "0110" AFTER 67 ns, "0111" AFTER 77 ns, "1000" AFTER 87 ns, "1001" AFTER 97 ns, "1010" AFTER 107 ns;
	opcode_tb <= "0000", "0111" AFTER 19 ns;
END mytest;

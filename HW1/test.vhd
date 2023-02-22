LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY excercise1 IS
	PORT ( a : IN  std_logic_vector(3 DOWNTO 0);
		   y : OUT std_logic_vector(4 DOWNTO 0)
		  );
END excercise1;
ARCHITECTURE test OF excercise1 IS
BEGIN
	y <= a & '0' AFTER 2 ns;
END test;
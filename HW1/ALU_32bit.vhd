LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_signed.ALL;

ENTITY ALU IS
	PORT (a    : IN   std_logic_vector(31 DOWNTO 0);
	      b    : IN   std_logic_vector(31 DOWNTO 0);
		  cin  : IN   std_logic;
		  func : IN   INTEGER RANGE 0 TO 15;
		  Y	   : OUT  std_logic_vector(31 DOWNTO 0);
		  Cout : OUT  std_logic
		  );
END ALU;
ARCHITECTURE myarch OF ALU IS
	TYPE AluOut IS ARRAY(0 TO 15) OF STD_LOGIC_VECTOR (32 DOWNTO 0);
	SIGNAL temp : AluOut;
    FUNCTION hamingweight(
                input: std_logic_vector
                ) RETURN INTEGER IS
        variable hamingweight : INTEGER := 0;
	  BEGIN
        FOR i IN input'RANGE LOOP
            IF input(i) = '1' THEN 
                hamingweight := hamingweight + 1;
            END IF;
        END LOOP;
        RETURN hamingweight;
    END FUNCTION hamingweight;    
BEGIN
		temp(0) <= '0' & NOT a                                                AFTER 1 ns; 				-- not a
        temp(1) <= '0' & (a NAND b) 										  AFTER 2 ns;				-- a and b
        temp(2) <= '0' & (a NOR b)											  AFTER 2 ns;			    -- a nor b
        temp(3) <= '0' & (a XOR b) 											  AFTER 2 ns;				-- a xor b
        temp(4) <= '0' & (a AND b) 										      AFTER 1 ns;				-- a and b
		temp(5) <= std_logic_vector(to_unsigned(hamingweight(a), 33))         AFTER 6 ns;				-- hw(a)	use hamingweight function and convert integer result to SLV														
		temp(6) <= std_logic_vector(to_unsigned(hamingweight(b), 33))         AFTER 6 ns;				-- hw(b)
        temp(7) <= ('0' & NOT a) + "000000000000000000000000000000001"        AFTER 3 ns;			    -- -a two's complement of a
        temp(8) <= ('0' & a) + ('0' & b) + cin 								  AFTER 3 ns;	            -- a + b + cin
        temp(9) <= a + (NOT b) + "000000000000000000000000000000001"          AFTER 3 ns;			    -- a - b -> a + two's complement of b
        temp(10) <= (0 => '1',OTHERS  => '0') WHEN a > b ELSE (OTHERS => '0') AFTER 2 ns;				-- a > b
        temp(11) <= (0 => '1',OTHERS  => '0') WHEN a < b ELSE (OTHERS => '0') AFTER 2 ns;				-- a < b
        temp(12) <= (0 => '1',OTHERS  => '0') WHEN a = b ELSE (OTHERS => '0') AFTER 2 ns;				-- a == b
        temp(13) <='0' & a(0) & (a(31 DOWNTO 1)) 							  AFTER 1 ns;				-- ror(a)
        temp(14) <='0' & (b(30 DOWNTO 0)) & b(31) 							  AFTER 1 ns;				-- rol(b)
        temp(15) <= (OTHERS => '0') 										  AFTER 1 ns;				-- 0
		
		Y	 <= temp(func)(31 DOWNTO 0);
		Cout <= temp(func)(32);
END myarch;

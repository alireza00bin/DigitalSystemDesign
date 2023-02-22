LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

ENTITY Adder_sequential IS
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
END Adder_sequential;
ARCHITECTURE myarch OF Adder_sequential IS
	SIGNAL areg    : STD_LOGIC_VECTOR(n-1 DOWNTO 0) := a;
	SIGNAL breg    : STD_LOGIC_VECTOR(n-1 DOWNTO 0) := b;
    SIGNAL sumreg  : STD_LOGIC_VECTOR(n-1 DOWNTO 0) := (OTHERS => '0');
	SIGNAL coutreg : STD_LOGIC := '0';
BEGIN
	PROCESS (clk)
		
		VARIABLE cnt     : INTEGER := 0;
	BEGIN
		IF (clk'EVENT AND clk = '1') THEN 
			IF (nrst = '0') THEN 
				cout <= '0';
				sum  <= (OTHERS => '0');
				done <= '0';
			ELSIF (start = '1') THEN 
				IF (cnt = n) THEN
					done <= '1';
					sum  <= sumreg;
					cout <= coutreg;
				ELSIF ( cnt < n) THEN 
				
					sumreg(cnt)  <= (a(cnt) XOR b(cnt) XOR coutreg);
					coutreg <= (coutreg AND a(cnt)) OR (coutreg AND b(cnt)) OR (a(cnt) AND b(cnt));
					cnt := cnt + 1;
		--areg <= '0' & areg(n - 1 downto 1);
		--breg <= '0' & breg(n - 1 downto 1);
				END IF;
			END IF;
		END IF;
		
	END PROCESS;
	done <= '1';
END myarch;

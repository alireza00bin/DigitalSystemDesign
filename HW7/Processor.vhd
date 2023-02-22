LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;
ENTITY miniproc IS 
    PORT (
        clk, nrst   : IN    STD_LOGIC;
        opcode      : IN    STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END miniproc; 
ARCHITECTURE behavioral OF miniproc IS
    TYPE state IS (T0, T1, T2, T3, T4, T5);
	SIGNAL cur_state, nxt_state : state;
	-- Control signals
	SIGNAL A_LD  : STD_LOGIC;
	SIGNAL B_LD  : STD_LOGIC;
	SIGNAL C_LD  : STD_LOGIC;
	SIGNAL D_LD  : STD_LOGIC;
	SIGNAL AC_LD : STD_LOGIC;
	SIGNAL WR    : STD_LOGIC;
	SIGNAL cbus  : STD_LOGIC_VECTOR(31 DOWNTO 0):= (OTHERS => '0');
	SIGNAL sel 	 : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
	SIGNAL func  : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
	
	SIGNAL Z 	 : STD_LOGIC_VECTOR(31 DOWNTO 0);

	-- Registers
	SIGNAL A 	: STD_LOGIC_VECTOR(5 DOWNTO 0)  := (OTHERS => '0');
	SIGNAL B 	: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL C 	: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL D 	: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL AC 	: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	
	-- Memory
	TYPE MEM IS ARRAY (0 TO 63) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL memory : MEM := (OTHERS => (OTHERS => '0'));
	
BEGIN

	-- SELECT 
	cbus <= memory(TO_INTEGER(UNSIGNED(A))) WHEN sel = "00" ELSE
			B WHEN sel = "01" ELSE
			AC;
	
	-- FUNCTION 
	z <= 	C       WHEN func = "000" ELSE
			D	    WHEN func = "001" ELSE
			C + D   WHEN func = "010" ELSE
			C - D   WHEN func = "011" ElSE
			C AND D WHEN func = "100" ELSE
			C XOR D WHEN func = "101" ElSE
			STD_LOGIC_VECTOR(SHIFT_LEFT(UNSIGNED(D), TO_INTEGER(UNSIGNED(C(4 DOWNTO 0)))));
			
    controlpath: PROCESS (cur_state, opcode)
    BEGIN
		A_LD <= '0';
		B_LD <= '0';
		C_LD <= '0';
		D_LD <= '0';
		AC_LD <= '0';
		CASE cur_state is
			WHEN T0 =>
				CASE opcode IS
					WHEN "0000" => AC_LD <= '1'; func <= "000"; nxt_state <= T0; -- AC <- C
					WHEN "0001" => AC_LD <= '1'; func <= "001"; nxt_state <= T0; -- AC <- D
 					WHEN "0010" => AC_LD <= '1'; func <= "010"; nxt_state <= T0; -- AC <- C + D
					WHEN "0011" => sel  <= "01"; D_LD <= '1';   nxt_state <= T1; -- AC <- B AND C
					WHEN "0100" => sel  <= "01"; D_LD <= '1';   nxt_state <= T1; -- AC <- B XOR C 
					WHEN "0101" => sel  <= "00"; C_LD <= '1';   nxt_state <= T1; -- AC <- MEM[A]
					WHEN "0110" => sel  <= "10"; WR   <= '1' ;  nxt_state <= T0; -- MEM[A] <- AC 
					WHEN "0111" => sel  <= "01"; A_LD <= '1';   nxt_state <= T1; -- AC <- MEM[B] + MEM[C]
					WHEN "1000" => sel  <= "01"; A_LD <= '1';   nxt_state <= T1; -- AC <- MEM[B] - MEM[C]
					WHEN "1001" => sel  <= "01"; D_LD <= '1';   nxt_state <= T1; -- MEM[A] <- B XOR C
					WHEN "1010" => sel  <= "01"; D_LD <= '1';   nxt_state <= T1; -- MEM[A] <- B << C[4:0]
					WHEN OTHERS => 
				END CASE;

			WHEN T1 =>
				CASE opcode IS
					WHEN "0011" => AC_LD <= '1'; func <= "100"; nxt_state <= T0; -- AC <- B AND C
					WHEN "0100" => AC_LD <= '1'; func <= "101"; nxt_state <= T0; -- AC <- B XOR C
					WHEN "0101" => AC_LD <= '1'; func <= "000"; nxt_state <= T0; -- AC <- MEM[A]
					WHEN "0111" => sel  <= "00"; D_LD <= '1';   nxt_state <= T2; -- AC <- MEM[B] + MEM[C]
					WHEN "1000" => sel  <= "00"; D_LD <= '1';   nxt_state <= T2; -- AC <- MEM[B] - MEM[C]
					WHEN "1001" => AC_LD <= '1'; func <= "101"; nxt_state <= T2; -- MEM[A] <- B XOR C
					WHEN "1010" => AC_LD <= '1'; func <= "110"; nxt_state <= T2; -- MEM[A] <- B << C[4:0]
					WHEN OTHERS => 
				END CASE;

			WHEN T2 =>
				CASE opcode IS
					WHEN "0111"	=> AC_LD <= '1' ; func  <= "000"; nxt_state <= T3; -- AC <- MEM[B] + MEM[C]
                    WHEN "1000"	=> AC_LD <= '1' ; func  <= "000"; nxt_state <= T3; -- AC <- MEM[B] - MEM[C]
                    WHEN "1001"	=> sel  <= "10" ; WR    <= '1'; nxt_state <= T0; -- MEM[A] <- B XOR C
                    WHEN "1010"	=> sel  <= "10" ; WR    <= '1'; nxt_state <= T0; -- MEM[A] <- B << C[4:0]
                    WHEN OTHERS =>
				END CASE;
			WHEN T3 =>
				CASE opcode IS 
					WHEN "0111"	=> sel  <= "10" ; A_LD  <= '1'; nxt_state <= T4; -- AC <- MEM[B] + MEM[C]
                    WHEN "1000"	=> sel  <= "10" ; A_LD  <= '1'; nxt_state <= T4; -- AC <- MEM[B] - MEM[C]
                    WHEN OTHERS => 
				END CASE;
				
			WHEN T4 =>
				CASE opcode IS
					WHEN "0111"	=> sel <= "00"; C_LD <= '1';  nxt_state <= T5; -- AC <- MEM[B] + MEM[C]
					WHEN "1000"	=> sel <= "00"; C_LD <= '1';  nxt_state <= T5; -- AC <- MEM[B] - MEM[C]
					WHEN OTHERS => 
				END CASE;
			WHEN OTHERS =>
				CASE opcode IS
					WHEN "0111"	=> AC_LD <= '1'; func <= "010";  nxt_state <= T0; -- AC <- MEM[B] + MEM[C]
					WHEN "1000"	=> AC_LD <= '1'; func <= "011";  nxt_state <= T0; -- AC <- MEM[B] - MEM[C]
					WHEN OTHERS => 
				END CASE;
		END CASE;
    END PROCESS controlpath;


    datapath: PROCESS (clk, nrst)
    BEGIN
        IF clk = '1' AND clk'EVENT THEN
			IF nrst = '0' THEN
				cur_state <= T0;
				memory <= (OTHERS => (OTHERS => '0'));
				A <= "000001";
				B <= X"00000001";
                C <= X"00000010";
                D <= X"00000100";
			ELSE
				IF A_LD = '1' THEN
					A <= cbus(5 DOWNTO 0);
				END IF;
				IF B_LD = '1' THEN
					B <= cbus;
				END IF;
				IF C_LD = '1' THEN
					C <= cbus;
				END IF;
				IF D_LD = '1' THEN
					D <= cbus;
				END IF;
				IF AC_LD = '1' THEN
					AC <= z;
				END IF;
				IF WR = '1' THEN 
					memory(TO_INTEGER(UNSIGNED(A))) <= cbus;
				END IF;
				cur_state <= nxt_state;
			END IF;
        END IF;
    END PROCESS datapath;
	
	

END behavioral;

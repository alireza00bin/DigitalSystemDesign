LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
ENTITY Elevator_tb IS 
END Elevator_tb;
ARCHITECTURE my_test_bench OF Elevator_tb IS 
			
	COMPONENT Elevator IS 
		PORT (
	          come   	     : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		      cf     	     : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		      switch 	     : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		      clk    	     : IN  STD_LOGIC;
		      nrst   	     : IN  STD_LOGIC;
		      motor_up   	 : OUT STD_LOGIC;
		      motor_down 	 : OUT STD_LOGIC;
		      elevator_state : OUT STD_LOGIC;
		      Current_floor  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		      );
	END COMPONENT;
	SIGNAL come_tb   	      : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL cf_tb     	      : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL switch_tb 	      : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL clk_tb    	      : STD_LOGIC := '0';
	SIGNAL nrst_tb   	      : STD_LOGIC;
	SIGNAL motor_up_tb   	  : STD_LOGIC;
	SIGNAL motor_down_tb 	  : STD_LOGIC;
	SIGNAL elevator_state_tb : STD_LOGIC;
	SIGNAL Current_floor_tb  : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN 	
	cut : Elevator PORT MAP (come_tb, cf_tb, switch_tb, clk_tb, nrst_tb, motor_up_tb, motor_down_tb, elevator_state_tb, Current_floor_tb);
	clk_tb  <= NOT clk_tb AFTER 5 ns;
	nrst_tb <= '0', '1' AFTER 11 ns;
	
	come_tb   <= "0000" AFTER 0 ns, "0010" AFTER 50 ns;
	cf_tb     <= "0100" AFTER 14 ns, "0001" AFTER 23 ns;
    switch_tb <= "0001" AFTER 0 ns, "0010" AFTER 55 ns, "0100" AFTER 75 ns, "0010" AFTER 95 ns;

    
ENd my_test_bench;
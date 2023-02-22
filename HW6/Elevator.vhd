LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
ENTITY Elevator IS 
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
END Elevator;
ARCHITECTURE myarch OF Elevator IS
	Type state IS (up, down, steady);
	SIGNAL cur_state  : state := steady;
	SIGNAL next_state : state := steady;
	SIGNAL request    : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL temp		  : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
BEGIN
	PROCESS (clk)
	BEGIN
		IF (clk='1' AND nrst='1') THEN
            motor_down     <= '0';
            motor_up   	   <= '0';
            elevator_state <= '0';
            next_state 	   <= steady;
		ELSIF (clk='1' AND cur_state = steady) THEN 
            motor_down 	   <= '0';
            motor_up   	   <= '0';
            elevator_state <= '0';
            IF (temp = request) THEN
                next_state <= steady;
            ELSIF (temp < request) THEN
                next_state <= up;
            ELSIF (temp > request) THEN
                next_state <= down;
            END IF;
        ELSIF (clk='1' AND cur_state = up) THEN 
            motor_down 	   <= '0';
            motor_up   	   <= '1';
            elevator_state <= '1';
            IF (temp = request) THEN
                next_state<= steady;
            ELSIF (temp < request) THEN
                next_state <= up;
            END IF;
        ELSIF (clk='1' AND cur_state = down) THEN 
            motor_down     <= '1';
            motor_up       <= '0';
            elevator_state <= '1';
            IF (temp = request) THEN
                next_state <= steady;
            ELSIF(temp >= request) THEN
                next_state <= down;
            END IF;
        END IF;
	END PROCESS;
	
	PROCESS(switch, nrst)
    BEGIN
        IF (nrst'EVENT AND nrst = '1') THEN
            temp <= "0000";
        ELSIF(switch'EVENT AND switch="0001") THEN
            temp <= "0001";
        ELSIF(switch'EVENT AND switch="0010") THEN
            temp <= "0010";
        ELSIF(switch'EVENT AND switch="0100") THEN
            temp <= "0100";
        ELSIF(switch'EVENT AND switch="1000") THEN
            temp <= "1000";
        END IF;
    END PROCESS ;
	
	PROCESS(cf , come, nrst)
    BEGIN
        IF (nrst'EVENT AND nrst = '1') THEN
            request <= "0000";
        ELSIF(cf'EVENT AND cf = "1000") THEN
            request <= "1000";
        ELSIF(cf'EVENT AND cf = "0100") THEN
            request <= "0100";
        ELSIF(cf'EVENT AND cf = "0010") THEN
            request <= "0010";
        ELSIF(cf'EVENT AND cf = "0001") THEN
            request <= "0001";
        ELSIF(come'EVENT AND come = "1000") THEN
            request <= "1000";      
        ELSIF(come'EVENT AND come = "0100") THEN
            request <= "0100";      
        ELSIF(come'EVENT AND come = "0010") THEN
            request <= "0010";      
        ELSIF(come'EVENT AND come = "0001") THEN
            request <= "0001";
        END IF;
    END PROCESS;
	
	PROCESS(clk)
    BEGIN
        IF (clk = '1' AND nrst = '0') THEN
            cur_state <= next_state;
        END IF;
    END PROCESS;
	
	Current_floor <= temp;
END myarch;

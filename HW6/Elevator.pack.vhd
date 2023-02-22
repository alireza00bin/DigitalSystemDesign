LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
PACKAGE Elevator_pack IS  
    TYPE reg_bank IS ARRAY (0 TO 31) OF std_logic_vector(31 DOWNTO 0);

    PROCEDURE read_test_vector_from_file (
                    PORT (
						  come   	     : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
						  cf     	     : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
						  switch 	     : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
						  motor_up   	 : OUT STD_LOGIC;
						  motor_down 	 : OUT STD_LOGIC;
						  elevator_state : OUT STD_LOGIC;
						  Current_floor  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		  );
END PACKAGE Elevator_pack;

PACKAGE BODY Elevator_pack IS  
    PROCEDURE read_test_vector_from_file (
					SIGNAL come   	     : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
					SIGNAL cf     	     : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
					SIGNAL switch 	     : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
					SIGNAL motor_up   	 : OUT STD_LOGIC;
					SIGNAL motor_down 	 : OUT STD_LOGIC;
					SIGNAL elevator_state : OUT STD_LOGIC;
					SIGNAL Current_floor  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) ) IS
        TYPE myfile IS FILE OF character;
        FILE fp : myfile;
        VARIABLE c : character;
        VARIABLE current_time : TIME := 3 ns;
        VARIABLE line_number : integer := 1;
    BEGIN
    
       FILE_OPEN(fp, "input.txt", READ_MODE);

       -- ignore line 1
       FOR i IN 0 TO 13 LOOP
        READ(fp, c);
       END LOOP;

       -- ignore line 2
       FOR i IN 0 TO 13 LOOP
        READ(fp, c);
       END LOOP;       
       
       WHILE ( NOT ENDFILE(fp) ) LOOP

            
       END LOOP;
       FILE_CLOSE(fp);
    END read_test_vector_from_file;
END PACKAGE BODY Elevator_pack;
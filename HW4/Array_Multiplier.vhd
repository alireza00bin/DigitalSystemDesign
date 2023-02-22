LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;
ENTITY Array_Multiplier IS 
	GENERIC (n : INTEGER);
	PORT(
		 multiplicand : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		 multiplier   : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		 product	  : OUT STD_LOGIC_VECTOR(2*n-1 DOWNTO 0)
		);
END Array_Multiplier;
ARCHITECTURE myarch OF Array_Multiplier IS 
	TYPE array_of_product IS ARRAY (0 TO n) OF STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
	SIGNAL bit_product, bit_carry, bit_sum : array_of_product;
BEGIN
	----------------------------------------------------------------
	--						   MULTI							  --
	----------------------------------------------------------------
	gen1:FOR i IN multiplier'REVERSE_RANGE GENERATE
		gen2:FOR j IN multiplicand'REVERSE_RANGE GENERATE
			bit_product(i)(j)<=multiplicand(j) and multiplier(i);
		END GENERATE;
		bit_carry(0)(i)<='0';
	END GENERATE;
	bit_sum(0)<=bit_product(0);
	product(0)<=bit_product(0)(0);												-- a0b0 -> directly is the product0
	----------------------------------------------------------------
	--							SUM								  --
	----------------------------------------------------------------
	
	add1:FOR i IN 1 TO n-1 GENERATE
		add2:FOR j IN 0 TO n-2 GENERATE
			bit_sum(i)(j)  <= bit_product(i)(j) xor bit_sum(i-1)(j+1) xor bit_carry(i-1)(j);
			bit_carry(i)(j)<=(bit_product(i)(j) and bit_carry(i-1)(j)) or
			                 (bit_product(i)(j) and bit_sum(i-1)(j+1)) or
			                 (bit_carry(i-1)(j) and bit_sum(i-1)(j+1));
		END GENERATE;
		product(i)<=bit_sum(i)(0);
		bit_sum(i)(n-1)<=bit_product(i)(n-1); 
	END GENERATE;
	bit_carry(n)(0)<='0';
	
	
	
	lastadd:FOR k IN 1 TO n-1 GENERATE
			bit_sum(n)(k)  <= bit_carry(n)(k-1)  xor bit_sum(n-1)(k) xor bit_carry(n-1)(k-1);
			bit_carry(n)(k)<=(bit_carry(n)(k-1)  and bit_carry(n-1)(k-1)) or
					         (bit_carry(n)(k-1)  and bit_sum(n-1)(k)) 	  or
		                     (bit_carry(n-1)(k-1)and bit_sum(n-1)(k));
    END GENERATE;
	product(2*n-1) <= bit_carry(n)(n-1);
	product(2*n-2 DOWNTO n)<=bit_sum(n)(n-1 DOWNTO 1);
END myarch;

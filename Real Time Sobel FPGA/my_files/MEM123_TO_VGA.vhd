LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
--USE IEEE.numeric_std.all;   -- CHANGED THIS
--USE IEEE.std_logic_arith.all;

ENTITY MEM123_TO_VGA IS
	port (
	  clk	      			: IN STD_LOGIC;
	  data_mem_1, data_mem_2, data_mem_3 : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	  mem_123_in			: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	  mem_gray_out			: OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	  );
END MEM123_TO_VGA;

ARCHITECTURE behavior OF MEM123_TO_VGA IS

BEGIN
	save_write_in_memory: PROCESS (clk) IS
	
	BEGIN
		--IF (rising_edge(clk) and clk = '1') THEN
		IF (clk = '1') THEN
			
			IF(mem_123_in = B"00") THEN
				mem_gray_out <= data_mem_1;
			ELSIF(mem_123_in = B"01") THEN
				mem_gray_out <= data_mem_2;
			ELSIF(mem_123_in = B"10") THEN
				mem_gray_out <= data_mem_3;
			END IF;
		
		END IF; -- clk
		
	END PROCESS; -- write_in_memory
END behavior;

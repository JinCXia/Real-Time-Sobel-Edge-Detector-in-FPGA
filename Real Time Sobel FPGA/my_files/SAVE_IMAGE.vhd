LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
--USE IEEE.numeric_std.all;   -- CHANGED THIS
--USE IEEE.std_logic_arith.all;

ENTITY SAVE_IMAGE IS
	port (
	  clk	      			: IN STD_LOGIC;
	  gray_in				: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	  X,Y					: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	  --sw0					: IN STD_LOGIC;
	  save_gray_out			: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
	  save_w_enable			: OUT STD_LOGIC;
	  save_addr_mem			: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
	  save_addr_mem_read	: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
	  mem_123				: BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0) := B"00"
	  --save_dentro_zona	: OUT STD_LOGIC
	  );
END SAVE_IMAGE;

ARCHITECTURE behavior OF SAVE_IMAGE IS
	SIGNAL SAVE_PONTEIRO_ADDR	: STD_LOGIC_VECTOR(9 DOWNTO 0) := B"0000000000";
	SIGNAL Y_ANT				: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL conta_640			: STD_LOGIC_VECTOR(9 DOWNTO 0);

BEGIN
	save_write_in_memory: PROCESS (clk) IS
	
	BEGIN
		--IF (rising_edge(clk) and clk = '1') THEN
		IF (clk = '1') THEN
			save_w_enable <= '0';

			save_gray_out <= B"0000000000";

			IF(X = B"0000000000" AND Y = B"0000000000") THEN
				SAVE_PONTEIRO_ADDR <= B"0000000000";
				Y_ANT <= Y;
				mem_123 <= B"00";
			END IF;

			IF(Y_ANT /= Y) THEN
				SAVE_PONTEIRO_ADDR <= B"0000000000";
				Y_ANT <= Y;
				IF(mem_123 = B"10") THEN
					mem_123 <= B"00";
				ELSE
					mem_123 <= mem_123 + B"01";
				END IF;
			END IF;
			
			
			IF(X < B"1010000000" AND Y < B"0111100000") THEN
				IF(SAVE_PONTEIRO_ADDR < B"1100100000") THEN
					SAVE_PONTEIRO_ADDR <= SAVE_PONTEIRO_ADDR + B"0000000001";
					save_gray_out <= gray_in;
					save_w_enable <= '1';
				END IF;
			END IF;
			
			save_addr_mem <= SAVE_PONTEIRO_ADDR;
			save_addr_mem_read <= SAVE_PONTEIRO_ADDR - B"0000000001";
		
		END IF; -- clk
		
	END PROCESS; -- write_in_memory
END behavior;

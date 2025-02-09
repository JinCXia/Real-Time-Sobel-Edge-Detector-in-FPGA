LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
--USE IEEE.numeric_std.all;   -- CHANGED THIS
--USE IEEE.std_logic_arith.all;

ENTITY GET_MASK IS
	port (
	  clk_vga								: IN STD_LOGIC;
	  save_addr								: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	  data_mem_1, data_mem_2, data_mem_3	: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	  mem_123_in							: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	  A0, A1, A2, A3, A5, A6, A7, A8		: BUFFER STD_LOGIC_VECTOR(9 DOWNTO 0)
	  --filtro_w_mem_addr						: OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	  --filtro_w_enable_mem					: OUT STD_LOGIC
	  --filtro_r_mem_addr						: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
	  );
END GET_MASK;

ARCHITECTURE behavior OF GET_MASK IS
	SIGNAL conta_3								: STD_LOGIC_VECTOR(1 DOWNTO 0) := B"00";
	SIGNAL FILTRO_PONTEIRO_ADDR					: STD_LOGIC_VECTOR(9 DOWNTO 0) := B"0000000000";
	SIGNAL V0, V1, V2, V3, V4, V5, V6, V7, V8	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	
BEGIN
	filtro_sobel: PROCESS (clk_vga) IS
	BEGIN
	
		--IF (rising_edge(clk_500) and clk_500 = '1') THEN
		IF (clk_vga = '1') THEN
			
			IF(save_addr = B"0000000000") THEN
				conta_3 <= B"01";
			END IF;
			
			-- Guarda no buffer o que recebe da memoria
			CASE conta_3 IS
				WHEN B"00" =>
					-- e so para nao fazer nada neste ciclo de relogio
				WHEN B"01" =>
					IF(mem_123_in = b"00") THEN
						V0 <= data_mem_2;
						V3 <= data_mem_3;
						V6 <= data_mem_1;
					ELSIF(mem_123_in = b"01") THEN
						V0 <= data_mem_3;
						V3 <= data_mem_1;
						V6 <= data_mem_2;
					ELSIF(mem_123_in = b"10") THEN
						V0 <= data_mem_1;
						V3 <= data_mem_2;
						V6 <= data_mem_3;
					END IF;
				WHEN B"10" =>
					IF(mem_123_in = b"00") THEN
						V1 <= data_mem_2;
						V4 <= data_mem_3;
						V7 <= data_mem_1;
					ELSIF(mem_123_in = b"01") THEN
						V1 <= data_mem_3;
						V4 <= data_mem_1;
						V7 <= data_mem_2;
					ELSIF(mem_123_in = b"10") THEN
						V1 <= data_mem_1;
						V4 <= data_mem_2;
						V7 <= data_mem_3;
					END IF;
				WHEN B"11" =>
					IF(mem_123_in = b"00") THEN
						V2 <= data_mem_2;
						V5 <= data_mem_3;
						V8 <= data_mem_1;
					ELSIF(mem_123_in = b"01") THEN
						V2 <= data_mem_3;
						V5 <= data_mem_1;
						V8 <= data_mem_2;
					ELSIF(mem_123_in = b"10") THEN
						V2 <= data_mem_1;
						V5 <= data_mem_2;
						V8 <= data_mem_3;
					END IF;
			END CASE;
				
			CASE conta_3 IS
				WHEN B"01" =>
					A0 <= V1;
					A3 <= V4;
					A6 <= V7;
					
					A1 <= V2;
					A7 <= V8;
					
					A2 <= V0;
					A5 <= V3;
					A8 <= V6;

				WHEN B"10" =>
					A0 <= V2;
					A3 <= V5;
					A6 <= V8;
					
					A1 <= V0;
					A7 <= V6;
					
					A2 <= V1;
					A5 <= V4;
					A8 <= V7;
				WHEN B"11" =>
					A0 <= V0;
					A3 <= V3;
					A6 <= V6;
					
					A1 <= V1;
					A7 <= V7;
					
					A2 <= V2;
					A5 <= V5;
					A8 <= V8;
				WHEN OTHERS =>
				
			END CASE;
			
			CASE conta_3 IS
				WHEN B"11" =>
					conta_3 <= B"01";
				WHEN OTHERS =>
					conta_3 <= conta_3 + B"01";
			END CASE;
		
		END IF; -- clk
		
	END PROCESS; -- write_in_memory
	
END behavior;

-------------------------------------------------------------------------------
-- Cameron Marsh
-- BCD Driver design for seven segment display. Fully combinational, not clocked.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_seg is
  port (
    clk             : in std_logic; 
    reset           : in std_logic;
    bcd             : in std_logic_vector(3 downto 0);
    seven_seg_out   : out std_logic_vector(6 downto 0)
  );  
end seven_seg;

architecture beh of seven_seg is
 -- Declarative section
	constant SEG0 : std_logic_vector := "1000000";
	constant SEG1 : std_logic_vector := "1111001";
	constant SEG2 : std_logic_vector := "0100100";
	constant SEG3 : std_logic_vector := "0110000";
	constant SEG4 : std_logic_vector := "0011001";
	constant SEG5 : std_logic_vector := "0010010";
	constant SEG6 : std_logic_vector := "0000010";
	constant SEG7 : std_logic_vector := "1111000";
	constant SEG8 : std_logic_vector := "0000000";
	constant SEG9 : std_logic_vector := "0011000";
	constant ERROR : std_logic_vector := "0000110";

	begin
-- Behavioral section
	process(bcd)
	begin
		if reset = '1' then
			seven_seg_out <= SEG0;
		else
			case bcd is
				when "0000" => seven_seg_out <= SEG0;
				when "0001" => seven_seg_out <= SEG1;
				when "0010" => seven_seg_out <= SEG2;
				when "0011" => seven_seg_out <= SEG3;
				when "0100" => seven_seg_out <= SEG4;
				when "0101" => seven_seg_out <= SEG5;
				when "0110" => seven_seg_out <= SEG6;
				when "0111" => seven_seg_out <= SEG7;
				when "1000" => seven_seg_out <= SEG8;
				when "1001" => seven_seg_out <= SEG9;
				when others => seven_seg_out <= ERROR;
			end case;
		end if;
	end process;
end beh;
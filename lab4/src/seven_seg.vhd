-------------------------------------------------------------------------------
-- Cameron Marsh
-- BCD Driver design for seven segment display. Fully combinational, not clocked.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_seg is
  port (
    reset           : in std_logic;
    bcd             : in std_logic_vector(3 downto 0);
    ssd_out   : out std_logic_vector(6 downto 0)
  );  
end seven_seg;

architecture beh of seven_seg is
 -- Declarative section (1 = segment off)
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
	constant SEGA : std_logic_vector := "0001000";
	constant SEGB : std_logic_vector := "0000011";
	constant SEGC : std_logic_vector := "1000110";
	constant SEGD : std_logic_vector := "0100001";
	constant SEGE : std_logic_vector := "0000110";
	constant SEGF : std_logic_vector := "0001110";
	constant BLANK : std_logic_vector := "1111111";

	begin
-- Behavioral section
	process(bcd, reset)
	begin
		if reset = '1' then
			ssd_out <= BLANK;
		else
			case bcd is
				when "0000" => ssd_out <= SEG0;
				when "0001" => ssd_out <= SEG1;
				when "0010" => ssd_out <= SEG2;
				when "0011" => ssd_out <= SEG3;
				when "0100" => ssd_out <= SEG4;
				when "0101" => ssd_out <= SEG5;
				when "0110" => ssd_out <= SEG6;
				when "0111" => ssd_out <= SEG7;
				when "1000" => ssd_out <= SEG8;
				when "1001" => ssd_out <= SEG9;
				when "1010" => ssd_out <= SEGA;
				when "1011" => ssd_out <= SEGB;
				when "1100" => ssd_out <= SEGC;
				when "1101" => ssd_out <= SEGD;
				when "1110" => ssd_out <= SEGE;
				when "1111" => ssd_out <= SEGF;
				when others => ssd_out <= BLANK;
			end case;
		end if;
	end process;
end beh;
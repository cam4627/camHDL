-------------------------------------------------------------------------------
-- Cameron Marsh
-- BCD Simulation for seven segment display
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
end entity;

architecture beh of seven_seg is
	constant SEG0 : std_logic_vector := '1000000';
	begin
	case bcd is
		when '0000' => seven_seg_out <= SEG0;
		when '0001' => seven_seg_out <= SEG1;
		when '0010' => seven_seg_out <= SEG2;
		when '0011' => seven_seg_out <= SEG3;
		when '0100' => seven_seg_out <= SEG4;
		when '0101' => seven_seg_out <= SEG5;
end beh;
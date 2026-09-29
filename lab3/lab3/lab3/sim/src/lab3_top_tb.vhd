-------------------------------------------------------------------------------
-- Cameron Marsh
-- Dr. Kaputa
-- testbench for the single-digit BCD up-counter with seven segment display.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab3_top_tb is
end lab3_top_tb;

architecture arch of lab3_top_tb is

component lab3_top is
	port(
	clk 	: std_logic;
	reset	: std_logic;
  SSD_out	: out std_logic_vector(6 downto 0)
	);
end component;

begin

  uut: lab3_top
    port map(
      clk   => clk,
      reset => reset,
      SSD_out => SSD_out
    );

-- clock process
clock: process
  begin
    clk <= not clk;
    wait for period/2;
end process; 
 
-- reset process
async_reset: process
  begin
    wait for 2 * period;
    reset <= '0';
    wait;
end process; 

end arch;
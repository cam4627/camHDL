-------------------------------------------------------------------------------
-- Cameron Marsh
-- Dr. Kaputa
-- seven segment test bench
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
	);
end component;

begin

-- bcd iteration
sequential_tb : process 
    begin
      report "****************** sequential testbench start ****************";
      wait for 80 ns;   -- let all the initial conditions trickle through
      for i in 0 to 9 loop

        wait for 40 ns;
      end loop;
      report "****************** sequential testbench stop ****************";
      wait;
  end process; 

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

uut: seven_seg  
  port map(        
    clk            => clk,
    reset          => reset,
    bcd            => bcd,
    seven_seg_out  => open
  );
end arch;
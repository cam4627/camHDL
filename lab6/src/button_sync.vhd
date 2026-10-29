-------------------------------------------------------------------------------
-- Dr. Kaputa
-- Synchronizer with an edge detector, for active high pushbutton.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity button_sync is 
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    async_in          : in std_logic;
    sync_out          : out std_logic
  );
end button_sync;

architecture beh of button_sync is
-- signal declarations
signal flop1     : std_logic;
signal flop2     : std_logic;
signal flop3     : std_logic;

begin
double_flop : process(reset, clk)
  begin
    if reset = '1' then
      flop1 <= '0';   
      flop2 <= '0';
    elsif rising_edge(clk) then
      flop1 <= async_in;
      flop2 <= flop1;
    end if;
end process;

  edge_detector : process(clk, reset)
  begin
    if reset = '1' then
      flop3 <= '0';
      sync_out <= '0';
    elsif rising_edge(clk) then
      flop3 <= flop2; -- flop3 gets the previous value of flop2
      sync_out <= flop2 and not flop3;
    end if;
  end process;

end beh; 
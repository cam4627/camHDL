-------------------------------------------------------------------------------
-- Cameron Marsh
-- Level-sensitive synchronizer for slide switch input
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity synchronizer_3bit is 
generic(
  WIDTH : integer := 3
);  
port (
    clk               : in std_logic;
    reset             : in std_logic;
    async_in          : in std_logic_vector(WIDTH-1 downto 0);
    sync_out          : out std_logic_vector(WIDTH-1 downto 0)
  );
end synchronizer_3bit;

architecture beh of synchronizer_3bit is
-- signal declarations
signal flop1     : std_logic_vector(WIDTH-1 downto 0);
signal flop2     : std_logic_vector(WIDTH-1 downto 0);

begin 
double_flop :process(reset,clk)
  begin
    if reset = '1' then
      flop1 <= (WIDTH-1 downto 0 => '0');   
      flop2 <= (WIDTH-1 downto 0 => '0');	
    elsif rising_edge(clk) then
      flop1 <= async_in;
      flop2 <= flop1;
    end if;
end process;

sync_out <= flop2;
end beh; 
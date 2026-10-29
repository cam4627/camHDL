-------------
-- Memory module
-------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

  entity memory is 
    generic (addr_width : integer := 2;
            data_width : integer := 4);
    port (
      clk               : in std_logic;
      we                : in std_logic;
      addr              : in std_logic_vector(addr_width - 1 downto 0);
      din               : in std_logic_vector(data_width - 1 downto 0);
      dout              : out std_logic_vector(data_width - 1 downto 0)
    );
  end memory;

architecture Behavioral of memory is

begin

end Behavioral;
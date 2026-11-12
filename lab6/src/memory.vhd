-------------
-- Cameron Marsh
-- Generic memory module (made of chained registers)
-------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

  entity memory is 
    generic (addr_width : integer := 2; -- default: 4 8-bit bins
            data_width : integer := 8);
    port (
      clk               : in std_logic;
      reset             : in std_logic;
      we                : in std_logic;
      addr              : in std_logic_vector(addr_width - 1 downto 0);
      din               : in std_logic_vector(data_width - 1 downto 0);
      dout              : out std_logic_vector(data_width - 1 downto 0)
    );
  end memory;

architecture Behavioral of memory is
  type ram_t is array (0 to 2**addr_width - 1) of std_logic_vector(data_width - 1 downto 0);
  signal RAM : ram_t := (others => (others => '0'));

begin
  
  process(clk, reset)
  begin
    if reset = '1' then
      RAM <= (others => (others => '0'));
    elsif (clk'event and clk = '1') then
      if we = '1' then
        RAM(to_integer(unsigned(addr))) <= din;
        end if;
        dout <= RAM(to_integer(unsigned(addr)));
    end if;
  end process;

end Behavioral;
-------------
-- Cameron Marsh
-- Top-level module for the memory calculator.
-------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.components.all;

  entity calculator_top is
    port (
      clk           : in  std_logic; 
      reset         : in  std_logic;
      execute       : in  std_logic;
      switch        : in  std_logic_vector(7 downto 0);
      op            : in  std_logic_vector(1 downto 0);
      led           : out std_logic_vector(2 downto 0);
      bcd_0         : out std_logic_vector(6 downto 0);
      bcd_1         : out std_logic_vector(6 downto 0);
      bcd_2         : out std_logic_vector(6 downto 0)
    );
  end calculator_top;
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
      hex0         : out std_logic_vector(6 downto 0);
      hex1         : out std_logic_vector(6 downto 0);
      hex2         : out std_logic_vector(6 downto 0)
    );
  end calculator_top;
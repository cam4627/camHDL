-------------------------------------------------------------------------------
-- Cameron Marsh
-- The 4 bit adder/subtractor component for lab 4, named "add_sub" in the block diagram.
-- Meant for padded 3 bit input. No overflow protection or carry-out.
-- Uses the "op" input to select:
-- 		0: add
-- 		1: sub
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub is
  generic (
    bits    : integer := 3
  );
  port (
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
	  clk		: in std_logic;
	  reset 	: in std_logic;
	  op		: in std_logic;
    result : out std_logic_vector(3 downto 0)
  );
end entity add_sub;

architecture beh of add_sub is

begin
	operation: process(clk,reset)
	begin
    if reset = '1' then
        result <= (others => '0');
    elsif rising_edge(clk) then
      if op = '0' then
        result <= std_logic_vector(unsigned(a) + unsigned(b));
      else
        result <= std_logic_vector(unsigned(a) - unsigned(b));
      end if;
    end if;
	end process;
end beh;
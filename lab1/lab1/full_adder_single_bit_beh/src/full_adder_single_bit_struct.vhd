-------------------------------------------------------------------------------
-- Cameron Marsh
-- single bit full adder [structural] written in gate-level logic.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all;      

entity full_adder_single_bit_struct is 
  port (
    a       : in std_logic;
    b       : in std_logic;
    cin     : in std_logic;
    sum     : out std_logic;
    cout    : out std_logic
  );
end entity;

architecture beh of full_adder_single_bit_struct is

begin
  sum  <= x(0);
  cout <= x(1);
end beh; 
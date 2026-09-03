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
	signal inputs : std_logic_vector(2 downto 0);
begin
	inputs <= a & b & cin;
	with inputs select
		sum <= 1 when "001" | "010" | "100" | "111", 0 when others;
	with inputs select
		cout <= 1 when "011" | "101" | "110" | "111"
  sum  <= ;
  cout <= ;
end beh; 
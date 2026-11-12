-------------------------------------------------------------------------------
-- Cameron Marsh
-- Testbench for top level of lab6 (8-bit calculator with memory)
-- Testbench using text IO (std textio library)
-- FORMAT: 10-character lines. Operation in first two bits,  
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
library work;
use work.components.all;

entity top_tb is
end entity top_tb;

architecture beh of top_tb is
    component top
    port (
        clk            : in std_logic;
        reset         : in std_logic;
        input_sw     : in std_logic_vector(7 downto 0);
        op_sw       : in std_logic_vector(1 downto 0);
        execute_btn : in std_logic;

        hex2 : out std_logic_vector(6 downto 0);
        hex1 : out std_logic_vector(6 downto 0);
        hex0 : out std_logic_vector(6 downto 0);
        led : out std_logic_vector(3 downto 0)
    );
    end component;

    file inputs : text;
    file outputs : text;
    signal input_vector : std_logic_vector(9 downto 0) := (others => '0');

    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal execute_btn : std_logic;
    signal hex2 : std_logic_vector(6 downto 0);
    signal hex1 : std_logic_vector(6 downto 0);
    signal hex0 : std_logic_vector(6 downto 0);
    signal led : std_logic_vector(3 downto 0);

    uut: top
    port map(
        clk => clk,
        reset => reset,
        input_sw => input_vector(7 downto 0),
        op_sw => input_vector(9 downto 8),
        execute_btn => execute_btn,
        hex2 => hex2,
        hex1 => hex1,
        hex0 => hex0,
        led => led
    );

    

end architecture beh;
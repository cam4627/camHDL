-------------------------------------------------------------------------------
-- Cameron Marsh
-- Testbench for lab 5 top level, as described in the document.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_tb is
end entity top_tb;

architecture tb of top_tb is

    component top 
      port (
        input_sw : in std_logic_vector(7 downto 0);
        button : in std_logic;
        clk : in std_logic;
        reset : in std_logic;

        hex0 : out std_logic_vector(6 downto 0);
        hex1 : out std_logic_vector(6 downto 0);
        hex2 : out std_logic_vector(6 downto 0);
        led : out std_logic_vector(3 downto 0)
      );
    end component;

    constant period : time := 20ns;
    signal clk              : std_logic := '0';
    signal reset            : std_logic := '1';
    signal input_sw         : std_logic_vector(7 downto 0) := (others => '0');
    signal button           : std_logic := '0';
    signal hex0             : std_logic_vector(6 downto 0);
    signal hex1             : std_logic_vector(6 downto 0);
    signal hex2             : std_logic_vector(6 downto 0);
    signal led              : std_logic_vector(3 downto 0);

type arr is array (0 to 7) of std_logic_vector(7 downto 0);
constant test_cases : arr := (X"05", X"02", X"02", X"05", X"C8", X"64", X"64", X"C8");

type pairs_array is array (0 to 3, 0 to 1) of
    std_logic_vector(7 downto 0);

constant test_cases : pairs_array := (
    (X"05", X"02"),
    (X"02", X"05"),
    (X"C8", X"64"),
    (X"64", X"C8")
);

    begin

      uut : top
      port map(
      input_sw => input_sw,
      button => button,
      clk => clk,
      reset => reset,
      hex0 => hex0,
      hex1 => hex1,
      hex2 => hex2,
      led => led
        );

    -- clock process
    clock: process
    begin
        clk <= not clk;
        wait for period/2;
    end process; 
 
    -- reset process
    async_reset: process
    begin
        wait for 2 * period;
        reset <= '0';
        wait;
    end process; 

    -- create the five test cases
    stimulus: process
    begin
      wait for 2 * period; -- wait for reset to finish
      for i in test_cases'range loop
        input_sw <= test_cases(i, 0); -- sIn1 input
        button <= '1';
        wait for 2 * period;
        button <= '0';
        i <= i + 1;
        input_sw <= test_cases(i, 1); -- sIn2 input
        wait for 2 * period;
        button <= '1';
        wait for 2 * period;
        button <= '0';
        wait for 2 * period;           -- sAdd result should be displayed
        button <= '1';
        wait for 2 * period;
        button <= '0';
        wait for 2 *period;           -- sSub result should be displayed
        button <= '1';
        wait for 2 * period;          -- return to sIn1 for next increment
        button <= '0';
        wait for 2 * period;
      end loop;

    end process;
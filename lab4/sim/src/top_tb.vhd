

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_tb is
end top_tb;

architecture tb of top_tb is
component top
    port (
        clk               : in std_logic;
        reset             : in std_logic;
        add_btn           : in std_logic;
        sub_btn           : in std_logic;
        a                 : in std_logic_vector(2 downto 0);
        b                 : in std_logic_vector(2 downto 0);
        hex0              : out std_logic_vector(6 downto 0);
        hex1              : out std_logic_vector(6 downto 0);
        hex2              : out std_logic_vector(6 downto 0)
    );
end component;

constant PERIOD     : time := 20 ns;

signal clk       : std_logic := '0';
signal reset     : std_logic := '0';
signal add_btn   : std_logic := '0';
signal sub_btn   : std_logic := '0';
signal a         : std_logic_vector(2 downto 0) := "000";
signal b         : std_logic_vector(2 downto 0) := "000";
signal hex0      : std_logic_vector(6 downto 0);
signal hex1      : std_logic_vector(6 downto 0);
signal hex2      : std_logic_vector(6 downto 0);

begin
    
    uut : top
        port map (
            clk               => clk,
            reset             => reset,
            add_btn           => add_btn,
            sub_btn           => sub_btn,
            a                 => a,
            b                 => b,
            hex0              => hex0,
            hex1              => hex1,
            hex2              => hex2
        );

    -- Stimulus
    stimulus: process
    begin
        reset <= '1';
        wait for 8 * PERIOD;
        reset <= '0';
        wait for 4 * PERIOD;
        for a_value in 0 to 7 loop
            a <= std_logic_vector(to_unsigned(a_value, a'length));
            for b_value in 0 to 7 loop
                b <= std_logic_vector(to_unsigned(b_value, b'length));
                wait for 4 * PERIOD;
            end loop;
        end loop;
        wait;
    end process;

    -- add/sub process
    add_sub: process
    begin
    add_btn <= '1';
    sub_btn <= '0';
    wait for 4 * PERIOD;
    add_btn <= '0';
    sub_btn <= '1';
    wait for 4 * PERIOD;
    end process;

    -- clock process
    clock: process
    begin
        clk <= not clk;
        wait for period/2;
    end process; 
    
end architecture tb;
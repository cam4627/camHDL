-------------------------------------------------------------------------------
-- Cameron Marsh
-- Top level for state machine adder/subtractor.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.components_lab5.all;

entity top is
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
    end entity top;

architecture beh of top is

    constant sIn1 : std_logic_vector(3 downto 0) := "0001";
    constant sIn2 : std_logic_vector(3 downto 0) := "0010";
    constant sAdd : std_logic_vector(3 downto 0) := "0100";
    constant sSub : std_logic_vector(3 downto 0) := "1000";
    -- State machine signals
    signal current_state, next_state : std_logic_vector(3 downto 0);
    signal out_12 : std_logic_vector(11 downto 0);
    signal num_sig : std_logic_vector(7 downto 0);
    signal button_sig : std_logic;
    -- add_sub signals
    signal a : std_logic_vector(7 downto 0);
    signal b : std_logic_vector(7 downto 0);
    signal op : std_logic;
    signal result : std_logic_vector(8 downto 0);
    -- SSD signals
    signal bcd2 : std_logic_vector(3 downto 0);
    signal bcd1 : std_logic_vector(3 downto 0);
    signal bcd0 : std_logic_vector(3 downto 0);

    begin

        -- Instantiations
    level_sync_inst : level_sync
        generic map(
            WIDTH => 8
        )
        port map(
            clk => clk,
            reset => reset,
            async_in => input_sw(7 downto 0),
            sync_out => num_sig(7 downto 0)
        );
    button_sync_inst : button_sync
        port map(
            clk => clk,
            reset => reset,
            async_in => button,
            sync_out => button_sig
        );
    add_sub_inst : add_sub
        generic map(
            bits => 8
        )
        port map(
            a => a,
            b => b,
            clk => clk,
            reset => reset,
            op => op,
            result => result
        );
    double_dabble_inst : double_dabble
        port map(
            result_padded => out_12,
            ones => bcd0,
            tens => bcd1,
            hundreds => bcd2
        );
    seven_seg_0 : seven_seg
        port map(
            reset => reset,
            bcd => bcd0,
            ssd_out => hex0
        );
    seven_seg_1 : seven_seg
        port map(
            reset => reset,
            bcd => bcd1,
            ssd_out => hex1
        );
    seven_seg_2 : seven_seg
        port map(
            reset => reset,
            bcd => bcd2,
            ssd_out => hex2
        );

    -- Behavior

    state_register: process(clk,reset)
    begin 
    if (reset = '1') then 
        current_state <= sIn1;
    elsif (clk'event and clk = '1') then
        current_state <= next_state;
    end if;
    end process;

    next_state_logic: process(button_sig, current_state)
    begin
        if (reset = '1') then
            next_state <= sIn1;
        else
            next_state <= current_state; -- default
            case current_state is
                when sIn1 =>
                    if(button_sig = '1') then
                        next_state <= sIn2;
                    end if;
                when sIn2 =>
                    if(button_sig = '1') then
                        next_state <= sAdd;
                    end if;
                when sAdd =>
                    if(button_sig = '1') then
                        next_state <= sSub;
                    end if;
                when sSub =>
                    if(button_sig = '1') then
                        next_state <= sIn1;
                    end if;
                when others =>
                    next_state <= sIn1;
                end case;
        end if;
    end process;

    output_logic: process(current_state, num_sig, result)
    begin
        led <= current_state; -- display one-hot on LEDs
        case current_state is 
            when sIn1 =>
            a <= num_sig; -- save a (register)
            out_12 <= "0000" & num_sig; -- 8 to 12 bits
            when sIn2 =>
            b <= num_sig; -- save b (register)
            out_12 <= "0000" & num_sig; -- 8 to 12 bits
            when sAdd =>
            op <= '0'; 
            out_12 <= "000" & result; -- 9 to 12 bits
            when sSub =>
            op <= '1';
            out_12 <= "000" & result;  -- 9 to 12 bits
            when others =>
            out_12 <= (others => '0');
        end case;

    end process;

end beh;
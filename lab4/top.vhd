-------------------------------------------------------------------------------
-- Cameron Marsh
-- Top level with instantiations, and selector and padder implemented as processes.
-- Hardware adder/subtractor taking two 3-bit inputs a and b from slide switches.
-- Operation selected from active-high pushbuttons.
--      HEX0: result display. 
--      HEX1: b input display.
--      HEX2: a input display.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity top is
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
    end top;

architecture beh of top is
    -- Signals
    signal add_sig : std_logic;
    signal sub_sig : std_logic;
    signal op : std_logic;
    signal result_sig : std_logic_vector(3 downto 0);
    signal a_sync : std_logic_vector(2 downto 0);
    signal b_sync : std_logic_vector(2 downto 0);
    signal a_4bit : std_logic_vector(3 downto 0);
    signal b_4bit : std_logic_vector(3 downto 0);


    -- Component declarations
    component seven_seg
        port (
            reset   : in std_logic;
            bcd     : in std_logic_vector(3 downto 0);
            ssd_out : out std_logic_vector(6 downto 0)
        );
    end component;

    component button_sync
        port (
            clk      : in std_logic;
            reset    : in std_logic;
            async_in : in std_logic;
            sync_out : out std_logic
        );
    end component;

    component level_sync_3bit
        generic (
            WIDTH : integer := 3
        );
        port (
            clk      : in std_logic;
            reset    : in std_logic;
            async_in : in std_logic_vector(WIDTH-1 downto 0);
            sync_out : out std_logic_vector(WIDTH-1 downto 0)
        );
    end component;

    component add_sub
        generic (
            bits : integer := 3
        );
        port (
            a      : in std_logic_vector(3 downto 0);
            b      : in std_logic_vector(3 downto 0);
            clk    : in std_logic;
            reset  : in std_logic;
            op     : in std_logic;
            result : out std_logic_vector(3 downto 0)
        );
    end component;

    begin
    -- Instantiations
    add_sync : button_sync
        port map (
            clk      => clk,
            reset    => reset,
            async_in => add_btn,
            sync_out => add_sig
        );
    sub_sync : button_sync
        port map (
            clk      => clk,
            reset    => reset,
            async_in => sub_btn,
            sync_out => sub_sig
        );
    a_sync : level_sync_3bit
        port map (
            clk => clk,
            reset => reset,
            async_in => a,
            sync_out => a_sync
        );
    b_sync : level_sync_3bit
        port map (
            clk => clk,
            reset => reset,
            async_in => b,
            sync_out => b_sync
        );
    ssd0 : seven_seg -- result display (hex0)
        port map (
            reset => reset,
            bcd => result_sig,
            ssd_out => hex0
        );
    ssd1 : seven_seg -- b display (hex1)
        port map (
            reset => reset,
            bcd => b_4bit,
            ssd_out => hex1
        );
    ssd2 : seven_seg -- a display (hex2)
        port map (
            reset => reset,
            bcd => a_4bit,
            ssd_out => hex2
        );
    add_sub_inst : add_sub
        port map(
            a => a_4bit,
            b => b_4bit,
            clk => clk,
            reset => reset,
            op => op,
            result => result_sig
        );

end beh;

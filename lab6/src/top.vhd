-------------------------------------------------------------------------------
-- Cameron Marsh
-- Top level module for lab6 (8-bit calculator with memory)
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.components.all;

entity top is
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
end top;

architecture behavioral of top is
    -- Signals and constants
    signal a : std_logic_vector(7 downto 0);
    signal op : std_logic_vector(1 downto 0);
    signal op_sig : std_logic_vector(1 downto 0);
    signal execute : std_logic;
    signal current_state, next_state : std_logic_vector(2 downto 0) := "001";
    signal din : std_logic_vector(7 downto 0);
    signal mem_out : std_logic_vector(7 downto 0);
    signal alu_out : std_logic_vector(7 downto 0);
    signal result_padded : std_logic_vector(11 downto 0);
    signal we : std_logic;
    signal address : std_logic_vector(1 downto 0);
    signal hundreds, tens, ones : std_logic_vector(3 downto 0);
    
    constant sINPUT : std_logic_vector(2 downto 0) := "001";
    constant sEXECUTE : std_logic_vector(2 downto 0) := "010";
    constant sWRITEBACK : std_logic_vector(2 downto 0) := "100";

    begin
    -- Instantiations
    button_sync_inst : button_sync
        port map(
            clk => clk,
            reset => reset,
            async_in => execute_btn,
            sync_out => execute
        );
    switch_sync : level_sync
        generic map(
            WIDTH => 8
        )
        port map(
            clk => clk,
            reset => reset,
            async_in => input_sw(7 downto 0),
            sync_out => a(7 downto 0)
        );
    op_sync : level_sync
        generic map(
            WIDTH => 2
        )
        port map(
            clk => clk,
            reset => reset,
            async_in => op_sw(1 downto 0),
            sync_out => op(1 downto 0)
        );
    mem : memory
        generic map(
            addr_width => 2,
            data_width => 8
        )
        port map(
            clk => clk,
            we => we,
            addr => address,
            din => alu_out,
            dout => mem_out
        );
    alu_inst : alu
        port map(
            reset => reset,
            a => a,
            b => mem_out,
            op => op_sig,
            result => alu_out
        );
    double_dabble_inst : double_dabble
        port map(
            result_padded => result_padded,
            ones => ones,
            tens => tens,
            hundreds => hundreds
        );
    hex0_inst : seven_seg
        port map(
            bcd => ones,
            ssd_out => hex0
        );
    hex1_inst : seven_seg
        port map(
            bcd => tens,
            ssd_out => hex1
        );
    hex2_inst : seven_seg
        port map(
            bcd => hundreds,
            ssd_out => hex2
        );

        -- Behavior

led <= "0" & current_state;

    -- State machine processes
state_register: process(clk,reset)
    begin 
    if (reset = '1') then 
        current_state <= sINPUT;
    elsif (clk'event and clk = '1') then
        current_state <= next_state;
    end if;
    end process;

next_state_logic: process(reset, current_state, execute)
begin
    if(reset = '1') then
        next_state <= sINPUT;
    else
        case current_state is
            when sINPUT =>
                if(execute = '1') then
                    next_state <= sEXECUTE;
                end if;
            when sEXECUTE =>
                next_state <= sWRITEBACK;
            when sWRITEBACK =>
                if(execute = '1') then
                    next_state <= sINPUT;
                end if;
            when others =>
                next_state <= sINPUT;
        end case;
    end if;
end process;

output_logic: process(a, op, alu_out, reset, current_state)
begin
    if reset = '1' then
        address <= (others => '0');
    else
        case current_state is
            when sINPUT =>
                result_padded <= "0000" & a;
                op_sig <= op;
                we <= '0';
            when sEXECUTE =>
                we <= '0';
                op_sig <= op;
                result_padded <= "0000" & alu_out;
                address <= std_logic_vector(unsigned(address) + 1);
            when sWRITEBACK =>
                we <= '1';
                result_padded <= "0000" & alu_out;
                --- result_padded remains latched to the last ALU output
            when others =>
                we <= '0';
                result_padded <= "0000" & alu_out;
                op_sig <= op;
        end case;
end process;

increment_addr: process(clk)
begin
    if (clk'event and clk = '1') then
        if(current_state = sEXECUTE) then
            address <= std_logic_vector(unsigned(address) + 1);
        end if;
    end if;
end process;
end architecture behavioral;
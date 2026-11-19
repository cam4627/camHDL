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

    -- File reading and writing
    file inputs : text;
    file outputs : text;
    signal input_vector : std_logic_vector(9 downto 0) := (others => '0');
    constant PERIOD           : time := 20 ns;


    -- UUT signals
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal execute_btn : std_logic;
    signal input_sw : std_logic_vector(7 downto 0);
    signal op_sw : std_logic_vector(1 downto 0);
    signal hex2 : std_logic_vector(6 downto 0);
    signal hex1 : std_logic_vector(6 downto 0);
    signal hex0 : std_logic_vector(6 downto 0);
    signal led : std_logic_vector(3 downto 0);

    begin 

    uut: top
    port map(
        clk => clk,
        reset => reset,
        input_sw => input_sw,
        op_sw => op_sw,
        execute_btn => execute_btn,
        hex2 => hex2,
        hex1 => hex1,
        hex0 => hex0,
        led => led
    );

clock_process: process
begin
    clk <= '0';
    wait for PERIOD / 2;
    clk <= '1';
    wait for PERIOD / 2;
end process;

-- Reads the input file and drives through the INPUT, EXECUTE and WRITEBACK
-- states (WRITEBACK is automatically one clock . 
-- FILE FORMAT: "input.txt" columns RESET OP SWITCH
-- Opcodes: "00" = ADD, "01" = SUB, "10" = MULT, "11" = DIV
read_file: process is
  variable input_line       : line;
  variable op_var           : bit_vector(1 downto 0);
  variable reset_var        : bit;
  variable switch_var       : bit_vector(7 downto 0); 
  file input_file           : text;
  variable read_ok          : boolean;

  begin 
  file_open(input_file,"inputs.txt",READ_MODE);
  readline(input_file,input_line);    -- strip off the header line
while not endfile(input_file) loop
    readline(input_file, input_line);
    -- read fields and assign them to signals
    read(input_line, reset_var, read_ok);
    if read_ok then
            reset <= to_stdlogic(reset_var);
    else
        report "Invalid read of RESET in input file"
            severity error;
    end if;
    read(input_line, op_var, read_ok);
    if read_ok then
            op_sw <= to_stdlogicvector(op_var);
    else
        report "Invalid read of OP in input file"
            severity error;
    end if;
    read(input_line, switch_var, read_ok);
    if read_ok then
            input_sw <= to_stdlogicvector(switch_var);
    else
        report "Invalid read of SWITCH in input file"
            severity error;
    end if;
    wait for PERIOD;
    execute_btn <= '1'; -- go to EXECUTE state
    wait for 2*PERIOD;
    execute_btn <= '0';
    wait for PERIOD;  
    execute_btn <= '1'; -- return to INPUT state
    wait for PERIOD;
    execute_btn <= '0';

    end loop;
    file_close(input_file);
    wait;
end process read_file;
end architecture beh;
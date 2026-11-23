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
            reset_n         : in std_logic;
            input_sw     : in std_logic_vector(7 downto 0);
            op_sw       : in std_logic_vector(1 downto 0);
            execute_btn : in std_logic;

            hex2 : out std_logic_vector(6 downto 0);
            hex1 : out std_logic_vector(6 downto 0);
            hex0 : out std_logic_vector(6 downto 0);
            led : out std_logic_vector(3 downto 0)
        );
    end component;

    constant PERIOD           : time := 20 ns;
    -- UUT signals
    signal clk : std_logic := '0';
    signal reset_n : std_logic := '0';
    signal execute_btn : std_logic := '0';
    signal input_sw : std_logic_vector(7 downto 0);
    signal op_sw : std_logic_vector(1 downto 0);
    signal hex2 : std_logic_vector(6 downto 0);
    signal hex1 : std_logic_vector(6 downto 0);
    signal hex0 : std_logic_vector(6 downto 0);
    signal led : std_logic_vector(3 downto 0);

    -- Helper function for writing output to the file
    function seven_seg_to_bcd(segments : std_logic_vector(6 downto 0))
        return std_logic_vector is
    begin
        case segments is
            when "1000000" => return "0000";
            when "1111001" => return "0001";
            when "0100100" => return "0010";
            when "0110000" => return "0011";
            when "0011001" => return "0100";
            when "0010010" => return "0101";
            when "0000010" => return "0110";
            when "1111000" => return "0111";
            when "0000000" => return "1000";
            when "0011000" => return "1001";
            when others =>
                return "0000";
        end case;
    end function;

begin

    uut: top
    port map(
        clk => clk,
        reset_n => reset_n,
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

-- reset_n process
async_reset_n: process
    begin
        wait for period;
        reset_n <= '1';
        wait;
    end process;

-- Reads the input file and drives through the INPUT, EXECUTE and WRITEBACK
-- states (WRITEBACK is automatically one clock . 
-- FILE FORMAT: "input.txt" columns reset_n OP SWITCH
-- Opcodes: "00" = ADD, "01" = SUB, "10" = MULT, "11" = DIV
read_file: process is
  variable input_line       : line;
  variable output_line      : line;
  variable op_var           : bit_vector(1 downto 0);
  variable reset_n_var        : bit;
  variable switch_var       : bit_vector(7 downto 0); 
  file input_file           : text;
  file output_file          : text;
  variable read_ok          : boolean;

  begin 
  file_open(input_file,"../src/inputs.txt",READ_MODE);
  file_open(output_file,"../src/outputs.txt",WRITE_MODE);
  readline(input_file,input_line);    -- strip off the header line
  write(output_line, string'("hundreds tens ones"));
  writeline(output_file, output_line);
  wait for PERIOD;                    -- wait for initial reset_n to complete
while not endfile(input_file) loop
    readline(input_file, input_line);
    -- read fields and assign them to signals
    read(input_line, reset_n_var, read_ok);
    if read_ok then
	if reset_n_var = '1' then
            reset_n <= '1';
	else
	   reset_n <= '0';
	end if;
    else
        report "Invalid read of reset_n in input file"
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
    wait for 2* PERIOD;
    execute_btn <= '0';
    wait for 2* PERIOD;  
    -- Write results to output
    write(output_line, to_integer(unsigned(seven_seg_to_bcd(hex2))));
    write(output_line, string'(" "));
    write(output_line, to_integer(unsigned(seven_seg_to_bcd(hex1))));
    write(output_line, string'(" "));
    write(output_line, to_integer(unsigned(seven_seg_to_bcd(hex0))));
    writeline(output_file, output_line);
    execute_btn <= '1'; -- return to INPUT state
    wait for PERIOD;
    execute_btn <= '0';
    wait for 3 * PERIOD; -- wait for switch back to INPUT 
    end loop;
    file_close(input_file);
    file_close(output_file);
    wait;
end process read_file;
end architecture beh;
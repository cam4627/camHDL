------------------------------------------------
-- Cameron Marsh
-- Utility package of reusable functions and components.
-- use with library work; and use work.utils.all;
------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package utils is

constant PERIOD : time : 20 ns;

function seven_seg_to_bcd(segments : std_logic_vector(6 downto 0) return std_logic_vector;
end package utils;

package body utils is

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

end package body utils;
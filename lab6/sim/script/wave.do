onerror {resume}
radix define seven_seg {
    "7'b1000000" "0" -color "red",
    "7'b1111001" "1" -color "red",
    "7'b0100100" "2" -color "red",
    "7'b0110000" "3" -color "red",
    "7'b0011001" "4" -color "red",
    "7'b0010010" "5" -color "red",
    "7'b0000010" "6" -color "red",
    "7'b1111000" "7" -color "red",
    "7'b0000000" "8" -color "red",
    "7'b0011000" "9" -color "red",
    "7'b0001000" "10" -color "red",
    "7'b0000011" "11" -color "red",
    "7'b1000110" "12" -color "red",
    "7'b0100001" "13" -color "red",
    "7'b0000110" "14" -color "red",
    "7'b0001110" "15" -color "red",
    "7'b1111111" "BLANK" -color "red",
    -default default
}
radix define opcode {
    "2'b00" "ADD" -color "cyan",
    "2'b01" "SUB" -color "cyan",
    "2'b10" "MULT" -color "cyan",
    "2'b11" "DIV" -color "cyan",
    -default default
}

radix define states {
    "3'b001" "INPUT" -color "green",
    "3'b010" "EXECUTE" -color "green",
    "3'b100" "WRITEBACK" -color "green",
    -default default
}


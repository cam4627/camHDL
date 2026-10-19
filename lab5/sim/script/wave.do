onerror {resume}
radix define SSD {
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
radix define add/sub {
    "1'b0" "ADD" -color "cyan",
    "1'b1" "SUB" -color "cyan",
    -default default
}
radix define statemachine {
    "4'b0001" "INPUT1" -color "green",
    "4'b0010" "INPUT2" -color "green",
    "4'b0100" "ADD" -color "red",
    "4'b1000" "SUB" -color "red",
    -default default
}


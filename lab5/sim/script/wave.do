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
    "4'b0001" "IN1" -color "green",
    "4'b0010" "IN2" -color "green",
    "4'b0100" "ADD" -color "red",
    "4'b1000" "SUB" -color "red",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/reset
add wave -noupdate /top_tb/clk
add wave -noupdate /top_tb/button
add wave -noupdate -radix hexadecimal /top_tb/uut/input_sw
add wave -noupdate -radix statemachine /top_tb/uut/led
add wave -noupdate -format Literal -radix add/sub /top_tb/uut/add_sub_inst/op
add wave -noupdate -radix decimal /top_tb/uut/out_12
add wave -noupdate -radix SSD /top_tb/uut/hex2
add wave -noupdate -radix SSD /top_tb/uut/hex1
add wave -noupdate -radix SSD /top_tb/uut/hex0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {390 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {375 ns} {879 ns}

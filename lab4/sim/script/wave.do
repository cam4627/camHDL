onerror {resume}
radix define States {
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
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/uut/clk
add wave -noupdate /top_tb/uut/reset
add wave -noupdate /top_tb/uut/a
add wave -noupdate /top_tb/uut/a_sync
add wave -noupdate /top_tb/uut/b
add wave -noupdate /top_tb/uut/b_sync
add wave -noupdate -color Red -itemcolor Red -radix decimal /top_tb/uut/add_sub_inst/result
add wave -noupdate -color Red -radix decimal /top_tb/uut/result_sig
add wave -noupdate /top_tb/uut/add_btn
add wave -noupdate -color {Slate Blue} /top_tb/uut/add_sig
add wave -noupdate /top_tb/uut/sub_btn
add wave -noupdate -color {Slate Blue} /top_tb/uut/sub_sig
add wave -noupdate -color Cyan -radix add/sub /top_tb/uut/op
add wave -noupdate /top_tb/uut/a_4bit
add wave -noupdate /top_tb/uut/b_4bit
add wave -noupdate -radix States /top_tb/uut/hex2
add wave -noupdate -radix States /top_tb/uut/hex1
add wave -noupdate -radix States /top_tb/uut/hex0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2352077 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {1227522 ps} {2015022 ps}

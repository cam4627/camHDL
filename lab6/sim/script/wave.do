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
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/uut/clk
add wave -noupdate /top_tb/uut/reset
add wave -noupdate -radix unsigned /top_tb/uut/input_sw
add wave -noupdate -expand -group memory -radix decimal /top_tb/uut/mem_out
add wave -noupdate -expand -group memory -radix unsigned /top_tb/uut/address
add wave -noupdate -expand -group memory /top_tb/uut/we
add wave -noupdate -radix opcode /top_tb/uut/op_sw
add wave -noupdate /top_tb/uut/execute_btn
add wave -noupdate /top_tb/uut/execute
add wave -noupdate -radix states /top_tb/uut/led
add wave -noupdate -radix states /top_tb/uut/next_state
add wave -noupdate -expand -group alu -radix unsigned /top_tb/uut/alu_inst/a
add wave -noupdate -expand -group alu -radix unsigned /top_tb/uut/alu_inst/b
add wave -noupdate -expand -group alu -radix unsigned /top_tb/uut/alu_inst/result
add wave -noupdate -expand -group display -radix seven_seg /top_tb/uut/hex2
add wave -noupdate -expand -group display -radix seven_seg /top_tb/uut/hex1
add wave -noupdate -expand -group display -radix seven_seg /top_tb/uut/hex0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {137794 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 212
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {378192 ps}

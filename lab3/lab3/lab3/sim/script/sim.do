vlib work
vcom -93 -work work ../../src/seven_seg.vhd
vcom -93 -work work ../../src/lab3_top.vhd
vcom -93 -work work ../../src/generic_counter.vhd
vcom -93 -work work ../../src/generic_adder.vhd
vcom -93 -work work ../src/lab3_top_tb.vhd

vsim -voptargs=+acc lab3_top_tb
do wave.do
run 3000 ns

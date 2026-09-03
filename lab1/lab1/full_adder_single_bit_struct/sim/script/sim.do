vlib work
vcom -93 -work work ../../src/full_adder_single_struct_beh.vhd
vcom -93 -work work ../src/full_adder_single_bit_struct_tb.vhd
vsim -voptargs=+acc full_adder_single_bit_beh_tb
do wave.do
run 100 ns

vlib work
vcom -93 -work work ../../src/seven_seg.vhd
vcom -93 -work work ../../src/top.vhd
vcom -93 -work work ../../src/level_sync_3bit.vhd
vcom -93 -work work ../../src/button_sync.vhd
vcom -93 -work work ../../src/add_sub.vhd
vcom -93 -work work ../src/top_tb.vhd

vsim -voptargs=+acc top_tb
do wave.do
run 3000 ns

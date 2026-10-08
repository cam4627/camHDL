# Dr. Kaputa
# Quartus II compile script for DE1-SoC board

# 1] name your project here
set project_name "Lab4"

file delete -force project
file delete -force output_files
file mkdir project
cd project
load_package flow
project_new $project_name
set_global_assignment -name FAMILY "Cyclone V"
set_global_assignment -name DEVICE 5CSEMA5F31C6 
set_global_assignment -name TOP_LEVEL_ENTITY top
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY ../output_files

# 2] include your relative path files here
set_global_assignment -name VHDL_FILE ../../src/top.vhd
set_global_assignment -name VHDL_FILE ../../src/level_sync_3bit.vhd
set_global_assignment -name VHDL_FILE ../../src/seven_seg.vhd
set_global_assignment -name VHDL_FILE ../../src/add_sub.vhd
set_global_assignment -name VHDL_FILE ../../src/button_sync.vhd
set_global_assignment -name VHDL_FILE ../../src/add_sub.vhd

set_location_assignment PIN_AB12 -to reset
set_location_assignment PIN_AF14 -to clk
set_location_assignment PIN_AC9  -to a[0]
set_location_assignment PIN_AD10 -to a[1]
set_location_assignment PIN_AE12 -to a[2]
set_location_assignment PIN_AD11 -to b[0]
set_location_assignment PIN_AD12 -to b[1]
set_location_assignment PIN_AE11 -to b[2]

set_location_assignment PIN_AA24 -to hex2[0]
set_location_assignment PIN_Y23  -to hex2[1]
set_location_assignment PIN_Y24  -to hex2[2]
set_location_assignment PIN_W22  -to hex2[3]
set_location_assignment PIN_W24  -to hex2[4]
set_location_assignment PIN_V23  -to hex2[5]
set_location_assignment PIN_W25  -to hex2[6]

set_location_assignment PIN_AB23 -to hex1[0]
set_location_assignment PIN_AE29 -to hex1[1]
set_location_assignment PIN_AD29 -to hex1[2]
set_location_assignment PIN_AC28 -to hex1[3]
set_location_assignment PIN_AD30 -to hex1[4]
set_location_assignment PIN_AC29 -to hex1[5]
set_location_assignment PIN_AC30 -to hex1[6]

set_location_assignment PIN_AE26 -to hex0[0]
set_location_assignment PIN_AE27 -to hex0[1]
set_location_assignment PIN_AE28 -to hex0[2]
set_location_assignment PIN_AG27 -to hex0[3]
set_location_assignment PIN_AF28 -to hex0[4]
set_location_assignment PIN_AG28 -to hex0[5]
set_location_assignment PIN_AH28 -to hex0[6]

set_location_assignment PIN_AA15 -to add_btn
set_location_assignment PIN_AA14 -to sub_btn

execute_flow -compile
project_close
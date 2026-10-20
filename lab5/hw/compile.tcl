# Dr. Kaputa
# Cameron Marsh
# Quartus II compile script for DE1-SoC board

# 1] name your project here
set project_name "add_sub_SM"

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
set_global_assignment -name VHDL_FILE ../../src/button_sync.vhd
set_global_assignment -name VHDL_FILE ../../src/seven_seg.vhd
set_global_assignment -name VHDL_FILE ../../src/add_sub.vhd
set_global_assignment -name VHDL_FILE ../../src/level_sync.vhd
set_global_assignment -name VHDL_FILE ../../src/double_dabble.vhd
set_global_assignment -name VHDL_FILE ../../src/components_lab5.vhd
set_global_assignment -name VHDL_FILE ../../src/top.vhd

set_location_assignment PIN_AB12 -to reset
set_location_assignment PIN_AF14 -to clk
#set_location_assignment PIN_D25 -to clk

set_location_assignment PIN_V16  -to led[0]
set_location_assignment PIN_W16  -to led[1]
set_location_assignment PIN_V17  -to led[2]
set_location_assignment PIN_V18  -to led[3]

set_location_assignment PIN_AF9  -to input_sw[0]
set_location_assignment PIN_AF10 -to input_sw[1]
set_location_assignment PIN_AD11 -to input_sw[2]
set_location_assignment PIN_AD12 -to input_sw[3]
set_location_assignment PIN_AE11 -to input_sw[4]
set_location_assignment PIN_AC9  -to input_sw[5]
set_location_assignment PIN_AD10 -to input_sw[6]
set_location_assignment PIN_AE12 -to input_sw[7]

set_location_assignment PIN_AE26 -to hex0[0]
set_location_assignment PIN_AE27 -to hex0[1]
set_location_assignment PIN_AE28 -to hex0[2]
set_location_assignment PIN_AG27 -to hex0[3]
set_location_assignment PIN_AF28 -to hex0[4]
set_location_assignment PIN_AG28 -to hex0[5]
set_location_assignment PIN_AH28 -to hex0[6]

set_location_assignment PIN_AJ29 -to hex1[0]
set_location_assignment PIN_AH29 -to hex1[1]
set_location_assignment PIN_AH30 -to hex1[2]
set_location_assignment PIN_AG30 -to hex1[3]
set_location_assignment PIN_AF29 -to hex1[4]
set_location_assignment PIN_AF30 -to hex1[5]
set_location_assignment PIN_AD27 -to hex1[6]

set_location_assignment PIN_AB23 -to hex2[0]
set_location_assignment PIN_AE29 -to hex2[1]
set_location_assignment PIN_AD29 -to hex2[2]
set_location_assignment PIN_AC28 -to hex2[3]
set_location_assignment PIN_AD30 -to hex2[4]
set_location_assignment PIN_AC29 -to hex2[5]
set_location_assignment PIN_AC30 -to hex2[6]

# set_location_assignment PIN_AD26 -to bcd_3[0]
# set_location_assignment PIN_AC27 -to bcd_3[1]
# set_location_assignment PIN_AD25 -to bcd_3[2]
# set_location_assignment PIN_AC25 -to bcd_3[3]
# set_location_assignment PIN_AB28 -to bcd_3[4]
# set_location_assignment PIN_AB25 -to bcd_3[5]
# set_location_assignment PIN_AB22 -to bcd_3[6]

# set_location_assignment PIN_AA24 -to bcd_4[0]
# set_location_assignment PIN_Y23  -to bcd_4[1]
# set_location_assignment PIN_Y24  -to bcd_4[2]
# set_location_assignment PIN_W22  -to bcd_4[3]
# set_location_assignment PIN_W24  -to bcd_4[4]
# set_location_assignment PIN_V23  -to bcd_4[5]
# set_location_assignment PIN_W25  -to bcd_4[6]

# set_location_assignment PIN_V25  -to bcd_5[0]
# set_location_assignment PIN_AA28 -to bcd_5[1]
# set_location_assignment PIN_Y27  -to bcd_5[2]
# set_location_assignment PIN_AB27 -to bcd_5[3]
# set_location_assignment PIN_AB26 -to bcd_5[4]
# set_location_assignment PIN_AA26 -to bcd_5[5]
# set_location_assignment PIN_AA25 -to bcd_5[6]

set_location_assignment PIN_AA14 -to button

execute_flow -compile
project_close
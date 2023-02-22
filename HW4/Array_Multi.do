vcom -reportprogress 300 -work work G:/Uni/DSD/HW/HW4/Array_Multiplier.vhd 
vcom -reportprogress 300 -work work G:/Uni/DSD/HW/HW4/Array_Multiplier_tb.vhd 
vsim -gui work.array_multiplier_tb -voptargs=+acc
do Array_Multiplier_wave.do
run 50 ns

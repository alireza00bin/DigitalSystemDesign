vcom -reportprogress 300 -work work G:/Uni/DSD/HW/HW4/Array_Multi.vhd 
vcom -reportprogress 300 -work work G:/Uni/DSD/HW/HW4/Array_Multi.TB.vhd 
vsim -gui work.array_multiplier_tb -voptargs=+acc
do Array_Multiplier_wave.do
run 50 ns

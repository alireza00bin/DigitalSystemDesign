vcom -reportprogress 300 -work work G:/Uni/DSD/HW/HW5/Sequential_adder.vhd 
vcom -reportprogress 300 -work work G:/Uni/DSD/HW/HW5/Sequential_adder_tb.vhd 
vsim -gui work.adder_sequential_tb -voptargs=+acc
do Sequential_adder_wave.do
run 250 ns

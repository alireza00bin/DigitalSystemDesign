vcom -reportprogress 300 -work work G:/Uni/DSD/HW/HW6/Elevator.vhd 
vcom -reportprogress 300 -work work G:/Uni/DSD/HW/HW6/Elevator.tb.vhd 
vsim -gui work.elevator_tb -voptargs=+acc
do Elevator_wave.do
run 350 ns
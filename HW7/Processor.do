vcom -reportprogress 300 -work work G:/Uni/DSD/HW/HW7/Processor.vhd
vcom -reportprogress 300 -work work G:/Uni/DSD/HW/HW7/Processor_tb2.vhd
vsim -gui work.miniproc_tb -voptargs=+acc
do Processor_wave.do
run 200 ns

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 20 -expand -group IN /adder_sequential_tb/a_tb
add wave -noupdate -height 20 -expand -group IN /adder_sequential_tb/b_tb
add wave -noupdate -height 20 -expand -group IN /adder_sequential_tb/start_tb
add wave -noupdate -height 20 -expand -group IN /adder_sequential_tb/clk_tb
add wave -noupdate -height 20 -expand -group IN /adder_sequential_tb/nrst_tb
add wave -noupdate -height 20 -expand -group OUT /adder_sequential_tb/sum_tb
add wave -noupdate -height 20 -expand -group OUT /adder_sequential_tb/cout_tb
add wave -noupdate -height 20 -expand -group OUT /adder_sequential_tb/done_tb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {44 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {250 ns}

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 18 -expand -group IN /elevator_tb/come_tb
add wave -noupdate -height 18 -expand -group IN /elevator_tb/cf_tb
add wave -noupdate -height 18 -expand -group IN /elevator_tb/switch_tb
add wave -noupdate -height 18 -expand -group IN /elevator_tb/clk_tb
add wave -noupdate -height 18 -expand -group IN /elevator_tb/nrst_tb
add wave -noupdate -height 18 -expand -group OUT /elevator_tb/motor_up_tb
add wave -noupdate -height 18 -expand -group OUT /elevator_tb/motor_down_tb
add wave -noupdate -height 18 -expand -group OUT /elevator_tb/elevator_state_tb
add wave -noupdate -height 18 -expand -group OUT /elevator_tb/Current_floor_tb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 212
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
WaveRestoreZoom {0 ns} {922 ns}
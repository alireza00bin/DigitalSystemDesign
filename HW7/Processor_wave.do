onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /miniproc_tb/opcode_tb
add wave -noupdate /miniproc_tb/clk_tb
add wave -noupdate /miniproc_tb/nrst_tb
add wave -noupdate /miniproc_tb/cut/clk
add wave -noupdate /miniproc_tb/cut/nrst
add wave -noupdate /miniproc_tb/cut/opcode
add wave -noupdate /miniproc_tb/cut/cur_state
add wave -noupdate /miniproc_tb/cut/nxt_state
add wave -noupdate /miniproc_tb/cut/A_LD
add wave -noupdate /miniproc_tb/cut/B_LD
add wave -noupdate /miniproc_tb/cut/C_LD
add wave -noupdate /miniproc_tb/cut/D_LD
add wave -noupdate /miniproc_tb/cut/AC_LD
add wave -noupdate /miniproc_tb/cut/WR
add wave -noupdate /miniproc_tb/cut/cbus
add wave -noupdate /miniproc_tb/cut/sel
add wave -noupdate /miniproc_tb/cut/func
add wave -noupdate /miniproc_tb/cut/Z
add wave -noupdate /miniproc_tb/cut/A
add wave -noupdate /miniproc_tb/cut/B
add wave -noupdate /miniproc_tb/cut/C
add wave -noupdate /miniproc_tb/cut/D
add wave -noupdate /miniproc_tb/cut/AC
add wave -noupdate /miniproc_tb/cut/memory
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {202 ns} 0}
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
WaveRestoreZoom {0 ns} {210 ns}

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dispatch_tb/clk
add wave -noupdate -radix hexadecimal /dispatch_tb/inst1
add wave -noupdate -radix hexadecimal /dispatch_tb/inst2
add wave -noupdate -radix hexadecimal /dispatch_tb/addbus
add wave -noupdate -radix hexadecimal /dispatch_tb/multbus
add wave -noupdate -radix hexadecimal /dispatch_tb/loadbus
add wave -noupdate -radix hexadecimal /dispatch_tb/storesig
add wave -noupdate -radix hexadecimal /dispatch_tb/instbus1
add wave -noupdate -radix hexadecimal /dispatch_tb/instbus2
add wave -noupdate /dispatch_tb/stall1
add wave -noupdate /dispatch_tb/stall2
add wave -noupdate -radix hexadecimal /dispatch_tb/D1/R0_t
add wave -noupdate -radix hexadecimal /dispatch_tb/D1/R1_t
add wave -noupdate -radix hexadecimal /dispatch_tb/D1/R2_t
add wave -noupdate -radix hexadecimal /dispatch_tb/D1/R3_t
add wave -noupdate /dispatch_tb/D1/A0_temp
add wave -noupdate /dispatch_tb/D1/A0_flag
add wave -noupdate /dispatch_tb/D1/A1_temp
add wave -noupdate /dispatch_tb/D1/A1_flag
add wave -noupdate /dispatch_tb/D1/A2_temp
add wave -noupdate /dispatch_tb/D1/A2_flag
add wave -noupdate /dispatch_tb/D1/M0_temp
add wave -noupdate /dispatch_tb/D1/M0_flag
add wave -noupdate /dispatch_tb/D1/M1_temp
add wave -noupdate /dispatch_tb/D1/M1_flag
add wave -noupdate /dispatch_tb/D1/LD0_temp
add wave -noupdate /dispatch_tb/D1/LD0_flag
add wave -noupdate /dispatch_tb/D1/LD1_temp
add wave -noupdate /dispatch_tb/D1/LD1_flag
add wave -noupdate /dispatch_tb/D1/ST0_temp
add wave -noupdate /dispatch_tb/D1/ST0_flag
add wave -noupdate /dispatch_tb/D1/ST1_temp
add wave -noupdate /dispatch_tb/D1/ST1_flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15 ns} 0}
configure wave -namecolwidth 177
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
WaveRestoreZoom {0 ns} {123 ns}

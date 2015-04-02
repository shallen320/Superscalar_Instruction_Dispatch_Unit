onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /adder_tb/clk
add wave -noupdate -radix hexadecimal /adder_tb/reg0
add wave -noupdate -radix hexadecimal /adder_tb/reg1
add wave -noupdate -radix hexadecimal /adder_tb/reg2
add wave -noupdate -radix hexadecimal /adder_tb/reg3
add wave -noupdate -radix hexadecimal /adder_tb/loadbus
add wave -noupdate -radix hexadecimal /adder_tb/multbus
add wave -noupdate -radix hexadecimal /adder_tb/addbus
add wave -noupdate -radix hexadecimal /adder_tb/instbus1
add wave -noupdate -radix hexadecimal /adder_tb/instbus2
add wave -noupdate -radix hexadecimal /adder_tb/addout
add wave -noupdate -radix hexadecimal /adder_tb/A1/A0_a
add wave -noupdate -radix hexadecimal /adder_tb/A1/A0_b
add wave -noupdate -radix hexadecimal /adder_tb/A1/A0_a_tag
add wave -noupdate -radix hexadecimal /adder_tb/A1/A0_b_tag
add wave -noupdate -radix hexadecimal /adder_tb/A1/A1_a
add wave -noupdate -radix hexadecimal /adder_tb/A1/A1_b
add wave -noupdate -radix hexadecimal /adder_tb/A1/A1_a_tag
add wave -noupdate -radix hexadecimal /adder_tb/A1/A1_b_tag
add wave -noupdate -radix hexadecimal /adder_tb/A1/A2_a
add wave -noupdate -radix hexadecimal /adder_tb/A1/A2_b
add wave -noupdate -radix hexadecimal /adder_tb/A1/A2_a_tag
add wave -noupdate -radix hexadecimal /adder_tb/A1/A2_b_tag
add wave -noupdate -radix unsigned /adder_tb/A1/A0_count
add wave -noupdate -radix unsigned /adder_tb/A1/A1_count
add wave -noupdate -radix unsigned /adder_tb/A1/A2_count
add wave -noupdate /adder_tb/A1/A0_a_rdy
add wave -noupdate /adder_tb/A1/A0_b_rdy
add wave -noupdate /adder_tb/A1/A1_a_rdy
add wave -noupdate /adder_tb/A1/A1_b_rdy
add wave -noupdate /adder_tb/A1/A2_a_rdy
add wave -noupdate /adder_tb/A1/A2_b_rdy
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {70 ns} 0}
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
WaveRestoreZoom {0 ns} {270 ns}

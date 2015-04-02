onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/clk
add wave -noupdate -radix hexadecimal /top_tb/data_in
add wave -noupdate -radix hexadecimal /top_tb/data_out
add wave -noupdate -radix hexadecimal /top_tb/inst1
add wave -noupdate -radix hexadecimal /top_tb/inst2
add wave -noupdate -radix hexadecimal /top_tb/instbus1
add wave -noupdate -radix hexadecimal /top_tb/instbus2
add wave -noupdate -radix hexadecimal /top_tb/addbus
add wave -noupdate -radix hexadecimal /top_tb/loadbus
add wave -noupdate -radix hexadecimal /top_tb/multbus
add wave -noupdate -radix hexadecimal /top_tb/storesig
add wave -noupdate -radix hexadecimal /top_tb/reg0
add wave -noupdate -radix hexadecimal /top_tb/reg1
add wave -noupdate -radix hexadecimal /top_tb/reg2
add wave -noupdate -radix hexadecimal /top_tb/reg3
add wave -noupdate /top_tb/stall1
add wave -noupdate /top_tb/stall2
add wave -noupdate -radix hexadecimal /top_tb/A1/A0_a
add wave -noupdate /top_tb/A1/A0_a_rdy
add wave -noupdate -radix hexadecimal /top_tb/A1/A0_a_tag
add wave -noupdate -radix hexadecimal /top_tb/A1/A0_b
add wave -noupdate /top_tb/A1/A0_b_rdy
add wave -noupdate -radix hexadecimal /top_tb/A1/A0_b_tag
add wave -noupdate -radix unsigned /top_tb/A1/A0_count
add wave -noupdate -radix hexadecimal /top_tb/A1/A1_a
add wave -noupdate /top_tb/A1/A1_a_rdy
add wave -noupdate -radix hexadecimal /top_tb/A1/A1_a_tag
add wave -noupdate -radix hexadecimal /top_tb/A1/A1_b
add wave -noupdate /top_tb/A1/A1_b_rdy
add wave -noupdate -radix hexadecimal /top_tb/A1/A1_b_tag
add wave -noupdate -radix unsigned /top_tb/A1/A1_count
add wave -noupdate -radix hexadecimal /top_tb/A1/A2_a
add wave -noupdate /top_tb/A1/A2_a_rdy
add wave -noupdate -radix hexadecimal /top_tb/A1/A2_a_tag
add wave -noupdate -radix hexadecimal /top_tb/A1/A2_b
add wave -noupdate /top_tb/A1/A2_b_rdy
add wave -noupdate -radix hexadecimal /top_tb/A1/A2_b_tag
add wave -noupdate -radix unsigned /top_tb/A1/A2_count
add wave -noupdate -radix unsigned /top_tb/L1/LD0_count
add wave -noupdate /top_tb/L1/LD0_rdy
add wave -noupdate -radix hexadecimal /top_tb/M1/M0_a
add wave -noupdate /top_tb/M1/M0_a_rdy
add wave -noupdate -radix hexadecimal /top_tb/M1/M0_a_tag
add wave -noupdate -radix hexadecimal /top_tb/M1/M0_b
add wave -noupdate /top_tb/M1/M0_b_rdy
add wave -noupdate -radix hexadecimal /top_tb/M1/M0_b_tag
add wave -noupdate -radix unsigned /top_tb/M1/M0_count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {165 ns} 0}
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
WaveRestoreZoom {5 ns} {131 ns}

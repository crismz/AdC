onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /processor_tb/CLOCK_50
add wave -noupdate /processor_tb/reset
add wave -noupdate /processor_tb/DM_writeEnable
add wave -noupdate /processor_tb/DM_writeData
add wave -noupdate /processor_tb/DM_addr
add wave -noupdate /processor_tb/dump
add wave -noupdate {/processor_tb/dut/dp/DECODE/registers/REGS[25]}
add wave -noupdate {/processor_tb/dut/dp/DECODE/registers/REGS[30]}
add wave -noupdate /processor_tb/dut/dp/EXECUTE/forwardA
add wave -noupdate /processor_tb/dut/dp/EXECUTE/forwardB
add wave -noupdate /processor_tb/dut/dp/EXECUTE/muxfA
add wave -noupdate /processor_tb/dut/dp/EXECUTE/muxfB
add wave -noupdate /processor_tb/dut/dp/EXECUTE/readData1_E
add wave -noupdate /processor_tb/dut/dp/EXECUTE/readData2_E
add wave -noupdate -divider forwarding
add wave -noupdate /processor_tb/dut/dp/EXECUTE/fw/forwardA
add wave -noupdate /processor_tb/dut/dp/EXECUTE/fw/forwardB
add wave -noupdate /processor_tb/dut/dp/EXECUTE/fw/MEM_WBregWrite
add wave -noupdate /processor_tb/dut/dp/EXECUTE/fw/EX_MEMregWrite
add wave -noupdate -radix unsigned /processor_tb/dut/dp/EXECUTE/fw/EX_MEMRegRd
add wave -noupdate -radix unsigned /processor_tb/dut/dp/EXECUTE/fw/MEM_WBRegRd
add wave -noupdate -radix unsigned /processor_tb/dut/dp/EXECUTE/fw/ID_EXRegRn
add wave -noupdate -radix unsigned /processor_tb/dut/dp/EXECUTE/fw/ID_EXRegRm
add wave -noupdate /processor_tb/dut/dp/EXECUTE/mxfA/y
add wave -noupdate /processor_tb/dut/dp/EXECUTE/mxfB/y
add wave -noupdate /processor_tb/dut/dp/EXECUTE/mxfA/d1
add wave -noupdate -radix decimal /processor_tb/dut/dp/EXECUTE/mxfA/d2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {630 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {592 ps} {728 ps}

transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1 {/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1/memory.sv}
vlog -sv -work work +incdir+/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1 {/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1/writeback.sv}
vlog -sv -work work +incdir+/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1 {/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1/sl2.sv}
vlog -sv -work work +incdir+/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1 {/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1/signext.sv}
vlog -sv -work work +incdir+/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1 {/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1/regfile.sv}
vlog -sv -work work +incdir+/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1 {/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1/processor_arm.sv}
vlog -sv -work work +incdir+/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1 {/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1/mux2.sv}
vlog -sv -work work +incdir+/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1 {/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1/maindec.sv}
vlog -sv -work work +incdir+/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1 {/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1/imem.sv}
vlog -sv -work work +incdir+/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1 {/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1/flopr.sv}
vlog -sv -work work +incdir+/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1 {/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1/fetch.sv}
vlog -sv -work work +incdir+/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1 {/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1/execute.sv}
vlog -sv -work work +incdir+/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1 {/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1/decode.sv}
vlog -sv -work work +incdir+/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1 {/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1/datapath.sv}
vlog -sv -work work +incdir+/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1 {/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1/controller.sv}
vlog -sv -work work +incdir+/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1 {/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1/aludec.sv}
vlog -sv -work work +incdir+/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1 {/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1/alu.sv}
vlog -sv -work work +incdir+/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1 {/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1/adder.sv}
vcom -2008 -work work {/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1/dmem.vhd}

vlog -sv -work work +incdir+/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1 {/home/crismuz/Desktop/Materias/3Anno/2Sem/AdC/lab1/LAB1/processor_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  processor_tb

add wave *
view structure
view signals
run -all

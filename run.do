vlib work
vlog FIFO_top.sv  FIFO.sv FIFO_interface.sv +cover +define+SIM -covercells 
vsim -voptargs=+acc work.FIFO_top -cover
add wave *
coverage save FIFO_top.ucdb -onexit 
run -all
//quit -sim
//vcover report FIFO_top.ucdb -details -all -output coverage_rpt.txt
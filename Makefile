TOP=top.sv
INTERFACE=interface.sv
BENCH=bench.sv
DUT=cam_decoder.sv cam_mux.sv cam_encoder.sv eff.sv rws_ff.sv cam.sv
FF_TEST=ff_top.sv ff_if.sv ff_bench.sv eff.sv rws_ff_test.sv

.PHONY: help

help:
	@echo "The following make targets are supported:" ;\
	echo " bench  - builds the testbench";\
	echo " wave   - convert vcd to vpd";\
	echo " expand - expands veritedium directives (autoargs, inst etc.)";\
	echo " indent - automatically indents verilog and c files" ;\
	echo " clean  - cleans testbench and intermediate files" ;\
	echo " help   - show this information";\

indent:
	emacs --batch *.sv -f verilog-batch-indent
	indent -linux *.c *.h
	rm *~

dut:  
	vcs -full64 -PP -sverilog +define+SV +define+VPD +lint=all,noVCDE -notice $(DUT) $(INTERFACE)

bench: 
	vcs -full64 -PP -sverilog +define+SV +define+VPD +lint=all,noVCDE -notice $(INTERFACE) $(DUT) $(BENCH) $(TOP) -o testbench.exe

ffbench:
	vcs -full64 -PP -sverilog +define+SV +define+VPD +lint=all,noVCDE -notice $(FF_TEST) -o fftestbench.exe

wave:
	vcs -vpd2vcd vcdplus.vpd waveform.vcd
	gtkwave waveform.vcd &

clean:
	rm -rf *.o *~ *.vpd sim* csrc DVEfiles *daidir *exe *.key

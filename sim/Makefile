##################################################################################################
#This file created by Huy Nguyen
#Created date: 7/1/2019
#Example run string: make TESTNAME={name_of_testcase} {optional}
#		     make TESTNAME=test_reg all 
##################################################################################################
#Define variables
TESTNAME 	?= Basic_trans_noload_cnt_up_T2
TB_NAME 	?= test_bench
RADIX		?= hexadecimal
REGRESS_LIST	?= regress.list
#================================================================================================

all: build run
regression: build regress 
regression_cov: build regress_cov  

build:
	mkdir -p log
	touch run_test.v
	vlib work
	vmap work work
	vlog -f compile.f

run:	
	cp -rf ../testcases/$(TESTNAME).v run_test.v
	vlog -f compile.f
	vsim -l $(TESTNAME).log -voptargs=+acc -novopt -assertdebug -c $(TB_NAME) -do "log -r /*;run -all;"
	mv $(TESTNAME).log ./log
	cp -rf  vsim.wlf $(TESTNAME).wlf
	mv $(TESTNAME).wlf ./log
	ln -sf ./log/$(TESTNAME).log sim.log

create_test_list:  
	find  ../testcases/ -type f -printf "%f\n" |sed 's/.v//' | tee $(REGRESS_LIST) | wc -l

regress:
	make run TESTNAME=`cat $(REGRESS_LIST) |sed -n 1p $(REGRESS_LIST)`
	make run TESTNAME=`cat $(REGRESS_LIST) |sed -n 2p $(REGRESS_LIST)`
	make run TESTNAME=`cat $(REGRESS_LIST) |sed -n 3p $(REGRESS_LIST)`
	make run TESTNAME=`cat $(REGRESS_LIST) |sed -n 4p $(REGRESS_LIST)`
	make run TESTNAME=`cat $(REGRESS_LIST) |sed -n 5p $(REGRESS_LIST)`
	make run TESTNAME=`cat $(REGRESS_LIST) |sed -n 6p $(REGRESS_LIST)`
	make run TESTNAME=`cat $(REGRESS_LIST) |sed -n 7p $(REGRESS_LIST)`
	make run TESTNAME=`cat $(REGRESS_LIST) |sed -n 8p $(REGRESS_LIST)`
	make run TESTNAME=`cat $(REGRESS_LIST) |sed -n 9p $(REGRESS_LIST)`
	make run TESTNAME=`cat $(REGRESS_LIST) |sed -n 10p $(REGRESS_LIST)`

	
regress_cov:
	make run_cov TESTNAME=`cat $(REGRESS_LIST) |sed -n 1p $(REGRESS_LIST)`
	make run_cov TESTNAME=`cat $(REGRESS_LIST) |sed -n 2p $(REGRESS_LIST)`
	make run_cov TESTNAME=`cat $(REGRESS_LIST) |sed -n 3p $(REGRESS_LIST)`
	make run_cov TESTNAME=`cat $(REGRESS_LIST) |sed -n 4p $(REGRESS_LIST)`
	make run_cov TESTNAME=`cat $(REGRESS_LIST) |sed -n 5p $(REGRESS_LIST)`
	make run_cov TESTNAME=`cat $(REGRESS_LIST) |sed -n 6p $(REGRESS_LIST)`
	make run_cov TESTNAME=`cat $(REGRESS_LIST) |sed -n 7p $(REGRESS_LIST)`
	make run_cov TESTNAME=`cat $(REGRESS_LIST) |sed -n 8p $(REGRESS_LIST)`
	make run_cov TESTNAME=`cat $(REGRESS_LIST) |sed -n 9p $(REGRESS_LIST)`
	make run_cov TESTNAME=`cat $(REGRESS_LIST) |sed -n 10p $(REGRESS_LIST)`


wave:
	vsim -i -view vsim.wlf -do "add wave vsim:/$(TB_NAME)/*; radix -$(RADIX)" &

run_cov:
	cp -rf ../testcases/$(TESTNAME).v run_test.v
	vlog +cover=sbceftx -f compile.f
	vsim -coverage -l $(TESTNAME).log -c $(TB_NAME) -voptargs="+cover=bcesfx" -novopt -assertdebug -do "coverage save -onexit $(TESTNAME).ucdb; log -r -d 6 /*;run -all"
	mv $(TESTNAME).log ./log

gen_cov:
	mkdir -p coverage
	vcover merge IP.ucdb *.ucdb
	vcover report IP.ucdb -file coverage/summary_report.txt
	vcover report -zeros -details -code bcefsx -All -codeAll IP.ucdb -file coverage/detail_report.txt

clean:
	rm -rf work
	rm -rf log
	rm -rf *.ini
	rm -rf *.log
	rm -rf *.wlf
	rm -rf transcript
	rm -rf coverage
	rm -rf *.ucdb
	rm -rf *.v

help:
	@echo "Use command: make {option} {argument}" 
	@echo "{option} is:" 
	@echo "build            :Compile rtl and testbench" 
	@echo "run              :Run simulation" 
	@echo "regression       :Run regression" 
	@echo "regression_cov   :Run regression with coverage" 
	@echo "wave             :Loading waveform" 
	@echo "run_cov          :Run single test with coverage" 
	@echo "gen_cov          :Generate coverage report" 
	@echo "clean            :Clean up environment" 

search: 
	find  ../testcases/ -type f -printf "%f\n" |sed 's/.vt//' 

report:
	grep "RESULT" ./log/*.log  

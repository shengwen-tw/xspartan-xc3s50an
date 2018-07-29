PROJECT=test_uart
TOP=test_uart

TARGET=xc3s50an-5-tqg144
OPT_MODE=Speed
OPT_LEVEL=1

###############################################################################################
all: init synthesize_xst implement_design generate_programming_file

init=build/

#If you add new files or modify the parameter above, you should init it again

init: build/
build/:
	@mkdir build/
	@######################################################################################
	@echo "Generate build/$(PROJECT).prj"
	@for i in `ls -1 src/*.v`; do echo "verilog work ../$$i" >> build/$(PROJECT).prj; done
	@######################################################################################
	@echo "Generate build/$(PROJECT).xst"
	@echo "run -ifn $(PROJECT).prj -ifmt mixed -top $(TOP) -ofn $(PROJECT) -ofmt NGC \
	-p $(TARGET) -opt_mode $(OPT_MODE) -opt_level $(OPT_LEVEL) -ofn synthesis.log" \
	-use_new_parser yes > build/$(PROJECT).xst

.ONESHELL:
synthesize_xst: build/$(PROJECT).xst build/$(PROJECT).prj
	cd build/
	xst -ifn $(PROJECT).xst

implement_design:
	cd build
	@######################################################################################
	ngdbuild -intstyle ise -dd _ngo -nt timestamp -uc ../constraints.ucf \
	-p $(TARGET) $(PROJECT).ngc $(PROJECT).ngd
	@######################################################################################
	map -intstyle ise -p $(TARGET) -cm area -ir off -pr off -c 100 \
	-o $(PROJECT).ncd $(PROJECT).ngd $(PROJECT).pcf
	@######################################################################################
	par -w -intstyle ise -ol high -t 1 $(PROJECT).ncd $(PROJECT).ncd $(PROJECT).pcf
	@######################################################################################
	trce -intstyle ise -v 3 -s 4 -n 3 -fastpaths -xml $(PROJECT).twx $(PROJECT).ncd \
	-o $(PROJECT).twr $(PROJECT).pcf -ucf ../constraints.ucf

generate_programming_file:
	cd build
	@######################################################################################
	bitgen -b -w $(PROJECT).ncd $(PROJECT).bit

impact:
	impact

clean:
	rm -rf build/

.PHONY: init synthesize_xst implement_design generate_programming_file impact clean

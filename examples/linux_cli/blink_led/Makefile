PROJECT=blink_led
TOP=blink_led

TARGET=xc3s50an-4-tqg144
OPT_MODE=Speed
OPT_LEVEL=1

#############################################################################################
all: synthesize_xst

init:
	@mkdir build/
	@####################################################################################
	@echo "Generate build/$(PROJECT).prj"
	@for i in `ls -1 src/`; do echo "verilog work ../src/$$i" >> build/$(PROJECT).prj; done
	@####################################################################################
	@echo "Generate build/$(PROJECT).xst"
	@echo "run -ifn $(PROJECT).prj -ifmt mixed -top $(TOP) -ofn $(PROJECT) -ofmt NGC \
	-p $(TARGET) -opt_mode $(OPT_MODE) -opt_level $(OPT_LEVEL) -ofn synthesis.log" \
	> build/$(PROJECT).xst

.ONESHELL:
synthesize_xst: build/$(PROJECT).xst build/$(PROJECT).prj
	cd build/
	xst -ifn $(PROJECT).xst

clean:
	rm -rf build/

TARGET=FPGA-Verilog/toplevel.bit
NMIGEN_PYTHON:=$$HOME/Github/nmigen-tutorial/.venv/bin/python
AUTO_GEN:=FPGA-Verilog/nmigen.v
SRC_PY:=leds.py

SRC_FPGA:=   \
	FPGA-Verilog/toplevel.tcl \
	FPGA-Verilog/toplevel.v   \
	FPGA-Verilog/Makefile

all:	${TARGET}

${TARGET}:	${SRC_FPGA} ${AUTO_GEN}
	@echo "[-] Spawning Xilinx ISE..."
	$(MAKE) -C FPGA-Verilog/

${AUTO_GEN}:	${SRC_PY}
	@echo "[-] Generating Verilog..."
	${NMIGEN_PYTHON} ${SRC_PY} ver

prog:	${TARGET}
	progZestSC1 ${TARGET}

il:
	${NMIGEN_PYTHON} ${SRC_PY} gen

formal_verification:
	$(MAKE) -C formal_verification/

pylint:
	pylint --rcfile=pylint.cfg ${SRC_PY}

clean:
	rm -rf ${TARGET} __pycache__/ ${AUTO_GEN}
	$(MAKE) -C FPGA-Verilog/ clean
	$(MAKE) -C formal_verification/ clean

.PHONY:	formal_verification pylint clean il

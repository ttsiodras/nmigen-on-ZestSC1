BITFILE := toplevel.bit

all: ${BITFILE}

${BITFILE}:	toplevel.v toplevel.tcl nmigen.v
	xtclsh toplevel.tcl rebuild_project
	@grep met toplevel.par
	@grep "All constraints were met." toplevel.twr >/dev/null || exit 1
	@grep "All constraints were met." toplevel.par >/dev/null || exit 1

clean:
	rm -rf ${BITFILE} $$(cat .gitignore)

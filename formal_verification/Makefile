TOP:=toplevel.il

all:	cover bmc prove
	@echo -e "\n=================="
	@echo "  All results: "
	@echo "=================="
	@for i in default_*/status ; do    \
		cat "$$i" | tr -d '\012' ; \
		echo " ($$i)" ;            \
	done
	@echo 

${TOP}:	../leds.py
	$(MAKE) -C ../ il

cover:	${TOP}
	sby -f default.sby cover || exit 0
	@echo "============================="
	@echo -n "  Result COVER: "
	@head -1 default_cover/status
	@echo "============================="

bmc:	${TOP}
	sby -f default.sby bmc || exit 0
	@echo "============================="
	@echo -n "  Result BMC: "
	@head -1 default_bmc/status
	@echo "============================="

prove:	${TOP}
	sby -f default.sby prove || exit 0
	@echo "============================="
	@echo -n "  Result PROVE: "
	@head -1 default_prove/status
	@echo "============================="

waves:
	find default* -type f -iname '*.vcd' | fzf | xargs -r gtkwave

clean:
	rm -rf default_bmc/  default_cover/  leds_cover/ toplevel.il

.PHONY:	cover bmc clean

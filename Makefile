DASM = /home/profs/aycock/599.82/bin/dasm
DEST = ~nielson.trung/www/599.82/final_back_up/
URL = https://pages.cpsc.ucalgary.ca/~nielson.trung/599.82/final_back_up/

$(file).prg:	$(file).asm
	@$(DASM) $< -o$@ -lout.lst	
	@chmod 755 $(DEST)$@
	@echo $(URL)$@

clean:		
	rm *.prg

echo:
	@echo $(URL)
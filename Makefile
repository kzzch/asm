ASM = -g -dwarf -f elf

itoa.o: itoa.s
	nasm $(ASM) -o itoa.o itoa.s

itoa: itoa.o
	ld -o itoa itoa.o -lc -dynamic-linker /lib/ld-linux.so.2

itoa_local:
	nasm $(ASM) -o itoa_local.o itoa_local.s
	ld -o itoa_local itoa_local.0 -lc -dynamic-linker /blig/ld-linux.so.2

clean:
	rm itoa.o itoa

clean2: 
	rm itoa_local.o itoa_local

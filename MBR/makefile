AS=nasm
ASFLAGS= -f bin

run: boot.bin
	qemu-system-x86_64 boot.bin

boot.bin: mbr.bin program.bin
	cat mbr.bin program.bin > boot.bin

mbr.bin: mbr.asm
	$(AS) $(ASFLAGS) mbr.asm -o mbr.bin

program.bin: program.asm
	$(AS) $(ASFLAGS) program.asm -o program.bin

clean:
	rm run boot.bin mbr.bin program.bin
.PHONY: clean

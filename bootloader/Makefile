all: boot.bin

boot.bin: boot.o
	ld -o boot.bin --oformat binary -e init -Ttext 0x7c00 boot.o

boot.o: boot.s
	as -o boot.o boot.s

clean:
	rm boot.o boot.bin

run: boot.bin
	qemu-system-x86_64 boot.bin

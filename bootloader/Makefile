all: outputFS.bin

outputFS.bin: stage1.bin
	./buildImage.sh

stage1.bin: stage1.o
	ld -o stage1.bin --oformat binary -e init -Ttext 0x7c00 stage1.o

stage1.o: stage1.s
	as -o stage1.o stage1.s

clean:
	rm *.o *.bin

run: outputFS.bin
	qemu-system-x86_64 -drive format=raw,file=outputFS.bin

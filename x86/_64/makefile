all: box

box: box.asm
	nasm -f elf64 -g -F stabs box.asm
	ld -o out/box box.o
	rm box.o

clean:
	rm out/*
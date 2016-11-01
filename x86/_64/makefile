all: box input

input: input.asm
	@ echo "Assembling input.asm"
	@ nasm -f elf64 -g -F stabs input.asm
	@ ld -o out/input.asm input.o
	@ rm input.o

box: box.asm
	@ echo "Assembling box.asm"
	@ nasm -f elf64 -g -F stabs box.asm
	@ ld -o out/box box.o
	@ rm box.o

clean:
	rm out/*

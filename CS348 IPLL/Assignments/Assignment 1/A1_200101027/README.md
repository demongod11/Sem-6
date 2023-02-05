Commands for executing both the files are as follows:
nasm -f elf64 file.o -o file.asm
ld file.o -o file
./file

Note: For the first assignment for the sake of convinience I have implemented only for 8 bits. So the range of numbers in the array must be from 0 to 255.
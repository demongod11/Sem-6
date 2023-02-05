section .data
    fileName db "file.txt", 0 ; file name

section .bss
    buffer resb 1024 ; buffer for reading file

section .text
    global _start

_start:
    ; open file for reading
    mov rax, 2
    mov rdi, fileName
    mov rsi, 0
    syscall

    ; read file into buffer
    mov rax, 0
    mov rdi, rax
    mov rsi, buffer
    mov rdx, 1024
    syscall

    ; replace non-printable characters in buffer
    mov rdi, buffer
    mov rcx, 1024

replaceLoop:
    cmp byte[rdi], 0
    jmp printFile
    cmp byte [rdi], 50
    jl replaceChar
    inc rdi
    jmp replaceLoop

replaceChar:
    mov byte [rdi], '*'
    inc rdi
    jmp replaceLoop

printFile:
    ; print contents of buffer
    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    mov rdx, 1024
    syscall

    ; close file
    mov rax, 3
    mov rdi, rax
    syscall

    ; exit program
    mov rax, 60
    xor rdi, rdi
    syscall

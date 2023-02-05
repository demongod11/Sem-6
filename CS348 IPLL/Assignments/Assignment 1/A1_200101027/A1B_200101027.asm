section .data
    filename db "file.txt",0    ;File Name
    asterick db "*",0   

section .bss
    temp resb 1
    var resb 10

section .text
    global _start

%macro exit 0                  
    mov rax, 60
    mov rdi, 0
    syscall
%endmacro

_start:
    ; File Open
    mov rax, 2
    mov rdi, filename
    mov rsi, 2
    mov rdx, 0777
    syscall

    mov r8, rax

_process:  
    ; File Read
    mov rax, 0
    mov rdi, r8
    mov rsi, temp
    mov rdx, 1
    syscall

    ; Comparing whether it is EOF or not
    cmp rax, 0
    jne _here

    ; File close
    mov rax, 3
    mov rdi, rax
    syscall
    exit

_here:
    ; Comparing whether it is a non printable character or not based on ASCII values
    cmp byte [temp], 31
    jle _change
    mov rax, 1
    mov rdi, 1
    mov rsi, temp
    mov rdx, 1
    syscall

    jmp _process


    ; Changing the non printable character with the asterick symbol
_change:

    ; Printing to the console
    mov rax, 1
    mov rdi, 1
    mov rsi, asterick
    mov rdx, 1
    syscall
    
    ; Changing the current file pointer position using seek
    mov rax, 8   ; syscall for lseek
    mov rdi, r8  ; file descriptor
    mov rsi, -1 ; offset (-1 byte)
    mov rdx, 1   ; whence (SEEK_CUR)
    syscall

    ; Writing to the file
    mov rax, 1
    mov rdi, r8
    mov rsi, asterick
    mov rdx, 1
    syscall

    ; Changing the current file pointer position using seek
    mov rax, 8   ; syscall for lseek
    mov rdi, r8  ; file descriptor
    mov rsi, 1 ; offset (1 byte)
    mov rdx, 1   ; whence (SEEK_CUR)
    syscall

    jmp _process
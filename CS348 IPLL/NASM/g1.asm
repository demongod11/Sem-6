section .data
    array qword 1, 2, 3, 4, 5
    array_size equ $ - array
    min_num qword 0
    min_loc qword 0
    max_num qword 0
    max_loc qword 0

section .text
    global _start

_start:
    mov rcx, array_size
    mov rsi, array
    mov rdi, array
    mov rax, [rsi]
    mov rbx, [rsi]
    mov [min_num], rax
    mov [max_num], rbx
    add rsi, 8

    ; Find minimum and maximum number
    find_minmax:
        cmp rcx, 0
        je print_result
        mov rax, [rsi]
        cmp rax, [min_num]
        jl set_min
        cmp rax, [max_num]
        jg set_max
        add rsi, 8
        dec rcx
        jmp find_minmax

    set_min:
        mov [min_num], rax
        mov [min_loc], rdi
        add rsi, 8
        add rdi, 8
        dec rcx
        jmp find_minmax

    set_max:
        mov [max_num], rax
        mov [max_loc], rdi
        add rsi, 8
        add rdi, 8
        dec rcx
        jmp find_minmax

    ; Print result
    print_result:
        mov rax, 1
        mov rdi, 1
        mov rsi, min_num
        mov rdx, 8
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, min_loc
        mov rdx, 8
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, max_num
        mov rdx, 8
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, max_loc
        mov rdx, 8
        syscall

        ; Exit program
        mov rax, 60
        xor rdi, rdi
        syscall

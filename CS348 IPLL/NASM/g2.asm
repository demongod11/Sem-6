section .data
    array_size dq 0
    array times 100 dq 0
    min_num qword 0
    min_loc qword 0
    max_num qword 0
    max_loc qword 0
    prompt db "Enter the size of the array:",0
    prompt_elements db "Enter the elements of the array:",0
    input db 21 dup(0)
    input_len equ $ - input

section .text
    global _start

_start:
    ; Print prompt for array size
    mov rax, 4
    mov rdi, 1
    mov rsi, prompt
    mov rdx, 26
    syscall

    ; Read array size
    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, input_len
    syscall

    ; Convert input to integer
    mov rax, input
    mov rbx, 10
    call _atoi

    ; Store array size in array_size
    mov [array_size], rax

    ; Print prompt for array elements
    mov rax, 4
    mov rdi, 1
    mov rsi, prompt_elements
    mov rdx, 29
    syscall

    ; Read array elements
    mov rcx, [array_size]
    mov rsi, array
    read_elements:
        cmp rcx, 0
        je calculate
        mov rax, 0
        mov rdi, 0
        mov rsi, input
        mov rdx, input_len
        syscall
        mov rax, input
        mov rbx, 10
        call _atoi
        mov [rsi], rax
        add rsi, 8
        dec rcx
        jmp read_elements

    calculate:
        mov rcx, [array_size]
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

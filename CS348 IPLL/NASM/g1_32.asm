section .data
    array dw 10, 9, 8, 7, 5
    array_size equ $ - array
    min_num dw 0
    min_loc dw 0
    max_num dw 0
    max_loc dw 0

section .text
    global _start

_start:
    mov ecx, array_size
    mov esi, array
    mov edi, array
    mov eax, [esi]
    mov ebx, [esi]
    mov [min_num], eax
    mov [max_num], ebx
    inc esi

    ; Find minimum and maximum number
    find_minmax:
        cmp ecx, 0
        je print_result
        mov eax, [esi]
        cmp eax, [min_num]
        jl set_min
        cmp eax, [max_num]
        jg set_max
        inc esi
        dec ecx
        jmp find_minmax

    set_min:
        mov [min_num], eax
        mov [min_loc], edi
        inc esi
        inc edi
        dec ecx
        jmp find_minmax

    set_max:
        mov [max_num], eax
        mov [max_loc], edi
        inc esi
        inc edi
        dec ecx
        jmp find_minmax

    ; Print result
    print_result:
        push eax
        mov eax, [min_num]
        add eax, 48
        mov [min_num], eax
        pop eax
        mov eax, 4
        mov ebx, 1
        mov ecx, min_num
        mov edx, 2
        int 0x80

        push eax
        mov eax, [min_loc]
        add eax, 48
        mov [min_loc], eax
        pop eax
        mov eax, 4
        mov ebx, 1
        mov ecx, min_loc
        mov edx, 2
        int 0x80

        push eax
        mov eax, [max_num]
        add eax, 48
        mov [max_num], eax
        pop eax
        mov eax, 4
        mov ebx, 1
        mov ecx, max_num
        mov edx, 2
        int 0x80

        push eax
        mov eax, [max_loc]
        add eax, 48
        mov [max_loc], eax
        pop eax
        mov eax, 4
        mov ebx, 1
        mov ecx, max_loc
        mov edx, 2
        int 0x80

        ; Exit program
        mov eax, 1
        xor ebx, ebx
        int 0x80

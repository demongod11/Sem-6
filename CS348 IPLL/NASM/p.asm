section .data
    n_prompt db "Enter the size of the array: ", 0
    element_prompt db "Enter the elements of the array: ", 0
    min_msg db "The smallest number is: %d located at index %d", 10, 0
    max_msg db "The largest number is: %d located at index %d", 10, 0
    n dq 0
    min dq 0
    max dq 0
    min_index dq 0
    max_index dq 0
    i dq 0
    arr times 8 db 0

section .text
    global main

main:
    ; Print n_prompt
    mov edx, n_prompt
    mov ecx, 30
    mov ebx, 1
    mov eax, 4
    int 0x80

    ; Get user input for n
    mov edx, 8
    mov ecx, n
    mov ebx, 0
    mov eax, 3
    int 0x80

    ; Print element_prompt
    mov edx, element_prompt
    mov ecx, 34
    mov ebx, 1
    mov eax, 4
    int 0x80

    ; Loop to get user input for array elements
array_input_start:
    mov ebx, i
    mov eax, [n]
    cmp ebx, eax
    jge array_input_done

    ; Get user input for array element
    mov edx, 4

    ; mov ecx, arr + 4*ebx
    add ebx, ebx
    add ebx, ebx
    add ebx, arr
    mov ecx, ebx
    sub ebx, arr
    push eax
    mov eax, ebx
    mov edx, 0
    push ecx
    mov ecx, 4
    div ecx
    pop ecx
    mov ebx, eax
    pop eax

    mov eax, 3
    int 0x80

    ; Increment i and repeat loop
    add ebx, 1
    jmp array_input_start

array_input_done:
    ; Set min and max to first array element
    mov eax, [arr]
    mov [min], eax
    mov [max], eax
    mov [min_index], 0
    mov [max_index], 0

    ; Loop through array to find min and max
    mov ebx, i
    mov eax, [n]
    cmp ebx, eax
    jge array_search_done

    ; Compare current array element to min and max
    ; mov ecx, arr + 4*ebx
    add ebx, ebx
    add ebx, ebx
    add ebx, arr
    mov ecx, ebx
    sub ebx, arr
    push eax
    mov eax, ebx
    mov edx, 0
    push ecx
    mov ecx, 4
    div ecx
    pop ecx
    mov ebx, eax
    pop eax

    cmp ecx, [min]
    jl update_min
    cmp ecx, [max]
    jg update_max
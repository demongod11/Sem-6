section .data
    n dw ?          ; variable to store size of array
    k dw ?          ; variable to store value of k
    arr db 20 dup(?) ; array of size 20
    message db "Enter the value of n: ",0
    message1 db "Enter the value of k: ",0
    message2 db "Enter the elements of the array: ",0
    message3 db "The Kth largest element is at index ",0
    message4 db "The Kth largest element is ",0
    message5 db " ",0

section .bss
    index resb 4    ; variable to store index of kth largest element

section .text
    global _start

_start:
    ; prompt user for n
    mov eax, 4
    mov ebx, 1
    mov ecx, message
    mov edx, len1
    int 0x80

    ; read n from user
    mov eax, 3
    mov ebx, 0
    mov ecx, n
    mov edx, 2
    int 0x80

    ; prompt user for k
    mov eax, 4
    mov ebx, 1
    mov ecx, message1
    mov edx, len2
    int 0x80

    ; read k from user
    mov eax, 3
    mov ebx, 0
    mov ecx, k
    mov edx, 2
    int 0x80

    ; prompt user to enter elements of array
    mov eax, 4
    mov ebx, 1
    mov ecx, message2
    mov edx, len3
    int 0x80

    ; read elements of array from user
    mov ecx, 0
    read_loop:
        mov eax, 3
        mov ebx, 0
        mov edx, 1
        add ecx, 1
        mov edi, ecx
        dec edi
        mov esi, offset arr
        add esi, edi
        int 0x80
        cmp ecx, [n]
        jl read_loop

    ; find kth largest element
    mov ecx, [n]
    mov ebx, [k]
    mov eax, 0
    mov edx, 0
    mov esi, offset arr
    dec ebx
find_loop:
    mov edi, 0
    mov edx, 0
    cmp eax, ecx
    je print_index
    mov edx, [esi+eax*1]
    inc eax
    jmp find_loop

print_index:
    mov eax, 4
    mov ebx, 1
    mov ecx, message4
    mov edx, len4
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, edx
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, message5
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, index
    mov edx, 4
    int 0x80

    ; exit program
    mov eax, 1
   

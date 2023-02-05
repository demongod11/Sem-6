section .data
    msgN db "Enter the size of array",10
    msgOne db "smallest="
    msgTwo db "loc_small="
    msgThree db "largest="
    msgFour db "loc_lar="

section .bss
    valNStr resb 8          ; Memory for string value of N
    rbxVal resb 8           ; Memory for temporary rbx values
    rVal resb 8
    valN resb 8             ; Memory for integer value of N
    mini resb 8             ; Memory for temporary minimum value
    maxi resb 8             ; Memory for temporary maximum value
    currStr resb 8          ; Memory for current value read in string format
    curr resb 8
    indMin resb 8
    indMax resb 8
    digitSpace resb 100
    digitSpacePos resb 8

section .text
    global _start

; Macro for exit
%macro exit 0
    mov rax, 60
    mov rdi, 0
    syscall
%endmacro


; This macro converts string to integers
%macro convertInt 2
    push r8
    mov r8, %1
    push r9
    mov r9, 0
    push r10
    push r14
    mov r14, 10

    %%convIntLoop:
        mov r10, [r8]
        sub r10, 48
        push rax
        mov rax, r9
        mul r14
        mov r9, rax
        pop rax
        add r9, r10
        add r8, 1
        cmp byte [r8], 10
        jne %%convIntLoop
    
    mov [%2], r9

    pop r14
    pop r10
    pop r9
    pop r8
%endmacro

_start:
    call _printMsgN
    call _getN
    convertInt valNStr, valN
    mov r12, [valN]
    mov rbx, 0

    call _process
    _here:
    call _msgOne
    mov rax, [mini]
    call _printRAX
    call _msgTwo
    mov rax, [indMin]
    call _printRAX
    call _msgThree
    mov rax, [maxi]
    call _printRAX
    call _msgFour
    mov rax, [indMax]
    call _printRAX

    exit

_process:
    cmp bl, r12b            ;Compares whether it took all input or not
    jne _branch
    mov [mini], r8
    mov [maxi], r9
    mov [indMin], r10
    mov [indMax], r14
    pop r13
    pop r14
    pop r10
    pop r9
    pop r8
    jmp _here

_branch:
    mov rax, 0
    mov rdi, 0
    mov rsi, currStr
    mov rdx, 8
    syscall

    convertInt currStr, curr
    mov r13, [curr]
    cmp rbx, 0
    je _initiation
    
    cmp r9b, r13b
    jl _swapMax

_hereOne:
    cmp r8b, r13b
    jg _swapMin

_hereTwo:
    add rbx, 1
    jmp _process
    

_swapMax:
    mov r9b, r13b
    mov r14, rbx
    jmp _hereOne

_swapMin:
    mov r8b, r13b
    mov r10, rbx
    jmp _hereTwo

; This is for initiation
_initiation:
    push r8                                 ; Mini
    push r9                                 ; Maxi
    push r10                                ; IndMin
    push r14                                ; IndMax
    push r13                                ; Curr
    
    mov r8b, r13b
    mov r9b, r13b
    mov r10, 0
    mov r14, 0
    add rbx, 1
    jmp _process

_printMsgN:
    mov rax, 1
    mov rdi, 1
    mov rsi, msgN
    mov rdx, 24
    syscall
    ret

_getN:
    mov rax, 0
    mov rdi, 0
    mov rsi, valNStr
    mov rdx, 8
    syscall
    ret

_printRbx:
    add rbx, 48
    mov [rbxVal], rbx
    sub rbx, 48
    mov rax, 1
    mov rdi, 1
    mov rsi, rbxVal
    mov rdx, 2
    syscall
    ret

; This is for printing integer values stored in rax register
_printRAX:
    mov rcx, digitSpace
    mov rbx, 10
    mov [rcx], rbx
    inc rcx
    mov [digitSpacePos], rcx
 
_printRAXLoop:
    mov rdx, 0
    mov rbx, 10
    div rbx
    push rax
    add rdx, 48
 
    mov rcx, [digitSpacePos]
    mov [rcx], dl
    inc rcx
    mov [digitSpacePos], rcx
    
    pop rax
    cmp rax, 0
    jne _printRAXLoop
 
_printRAXLoop2:
    mov rcx, [digitSpacePos]
 
    mov rax, 1
    mov rdi, 1
    mov rsi, rcx
    mov rdx, 1
    syscall
 
    mov rcx, [digitSpacePos]
    dec rcx
    mov [digitSpacePos], rcx
 
    cmp rcx, digitSpace
    jge _printRAXLoop2
 
    ret
    
_msgOne:
    mov rax, 1
    mov rdi, 1
    mov rsi, msgOne
    mov rdx, 9
    syscall
    ret

_msgTwo:
    mov rax, 1
    mov rdi, 1
    mov rsi, msgTwo
    mov rdx, 10
    syscall
    ret

_msgThree:
    mov rax, 1
    mov rdi, 1
    mov rsi, msgThree
    mov rdx, 8
    syscall
    ret

_msgFour:
    mov rax, 1
    mov rdi, 1
    mov rsi, msgFour
    mov rdx, 8
    syscall
    ret
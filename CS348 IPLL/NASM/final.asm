section .data
    init db 0,10
    msgN db "Enter the size of array",10
    msgOne db "smallest="
    msgTwo db "loc_small="
    msgThree db "largest="
    msgFour db "loc_lar="

section .bss
    valNStr resb 8
    rbxVal resb 8
    rVal resb 8
    rEightVal resb 8
    rNineVal resb 8
    rThirVal resb 8
    valN resb 8
    mini resb 8
    maxi resb 8
    currStr resb 8
    curr resb 8
    indMin resb 8
    indMax resb 8
    digitSpace resb 100
    digitSpacePos resb 8

section .text
    global _start

%macro exit 0
    mov rax, 60
    mov rdi, 0
    syscall
%endmacro

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
    mov rbx, [init]

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
    ; call _printRbx
    ; call _printR
    cmp bx, r12w
    jne _branch
    ; call _printREight
    ; call _printRNine
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
    ; call _printRThirteen
    cmp rbx, [init]
    je _initiation
      
    cmp r9w, r13w
    jl _swapMax

_hereOne:
    cmp r8w, r13w
    jg _swapMin

_hereTwo:
    add rbx, 1
    jmp _process
    

_swapMax:
    mov r9w, r13w
    call _printMsgN
    call _printRNine
    mov r14, rbx
    jmp _hereOne

_swapMin:
    mov r8w, r13w
    call _msgFour
    ; call _printREight
    mov r10, rbx
    jmp _hereTwo

_initiation:
    push r8                                 ; Mini
    push r9                                 ; Maxi
    push r10                                ; IndMin
    push r14                                ; IndMax
    push r13                                ; Curr
    
    mov r8w, r13w
    ; call _printREight
    mov r9w, r13w
    ; call _printRNine
    mov r10, [init]
    mov r14, [init]
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
    mov rdx, 8
    syscall
    ret

_printRTwelve:
    add r12, 48
    mov [rVal], r12
    sub r12, 48
    mov rax, 1
    mov rdi, 1
    mov rsi, rVal
    mov rdx, 2
    syscall
    ret

_printRThirteen:
    add r13, 48
    mov [rThirVal], r13
    sub r13, 48
    mov rax, 1
    mov rdi, 1
    mov rsi, rThirVal
    mov rdx, 8
    syscall
    ret

_printREight:
    add r8, 48
    mov [rEightVal], r8
    sub r8, 48
    mov rax, 1
    mov rdi, 1
    mov rsi, rEightVal
    mov rdx, 2
    syscall
    ret

_printRNine:
    add r9, 48
    mov [rNineVal], r9
    sub r9, 48
    mov rax, 1
    mov rdi, 1
    mov rsi, rNineVal
    mov rdx, 2
    syscall
    ret

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
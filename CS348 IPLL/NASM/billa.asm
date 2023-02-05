segment .data
    a: dq 2    ; variable to store input number
    b: dq 0    ; variable for temporary use
    sz: dq 0   ; variable to store size of array
    ind: dq 0  ; variable for temporary use
    cnt: dq 0  ; variable to store current index of array
    cnt2: dq 0 ; variable for temporary use
    mini: dq 0 ; variable to store the minimum number
    maxi: dq 0 ; variable to store the maximum number
    min_pos: dq 0 ; variable to store the position of minimum number
    max_pos: dq 0 ; variable to store the position of maximum number
    fmt: dq "%lld ",10,0   ; format string for output
    fmt_in: dq "%lld", 0  ; format string for input
    fmt_out_max  dq "The largest number at index %lld is: %lld ", 10, 0 ; format string for output of max number
    fmt_out_min  dq "The smallest number at index %lld is: %lld ", 10, 0 ; format string for output of min number
    l_b db "",10,0   ; empty line
    szz db "Give size of array ",0  ; prompt for size of array
    szz1 db "Give the numbers of array : ",0 ; prompt for array numbers

segment .bss
    array resq 400 ; reserve memory for array

segment .text
global main
extern printf
extern scanf

main:
    push RBP  ; setup stack frame
    mov RAX, 0  ; initialize RAX to 0
    mov RCX, 0  ; initialize RCX to 0
    mov RBX, 0  ; initialize RBX to 0

lea rdi,[szz]
    call printf  ; prompt user for size of array
    mov RDI, fmt_in  ; set input format
    mov RSI, sz  ; pass sz as input
    call scanf  ; read input
    lea rdi,[l_b]
    call printf  ; print empty line
    lea rdi,[szz1]
    call printf  ; prompt user for array numbers

INPUT_ARRAY: 
    cmp RCX, [sz]  ; check if current index is equal to size of array
    jz DONE  ; if yes, jump to DONE
    mov [cnt], RCX  ; store current index in cnt
    mov RAX, 0  ; initialize RAX to 0
    mov RDI, fmt_in  ; set input format
    mov RSI, a  ; pass a as input
    call scanf  ; read input
    mov RAX, [a]  ; store input in RAX
    mov [mini],rax  ; initialize mini to input
    mov [maxi],rax  ; initialize maxi to input
    mov RCX, [cnt]  ; load cnt to RCX
    mov [min_pos],rcx  ; initialize min_pos to current index
    mov [max_pos],rcx  ; initialize max_pos to current index
    mov [array+RCX*8], RAX  ; store input in array
    add RBX, [a]   ; add input to RBX
    inc RCX   ; increment index
    jmp INPUT_ARRAY  ; jump back to start of loop

DONE:
    mov RAX, 0  ; initialize RAX to 0
    mov RCX, 0  ; initialize RCX to 0
    mov RBX, 0  ; initialize RBX to 0

mov [cnt],rax  ; initialize cnt to 0

FIND_MAX:
    cmp RCX, [sz]  ; check if current index is equal to size of array
    jge exit1  ; if yes, jump to exit1
    mov [cnt], RCX   ; store current index in cnt
    mov RAX, [maxi]  ; load maxi to RAX
    mov RBX, [array+RCX*8]  ; load current array element to RBX
    mov RCX, [cnt]  ; load cnt to RCX
    cmp RAX, RBX  ; compare maxi and current array element
    jl PRINT_MAX  ; if maxi is less than current array element, jump to PRINT_MAX
    jmp FIND_MAX  ; otherwise, jump back to start of loop

PRINT_MAX:
    mov [maxi],rbx  ; update maxi to current array element
    mov [max_pos],rcx  ; update max_pos to current index
    jmp FIND_MAX  ; jump back to start of loop

exit1:
    mov RAX, 0  ; initialize RAX to 0
    mov RCX, 0  ; initialize RCX to 0
    mov RBX, 0  ; initialize RBX to 0
    mov [cnt],rax  ; initialize cnt to 0

FIND_MIN:
    cmp RCX, [sz]  ; check if current index is equal to size of array
    jge exit2  ; if yes, jump to exit2
    mov [cnt], RCX   ; store current index in cnt
    mov RAX, [mini]  ; load mini to RAX
    mov RBX, [array+RCX*8]  ; load current array element to RBX
    mov RCX, [cnt]  ; load cnt to RCX
    cmp RAX, RBX  ; compare mini and current array element
    jg PRINT_MIN  ; if mini is greater than current array element, jump to PRINT_MIN
    jmp FIND_MIN  ; otherwise, jump back to start of loop

PRINT_MIN:
    mov [mini],rbx  ; update mini to current array element
    mov [min_pos],rcx  ; update min_pos to current index
    jmp FIND_MIN  ; jump back to start of loop

exit2:
    mov rax,0
    lea rdi,[fmt_out_max]
    mov rsi ,[max_pos]
    mov rdx,[maxi]
    call printf  ; print the maximum value and its index
    lea rdi,[l_b]
    call printf  ; print empty line
    mov rax,0
    lea rdi,[fmt_out_min]
    mov rsi ,[min_pos]
    mov rdx,[mini]
    call printf  ; print the minimum value and its index
    lea rdi,[l_b]
    call printf  ; print empty line

END:
    mov RAX, 0  ; return 0
    pop RBP  ; restore the stack frame
    ret   ; return from main function
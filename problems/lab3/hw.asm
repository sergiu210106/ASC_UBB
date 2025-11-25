bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 1234h ; 0001001000110100b
    b db 5Ah ; 01011010b
    c dd 0
; problem 9
; our code starts here
segment code use32 class=code
    start:
        mov ebx, 0
        ; step 1 : bits 0-3 of C to be the same as 6-9 of A 
        movzx eax, word[a] ; mov a to ax
        shr eax, 6 
        and eax, 000Fh
        or ebx, eax 
        
        ; step 2 : bits 4-5 of c have the value 1 
        or ebx, 0030h
        
        ; step 3 : bits 6-7 of c are bits 1-2 of b 
        movzx eax, byte[b] 
        shr eax, 1 
        and eax, 0003h
        shl eax, 6 
        or ebx, eax 
        
        ; step 4 : bits 8-23 of C are bits of A 
        movzx eax, word[a]
        shl eax, 8
        or ebx, eax 
        
        ; step 5 : bits 24-31 of C are bits of B 
        movzx eax, byte[b] 
        shl eax, 24
        or ebx, eax 
        
        ; final 
        mov [c], ebx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

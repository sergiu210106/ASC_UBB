
; A12. A string of bytes A is given. Construct string B containing only values divisible with 5 from string A.

; If A = 16, 20, 5, 18 => B = 20, 5

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 16, 20, 5, 18
    len_A equ $ - a 

    b resb len_A

; our code starts here
segment code use32 class=code
    start:
        mov esi, a 
        mov edi, b 
        mov ecx, len_A 
        cld 
    iter:
        lodsb       ; load byte from [esi] into al, esi ++

        mov bl, al  ; prepare div
        mov ah, 0   
        mov dl, 5
        div dl      ; al = quotient, ah = remainder, b/b

        cmp ah, 0
        jne final
        mov al, bl 
        stosb 
    
    final: 
        loop iter 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

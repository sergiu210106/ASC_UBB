; B4. A string of words S is given. Compute string D containing only high bytes multiple of 7 from string S.
; If S = 1735h, 0778h, 0E20h => D = 07h, 0Eh
bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s dw 1735h, 0778h, 0E20h, 0B15h, 0042h 
    len equ ($ - s) / 2
    d resb len 
    divisor db 7

; our code starts here
segment code use32 class=code
    start:
        mov esi, s
        mov edi, d 
        mov ecx, len 
        cld 

iter:
    lodsw
    mov bl, ah          ; Save high byte in BL

    mov al, ah         ; high byte in AL
    mov ah, 0
    mov dl, [divisor]
    div dl              ; remainder in AH

    cmp ah, 0
    jne final 

    mov al, bl          ; restore original high byte
    stosb

    final:
        loop iter 
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

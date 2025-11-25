bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 20
    b db 5
    c dw 10 
    e dd 10
    x dq 10

; our code starts here
segment code use32 class=code
    start:
        movsx ebx, byte [a]
        movsx ecx, byte [b]
        
        mov edx, ebx 
        add edx, ecx ; a+b in edx 
        
        
        sub ebx, ecx  ; a-b in ebx
        
        movsx ecx, word [c] 
        shl ecx, 7 ; c * 128 in ecx
        
        add ebx, ecx ; a-b+128*c in ebx
        
        mov eax, ebx 
        mov ecx, edx 
        cdq 
        idiv ecx 
        
        ; Expression: (a-b+c*128)/(a+b)+e-x
        
        mov ecx, [e]
        add eax, ecx 
        cdq 
        
        mov ebx, dword[x] 
        mov ecx, dword[x+4]
        sub eax, ebx 
        sbb edx, ecx 
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

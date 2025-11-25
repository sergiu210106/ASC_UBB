bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 1
    b db 2
    c db 3
    d dw 200

; our code starts here
segment code use32 class=code
    start:
        ; Expression: 3 * [20 * (b - a + 2) - 10 * c] + 2 * (d - 3)
        movsx eax, byte[a] 
        movsx ebx, byte[b] 
        sub ebx, eax ; b-a
        add ebx, 2 
        mov eax, ebx 
        mov ebx, 20
        imul ebx ; 20 * (b - a + 2) in eax 
        
        mov ebx, eax ; move to ebx 
        movsx eax, byte[c] 
        mov ecx, 10 
        imul ecx ; 10 * c in eax 
        
        sub ebx, eax ; 20 * (b - a + 2) - 10 * c in ebx
        mov eax, ebx 
        mov ebx, 3
        imul ebx 
        
        mov ecx, eax 
        
        movsx eax, word [d] 
        sub eax, 3
        mov ebx, 2
        imul ebx 
        
        add eax, ecx
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

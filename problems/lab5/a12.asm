bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf
import exit msvcrt.dll  
import scanf msvcrt.dll
import printf msvcrt.dll

; A12. Read two doublewords a and b in base 16 from the keyboard. Display the minim value on the screen in format. a= ... b= .... Min = ... because value a < value b or value a > value b or value a = value b
                          
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 0
    b dd 0
    formatx db "%x", 0
    formatPrint db "a = %x, b = %x, Min = %x because value a %s value b", 0
    
    str_less db "<", 0
    str_greater db ">", 0
    str_equal db "=", 0
    
    min_val dd 0    

; our code starts here
segment code use32 class=code
    start:
        push dword a
        push dword formatx
        call [scanf]
        add esp, 4 * 2
        
        push dword b
        push dword formatx
        call [scanf]
        add esp, 4 * 2 
        
        mov eax, [a] 
        mov ebx, [b]
        cmp eax, ebx 
        
        jl a_min 
        jg b_min
        je ab_eq 
        
    a_min:
        mov ecx, [a] 
        mov [min_val], ecx 
        push dword str_less
        jmp final
    b_min:
        mov ecx, [b]
        mov [min_val], ecx 
        push dword str_greater
        jmp final 
        
    ab_eq:
        mov ecx, [a]
        mov [min_val], ecx 
        push dword str_equal 
        jmp final 
    
    final:
        push dword[min_val]
        push dword[b] 
        push dword[a]
        push formatPrint
        
        call [printf]
        add esp, 4 * 5
       
        
    
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

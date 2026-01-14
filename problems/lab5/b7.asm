bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf, gets
import exit msvcrt.dll  
import scanf msvcrt.dll
import printf msvcrt.dll
import gets msvcrt.dll


; B7.Read a string and read one character S. Replace all occurrences of space from the string with the character S. Print on screen the resulted string.
; Ex: s = ana are 7 mere si 5 pere => d = anaSareS7SmereSsiS5Spere

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    format_char db "%s", 0
    user_string resb 100
    char_s resb 4

; our code starts here
segment code use32 class=code
    start:
        push user_string
        call [gets]
        add esp, 4

        push dword char_s
        push dword format_char
        call [scanf]
        add esp, 4 * 2

        cld
        mov esi, user_string
        mov edi, user_string

        mov bl, [char_s]

        iter:
            lodsb 

            cmp al, 0
            je final

            cmp al, ' '
            jne save_char 

            mov al, bl 
        
        save_char:
            stosb 
            jmp iter 
        
        final:
            push user_string
            push format_char
            call [printf]
            add esp, 4*2

        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

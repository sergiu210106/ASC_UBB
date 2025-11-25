bits 32 

global start        

extern exit              
import exit msvcrt.dll    

segment data use32 class=data
    A db
    B dw 
    C dw 
    D dd 

segment code use32 class=code ; a/b - c*2 + d 
    start:
        mov ax, 0
        mov dx, 0
        mov al, [A]
        
        div word[b] ; a/b in dx:ax 
        
        mov bx, ax 
        mov ax, [c]
        mov cx, 2
        mul cx ; c * 2 in cx 
        
        push dx
        push ax 
        pop eax 
        sub ebx, eax 
        add ebx, [d]
        
    
        ; exit(0)
        push    dword 0     
        call    [exit]    

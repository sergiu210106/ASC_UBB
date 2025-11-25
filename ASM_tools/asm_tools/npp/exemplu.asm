; asamblare 			nasm -fobj exemplu.asm
; linkeditare 			alink -oPE -subsys console -entry start exemplu.obj
; depanare  			ollydbg exemplu.exe
; programe necesare 	http://www.nasm.us + alink: alink.sourceforge.net/download.html + http://www.ollydbg.de

bits 32

global start

segment code use32 class=CODE
    a db 1
    b db 2
    c dw 3
    d dw 4

    ; (b + d) - (a + c)



start:
    mov AL, [b]
    mov AH, 0
    add AX, [d] ; AX = b + d

    mov CL, [a]
    mov CH, 0
    add CX, [c]
    sub AX, CX  

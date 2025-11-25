bits 32
; c - (b-a) + 3 + d 
global start

segment code use32 class=data

    a dw 1
    b db 2
    c dw 3
    d db 4
    
start:
    mov AH, 0
    mov AL, [b] ; b in word in AX
    
    sub AX, [a] ; b - a in AX
    
    mov BX, [c] ; c in BX
    sub BX, AX ; c - (b-a) in BX
    add BX, 3 ; c-(b-a)+3 in BX
    mov DH, 0
    
    mov DL, [d] ; d in word in BX
    
    add BX, DX ; final answer in BX
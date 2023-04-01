PUBLIC to_real_numb
PUBLIC to_ubin
PUBLIC to_shex

EXTRN real_numb: near
EXTRN len: byte
EXTRN num_str: byte
EXTRN bin_len: byte
EXTRN bin_str: byte
EXTRN hex_len: byte
EXTRN hex_str: byte
EXTRN hex_sign: byte

CSEG SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:CSEG

to_real_numb proc near
    xor cx, cx

    mov cl, len
    mov si, cx
    dec si
    mov bx, 1

    to_real:
        xor ax, ax
        mov al, byte ptr[num_str + si]
        sub ax, "0"
        mul bx
        add word ptr [real_numb], ax

        mov ax, bx
        mov bx, 10
        mul bx
        mov bx, ax

        dec si

        loop to_real

    ret
to_real_numb endp
    

to_ubin proc near
    mov ax, word ptr[real_numb]
    mov si, 15
    xor dx, dx
    mov bx, 2

    lbl:
        div bx
        mov bin_str[si], dl
        add bin_str[si], "0"
        xor dx, dx
        inc bin_len

        dec si
        cmp ax, 0
        jne lbl

    ret
to_ubin endp


to_shex proc near
    mov ax, word ptr[real_numb]
    cmp ax, 7FFFh
    ja hex_to_neg
    
    mov hex_sign, '+'
    
continue:
    xor cx, cx

    mov bx, 16
    mov si, 5
    mov ax, word ptr[real_numb]
    xor dx, dx

    loop_shex:
        div bx
        mov hex_str[si], dl
        cmp dl, 9 
        jg hex_char
        add hex_str[si], "0"

        back:
        xor dx, dx
        inc hex_len

        dec si
        cmp ax, 0
        jne loop_shex


    xor bx, bx
    mov bl, 5
    sub bl, hex_len
    mov dh, byte ptr[num_str]
    mov hex_str[bx], dh
    ret

    hex_char:
        add hex_str[si], 55
        jmp back
        
    hex_to_neg:
        mov hex_sign, '-'
        mov bx, 0FFFFh
        sub bx, ax
        mov ax, bx
        jmp continue
to_shex endp

CSEG ENDS
END

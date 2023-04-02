PUBLIC str_to_num
PUBLIC num_to_ubin
PUBLIC num_to_shex

EXTRN number: near
EXTRN len: byte
EXTRN num_str: byte
EXTRN bin_len: byte
EXTRN bin_str: byte
EXTRN hex_len: byte
EXTRN hex_str: byte
EXTRN hex_sign: byte

CSEG SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:CSEG

str_to_num proc near
    xor cx, cx

    mov cl, len
    mov si, cx
    dec si
    mov bx, 1

    to_num:
        xor ax, ax
        mov al, byte ptr [num_str + si]
        sub ax, '0'
        mul bx
        add word ptr [number], ax

        mov ax, bx
        mov bx, 10
        mul bx
        mov bx, ax

        dec si

        loop to_num

    ret
str_to_num endp

num_to_ubin proc near
    mov ax, word ptr [number]
    mov si, 15
    xor dx, dx
    mov bx, 2

    lbl:
        div bx
        mov bin_str[si], dl
        add bin_str[si], '0'
        xor dx, dx
        inc bin_len

        dec si
        cmp ax, 0
        jne lbl

    ret
num_to_ubin endp


num_to_shex proc near
    mov ax, word ptr [number]
    cmp ax, 7FFFh
    ja hex_to_neg
    
    mov hex_sign, '+'
    
    continue:
    xor cx, cx

    mov bx, 16
    mov si, 3
    xor dx, dx

    loop_shex:
        div bx
        mov hex_str[si], dl
        cmp dl, 9 
        jg hex_char
        add hex_str[si], '0'

        back:
        xor dx, dx
        inc hex_len

        dec si
        cmp ax, 0
        jne loop_shex
        
    inc si
    test si, si
    jne set_zeros
    
    end_lbl:
        ret
    
    set_zeros:
        mov hex_str[si - 1], '0'
        dec si
        jnz set_zeros
        
        jmp end_lbl

    hex_char:
        add hex_str[si], 55
        jmp back
        
    hex_to_neg:
        mov hex_sign, '-'
        mov bx, 0FFFFh
        sub bx, ax
        mov ax, bx
        inc ax
        jmp continue
num_to_shex endp

CSEG ENDS
END

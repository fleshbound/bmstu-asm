PUBLIC read_numb
PUBLIC num_str
PUBLIC len
PUBLIC real_numb
PUBLIC bin_len
PUBLIC bin_str
PUBLIC hex_len
PUBLIC hex_str
PUBLIC hex_sign

EXTRN newline: near
EXTRN to_real_numb: near
EXTRN to_ubin: near
EXTRN to_shex: near

DSEG SEGMENT PARA PUBLIC 'DATA'
    max_size   db 6
    len        db 0
    num_str    db 5 DUP ("$"), "$"

    bin_len    db 0
    bin_str    db 16 DUP ("0")
               db "$" 
    
    hex_sign   db 0
    hex_len    db 0
    hex_str    db 4 DUP ("$")
               db "$"

    real_numb  dw 0

    ent_msg  db "Enter unsigned deximal: $"
DSEG ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:CSEG, DS:DSEG
read_numb proc near
    call fill_nulls
    call newline

    mov ah, 9
    mov dx, offset ent_msg
    int 21h

    mov ah, 0AH
    mov dx, offset max_size
    int 21h
    mov dl, "$"
    mov num_str[5], dl

    call to_real_numb
    call to_ubin
    call to_shex
    call newline
    
    ret
read_numb endp

fill_nulls proc near
    mov len, 0
    mov bin_len, 0
    mov hex_len, 0
    mov word ptr[real_numb], 0

    mov ax, seg num_str
    mov es, ax
    mov di, offset num_str
    mov al, "$"
    mov cx, 8
    rep stosb
    
    mov ax, seg hex_str
    mov es, ax
    mov di, offset hex_str
    mov al, "$"
    mov cx, 6
    rep stosb

    ret
fill_nulls endp

CSEG ENDS
END

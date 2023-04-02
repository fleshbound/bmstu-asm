PUBLIC read_numb
PUBLIC num_str
PUBLIC len
PUBLIC number
PUBLIC bin_len
PUBLIC bin_str
PUBLIC hex_len
PUBLIC hex_str
PUBLIC hex_sign

EXTRN print_newline: near
EXTRN str_to_num: near
EXTRN num_to_ubin: near
EXTRN num_to_shex: near

DSEG SEGMENT PARA PUBLIC 'DATA'
    max_size   db 6
    len        db 0
    num_str    db 5 DUP ('$'), '$'

    bin_len    db 0
    bin_str    db 16 DUP ('0')
               db '$' 
    
    hex_len    db 0
    hex_sign   db 0
    hex_str    db 4 DUP ('$')
               db '$'

    number  dw 0

    ent_msg  db "Enter unsigned deximal: $"
DSEG ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:CSEG, DS:DSEG
read_numb proc near
    call null_data
    call print_newline

    mov ah, 9
    mov dx, offset ent_msg
    int 21h

    mov ah, 0Ah
    mov dx, offset max_size
    int 21h
    mov dl, '$'
    mov num_str[5], dl

    call str_to_num
    call num_to_ubin
    call num_to_shex
    call print_newline
    
    ret
read_numb endp

null_data proc near
    mov len, 0
    mov bin_len, 0
    mov hex_len, 0
    mov number, 0
    mov hex_sign, 0

    mov ax, seg num_str
    mov es, ax
    mov di, offset num_str
    mov al, '$'
    mov cx, 8
    rep stosb
    
    mov ax, seg bin_str
    mov es, ax
    mov di, offset bin_str
    mov al, '0'
    mov cx, 16
    rep stosb
    
    mov ax, seg hex_str
    mov es, ax
    mov di, offset hex_str
    mov al, '$'
    mov cx, 5
    rep stosb

    ret
null_data endp

CSEG ENDS
END

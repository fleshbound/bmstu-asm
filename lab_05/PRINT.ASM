PUBLIC print_bin
PUBLIC newline

EXTRN real_numb: near
EXTRN num_str: near
EXTRN bin_len: byte
EXTRN bin_str: byte
EXTRN hex_str: byte
EXTRN hex_len: byte

DSEG SEGMENT PARA PUBLIC 'DATA'
    bin_msg    db "Unsigned binary:"
               db 10
               db 13
               db "$"

    hex_msg    db "Signed hexadecimal:"
               db 10
               db 13
               db "$"
DSEG ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:CSEG, DS:DSEG

print_bin proc near
    call newline

    mov ah, 9
    mov dx, offset bin_msg
    int 21h

    mov dx, offset bin_str
    int 21h

    call newline
    ret

print_bin endp


print_hex proc near
    call newline
    
    mov ah, 9
    mov dx, offset hex_msg
    int 21h

    mov ah, 9
    mov dx, offset hex_str
    int 21h

    call newline
    ret

print_hex endp


newline proc near
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h

    ret
newline endp

CSEG ENDS
END

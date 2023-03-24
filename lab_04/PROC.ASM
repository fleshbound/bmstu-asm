PUBLIC switch_to_symbols

EXTRN rows: byte
EXTRN cols: byte
EXTRN matrix: byte
EXTRN move_to_next_row: near

CSEG SEGMENT PARA PUBLIC 'CODE'
    assume cs:CSEG
switch_to_symbols proc near
    mov bl, byte ptr [rows]
    mov si, 0
    mov cx, 0
    
    p_col:
        mov cl, byte ptr [cols]
        
        p_row:
            add [matrix + si], 'A' - '0'
            inc si
            loop p_row

        call move_to_next_row
        loop p_col
        
    ret
switch_to_symbols endp
CSEG ENDS
END
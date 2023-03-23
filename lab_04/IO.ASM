PUBLIC new_line
PUBLIC print_matrix

EXTRN rows: byte
EXTRN cols: byte
EXTRN matrix: byte

CSEG SEGMENT PARA PUBLIC 'CODE'
    assume cs:CSEG
print_msg proc near
    mov ah, 9
    int 21h
    ret 
print_msg endp

input_n proc near
    mov ah, 1
    int 21h
    
    mov [bx], al
    
    ret
input_n endp    

space proc near
    mov ah, 2
    mov dl, ' '
    int 21h
    ret
space endp

new_line proc near
    mov ah, 2
    mov dl, 10
	int 21h
    mov dl, 13
	int 21h
    ret
new_line endp

print_matrix proc near
    mov ah, 2
    mov bl, byte ptr [rows]
    mov si, 0
    
    p_col:
        mov cl, byte ptr [cols]
        
        p_row:
            mov dl, byte ptr [matrix + si]
            inc si
            int 21h
            call space
            loop p_row
        
        call new_line
        mov cl, bl
        dec bl
        loop p_col
        
    ret
print_matrix endp

input_matrix proc near
    mov bx, offset rows
    call input_n
    sub rows, '0'
    call space
    
    mov bx, offset cols
    call input_n
    sub cols, '0'
    call new_line

    mov bl, byte ptr [rows]
    mov si, 0
    
    i_col:
        mov cl, byte ptr [cols]
        
        i_row:
            mov ah, 1
            int 21h
            mov [matrix + si], al
            inc si
            call space
            loop i_row
        
        call new_line
        mov cl, bl
        dec bl
        loop i_col
        
    ret
input_matrix endp
CSEG ENDS
END
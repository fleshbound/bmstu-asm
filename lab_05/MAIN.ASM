EXTRN print_bin: near
EXTRN print_hex: near
EXTRN read_numb: near
EXTRN print_newline: near

SSEG SEGMENT PARA STACK 'STACK'
    db 200 dup (?)
SSEG ENDS

DSEG SEGMENT PARA PUBLIC 'DATA'
    menu_text db "1. Enter deximal"
              db 10
              db 13
              db "2. Convert to unsigned binary"
              db 10
              db 13
              db "3. Convert to signed hexadecimal"
              db 10
              db 13
              db "0. Exit" 
              db 10
              db 13
              db "Enter command: $"
    f_table     dw 4 DUP (0)
DSEG ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:CSEG, DS:DSEG, SS:SSEG
main:
    mov ax, DSEG
    mov ds, ax
    
    mov f_table[0], exit
    mov f_table[2], read_numb
    mov f_table[4], print_bin
    mov f_table[6], print_hex

    print_menu:
        mov ah, 9
        mov dx, offset menu_text
        int 21h
        mov ah, 1
        int 21h

        xor ah,ah
        sub al, '0'
        mov dl, 2
        mul dl
        mov bx, ax

        call print_newline
        call f_table[bx]
        call print_newline
        
        jmp print_menu

exit proc near
    mov ax, 4c00h
    int 21h
exit endp

CSEG ENDS
END main

; Квадратная символьная матрица
; Перевести все цифры в заглавные буквы

EXTRN print_matrix: near
EXTRN switch_to_symbols: near
EXTRN input_matrix: near
EXTRN new_line: near

PUBLIC rows
PUBLIC cols
PUBLIC matrix

SSEG SEGMENT PARA STACK 'STACK'
    db 200 dup(0)
SSEG ENDS

DSEG SEGMENT PARA PUBLIC 'DATA'
    rows db 0
    org 2h
    cols db 0
    org 4h
    matrix db 9 * 9 dup('0')
DSEG ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
    assume cs:CSEG, ds:DSEG, ss:SSEG
main:
    mov ax, DSEG
    mov ds, ax
    
    call input_matrix
    call switch_to_symbols
    call new_line
    call print_matrix
    
    mov ah, 4ch
    int 21h
CSEG ENDS
END main
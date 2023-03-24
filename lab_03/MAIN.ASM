; с двумя сегментами данных. Ввести строку цифр до 0 до 5 
; в первый сегмент, далее во 2-й байт второго сегмента 
; записать сумму 2-й и 5-й цифр и вывести её на экран

; stack
SSEG SEGMENT PARA stack 'STACK'
    db 100 dup(0)
SSEG ENDS

; buffer data
DSEG1 SEGMENT PARA public 'DATA'
    N db 50
    LEN db ?
    BUF db 50 dup(0)
DSEG1 ENDS

; result data
DSEG2 SEGMENT PARA public 'DATA'
    RES db 2 dup(0)
DSEG2 ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
    assume CS:CSEG, DS:DSEG1, ES:DSEG2, SS:SSEG
output:
    mov ah, 2

    mov dl, 10
	int 21h
    
    mov dl, 13
	int 21h
    
    mov dl, [RES + 1]
    int 21h
    
	ret
    
sum:
    mov dh, [BUF + 1]
    sub dh, '0'
    add dh, [BUF + 4]
    mov [RES + 1], dh
    ret
    
main:
    mov ax, DSEG1
    mov ds, ax
    
    mov ax, DSEG2
    mov es, ax
    
    mov ah, 0Ah
    mov dx, 0
    int 21h
    
    call sum
    call output
    
    mov ax, 4c00h
    int 21h
CSEG ENDS
END main
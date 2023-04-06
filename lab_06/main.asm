; var 1: Командой дальнего вызова подпрограммы CALL в начале обработчика
; прерывания с предварительным сохранением регистра флагов в стеке.
.model tiny

.186    ; popa, pusha

CODE SEGMENT
    assume cs:CODE, ds:CODE
    org 100h

main:
    jmp initialize
    old_int9h   dd ?
    flag_inst   dw INSTALLED
    
int9h_handler proc far
    pusha
    push es
    push ds
    
    pushf
    call cs:old_int9h
    
    ; get rtc
    mov ah, 02h         
    int 1ah
    cmp dh, curr_sec
    mov curr_sec, dh
    je quit
    
    mov al, 0f3h
    out 60h, al
    mov al, speed
    out 60h, al
    
    dec speed
    cmp speed, MAX_SPEED
    je reset
    jmp quit
    
reset:
    mov speed, MAX_SPEED

quit:
    pop ds
    pop es
    popa
    
    iret
int9h_handler endp

initialize proc near
    ; get old handler
    mov ax, 3509h
    int 21h
    
    cmp es:flag_inst, INSTALLED
    je uninstall
    
    mov word ptr old_int9h, bx      ; offset
    mov word ptr old_int9h+2, es    ; segment
    
    ; set new handler
    mov ax, 2509h
    mov dx, offset int9h_handler
    int 21h
    
    mov dx, offset init_msg
    mov ah, 9
    int 21h
    
    mov dx, offset initialize
    int 27h

uninstall:
    push es
    push ds

init_msg    db '+installed+$'
uninst_msg  db '-uninstalled-$' 
curr_sec    db 0
speed       db 01fh
INSTALLED   equ 0DEADh
MAX_SPEED   equ 01fh
 
initialize endp

CODE ends
    end main
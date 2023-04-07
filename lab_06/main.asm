; var 1: Командой дальнего вызова подпрограммы CALL в начале обработчика
; прерывания с предварительным сохранением регистра флагов в стеке.
.model tiny

.186    ; popa, pusha

CODE SEGMENT
    assume cs:CODE, ds:CODE
    org 100h

main:
    jmp initialize
    old_int8h   dd ?
    flag_inst   dw INSTALLED
    
int8h_handler proc far
    pusha
    push es
    push ds
    pushf
    call cs:old_int8h
    
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
    cmp speed, MIN_SPEED
    je reset
    jmp quit
    
reset:
    mov speed, MIN_SPEED

quit:
    popf
    pop ds
    pop es
    popa
    
    iret
int8h_handler endp

initialize proc near
    ; get old handler
    mov ax, 3508h
    int 21h
    
    cmp es:flag_inst, INSTALLED
    je uninstall
    
    mov word ptr old_int8h, bx      ; offset
    mov word ptr old_int8h+2, es    ; segment
    
    ; set new handler
    mov ax, 2508h
    mov dx, offset int8h_handler
    int 21h
    
    mov dx, offset init_msg
    mov ah, 9
    int 21h
    
    mov dx, offset initialize
    int 27h

uninstall:
    pusha
    push es
    push ds
    pushf
    
    mov dx, word ptr es:old_int8h
    mov ds, word ptr es:old_int8h+2
    mov ax, 2508h
    int 21h
    
    popf
    pop ds
    pop es
    popa
    
    mov al, 0f3h
    out 60, al
    mov al, 0
    out 60h, al
    
    mov ah, 49h
    int 21h
    
    mov dx, offset uninst_msg
    mov ah, 9h
    int 21h
    
    mov ax, 4c00h
    int 21h

init_msg    db  -'int9 installed$'
uninst_msg  db  'int9 uninstalled$' 
curr_sec    db  0
speed       db  01fh
INSTALLED   equ 0DEADh
MIN_SPEED   equ 01fh
 
initialize endp

CODE ends
    end main
; var 1: Командой дальнего вызова подпрограммы CALL в начале обработчика
; прерывания с предварительным сохранением регистра флагов в стеке.
.model tiny

.186    ; popa, pusha

CODE SEGMENT
    assume cs:CODE, ds:CODE
    org 100h

main:
    jmp initialize
    old_int8h   dd  ?
    flag_inst   dw  INSTALLED
    curr_sec    db  0
    speed       db  01fh
    
int8h_handler proc far
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
    test speed, MIN_SPEED
    jz reset
    jmp quit

reset:
    mov speed, MIN_SPEED

quit:
    iret
int8h_handler endp

initialize proc near
    ; get old handler
    mov ax, 351Ch
    int 21h

    cmp es:flag_inst, INSTALLED
    je uninstall
    
    mov word ptr old_int8h, bx      ; offset
    mov word ptr old_int8h+2, es    ; segment
    
    ; set new handler
    mov ax, 251Ch
    mov dx, offset int8h_handler
    int 21h
    
    mov dx, offset init_msg
    mov ah, 9
    int 21h
    
    mov dx, offset initialize
    int 27h

uninstall:
    mov dx, word ptr es:old_int8h
    mov ds, word ptr es:old_int8h+2
    
    mov ax, 251Ch
    int 21h
    
    mov al, 0f3h
    out 60h, al
    mov al, 0
    out 60h, al
    
    ; fix: mov dx, offset uninst_msg

    mov ah, 49h
    int 21h
    
    mov ax, 4c00h
    int 21h 
initialize endp

MIN_SPEED   equ 01fh
INSTALLED   equ 0DEADh
init_msg    db  'int9 installed$'
uninst_msg  db  'int9 uninstalled$'

CODE ends
    end main
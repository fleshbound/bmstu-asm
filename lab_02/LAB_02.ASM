StkSeg  SEGMENT PARA STACK 'STACK'
        DB      200h DUP(?)
StkSeg  ENDS
;
DataS   SEGMENT WORD 'DATA'
HelloMessage    DB   13
                DB   10
                DB   'Hello, World!'
                DB   '$'
DispCount       DB   03h
DataS   ENDS
;
Code    SEGMENT PARA 'CODE'
        ASSUME  CS:Code, DS:DataS
DispMsg:
        mov     AX,DataS
        mov     DS,AX
        mov     DX,OFFSET HelloMessage
        mov     AH,09h
        mov     CX,3
disp_loop:
        int     21h
        loop    disp_loop;
        mov     AH,07h
        int     21h
        mov     DX,OFFSET DispCount
        mov     AH,4Ch
        int     21h
Code    ENDS
        END     DispMsg

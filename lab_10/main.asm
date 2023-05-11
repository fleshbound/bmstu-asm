.686
.model flat, stdcall
option casemap: none

include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib

wMain       PROTO   :DWORD, :DWORD, :DWORD, :DWORD
wProc       PROTO   :DWORD, :DWORD, :DWORD, :DWORD

    .data
wTitle      db          " Digit Sum App      ", 0
wClassName  db          "window", 0
eClassName  db          "edit", 0
bClassName  db          "button", 0
bText       db          "Get Digit Sum", 0
resFmt      db          "Digit sum: %d", 0
resText     db          " Result                   ", 0
exitText    db          "Exit the app?", 0
exitTitle   db          " Exit Program   ", 0

    .data?
cmdLine     LPSTR       ?
hinstance   HINSTANCE   ?
hButton     HWND        ?
hEntry1     HWND        ?
hEntry2     HWND        ?
buffer      db          2 DUP(?)

    .const
idButton    EQU         1
idEntry     EQU         2
eWidth      EQU         80
eHeight     EQU         25
offX        EQU         10
offY        EQU         20
eY          EQU         offY
eX          EQU         offX * 5
wX          EQU         800
wY          EQU         500

    .code
main:
        invoke  GetModuleHandle, NULL
        mov     hinstance, eax
        
        invoke  GetCommandLine
        mov     cmdLine, eax
        
        invoke  wMain, hinstance, NULL, cmdLine, SW_SHOWDEFAULT
        invoke  ExitProcess, eax
    
wMain       proc    hinst: HINSTANCE, hPrevInst: HWND, CmdLine: DWORD, CmdShow: DWORD
        LOCAL   wClass:     WNDCLASSEX
        LOCAL   msg:        MSG
        LOCAL   wHandle:    HWND
       
        mov     wClass.cbSize, SIZEOF WNDCLASSEX
        mov     wClass.style, CS_HREDRAW or CS_VREDRAW
        mov     wClass.lpfnWndProc, offset wProc
        mov     wClass.cbClsExtra, NULL
        mov     wClass.cbWndExtra, NULL
        push    hinst
        pop     wClass.hInstance
        mov     wClass.hbrBackground, COLOR_WINDOW
        mov     wClass.lpszMenuName, NULL
        mov     wClass.lpszClassName, offset wClassName
        invoke  LoadIcon, NULL, IDI_APPLICATION
        mov     wClass.hIcon, eax
        mov     wClass.hIconSm, eax
        invoke  LoadCursor, NULL, IDC_ARROW
        mov     wClass.hCursor, eax
        
        invoke  RegisterClassEx, addr wClass
        
        invoke  CreateWindowEx, WS_EX_CLIENTEDGE, addr wClassName, \
                addr wTitle, WS_OVERLAPPEDWINDOW, wX, wY, \
                eWidth * 2 +  13 * offX, eHeight * 6, NULL, NULL, hinst, NULL
        mov     wHandle, eax

        invoke  ShowWindow, wHandle, SW_SHOWNORMAL
        invoke  UpdateWindow, wHandle
        
        .WHILE TRUE
                invoke  GetMessage, addr msg, NULL, 0, 0
                .BREAK .IF(!eax)
                invoke  TranslateMessage, addr msg
                invoke  DispatchMessage, addr msg
        .ENDW
        
        mov     eax, msg.wParam
        ret
wMain   endp

wProc       proc    hWnd: HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM
        LOCAL   exitHandle: HWND
        LOCAL   tmpHandle:  HWND

        .IF uMsg == WM_CLOSE
                invoke  MessageBox, hWnd, addr exitText, addr exitTitle, \
                        MB_OKCANCEL or MB_ICONQUESTION
                mov exitHandle, eax
                
                .IF exitHandle == IDOK
                        invoke  DestroyWindow, hWnd
                .ENDIF
                
        .ELSEIF uMsg == WM_DESTROY
                invoke  PostQuitMessage, NULL
                
        .ELSEIF uMsg == WM_CREATE
                invoke  CreateWindowEx, WS_EX_CLIENTEDGE, addr eClassName, NULL,\
                        WS_CHILD or WS_VISIBLE or WS_BORDER or ES_LEFT \
                        or ES_AUTOHSCROLL or WS_TABSTOP, \
                        eX, eY, eWidth, eHeight, hWnd, 1, hinstance, NULL
                mov     hEntry1, eax
                
                invoke  CreateWindowEx, WS_EX_CLIENTEDGE, addr eClassName, NULL,\
                        WS_CHILD or WS_VISIBLE or WS_BORDER or ES_LEFT \
                        or ES_AUTOHSCROLL or WS_TABSTOP, \
                        eX + eWidth + offX, eY, eWidth, eHeight, hWnd, 2, hinstance, NULL
                mov     hEntry2, eax
                
                invoke  CreateWindowEx, NULL, addr bClassName, addr bText, \
                        WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON or WS_TABSTOP, \
                        eX, eY + eHeight + offY, eWidth * 2 + offX, eHeight, hWnd, 3, hinstance, NULL
                mov     hButton, eax 
                
                invoke  SendMessage, hEntry1, EM_SETLIMITTEXT, 1, NULL
                invoke  SendMessage, hEntry2, EM_SETLIMITTEXT, 1, NULL
                invoke  SetFocus, hEntry1
            
        .ELSEIF uMsg == WM_COMMAND
                mov     eax, wParam
                shr     eax, 16
                    
                .IF ax == BN_CLICKED
                    push    edi
                    push    ebx
                    
                    invoke  GetWindowText, hEntry1, addr buffer, 2
                    xor     edi, edi
                    xor     eax, eax
                    xor     ebx, ebx
                    mov     cx, 10
                    mov     bl, byte ptr buffer[edi]
                    sub     bl, '0'
                    mul     cx
                    add     eax, ebx
                    push    eax
                    
                    invoke  GetWindowText, hEntry2, addr buffer, 2
                    xor     edi, edi
                    xor     eax, eax
                    xor     ebx, ebx
                    mov     cx, 10
                    mov     bl, byte ptr buffer[edi]
                    sub     bl, '0'
                    mul     cx
                    add     eax, ebx
                    pop     ebx
                    add     eax, ebx
                    
                    invoke  wsprintf, addr buffer, addr resFmt, eax
                    invoke  MessageBox, hWnd, addr buffer, addr resText, MB_OK

                    pop     ebx
                    pop     edi
                .ENDIF
            
        .ELSE
                invoke  DefWindowProc, hWnd, uMsg, wParam, lParam
                ret
        .ENDIF
        
        xor     eax, eax
        ret
wProc   endp

        end main
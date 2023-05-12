.686
.model flat, stdcall
option casemap: none

include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
include \masm32\macros\macros.asm

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
hInstance   HINSTANCE   ?
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
        mov     hInstance, rv(GetModuleHandle, NULL)
        mov     cmdLine, rv(GetCommandLine)
        invoke  wMain, hInstance, NULL, cmdLine, SW_SHOWDEFAULT
        invoke  ExitProcess, eax
    
wMain       proc    hInst: HINSTANCE, hPrevInst: HWND, CmdLine: DWORD, CmdShow: DWORD
        LOCAL   wClass:     WNDCLASSEX
        LOCAL   msg:        MSG
        LOCAL   wHandle:    HWND
        LOCAL   wHandle1:   HWND
       
        mov     wClass.cbSize, SIZEOF WNDCLASSEX
        mov     wClass.style, CS_HREDRAW or CS_VREDRAW
        mov     wClass.lpfnWndProc, offset wProc
        mov     wClass.cbClsExtra, NULL
        mov     wClass.cbWndExtra, NULL
        m2m     hInst, wClass.hInstance
        mov     wClass.hbrBackground, 1 + 1
        mov     wClass.lpszMenuName, NULL
        mov     wClass.lpszClassName, offset wClassName
        mov     wClass.hIcon, rv(LoadIcon, NULL, IDI_APPLICATION)
        mov     wClass.hIconSm, rv(LoadIcon, NULL, IDI_APPLICATION)
        mov     wClass.hCursor, rv(LoadCursor, NULL, IDC_ARROW)
        
        invoke  RegisterClassEx, addr wClass
        
        invoke  CreateWindowEx, WS_EX_CLIENTEDGE, addr wClassName, \
                addr wTitle, WS_OVERLAPPED or WS_CAPTION or WS_SYSMENU or WS_MINIMIZEBOX or WS_MAXIMIZEBOX, \
                wX, wY, eWidth * 2 +  13 * offX, eHeight * 6, NULL, NULL, hInst, NULL
        mov     wHandle, eax
        
        ;invoke  CreateWindowEx, WS_EX_CLIENTEDGE, addr wClassName, \
        ;        addr wTitle, WS_OVERLAPPED or WS_CAPTION or WS_SYSMENU or WS_MINIMIZEBOX or WS_MAXIMIZEBOX, \
        ;        wX, wY, eWidth * 2 +  13 * offX, eHeight * 6, NULL, NULL, hInst, NULL
        ;mov     wHandle1, eax

        invoke  ShowWindow, wHandle, SW_SHOWNORMAL
        invoke  UpdateWindow, wHandle
        
        ;invoke  ShowWindow, wHandle1, SW_SHOWNORMAL
        ;invoke  UpdateWindow, wHandle1
        
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

        Switch uMsg
            case WM_CLOSE
                invoke  MessageBox, hWnd, addr exitText, addr exitTitle, \
                        MB_OKCANCEL or MB_ICONQUESTION
                mov exitHandle, eax
                
                .IF exitHandle == IDOK
                        invoke  DestroyWindow, hWnd
                .ENDIF
                    
            case WM_DESTROY
                invoke  PostQuitMessage, NULL
                    
            case WM_CREATE
                invoke  CreateWindowEx, WS_EX_CLIENTEDGE, addr eClassName, NULL,\
                        WS_CHILD or WS_VISIBLE or WS_BORDER or ES_LEFT \
                        or ES_AUTOHSCROLL or WS_TABSTOP, \
                        eX, eY, eWidth, eHeight, hWnd, idEntry, hInstance, NULL
                mov     hEntry1, eax
                
                invoke  CreateWindowEx, WS_EX_CLIENTEDGE, addr eClassName, NULL,\
                        WS_CHILD or WS_VISIBLE or WS_BORDER or ES_LEFT \
                        or ES_AUTOHSCROLL or WS_TABSTOP, \
                        eX + eWidth + offX, eY, eWidth, eHeight, hWnd, idEntry, hInstance, NULL
                mov     hEntry2, eax
                
                invoke  CreateWindowEx, NULL, addr bClassName, addr bText, \
                        WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON or WS_TABSTOP, \
                        eX, eY + eHeight + offY, eWidth * 2 + offX, eHeight, hWnd, idButton, hInstance, NULL
                mov     hButton, eax 
                
                invoke  SendMessage, hEntry1, EM_SETLIMITTEXT, 1, NULL
                invoke  SendMessage, hEntry2, EM_SETLIMITTEXT, 1, NULL
                invoke  SetFocus, hEntry1
            
            case WM_COMMAND
                mov     eax, wParam
                shr     eax, 16
                    
                .IF ax == BN_CLICKED
                    push    edi
                    push    ebx
                    push    eax
                    
                    invoke  GetWindowText, hEntry1, addr buffer, 2
                    xor     edi, edi
                    xor     eax, eax
                    xor     ebx, ebx
                    mov     al, byte ptr buffer[edi]
                    sub     al, '0'
                    push    eax
                    
                    invoke  GetWindowText, hEntry2, addr buffer, 2
                    xor     edi, edi
                    xor     eax, eax
                    xor     ebx, ebx
                    mov     al, byte ptr buffer[edi]
                    sub     al, '0'
                    pop     ebx
                    add     eax, ebx
                    
                    invoke  wsprintf, addr buffer, addr resFmt, eax
                    invoke  MessageBox, hWnd, addr buffer, addr resText, MB_OK

                    pop     eax
                    pop     ebx
                    pop     edi
                .ENDIF
        Endsw
        
        invoke  DefWindowProc, hWnd, uMsg, wParam, lParam
        ret
wProc   endp

        end main
section .data
section .text
global _my_strcpy

_my_strcpy:
        push    ebp
        mov     ebp, esp
        mov     ecx, [ebp + 8]
        mov     edi, [ebp + 16]
        mov     esi, [ebp + 12]

        ; inc     ecx
        cmp     edi, esi
        je      quit
not_equal:      
        cmp     edi, esi
        jl      copy
        
        mov     eax, edi
        sub     eax, esi
        cmp     eax, ecx
        jge     copy
overlapping:
        add     edi, ecx
        add     esi, ecx
        sub     edi, 1
        sub     esi, 1                
        std
copy:
        rep     movsb
        cld
quit:
        pop ebp
        ret

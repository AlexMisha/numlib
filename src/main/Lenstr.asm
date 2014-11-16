.686P
; плоская модель
.MODEL FLAT, stdcall

PUBLIC Lenstr

   includelib c:\masm32\lib\user32.lib
   includelib c:\masm32\lib\kernel32.lib
.data

.code
; строка - [EBP+08H]
; длина в EBX
Lenstr proc pStr:dword   
	local dwOldEax:dword
	mov dwOldEax, eax
;------------------------------
    cld 
    mov edi, pStr
    mov ebx,edi 
    mov ecx,100 ; ограничить длину строки
    xor al,al 
    repne scasb ; найти символ 0
    sub edi,ebx ; длина строки, включая 0
    mov ebx,edi
    dec ebx
;------------------------------
    mov eax, dwOldEax
    ret 
Lenstr endp
end
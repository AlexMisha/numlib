.686P
; ������� ������
.MODEL FLAT, stdcall

PUBLIC Lenstr

   includelib c:\masm32\lib\user32.lib
   includelib c:\masm32\lib\kernel32.lib
.data

.code
; ������ - [EBP+08H]
; ����� � EBX
Lenstr proc pStr:dword   
	local dwOldEax:dword
	mov dwOldEax, eax
;------------------------------
    cld 
    mov edi, pStr
    mov ebx,edi 
    mov ecx,100 ; ���������� ����� ������
    xor al,al 
    repne scasb ; ����� ������ 0
    sub edi,ebx ; ����� ������, ������� 0
    mov ebx,edi
    dec ebx
;------------------------------
    mov eax, dwOldEax
    ret 
Lenstr endp
end
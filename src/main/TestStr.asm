.686P
; плоская модель
.MODEL FLAT, stdcall

PUBLIC TestStr

   includelib c:\masm32\lib\user32.lib
   includelib c:\masm32\lib\kernel32.lib
   includelib Lenstr.lib
   
extern Lenstr@4:near

.data

.code

; ebp+8 - строка для теста
; eax = 1 - ошибки нет
; eax = 2 - ошибка
TestStr proc pStr:dword

mov esi, pStr
push esi
call Lenstr@4

cmp ebx,0
je Error

mov esi, pStr
sub ebx,2h
StartTestCicle:
cmp byte ptr [esi], 29h
jle Error
cmp byte ptr [esi], 40h
jge Error
inc esi
dec ebx
cmp ebx,0
je EndTestCicle
jmp StartTestCicle
EndTestCicle:

mov eax,1h
jmp NotError
Error:
mov eax,2h
NotError:

ret 
TestStr endp

end
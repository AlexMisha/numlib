.686P
; плоская модель
.MODEL FLAT, stdcall

PUBLIC SizeOfNum

   includelib c:\masm32\lib\user32.lib
   includelib c:\masm32\lib\kernel32.lib
   includelib Lenstr.lib
   
extern Lenstr@4:near

.data

.code

;eax = 1 - ошибка
;eax = 2 - ошибки нет
;ebp+8 - переменная для сравнивания
;ebp+12 - параметр сравнивания
SizeOfNum proc pStr:dword, pCond:dword

mov esi, pStr

push esi
call Lenstr@4

sub ebx,2h
mov edi, pCond
cmp ebx,edi
jle NotError
mov eax,1h
jmp NotErrorEnd
NotError:
mov eax,2h
NotErrorEnd:

ret
SizeOfNum endp

end
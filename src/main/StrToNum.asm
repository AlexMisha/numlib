.686p
.model flat, stdcall

PUBLIC StrToNum

   includelib c:\masm32\lib\user32.lib
   includelib c:\masm32\lib\kernel32.lib
   includelib c:\masm32\projects\calculator\Lenstr.lib
   includelib c:\masm32\projects\numlib\atodw.lib
   
   extern atodw@4:near
   extern Lenstr@4:near

.data

.code
; ebp+8 - строка
StrToNum proc pStr:dword
mov esi, pStr									; указатель на буффер со строкой
; размер строки
push pStr
call Lenstr@4
sub ebx, 2h

Masm32Code:
mov esi,pStr
add esi,ebx
mov byte ptr [esi], 0
inc esi
mov byte ptr [esi], 0
push pStr
call atodw@4
jmp Return

Return:
										; сбалансировать стэк
ret													; вытащить из стэка 1 аргумент
StrToNum endp
end 
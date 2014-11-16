.686p
.model flat, stdcall

PUBLIC StrToNum

   includelib c:\masm32\lib\user32.lib
   includelib c:\masm32\lib\kernel32.lib
   includelib c:\masm32\projects\calculator\Lenstr.lib

   extern Lenstr@4:near

.data

.code
; ebp+8 - строка
; результат помещён в буффер со строкой в инвертированном виде
StrToNum proc pStr:dword
mov esi, pStr									; указатель на буффер со строкой
; размер строки
push pStr
call Lenstr@4
; входные данные для цикла
add esi, ebx										; указатель на последний символ буффера						
sub esi,3h											; указатель на последнюю цифру буффера
mov ecx, 1h
sub ebx, 2h
mov edi, 0
; цикл преобразования
StartConvertionCicle:
mov eax, 0
mov al, byte ptr [esi]							
sub eax, 30h
mul ecx
add edi, eax
mov eax, 10
mul ecx
mov ecx, eax
dec ebx
sub esi, 1h
cmp ebx, 0
je EndConvertionCicle
jmp StartConvertionCicle
EndConvertionCicle:

Return:
mov [esi], edi
mov edi, 0											; сбалансировать стэк
ret													; вытащить из стэка 1 аргумент
StrToNum endp
end
.686P
; плоская модель
.MODEL FLAT, stdcall

PUBLIC Reconversion

	includelib c:\masm32\lib\user32.lib
	includelib c:\masm32\lib\kernel32.lib
	includelib Lenstr.lib
	
extern Lenstr@4:near

.data

.code

; результирующий буффер - ebp+12
; число - ebp+8
Reconversion proc pNum:dword,pAdress:dword,pReserv1:dword	
;размер строки
push pNum
call Lenstr@4
;входные данные для цикла
mov ecx, 10
mov eax, dword ptr [esi]
mov esi, 0
StartNumToStringCicle:
xor edx,edx
div ecx
add edx, 30h
mov byte ptr [esi+ebp+16], dl
add esi, 1h
cmp eax, 0
je EndNumToStringCicle
jmp StartNumToStringCicle
EndNumToStringCicle:

mov esi, pAdress
mov ecx,0
mov ebx,12h
StartMovCicle:
cmp byte ptr [ecx+ebp+16], 0
je EndMovCicle
cmp ebx,0
je EndMovCicle
mov al, byte ptr [ecx+ebp+16]
mov byte ptr [esi], al
inc ecx
inc esi
dec ebx
jmp StartMovCicle
EndMovCicle:

return2:

ret 
Reconversion endp

end
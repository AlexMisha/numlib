.686P
; плоская модель
.MODEL FLAT, stdcall

PUBLIC ReverStr

   includelib c:\masm32\lib\user32.lib
   includelib c:\masm32\lib\kernel32.lib
.data

.code
; функция для инвертирования содержимого буфера
;1 - указатель на буфер с исходником  [EBP+8]
;2 - указатель на буфер под результат  [EBP+12]
;3 - размер исходного буфера	[EBP+16]
; В EAX возвращаем значение (0 - ошибка) (1 - содержимое буфера инвертировалось)
ReverStr proc pStartBuf:dword, pEndBuf:dword, pSizeStartBuf:dword

	
	cmp pStartBuf, 0	; сравнение первого аргумента с 0
	je falled		; прыжок на метку falled, если 1 аргумент = 0
	cmp pEndBuf, 0	; сравнение второго аргумента с 0
	je falled		; прыжок на метку falled, если 2 аргумент = 0
	cmp dword ptr [pSizeStartBuf], 0
	jle falled
	cmp dword ptr [pSizeStartBuf], 0ffffh
	ja falled
	
;регистр ESI - указатель на исходный буфер
;регистр EDI - указатель на результирующий буфер
	mov esi, pStartBuf
	mov edi, pEndBuf
	
; EDX - индекс исходного буфера
; EBX - индекс результирующего буфера
	; прямой счётчик						; 2.3.3.1.3
	mov edx, 0	
	; обратный счётчик						; 2.3.3.1.4
	mov ebx, pSizeStartBuf				
	sub ebx, 1
	
	
StartReverCicle:
	
	mov cl, byte ptr [esi+ebx]				; взять символ из конца первого буфера по обратному индексу
	mov byte ptr [edi+edx], cl				; положить символ из п.2.3.3.2.1 в начало второго буфера по прямому индексу
	
	
	add edx,1								; инкремент прямого счётчика			; п. 2.3.3.2.1		п. 2.3.3.2.3
	sub ebx,1								; декремент братного счётчика			; п. 2.3.3.2.2		п. 2.3.3.2.3
	cmp edx, [pSizeStartBuf]								; п. 2.3.3.2.4
	je EndReverCicle
	jmp StartReverCicle

EndReverCicle:

Success:									;В EAX возвращаем значение 1 - содержимое буфера инвертировалось
	mov eax, 1 
Falled:										;В EAX возвращаем значение 0 - ошибка
	mov eax, 0 
Return:
	ret
ReverStr endp

end

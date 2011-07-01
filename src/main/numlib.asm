.686P
.model flat, stdcall

STD_INPUT_HANDLE  equ -10
STD_OUTPUT_HANDLE	equ -11
;---------------------------------------

includelib c:\masm32\lib\user32.lib 
includelib c:\masm32\lib\kernel32.lib
includelib Lenstr.lib
includelib ReverStr.lib
includelib StrToNum.lib
includelib Reconversion.lib
includelib TestStr.lib
includelib SizeOfNum.lib

EXTERN  ExitProcess@4:NEAR
EXTERN  GetStdHandle@4:NEAR		
EXTERN  WriteConsoleA@20:NEAR		
EXTERN  ReadConsoleA@20:NEAR
extern  ReverStr@12:near
extern  StrToNum@4:near
extern  Lenstr@4:near
extern  Reconversion@12:near
extern  TestStr@4:near
extern  SizeOfNum@8:near


;---------------------------------------
.data

	dwStdInputHandle   dword ?
	dwStdOutputHandle  dword ?
	sWrongValueString db "Like value is not possible",13,10,0
	sInputString1 DB "The first multipleer :",13,10,0
	sCrashString db "Result is too large",13,10,0
	lpBufferSpeed db 20 dup(0)
	lpBufferTime db 20 dup(0)
	lpBufferResult db 30 dup(0)
	sInputString2 db "The second multipleer :",13,10,0
	pSize db 10 dup(0)
	pSize1 db 10 dup(0)
	pSize2 db 10 dup(0)
	sInputString3 db "Set up the move */+/- or / :",13,10,0
	lpMov db 10 dup(0)
	pForSubOrDiv db 10 dup(0)
	OstOfDiv db 20 dup(0)
	dwTemp dword ?
	sTitleResultString db "Result:",13,10,0
	lpBufferStringResult db 50 dup(0)
	
.code
start:

push STD_INPUT_HANDLE
call GetStdHandle@4
mov dwStdInputHandle, eax

push STD_OUTPUT_HANDLE
call GetStdHandle@4
mov dwStdOutputHandle, eax
; принятие ввода пользователя и выводы приглашения на ввод

;принятие первого числа
push 0
push offset dwTemp
push lengthof sInputString1
push offset sInputString1
push dwStdOutputHandle
call WriteConsoleA@20

push 0
push offset pSize
push 20
push offset lpBufferSpeed
push dwStdInputHandle
call ReadConsoleA@20

;проверка на правильность первого числа
push offset lpBufferSpeed
call TestStr@4
cmp eax,2
je FalseValue

push 8
push offset lpBufferSpeed
call SizeOfNum@8
cmp eax, 1
je FalseValue

;принятие второго числа
push 0
push offset dwTemp
push lengthof sInputString2
push offset sInputString2
push dwStdOutputHandle
call WriteConsoleA@20

push 0
push offset pSize1
push 200
push offset lpBufferTime
push dwStdInputHandle
call ReadConsoleA@20

;проверка на правильность второго числа
push offset lpBufferTime
call TestStr@4
cmp eax,2
je FalseValue

push 8
push offset lpBufferSpeed
call SizeOfNum@8
cmp eax,1h
je FalseValue

;принятие действия
push 0
push offset dwTemp
push lengthof sInputString3
push offset sInputString3
push dwStdOutputHandle
call WriteConsoleA@20

push 0
push offset pSize2
push 20
push offset lpMov
push dwStdInputHandle
call ReadConsoleA@20

;проверка на наличие действия
mov esi, offset lpMov
push esi
call Lenstr@4
mov esi, offset lpMov
add esi, ebx
sub esi,2h
cmp byte ptr [esi], 0h
je FalseValue

jmp Continue3

FalseValue:
push 0
push offset dwTemp
push lengthof sWrongValueString
push offset sWrongValueString
push dwStdOutputHandle
call WriteConsoleA@20
jmp finish
Continue3:

;преобразование первого множителя
push offset lpBufferSpeed
call StrToNum@4
;преобразование второго множителя
push offset lpBUfferTime
call StrToNum@4

;определение действия
mov esi, offset lpMov
cmp byte ptr [esi], 02bh				; +
je SumMov
cmp byte ptr [esi], 02dh				; -
je SubMov
cmp byte ptr [esi], 02ah				; *
je MulMov
cmp byte ptr [esi], 02fh				; /
je DivMov
jmp FalseValue
ContinueProg:
;сохранение результата
mov esi, offset lpBufferResult
mov [esi], eax
test edx,edx
je Continue
mov ebx, 0

push 0
push offset dwTemp
push lengthof sCrashString
push offset sCrashString
push dwStdOutputHandle
call WriteConsoleA@20
jmp finish

Continue:

;преобразование результата
push 0
push 0
push 0
push offset lpBufferStringResult
push offset lpBufferResult
call Reconversion@12

;вывод результата
push 0
push offset dwTemp
push lengthof sTitleResultString
push offset sTitleResultString
push dwStdOutputHandle
call WriteConsoleA@20

push offset lpBufferStringResult
call Lenstr@4

push ebx
push offset lpBufferResult
push offset lpBufferStringResult
call ReverStr@12

push offset lpBufferResult
call Lenstr@4

mov esi, offset pForSubOrDiv
cmp byte ptr [esi], 02dh
je WriteWithOtr


ContinueWrite:

mov esi, offset lpBufferResult
push esi
call Lenstr@4

push 0
push offset dwTemp
push ebx
push offset lpBufferResult
push dwStdOutputHandle
call WriteConsoleA@20

finish:

push 0
call ExitProcess@4

WriteWithOtr:
mov esi, offset lpBufferResult
mov edi, offset lpBufferResult
inc edi
mov al, byte ptr [esi]
mov cl, byte ptr [edi]
mov byte ptr [esi], 02dh
StartWriteWithOtrCicle:
mov byte ptr [edi], al
add esi,2h
mov byte ptr [esi], cl
inc esi
cmp byte ptr [esi], 0
je EndWriteWithOtrCicle
add edi,2h
mov al, byte ptr [esi]
mov cl, byte ptr [edi]
jmp StartWriteWithOtrCicle
EndWriteWithOtrCicle:
jmp ContinueWrite

SumMov:
mov esi, offset lpBufferSpeed
sub esi,1h
mov edi, offset lpBufferTime
sub edi,1h
mov eax, [esi]
mov ebx, [edi]
add eax,ebx
jmp ContinueProg

SubMov:
mov esi, offset lpBufferSpeed
sub esi,1h
mov edi, offset lpBufferTime
sub edi,1h
mov eax,[esi]
mov ebx,[edi]
cmp eax, ebx
jnl PolSub
mov esi, offset pForSubOrDiv
mov byte ptr [esi], 02dh
mov esi, offset lpBufferSpeed
dec esi
mov edi, offset lpBufferTime
dec edi
mov eax, [esi]
mov ebx, [edi]
sub ebx,eax
mov eax, ebx
jmp EndOfSub
PolSub:
mov esi, offset lpBufferSpeed
dec esi
mov edi, offset lpBufferTime
dec edi
mov eax, [esi]
mov ebx, [edi]
sub eax,ebx
EndOfSub:
jmp ContinueProg

MulMov:
;умножение
mov esi, offset lpBufferSpeed
sub esi, 1h
mov edi, offset lpBufferTime
sub edi, 1h
mov eax, [esi]
mov ebx, [edi]
xor edx,edx
mul ebx
jmp ContinueProg

DivMov:
mov esi, offset lpBufferSpeed
sub esi,1h
mov edi, offset lpBufferTime
sub edi,1h
mov eax,[esi]
mov ebx,[edi]
cmp ebx,0
je FalseValue
xor edx,edx
div ebx
xor edx,edx
jmp ContinueProg

end start
.686p
.model flat, stdcall

PUBLIC StrToNum

   includelib c:\masm32\lib\user32.lib
   includelib c:\masm32\lib\kernel32.lib
   includelib c:\masm32\projects\calculator\Lenstr.lib

   extern Lenstr@4:near

.data

.code
; ebp+8 - ������
; ��������� ������� � ������ �� ������� � ��������������� ����
StrToNum proc pStr:dword
mov esi, pStr									; ��������� �� ������ �� �������
; ������ ������
push pStr
call Lenstr@4
; ������� ������ ��� �����
add esi, ebx										; ��������� �� ��������� ������ �������						
sub esi,3h											; ��������� �� ��������� ����� �������
mov ecx, 1h
sub ebx, 2h
mov edi, 0
; ���� ��������������
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
mov edi, 0											; �������������� ����
ret													; �������� �� ����� 1 ��������
StrToNum endp
end
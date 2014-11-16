.686P
; ������� ������
.MODEL FLAT, stdcall

PUBLIC ReverStr

   includelib c:\masm32\lib\user32.lib
   includelib c:\masm32\lib\kernel32.lib
.data

.code
; ������� ��� �������������� ����������� ������
;1 - ��������� �� ����� � ����������  [EBP+8]
;2 - ��������� �� ����� ��� ���������  [EBP+12]
;3 - ������ ��������� ������	[EBP+16]
; � EAX ���������� �������� (0 - ������) (1 - ���������� ������ ���������������)
ReverStr proc pStartBuf:dword, pEndBuf:dword, pSizeStartBuf:dword

	
	cmp pStartBuf, 0	; ��������� ������� ��������� � 0
	je falled		; ������ �� ����� falled, ���� 1 �������� = 0
	cmp pEndBuf, 0	; ��������� ������� ��������� � 0
	je falled		; ������ �� ����� falled, ���� 2 �������� = 0
	cmp dword ptr [pSizeStartBuf], 0
	jle falled
	cmp dword ptr [pSizeStartBuf], 0ffffh
	ja falled
	
;������� ESI - ��������� �� �������� �����
;������� EDI - ��������� �� �������������� �����
	mov esi, pStartBuf
	mov edi, pEndBuf
	
; EDX - ������ ��������� ������
; EBX - ������ ��������������� ������
	; ������ �������						; 2.3.3.1.3
	mov edx, 0	
	; �������� �������						; 2.3.3.1.4
	mov ebx, pSizeStartBuf				
	sub ebx, 1
	
	
StartReverCicle:
	
	mov cl, byte ptr [esi+ebx]				; ����� ������ �� ����� ������� ������ �� ��������� �������
	mov byte ptr [edi+edx], cl				; �������� ������ �� �.2.3.3.2.1 � ������ ������� ������ �� ������� �������
	
	
	add edx,1								; ��������� ������� ��������			; �. 2.3.3.2.1		�. 2.3.3.2.3
	sub ebx,1								; ��������� �������� ��������			; �. 2.3.3.2.2		�. 2.3.3.2.3
	cmp edx, [pSizeStartBuf]								; �. 2.3.3.2.4
	je EndReverCicle
	jmp StartReverCicle

EndReverCicle:

Success:									;� EAX ���������� �������� 1 - ���������� ������ ���������������
	mov eax, 1 
Falled:										;� EAX ���������� �������� 0 - ������
	mov eax, 0 
Return:
	ret
ReverStr endp

end

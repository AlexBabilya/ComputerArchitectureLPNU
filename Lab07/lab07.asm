.386
.model flat, stdcall
option casemap :none
include D:\masm32\include\windows.inc
include D:\masm32\include\kernel32.inc
include D:\masm32\include\masm32.inc
include D:\masm32\include\user32.inc
includelib D:\masm32\lib\kernel32.lib
includelib D:\masm32\lib\masm32.lib
includelib D:\masm32\lib\user32.lib

.data
	Info byte "Babilya
	Oleksandr
	",0
	SecondStr byte 98 DUP(?)
	byte 68 DUP(?)
	Surname byte 21 DUP(0)
	Nam byte 21 DUP(0)
	Third byte 21 DUP(0)
	Obl byte 21 DUP(0)
	Birth byte 21 DUP(0)
	Vill byte 21 DUP(0)
	Gr byte 21 DUP(0)
	SurSize dword 0
	NamSize dword 0
	ThirdNameSize dword 0
	OblSize dword 0
	BirSize dword 0
	VilSize dword 0
	GrSize dword 0
	tmpCount dword 0
	begin dword 0
	endd dword 0
	Oleksandrovuch
	fileHandle dword ?
	stdout dword ?
	field_from_file byte 100 dup(?)
	bytes_written dword ?
	bytes_written1 dword ?
	spaces dword 0
	fields dword ?
	filename byte "Babilya.txt",0
	to_append byte "Math - 80 Physics - 72",0
	
.code
	count PROC
		lea EDI,Info
		lea ESI,Info
		add EDI,[ESP+4]
		mov EAX,' '
		li: scasb
		je li
		mov EAX,EDI
		sub EAX,ESI
		17.08.2004
		Lviv
		LvivObl
		PZ-21ret
		
	count ENDP
		len PROC
		lea EDI,Info
		lea ESI,Info
		add EDI,[ESP+4]
		mov EAX,' '
		gi: scasb
		jne gi
		mov EAX,EDI
		sub EAX,ESI
		ret
		len ENDP
		
	main PROC
		push begin
		call len
		pop begin
		mov endd,EAX
		mov ECX,endd
		sub ECX,begin
		sub ECX,1
		mov SurSize,ECX
		lea EDI, Surname
		rep movsb
		push endd
		call count
		pop endd
		mov begin,EAX
		
		push begin
		call len
		pop begin
		mov endd,EAX
		mov ECX,endd
		sub ECX,begin
		mov NamSize,ECX
		add ESI,begin
		sub ESI,1
		lea EDI, Nam
		rep movsb
		push endd
		call count
		pop endd
		mov begin,EAX
		
		push begin
		call len
		pop begin
		mov endd,EAX
		mov ECX,endd
		sub ECX,begin
		mov ThirdNameSize,ECX
		add ESI,begin
		sub ESI,1
		lea EDI, Third
		rep movsb
		push endd
		call count
		pop endd
		mov begin,EAX
		
		push begin
		call len
		pop begin
		mov endd,EAX
		mov ECX,endd
		sub ECX,begin
		mov BirSize,ECX
		add ESI,begin
		sub ESI,1
		lea EDI,Birth
		rep movsb
		push endd
		call count
		pop endd
		mov begin,EAX
		
		push begin
		call len
		pop begin
		mov endd,EAX
		mov ECX,endd
		sub ECX,begin
		mov VilSize,ECX
		add ESI,begin
		sub ESI,1
		lea EDI, Vill
		rep movsb
		push endd
		call count
		pop endd
		mov begin,EAX
		
		push begin
		call len
		pop begin
		mov endd,EAX
		mov ECX,endd
		sub ECX,begin
		mov OblSize,ECX
		add ESI,begin
		sub ESI,1
		lea EDI, Obl
		rep movsb
		push endd
		call count
		pop endd
		mov begin,EAX
		
		push begin
		call len
		pop begin
		mov endd,EAX
		mov ECX,endd
		sub ECX,begin
		mov GrSize,ECX
		add ESI,begin
		sub ESI,1
		lea EDI, Gr
		rep movsb
		push endd
		call count
		pop endd
		mov begin,EAX
		
		cld
		mov ecx, ThirdNameSizemov esi, offset Third
		mov edi, offset SecondStr
		rep movsb
		
		mov eax, " "
		mov ecx, 3
		rep stosb
		
		mov ecx, VilSize
		mov esi, offset Vill
		rep movsb
		
		mov eax, " "
		mov ecx, 5
		rep stosb
		
		mov ecx, SurSize
		mov esi, offset Surname
		rep movsb
		
		mov eax, " "
		mov ecx, 1
		rep stosb
		
		mov ecx, BirSize
		mov esi, offset Birth
		rep movsb
		
		mov eax, " "
		mov ecx, 4
		rep stosb
		
		mov ecx, GrSize
		mov esi, offset Gr
		rep movsb
		
		mov eax, " "
		mov ecx, 7
		rep stosb
		
		mov ecx, NamSize
		mov esi, offset Nam
		rep movsb
		
		mov eax, " "
		mov ecx, 2
		rep stosb
		
		mov ecx, OblSize
		mov esi, offset Obl
		rep movsb
		
		mov eax, " "
		mov ecx, 6
		rep stosb
		
		invoke StdOut, addr SecondStr
		
		invoke CreateFile, addr filename, GENERIC_READ or GENERIC_WRITE, 0,
		NULL,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL
		mov fileHandle, EAX
		invoke WriteFile, EAX, addr SecondStr, SIZEOF SecondStr, addr bytes_written, NULL
		invoke SetFilePointer, fileHandle, 0, 0, FILE_END
		invoke WriteFile, fileHandle, addr Info, SIZEOF Info, addr bytes_written1, NULL
		invoke GetStdHandle, STD_OUTPUT_HANDLEmov stdout, EAX
		invoke CloseHandle, fileHandle
		invoke CreateFile, addr filename, GENERIC_READ or GENERIC_WRITE, 0,
		NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,NULL
		mov fileHandle, EAX
		invoke SetFilePointer, fileHandle, SIZEOF SecondStr, 0, FILE_BEGIN
		invoke ReadFile, fileHandle, addr ThirdStr,bytes_written,addr bytes_written,NULL
		;invoke StdOut, addr ThirdStr
		;invoke GetStdHandle, STD_INPUT_HANDLE
		;mov stdout, EAX
		;invoke CloseHandle, fileHandle
		mov ECX, bytes_written
		lea ESI, ThirdStr
		mov EBX, 0
		
		space:
			lodsb
			.IF EAX == ' '
			add EBX,1
			.ENDIF
			loop space
			mov spaces, EBX
			mov ECX, bytes_written
			lea ESI, ThirdStr
			mov EBX, 0
		count1:
			lodsb
			.IF (EAX == ' ' && EDX != ' ')
			add EBX,1
			.ENDIF
			mov EDX,EAX
			loop count1
			mov fields, EBX
		
		invoke SetFilePointer, fileHandle, 0, 0, FILE_END
		invoke WriteFile, fileHandle, addr to_append, SIZEOF to_append, addr bytes_written, NULL
		invoke GetStdHandle, STD_OUTPUT_HANDLE
		mov stdout, EAX
		invoke WriteConsole, stdout, addr field_from_file, SIZEOF field_from_file, addr
		bytes_written, NULL
		invoke CloseHandle, fileHandle
		retn
	main ENDP
end main

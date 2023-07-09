.386
.model flat,stdcall
.stack
.data

ARR DWORD 46, 19, 99, 5, -16, -37, 48
    DWORD -1, 4, 98, 48, -32, -26, 44
    DWORD 2, 3, -38, 99, 4, 5, 6
    DWORD -10, 69, 22, 7, 10, 80, -47
    DWORD -12, 16, 52, 11, 96, 2, -38
    DWORD -50, 19, -37, 72, -38, 69, 95

ARR2 DWORD 0, 0, 0, 0, 0, 0
    DWORD 0, 0, 0, 0, 0, 0
    DWORD 0, 0, 0, 0, 0, 0
    DWORD 0, 0, 0, 0, 0, 0
    DWORD 0, 0, 0, 0, 0, 0
    DWORD 0, 0, 0, 0, 0, 0
    DWORD 0, 0, 0, 0, 0, 0

ROW DWORD 6
COL DWORD 7
Bi DWORD -37
Ci DWORD 69
M DWORD 7
Sum DWORD 0
Scalar DWORD 0
N DWORD 42
Count DWORD 0
COUNT1 DWORD 0
COUNT2 DWORD 0

.code
    main PROC
    mov EAX,0
    mov EBX,ARR
    mov ECX,M
    mov EDX,0
    lea ESI,ARR
    add ESI, 56
    mov EBX,[ESI]

prepare_to_transpose:
    lea ESI,ARR
    lea EBX,ARR2
    mov ECX, ROW

transpose:
    mov EAX,[ESI]
    mov [EBX],EAX
    add EBX, 4
    add ESI, 28
    loop transpose

new_col:
    add COUNT1,4
    lea ESI,ARR
    add ESI,COUNT1
    mov ECX, ROW
    add COUNT2,1
    mov EDX, COUNT2
    cmp EDX,COL
    jne transpose
    mov EAX,0
    mov EBX,ARR
    mov ECX,6
    mov EDX,0
    lea ESI,ARR
    add ESI, 4
    
newArr:
    mov EAX, [ESI]
    add ESI, 8
    mov EDX, [ESI]
    mul EDX
    add ESI, 20
    add Scalar, EAX
    loop newArr
    mov EAX,0
    mov EBX,ARR
    mov ECX,M
    mov EDX,0
    lea ESI,ARR
    add ESI, 56
    mov EBX,[ESI]

start:
    cmp Bi,EBX
    jle sumup1
    add ESI, 4
    mov EBX,[ESI]
    loop start
    jmp finish

sumup1:
    cmp Ci,EBX
    jg sumup2
    add ESI, 4
    mov EBX,[ESI]
    loop start
    jmp finish

sumup2:
    add EAX,EBX
    add EDX,1
    add ESI, 4
    mov EBX,[ESI]
    loop start
    jmp finish

finish:
    mov Sum,EAX
    mov Count,EDX
    retn

main ENDP
END main
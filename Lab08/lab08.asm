.model small
.stack

.data
    row equ 1
    column equ 22
    lastName db "Babilya"
    lastNameLen equ $ - lastName
    lastNameAttrib equ 021h
    firstName db "Oleksandr"
    firstNameLen equ $ - firstName
    firstNameAttrib equ 04Fh
    fathersName db "Oleksndrovuch"
    fathersNameLen equ $ - fathersName
    fathersNameAttrib equ 061h
    saveMode db ?
    startX equ fathersNameLen
    startY equ lastNameLen
    horizontalSize equ 3 * 21 + 1
    verticalSize equ 2 * 21 + 1
    currentX dw ?
    color equ 1

.code

    initDS proc
        mov ax, @data
        mov ds, ax
        ret
    initDS endp
        
    initES proc
        mov ax,0B800h
        mov es,ax
        ret
    initES endp

    waitForInput proc
        mov ah, 01h
        int 21h
        ret
    waitForInput endp

    exitProcess proc
        mov ax,4C00h
        int 21h
        ret
    exitProcess endp

    clearScreen proc
        xor di, di
        mov al, ' '
        mov ah, 0
        mov cx, 2000
        cld
        rep stosw
        ret
    clearScreen endp

    disableBlinking proc
        mov ax, 1003h
        mov bl, 0
        int 10h
        ret
    disableBlinking endp

    enableBlinking procmov ax, 1003h
        mov bl, 1
        int 10h
        ret
    enableBlinking endp

    main proc
        call initDS
        call initES
        call clearScreen
        call disableBlinking

        mov ah, lastNameAttrib
        mov cx, lastNameLen
        mov si, OFFSET lastName
        mov di, (row * 80 * 2) + (column * 2)

        lastNameLoop:
            lodsb
            mov es:[di],al
            inc di
            mov es:[di],ah
            inc di
            loop lastNameLoop

        mov ah, firstNameAttrib
        mov cx, firstNameLen
        mov si, OFFSET firstName
        mov di, ((row + 2) * 80 * 2) + ((column + 3) * 2)

        firstNameLoop:
            lodsb
            mov es:[di],al
            inc di
            mov es:[di],ah
            inc di
            loop firstNameLoop

        mov ah, fathersNameAttrib
        mov cx, fathersNameLen
        mov si, OFFSET fathersName
        mov di, ((row + 6) * 80 * 2) + ((column + 8) * 2)

        fathersNameLoop:
            lodsb
            mov es:[di],al
            inc di
            mov es:[di],ah
            inc di
            loop 
            
        call waitForInput
        mov ah, 0Fh
        int 10h
        mov saveMode, al
        mov ah, 0
        mov al, 13h
        int 10h
        mov ah, 0Ch
        mov al, 1
        mov bh, 2
        mov currentX, startX
        mov cx, horizontalSize
        mov dx, startY

        draw_horizontal_first:
            push cx
            mov cx, currentX
            int 10hinc currentX
            pop cx
            loop draw_horizontal_first

        mov currentX, startX
        mov cx, horizontalSize
        mov dx, startY + verticalSize

        draw_horizontal_second:
            push cx
            mov cx, currentX
            int 10h
            inc currentX
            pop cx
            loop draw_horizontal_second

        mov cx, verticalSize
        mov dx, startY

        draw_vertical_first:
            push cx
            mov cx, startX
            int 10h
            inc dx
            pop cx
            loop draw_vertical_first

        mov cx, verticalSize
        mov dx, startY

        draw_vertical_second:
            push cx
            mov cx, startX + horizontalSize
            int 10h
            inc dx
            pop cx
            loop draw_vertical_second
            
        call waitForInput
        mov ah, 0
        mov al, saveMode
        int 10
        call exitProcess
    main endp
end main
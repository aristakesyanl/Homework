disk_load:
    pusha
    push dx

    mov ah, 0x02 ; BIOS read sector function
    mov al, dh ; al<-the number of sectors to be read
    mov cl, 0x02 ; cl <- sector (0x01 .. 0x11)
                 ; 0x01 is our boot sector, 0x02 is the first 'available' sector

    mov ch, 0x00 ; ch <- cylinder 
    ; dl <- drive number. Our caller sets it as a parameter and gets it from BIOS
    ; (0 = floppy, 1 = floppy2, 0x80 = hdd, 0x81 = hdd2)
    mov dh, 0x00 ; dh <- head number (0x0 .. 0xF)

    int 0x13 ; BIOS interrupt
    jc disk_error ; BIOS sets carry flag if error occurs

    pop dx

    cmp al, dh ;BIOS sets the number of registers read in al registers
    jne sector_error
    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print
    call nl
    jmp disk_loop

sector_error:
    mov bx, SECTOR_ERROR
    call print
    call nl

disk_loop:
    jmp $
    
DISK_ERROR: db 'Disk read error', 0
SECTOR_ERROR: db 'Incorrect number of sectors read', 0

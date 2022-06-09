[bits 16]
[org 0x7C00]
address equ 0x9000

mov bx, message
call print
call print_nl

mov bx, address ; program is going to be loaded at the address 0x9000
mov dh, 1 ; read 1 sector
call disk_load

jmp address

jmp $

%include "print.asm"
%include "diskload.asm"


message: db 'MBR Loaded!!!', 0

;padding and magic number
times 510-($-$$) db 0
dw 0xaa55

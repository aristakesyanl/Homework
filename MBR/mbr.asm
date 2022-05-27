[bits 16]
[org 0x7C00]

mov bx, message
call print
call print_nl

mov bx, 0x9000 ; program is going to be loaded at the address 0x9000
mov dh, 2 ; read 2 sectors
call disk_load

jmp $

%include "print.asm"
%include "diskload.asm"

message: db 'MBR Loaded!!!', 0

;padding and magic number
times 510-($-$$) db 0
dw 0xaa55

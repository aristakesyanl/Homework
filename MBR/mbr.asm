[bits 16]
[org 0x7C00]

mov bx, message
call print
call print_nl

jmp $

%include "print.asm"

message: db 'MBR Loaded!!!', 0

;padding and magic number
times 510-($-$$) db 0
dw 0xaa55

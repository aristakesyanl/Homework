[bits 16]
[org 0x9000]

mov bx, message
call print
call print_nl

jmp $

%include "print.asm"

message: db 'Program Loaded!!!',0

times 512 - ($-$$) db 0

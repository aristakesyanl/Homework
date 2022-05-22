print:
    pusha
start:
    ;bx contains the base address of the string
    mov al, [bx]
    ;string is terminated with null character
    cmp al, 0
    je done
    mov ah, 0x0e ;tty mode
    int 0x10
    inc bx
    jmp start
done:
    popa
    ret
    
print_nl:
    pusha

    mov ah, 0x0e
    mov al, 0x0a; newline character
    int 0x10
    mov al, 0x0d; carriage return
    int 0x10

    popa
    ret

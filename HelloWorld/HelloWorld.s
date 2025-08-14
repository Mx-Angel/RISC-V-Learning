.globl _start

.section .rodata
msg:
    .ascii "Hello, World\n"

.section .text
_start:
    li a0, 1 # 1 = stdout
    la a1, msg
    li a2, 13 # Length of string
    li a7, 64 # write command syscall number
    ecall

    li a0, 0
    li a7, 93
    ecall



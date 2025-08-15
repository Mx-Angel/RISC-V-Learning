.globl _start

.section .rodata
msg: .asciz "Hello, please type a single digit number:\n> "

.section .bss
buffer: .skip 100        # increase buffer to match read length

.section .text
_start:
    # write prompt
    li a0, 1              # stdout
    la a1, msg
    li a2, 44             # length of prompt
    li a7, 64             # write syscall
    ecall

    # read input
    li a0, 0              # stdin
    la a1, buffer
    li a2, 100            # kept failing as leftover from print statement, switched .data to .rodata section and it worked?
    li a7, 63             # read syscall
    ecall

    mv t0, a0             # save number of bytes read

    # write input back
    li a0, 1              # stdout
    la a1, buffer
    mv a2, t0             # number of bytes read
    li a7, 64             # write syscall
    ecall

    # exit
    li a0, 0
    li a7, 93             # exit syscall
    ecall

    .section .bss
buffer:
    .skip 100             # space for input

    .section .text
    .globl _start
_start:
    # read from stdin
    li a0, 0              # fd = stdin
    la a1, buffer         # buffer pointer
    li a2, 100            # max bytes to read
    li a7, 63             # syscall: read
    ecall

    mv t0, a0             # save number of bytes read in t0

    # write to stdout
    li a0, 1              # fd = stdout
    la a1, buffer         # buffer pointer
    mv a2, t0             # number of bytes to write
    li a7, 64             # syscall: write
    ecall

    # exit
    li a0, 0
    li a7, 93             # syscall: exit
    ecall

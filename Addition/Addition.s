.section .rodata
msg1: .asciz "Hello, please type the first number you want to add:\n> "
msg2: .asciz "Hello, please type the second number you want to add:\n> "

.section .data
buffer1: .space 10        # increase buffer to match read length
buffer2: .space 10
result: .space 10

.section .text
    .globl _start
_start:
    # write prompt
    li a0, 1              # stdout
    la a1, msg1
    li a2, 55             # length of prompt
    li a7, 64             # write syscall
    ecall

    # read input
    li a0, 0              # stdin
    la a1, buffer1
    li a2, 2              # kept failing as leftover from print statement, switched .data to .rodata section and it worked?
    li a7, 63             # read syscall
    ecall

    mv t0, a0             # save number of bytes read of first number

    li a0, 1
    la a1, msg2
    li a2, 56
    li a7, 64
    ecall

    li a0, 0
    la a1, buffer2        # Something is over-writting this address and I dont know what but I will figure it out
    li a2, 2              # Make sure this is the same size as the buffer you are saving into
    li a7, 63
    ecall

    mv t1, a0             # save number of bytes read of second number

    # Convert from ASCII
    # la t2, buffer1
    # lb t4, 0(t2)          # Use t4 instead of t0
    # addi t4, t4, -48

    # la t3, buffer2  
    # lb t5, 0(t3)          # Use t5 instead of t1
    # addi t5, t5, -48

    # add t6, t4, t5        # Add the converted values
    # addi t6, t6, 48       # Convert back to ASCII

    # la t5, result
    # sb t4, 0(t5)         # Store the result
    # li t6, 10            # ASCII 10 = newline  
    # sb t6, 1(t5)         # Store newline

    # write input back
    li a0, 1              # stdout
    la a1, buffer2
    mv a2, t1             # number of bytes read
    li a7, 64             # write syscall
    ecall

    # exit
    li a0, 0
    li a7, 93             # exit syscall
    ecall

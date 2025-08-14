.globl _start

.section .data
number: .byte 7         # The number to convert and print
buffer: .byte 0, 10     # Buffer: placeholder + newline

.section .text
_start:
    # Load the number
    la t0, number
    lb t1, 0(t0)         # Load byte value (7)
    
    # Convert to ASCII
    addi t1, t1, 48      # Add 48 to get ASCII '7'
    
    # Store in buffer
    la t0, buffer
    sb t1, 0(t0)         # Store ASCII character at first position
    
    # Print it
    li a0, 1             # stdout
    la a1, buffer        # address of buffer
    li a2, 2             # length (digit + newline)
    li a7, 64            # write syscall
    ecall

    # Exit cleanly
    li a0, 0             # exit status
    li a7, 93            # exit syscall
    ecall
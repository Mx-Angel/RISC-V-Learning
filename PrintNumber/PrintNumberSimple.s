.globl _start

.section .data
digits: .ascii "0123456789\n"  # All digits + newline

.section .text
_start:
    # Choose which digit to print (0-9)
    li t0, 7              # The number we want to print
    
    # Calculate address of that digit
    la t1, digits         # Load base address
    add t1, t1, t0        # Add offset to get digit '7'
    
    # Print the digit
    li a0, 1              # stdout
    mv a1, t1             # address of the digit
    li a2, 1              # print just 1 character
    li a7, 64             # write syscall
    ecall
    
    # Print newline (digit 10 in our array)
    la a1, digits
    addi a1, a1, 10       # Point to newline
    li a2, 1              # length
    li a7, 64             # write syscall
    ecall

    # Exit
    li a0, 0
    li a7, 93
    ecall

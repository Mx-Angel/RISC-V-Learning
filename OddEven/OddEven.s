.section .rodata
msg1: .asciz "Hello, please enter a number\n> "
even: .asciz "Even\n"
odd: .asciz "Odd\n"

.section .data
buffer1: .space 10        # writeable buffers in .data for Linux user-mode
result: .space 10         # buffer to store the result string

.section .text
    .globl _start

exit: 
    # exit
    li a0, 0
    li a7, 93             # exit syscall
    ecall

print_res:
    # write input back
    li a0, 1              # stdout
    la a1, result
    li a2, 5             # number of bytes read
    li a7, 64             # write syscall
    ecall

    j  exit

update_even:
    la t5, result
    la t3, even
    lw t4, 0(t3)          # Load the "Even\n" string data
    sw t4, 0(t5)          # Store it in result buffer
    lw t4, 4(t3)          # Load remaining bytes if needed (note a word is 32 bits)
    sw t4, 4(t5)
    j  print_res

update_odd:
    la t5, result
    la t3, odd
    lw t4, 0(t3)          # Load the "Odd\n" string data  
    sw t4, 0(t5)          # Store it in result buffer
    j  print_res


_start: # Only works for small numbers havent added support for large numbers
    # Initialize global pointer and turn of relaxation as no .sdata exists as we don't have a linker script/runtime that will initialise it properly
    .option push          # Save current options (relaxation probably ON)
    .option norelax       # Turn relaxation OFF for specifically the global pointer loading as it will still use relaxation regardless
    la gp, __global_pointer$  # This la won't be relaxed/optimized
    .option pop           # Restore previous options (relaxation back ON)

    # write prompt
    li a0, 1              # stdout
    la a1, msg1
    li a2, 31             # length of prompt
    li a7, 64             # write syscall
    ecall

    # read input
    li a0, 0              # stdin
    la a1, buffer1
    li a2, 5              # kept failing as leftover from print statement, switched .data to .rodata section and it worked? Need to initialise gp
    li a7, 63             # read syscall
    ecall

    mv t0, a0             # save number of bytes read of first number

    # Convert from ASCII
    la t2, buffer1
    lb t4, 0(t2)          # Use t4 instead of t0
    addi t4, t4, -48

    andi t6, t4, 1        # Check if number is odd (bit 0 set) or even (bit 0 clear)
    beqz t6, update_even  # If bit 0 is 0, number is even
    bnez t6, update_odd   # If bit 0 is 1, number is odd

# addi explanation
# Number 5 (odd):   0101  (binary)
# AND with 1:       0001
# Result:           0001  = 1 (non-zero, so odd)

# Number 6 (even):  0110  (binary) 
# AND with 1:        0001
# Result:            0000  = 0 (zero, so even)
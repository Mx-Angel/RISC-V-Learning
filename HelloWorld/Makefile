# RISC-V Hello World Makefile
# Compiler and tools
AS = riscv64-elf-as
LD = riscv64-elf-ld
OBJDUMP = riscv64-elf-objdump

# Target architecture
ARCH = -march=rv32i -mabi=ilp32

# File names
ASM_FILE = HelloWorld.s
OBJ_FILE = main.o
EXECUTABLE = main.x

# Default target
all: $(EXECUTABLE)

# Assemble the source file
$(OBJ_FILE): $(ASM_FILE)
	$(AS) $(ARCH) -o $(OBJ_FILE) $(ASM_FILE)

# Link the object file to create executable
$(EXECUTABLE): $(OBJ_FILE)
	$(LD) -m elf32lriscv -o $(EXECUTABLE) $(OBJ_FILE)

# Clean up generated files
clean:
	rm -f $(OBJ_FILE) $(EXECUTABLE)

# Run the program (requires RISC-V emulator like qemu-user)
run: $(EXECUTABLE)
	qemu-riscv32 ./$(EXECUTABLE)

# Disassemble the executable for debugging
disassemble: $(EXECUTABLE)
	$(OBJDUMP) -d $(EXECUTABLE)

# Show file information
info: $(EXECUTABLE)
	file $(EXECUTABLE)
	$(OBJDUMP) -h $(EXECUTABLE)

# Phony targets
.PHONY: all clean run disassemble info
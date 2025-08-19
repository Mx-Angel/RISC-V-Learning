# RISC-V Hello World Makefile
# Compiler and tools
AS = riscv64-elf-as
LD = riscv64-elf-ld
OBJDUMP = riscv64-elf-objdump

# Target architecture
ARCH = -march=rv32i -mabi=ilp32

# File names
ASM_FILE = Addition.s
OBJ_FILE = Addition.o
EXECUTABLE = Addition.x

# Default target
all: $(EXECUTABLE)

# Assemble the source file (include debug symbols for GDB/VS Code)
$(OBJ_FILE): $(ASM_FILE)
	$(AS) -g $(ARCH) -o $(OBJ_FILE) $(ASM_FILE)
# Add -mno-relax after (AS) so that the assembler does not perform relaxation on the instructions and avoids the wrong address being generated.
# Only add -mno-relax if you dont want to initialise the global pointer (thought that is bad practice)

# Link the object file to create executable
$(EXECUTABLE): $(OBJ_FILE)
	$(LD) -m elf32lriscv -o $(EXECUTABLE) $(OBJ_FILE)
# Add --no-relax after (LD) so that the linker does not perform relaxation on the instructions and avoids the wrong address being generated.
# Only add --no-relax if you dont want to initialise the global pointer (thought that is bad practice)

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
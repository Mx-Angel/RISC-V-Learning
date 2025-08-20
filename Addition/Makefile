# RISC-V Hello World Makefile
# Compiler and tools
AS = riscv64-elf-as
LD = riscv64-elf-ld
OBJDUMP = riscv64-elf-objdump

# Target architecture
ARCH = -march=rv32i -mabi=ilp32

# Relaxation toggle (RELAX=1 uses default relaxation; RELAX=0 disables it)
RELAX ?= 0

# File names
ASM_FILE = Addition.s
OBJ_FILE = Addition.o
EXECUTABLE = Addition.x

# Default target
all: $(EXECUTABLE)

# Assemble the source file (include debug symbols for GDB/VS Code)
$(OBJ_FILE): $(ASM_FILE)
ifeq ($(RELAX),0)
# Enable relaxation
	$(AS) -g -mno-relax $(ARCH) -o $(OBJ_FILE) $(ASM_FILE)
else
	$(AS) -g $(ARCH) -o $(OBJ_FILE) $(ASM_FILE)
endif

# Link the object file to create executable
$(EXECUTABLE): $(OBJ_FILE)
ifeq ($(RELAX),0)
	$(LD) -m elf32lriscv --no-relax -o $(EXECUTABLE) $(OBJ_FILE)
else
	$(LD) -m elf32lriscv -o $(EXECUTABLE) $(OBJ_FILE)
endif

# Convenience target to rebuild without relaxation
.PHONY: norelax
norelax:
	$(MAKE) RELAX=0 clean all

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
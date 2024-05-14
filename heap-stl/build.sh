#!/bin/bash

# Set the path to the toolchain
export TOOL_DIR=/opt/riscv32/

# Compile the C++ file into an ELF executable
$TOOL_DIR/bin/riscv32-unknown-elf-g++ -march=rv32im -std=c++11 -O3 -ffreestanding -Wl,-Bstatic -o heap_stl.elf heap_stl.cpp -Wextra -Wshadow -Wundef -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings -Wredundant-decls -g -pedantic -ffreestanding -fpermissive

# Create a binary file from the ELF executable
$TOOL_DIR/bin/riscv32-unknown-elf-objcopy -O binary heap_stl.elf heap_stl.bin

# Disassemble the ELF file for detailed analysis
$TOOL_DIR/bin/riscv32-unknown-elf-objdump -d heap_stl.elf > heap_stl_dump.txt

# Display the start address of the compiled ELF executable
$TOOL_DIR/bin/riscv32-unknown-elf-readelf -h heap_stl.elf | grep 'Entry point address'

# Optional: Output the disassembly to the terminal (commented out, remove # to enable)
# cat heap_stl_dump.tx

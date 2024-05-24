#!/bin/bash

export TOOL_DIR=/opt/riscv32/

$TOOL_DIR/bin/riscv32-unknown-elf-g++ -march=rv32im -std=gnu++11 benchmark.cpp -O3 -ffreestanding -Wl,-Bstatic -o firmware.elf -Wextra -Wshadow -Wundef -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings -Wredundant-decls -g -pedantic -ffreestanding -fpermissive

$TOOL_DIR/bin/riscv32-unknown-elf-objcopy -O binary firmware.elf firmware.bin
$TOOL_DIR/bin/riscv32-unknown-elf-objdump -s -t -r -d -f --source firmware.elf > objdump.txt
cat objdump.txt | grep "start address"
rm firmware.elf
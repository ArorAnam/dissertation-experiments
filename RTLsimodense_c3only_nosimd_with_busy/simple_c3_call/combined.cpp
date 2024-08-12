#include <stdint.h>
#include <string.h>
#include <stdarg.h>
#include <stdio.h>
#include <limits.h>
#include <sys/signal.h>
#include <stdlib.h>

#include "syscalls.c"

void heap_push_custom(uint32_t value);
uint32_t heap_pop_custom();
void heap_push(uint32_t* heap, uint32_t value, size_t* heap_size);
uint32_t heap_pop(uint32_t* heap, size_t* heap_size);

void main(int argc, char** argv) {
    
    uint32_t* src = 0x05000000; 
    uint32_t* custom_heap = 0x06000000; 
    uint32_t* non_custom_heap = 0x06800000;
    
    size_t heap_size_custom = 0;
    size_t heap_size_non_custom = 0;

    // Initialize heap with some values (1 to 10)
    for (int j = 1; j <= 10; j++) {
        *((volatile uint32_t*)(src + j - 1)) = j;
    }

    // Custom Instruction Performance Test
    for (size_t len = 10; len <= 10; len++) {

        for (int j = 0; j < len; j++) {
            uint32_t value = *((volatile uint32_t*)(src + j));

            // Get number of cycles and instructions before the push
            uint64_t time1 = time();
            uint64_t icount1 = insn();

            // Push using custom instruction
            heap_push_custom(value);

            // Get number of cycles and instructions after the push
            uint64_t time2 = time() - time1;
            uint64_t icount2 = insn() - icount1;

            // Pop using custom instruction
            uint64_t time3 = time();
            uint32_t pop_value_custom = heap_pop_custom();
            uint64_t time4 = time() - time3;

            printf("Custom push and pop for value %d: push cyc %llu, icount %llu, pop cyc %llu\n", 
                value, time2, icount2, time4);

            // Push into non-custom heap for comparison
            heap_push(non_custom_heap, value, &heap_size_non_custom);
        }

        // Non-Custom Instruction Performance Test
        uint64_t time5 = time();
        uint64_t icount3 = insn();

        for (int j = 0; j < len; j++) {
            heap_pop(non_custom_heap, &heap_size_non_custom);
        }

        uint64_t time6 = time() - time5;
        uint64_t icount4 = insn() - icount3;

        printf("Non-Custom heap pop: cyc %llu, icount %llu\n", time6, icount4);
    }

    while (1);
    return;
}

void heap_push_custom(uint32_t value) {
    asm volatile (
        "c3 x0, %0, %1"  // No output, just input operands
        :: "r"(value), "I"(0) // Push operation (rd = 0)
    );
}

uint32_t heap_pop_custom() {
    uint32_t result;
    asm volatile (
        "c3 %0, x0, %1"  // Store result in the output operand
        : "=r"(result)   // Output operand
        : "I"(0)         // Pop operation (rd = 1), input is dummy
    );
    return result;
}


// Non-Custom Heap Push and Pop
void heap_push(uint32_t* heap, uint32_t value, size_t* heap_size) {
    heap[(*heap_size)++] = value;
    size_t idx = *heap_size - 1;
    size_t parent_idx = (idx - 1) / 2;
    while (idx > 0 && heap[idx] > heap[parent_idx]) {
        uint32_t temp = heap[idx];
        heap[idx] = heap[parent_idx];
        heap[parent_idx] = temp;
        idx = parent_idx;
        parent_idx = (idx - 1) / 2;
    }
}

uint32_t heap_pop(uint32_t* heap, size_t* heap_size) {
    uint32_t pop_value = heap[0];
    heap[0] = heap[--(*heap_size)];
    size_t idx = 0;
    while (1) {
        size_t left_idx = 2 * idx + 1;
        size_t right_idx = 2 * idx + 2;
        size_t largest_idx = idx;

        if (left_idx < *heap_size && heap[left_idx] > heap[largest_idx]) {
            largest_idx = left_idx;
        }
        if (right_idx < *heap_size && heap[right_idx] > heap[largest_idx]) {
            largest_idx = right_idx;
        }
        if (largest_idx == idx) {
            break;
        }

        uint32_t temp = heap[idx];
        heap[idx] = heap[largest_idx];
        heap[largest_idx] = temp;
        idx = largest_idx;
    }
    return pop_value;
}

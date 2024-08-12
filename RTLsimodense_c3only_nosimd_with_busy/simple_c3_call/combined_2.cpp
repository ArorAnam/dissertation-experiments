#include <stdint.h>
#include <string.h>
#include <stdarg.h>
#include <stdio.h>
#include <limits.h>
#include <sys/signal.h>
#include <stdlib.h>

#include "syscalls.c"

// Function declarations
void heap_push_custom(uint32_t value);
uint32_t heap_pop_custom();
void heap_push(uint32_t* heap, uint32_t value, size_t* heap_size);
uint32_t heap_pop(uint32_t* heap, size_t* heap_size);

void main(int argc, char** argv) {
    
    uint32_t* src = 0x05000000; 
    uint32_t* destA = 0x06000000;
    uint32_t* destB = 0x06800000;

    size_t heap_size_non_custom = 0;

    size_t len = 10;

    // Initialize the source with values 1 to 10
    for (int j = 0; j < len; j++) {
        *((volatile uint32_t*)(src + j)) = j + 1;
    }

    // Custom Instruction Performance Test
    uint64_t time1 = time();
    uint64_t icount1 = insn();

    // Perform all heap operations using the custom instruction
    for (int j = 0; j < len; j++) {
        heap_push_custom(*((volatile uint32_t*)(src + j)));
    }
    for (int j = 0; j < len; j++) {
        destA[j] = heap_pop_custom();
    }

    uint64_t time2 = time() - time1;
    uint64_t icount2 = insn() - icount1;

    // Print the results for the custom instruction
    printf("Custom Heap Operations N %d cyc %llu icount %llu CPI %llu.%02llu ",
           len, time2, icount2, (time2) / (icount2), (((time2) % (icount2)) * 100) / (icount2));

    uint64_t int_part = len * 150 / time2;
    uint64_t dec_part = ((len * 150) % time2) * 100 / time2;
    printf("MB/s@150MHz %llu.%02llu \n", int_part, dec_part);

    // Non-Custom Instruction Performance Test
    uint64_t time3_ = time();
    uint64_t icount3 = insn();

    for (int j = 0; j < len; j++) {
        heap_push(destB, *((volatile uint32_t*)(src + j)), &heap_size_non_custom);
    }
    for (int j = 0; j < len; j++) {
        destB[j] = heap_pop(destB, &heap_size_non_custom);
    }

    uint64_t time3 = time() - time3_;
    uint64_t icount4 = insn() - icount3;

    // Print the results for the non-custom instruction
    printf("Non-Custom Heap Operations N %d cyc %llu icount %llu CPI %llu.%02llu ",
           len, time3, icount4, (time3) / (icount4), (((time3) % (icount4)) * 100) / (icount4));

    // Compare results
    int error = 0;
    for (int i = 0; i < len; i++) {
        if (destA[i] != destB[i]) {
            error = 1;
            printf("%d) Custom: %d != Non-Custom: %d\n", i, destA[i], destB[i]);
        }
    }
    printf("\nEnd! error? %s\n", error ? "yes" : "no");

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
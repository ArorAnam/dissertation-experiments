#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "syscalls.c"

void heap_push(uint32_t value);
uint32_t heap_pop();

void main() {
    printf("Inside main\n");
    // uint32_t push_value = 42;  // Value to push into the heap
    // uint32_t pop_value;

    // // wait(1);
    // while(1);
    // // Push the value into the heap
    // printf("Pushing value: %u\n", push_value);
    // heap_push(push_value);

    // while(1);
    // // wait(1);
    // // Pop the value from the heap
    // pop_value = heap_pop();
    // printf("Popped value: %u\n", pop_value);

    // // Check if the popped value matches the pushed value
    // if (pop_value == push_value) {
    //     printf("Test Passed: Popped value matches the pushed value.\n");
    // } else {
    //     printf("Test Failed: Popped value does not match the pushed value.\n");
    // }

    // while (1);
    return;
}

void heap_push(uint32_t value) {
    asm volatile (
        "c3 x0, %0, %1"  // No output, just input operands
        :: "r"(value), "I"(0) // Push operation (rd = 0)
    );
}

uint32_t heap_pop() {
    uint32_t result;
    asm volatile (
        "c3 %0, x0, %1"  // Store result in the output operand
        : "=r"(result)   // Output operand
        : "I"(0)         // Pop operation (rd = 1), input is dummy
    );
    return result;
}
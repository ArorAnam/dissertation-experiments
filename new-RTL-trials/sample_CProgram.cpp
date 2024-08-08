#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "syscalls.c"

void heap_push(uint32_t value);
uint32_t heap_pop();

void main(int argc, char** argv) {
    printf("Inside Main\n");

    // uint32_t data[10];
    // size_t len = 10;

    // Fill data with values from 1 to 10
    // for (size_t i = 0; i < len; ++i) {
    //     data[i] = i + 1; // Values from 1 to 10
    //     printf("Generated value: %u\n", data[i]); // Print generated value for debugging
    // }

    // Timing and instruction count for heap push operations
    // uint64_t time1 = time();
    // uint64_t icount1 = insn();
    
    // for (size_t i = 0; i < len; ++i) {
    //     heap_push(data[i]);
    //     printf("Pushed value: %u\n", data[i]); // Print pushed value for debugging
    // }

    heap_push(10);
    printf("Pushed value: %u\n", 10);

    // uint64_t time2 = time() - time1;
    // uint64_t icount2 = insn() - icount1;

    // printf("heapPush N %zu cyc %llu icount %llu CPI %llu.%02llu ",
    //        len, time2, icount2, (time2) / (icount2), (((time2) % (icount2)) * 100) / (icount2));

    // uint64_t int_part = len * 150 / time2;
    // uint64_t dec_part = ((len * 150) % time2) * 100 / time2;
    // printf("MB/s@150MHz %llu.%02llu\n", int_part, dec_part);

    // Timing and instruction count for heap pop operations
    // time1 = time();
    // icount1 = insn();
    
    // for (size_t i = 0; i < len; ++i) {
    //     uint32_t popped_value = heap_pop();
    //     printf("Popped value: %u\n", popped_value); // Print popped value for debugging
    // }

    while (1);

    uint32_t popped_value = heap_pop();
    printf("Popped value: %u\n", popped_value);

    // time2 = time() - time1;
    // icount2 = insn() - icount1;

    // printf("heapPop N %zu cyc %llu icount %llu CPI %llu.%02llu ",
    //        len, time2, icount2, (time2) / (icount2), (((time2) % (icount2)) * 100) / (icount2));

    // int_part = len * 150 / time2;
    // dec_part = ((len * 150) % time2) * 100 / time2;
    // printf("MB/s@150MHz %llu.%02llu\n", int_part, dec_part);
    
    while (1);
    return;
}

void heap_push(uint32_t value) {
    asm volatile (
        "c3 x0, %0, %1\n"
        :
        : "r"(value), "I"(0)
    );
}

uint32_t heap_pop() {
    uint32_t result;
    asm volatile (
        "c3 %0, x0, %1\n"
        : "=r"(result)
        : "I"(1)
    );
    return result;
}

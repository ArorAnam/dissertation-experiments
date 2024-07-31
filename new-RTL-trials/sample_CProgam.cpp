#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void heap_operation(uint32_t* data, size_t len, bool push);

void main(int argc, char** argv) {
    srand(time(0));
    
    uint32_t data[30];
    size_t len = 30;
    
    // Fill data with random values
    for (size_t i = 0; i < len; ++i) {
        data[i] = rand() % 100;
    }
    
    // Perform heap push operations
    for (size_t i = 0; i < len; ++i) {
        heap_operation(&data[i], len, true);
    }
    
    // Perform heap pop operations
    for (size_t i = 0; i < len; ++i) {
        heap_operation(nullptr, len, false);
    }
    
    while (1);
    return;
}

void heap_operation(uint32_t* data, size_t len, bool push) {
    uint32_t* in_data = data;
    uint32_t* out_data = nullptr;
    
    // Push operation
    if (push) {
        asm volatile (
            "c0_lv x0, %0, %1, %2\n"
            "c3 x0, x0, 0\n"
            "c0_sv x0, %0, %1, %2\n"
            :
            : "r"(in_data), "r"(0), "I"(0)
        );
    }
    // Pop operation
    else {
        asm volatile (
            "c0_lv x0, %0, %1, %2\n"
            "c3 x0, x0, 1\n"
            "c0_sv x0, %0, %1, %2\n"
            :
            : "r"(out_data), "r"(0), "I"(1)
        );
    }
}

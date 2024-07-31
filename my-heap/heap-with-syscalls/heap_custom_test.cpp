#include <iostream>

int main() {
    int a = 42, b = 23, result;

    // Inline assembly for heap push
    asm volatile ("heap_push %0, %1" : "=r"(result) : "r"(a));
    asm volatile ("heap_push %0, %1" : "=r"(result) : "r"(b));

    // Inline assembly for heap pop
    asm volatile ("heap_pop %0" : "=r"(result));
    std::cout << "Heap Pop Result 1: " << result << std::endl;

    asm volatile ("heap_pop %0" : "=r"(result));
    std::cout << "Heap Pop Result 2: " << result << std::endl;

    return 0;
}


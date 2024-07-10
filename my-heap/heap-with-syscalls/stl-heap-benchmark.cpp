#include <iostream>
#include <vector>
#include <algorithm>
#include <cstdlib>
#include <chrono>

// Assuming syscalls.c has been adapted for extern "C" and includes necessary timing functions
extern "C" {
    #include "syscalls.c"
}

// Benchmark function using STL heap functions with additional metrics
void benchmarkSTLHeapOperations(int initialHeapSize, int popRatePercent, int duration_seconds) {
    int* heap = new int[initialHeapSize + duration_seconds * 100];  // Sufficient space for dynamic changes
    std::srand(static_cast<unsigned>(std::time(nullptr)));

    // Fill the heap with random values
    for (int i = 0; i < initialHeapSize; ++i) {
        heap[i] = std::rand() % 1000;
    }

    std::make_heap(heap, heap + initialHeapSize);

    size_t currentSize = initialHeapSize;  // Current dynamic size of the heap
    size_t operations = 0;
    size_t push_operations = 0;
    size_t pop_operations = 0;
    uint64_t startTime = riscv_time();

    while (riscv_time() - startTime < static_cast<uint64_t>(duration_seconds) * 1000000) {  // Convert seconds to microseconds
        if (std::rand() % 100 < popRatePercent && currentSize > 0) {
            std::pop_heap(heap, heap + currentSize);
            --currentSize;  // Decrease current heap size after popping
            ++pop_operations;
        } else if (currentSize < initialHeapSize + duration_seconds * 100) {  // Check to avoid overflow
            heap[currentSize] = std::rand() % 1000;
            ++currentSize;  // Increase current heap size after pushing
            std::push_heap(heap, heap + currentSize);
            ++push_operations;
        }
        ++operations;
    }

    uint64_t endTime = riscv_time();
    uint64_t elapsed = endTime - startTime;
    double elapsed_seconds = elapsed / 1000000.0;
    double opsPerSecond = operations / elapsed_seconds;
    double avgTimePerOp = 1000.0 * elapsed_seconds / operations;  // in milliseconds

    char buffer[256];
    sprintf(buffer, "Initial Heap Size: %d, Current Heap Size: %zu, Pop Rate: %d%%\n", initialHeapSize, currentSize, popRatePercent);
    printstr(buffer);
    sprintf(buffer, "Performed %zu operations in %.2f seconds (%.2f OP/s)\n", operations, elapsed_seconds, opsPerSecond);
    printstr(buffer);
    sprintf(buffer, "Push Operations: %zu, Pop Operations: %zu\n", push_operations, pop_operations);
    printstr(buffer);
    sprintf(buffer, "Average Time per Operation: %.4f ms\n", avgTimePerOp);
    printstr(buffer);
    printstr("----------------------------------------\n");

    delete[] heap;
}

int main() {
    printstr("Entered into main\n");
    
    std::srand(static_cast<unsigned>(std::time(nullptr))); // Use the standard library's time function

    std::vector<size_t> heap_sizes = {10, 20, 50, 100}; //, 500}; // 5000, 10000}; // Expanded heap sizes for a broader range
    std::vector<int> pop_rates = {10, 20, 50}; // Expanded pop rates in percentage
    // int heap_size = 10;
    // int pop_rate = 50;
    int duration_seconds = 1; // Reduced duration for the benchmark

    for (size_t heap_size : heap_sizes) {
        for (int pop_rate : pop_rates) {
            benchmarkSTLHeapOperations(heap_size, pop_rate, duration_seconds);
        }
    }

    // benchmarkSTLHeapOperations(heap_size, pop_rate, duration_seconds);

    return 0;
}

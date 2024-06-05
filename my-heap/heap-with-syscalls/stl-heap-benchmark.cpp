// syscalls.c - assume to be the same as provided earlier with necessary modifications for extern "C"
extern "C" {
    #include "syscalls.c"
}

#include <iostream>
#include <vector>
#include <algorithm>
#include <cstdlib>
#include <chrono>

// Benchmark function using STL heap functions with additional metrics
void benchmarkSTLHeapOperations(size_t initialHeapSize, int popRatePercent, int duration_seconds) {
    std::vector<int> heap(initialHeapSize + duration_seconds * 100);
    std::srand(static_cast<unsigned>(std::time(nullptr)));

    // Fill the heap with random values
    for (size_t i = 0; i < initialHeapSize; ++i) {
        heap[i] = std::rand() % 1000;
    }

    std::make_heap(heap.begin(), heap.begin() + initialHeapSize);

    size_t operations = 0;
    size_t push_operations = 0;
    size_t pop_operations = 0;
    uint64_t startTime = riscv_time();

    while (riscv_time() - startTime < static_cast<uint64_t>(duration_seconds) * 1000000) { // convert seconds to microseconds
        if (std::rand() % 100 < popRatePercent && initialHeapSize > 0) {
            std::pop_heap(heap.begin(), heap.begin() + initialHeapSize);
            --initialHeapSize;
            ++pop_operations;
        } else {
            heap[initialHeapSize] = std::rand() % 1000;
            ++initialHeapSize;
            std::push_heap(heap.begin(), heap.begin() + initialHeapSize);
            ++push_operations;
        }
        ++operations;
    }

    uint64_t endTime = riscv_time();
    uint64_t elapsed = endTime - startTime;
    double elapsed_seconds = elapsed / 1000000.0;
    double opsPerSecond = operations / elapsed_seconds;
    double avgTimePerOp = elapsed_seconds / operations * 1000; // in milliseconds

    char buffer[256];
    sprintf(buffer, "Heap Size: %zu, Pop Rate: %d%%\n", initialHeapSize, popRatePercent);
    printstr(buffer);
    sprintf(buffer, "Performed %zu operations in %.2f seconds (%.2f OP/s)\n", operations, elapsed_seconds, opsPerSecond);
    printstr(buffer);
    sprintf(buffer, "Push Operations: %zu, Pop Operations: %zu\n", push_operations, pop_operations);
    printstr(buffer);
    sprintf(buffer, "Average Time per Operation: %.4f ms\n", avgTimePerOp);
    printstr(buffer);
    printstr("----------------------------------------\n");
}

int main() {
    printstr("Entered into main\n");

    std::srand(static_cast<unsigned>(std::time(nullptr))); // Use the standard library's time function

    std::vector<size_t> heap_sizes = {100, 500, 1000, 5000, 10000}; // Expanded heap sizes for a broader range
    std::vector<int> pop_rates = {1, 5, 10, 20, 50}; // Expanded pop rates in percentage
    int duration_seconds = 1; // Reduced duration for the benchmark

    for (size_t heap_size : heap_sizes) {
        for (int pop_rate : pop_rates) {
            benchmarkSTLHeapOperations(heap_size, pop_rate, duration_seconds);
        }
    }

    return 0;
}

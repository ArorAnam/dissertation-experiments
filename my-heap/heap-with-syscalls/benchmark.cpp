#include <iostream>
#include <cstdlib>
#include <ctime>
#include <chrono>
#include "syscalls.c"
#include "heap.h"

// Function to perform the benchmark
void benchmarkHeapOperations(int initialHeapSize, int popRatePercent, std::chrono::seconds duration) {
    int* heap = new int[initialHeapSize + duration.count() * 100]; // Oversize the heap for simplicity
    int heapSize = initialHeapSize;

    // Initialize the heap with some values
    for (size_t i = 0; i < initialHeapSize; ++i) {
        heap[i] = std::rand() % 1000; // Random values between 0 and 999
    }
    make_heap(heap, heapSize);

    size_t operations = 0;
    auto startTime = std::chrono::steady_clock::now();

    while (std::chrono::steady_clock::now() - startTime < duration) {
        if (std::rand() % 100 < popRatePercent && heapSize > 0) {
            // Perform a pop operation with a certain percentage
            popHeap(heap, heapSize);
        } else {
            // Otherwise, perform a push operation
            int value = std::rand() % 1000; // Random value to push
            pushHeap(heap, heapSize, value);
        }

        operations++;
    }

    // Calculate and print operations per second
    auto endTime = std::chrono::steady_clock::now();
    std::chrono::duration<double> elapsed = endTime - startTime;
    double opsPerSecond = operations / elapsed.count();

    printf("Performed %zu operations in %f seconds (%f OP/s)\n", operations, elapsed.count(), opsPerSecond);

    delete[] heap; // Clean up
}

int main() {
    std::srand(std::time(nullptr)); // Seed the random number generator

    int initialHeapSize = 10000; // Initial number of elements in the heap
    int popRatePercent = 1; // Percentage of pop operations
    std::chrono::seconds duration(30); // Duration of the benchmark

    benchmarkHeapOperations(initialHeapSize, popRatePercent, duration);

    return 0;
}

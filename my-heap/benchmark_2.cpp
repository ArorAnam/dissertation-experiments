#include <chrono>
#include <cstdlib>
#include <iostream>

// Include or define your heap functions here
// void pushHeap(int arr[], int& n, int key);
// void popHeap(int arr[], int& n);
// void make_heap(int arr[], int n);
#include "heap.h"

int main() {
    const int heapSize = 1000000; // Initial size of the heap
    int heap[heapSize]; // Adjust based on your maximum expected heap size
    int n = 0; // Current size of the heap
    long long operations = 0; // Total number of operations performed

    // Seed for random number generation
    srand(static_cast<unsigned int>(time(nullptr)));

    // Initialize the heap with some values
    for (int i = 0; i < heapSize / 2; ++i) {
        pushHeap(heap, n, rand());
    }

    // Start timing
    auto start = std::chrono::high_resolution_clock::now();

    while (true) {
        // Check the elapsed time
        auto now = std::chrono::high_resolution_clock::now();
        auto elapsed = std::chrono::duration_cast<std::chrono::seconds>(now - start);

        // Break the loop after 30 seconds
        if (elapsed.count() >= 30) {
            break;
        }

        // With 1% chance, pop an element from the heap, otherwise push a new element
        if ((rand() % 100) < 1 && n > 0) {
            popHeap(heap, n);
        } else {
            pushHeap(heap, n, rand());
        }

        // Ensure the heap does not exceed its maximum size
        if (n >= heapSize) {
            std::cerr << "Heap size limit exceeded" << std::endl;
            break;
        }

        ++operations; // Increment the count of operations
    }

    // Calculate and print operations per second
    auto totalElapsed = std::chrono::duration_cast<std::chrono::seconds>(std::chrono::high_resolution_clock::now() - start).count();
    std::cout << "Operations per second: " << operations / totalElapsed << " OP/s" << std::endl;

    return 0;
}

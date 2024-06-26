#include <iostream>
#include <vector>
#include <algorithm>
#include <cstdlib>
#include <chrono>
#include <cmath>
#include <cstdio>

// Custom heap implementation
inline void heapify(int arr[], int n, int i) {
    int largest = i;
    int l = 2 * i + 1;
    int r = 2 * i + 2;

    if (l < n && arr[l] > arr[largest])
        largest = l;
    if (r < n && arr[r] > arr[largest])
        largest = r;
    if (largest != i) {
        std::swap(arr[i], arr[largest]);
        heapify(arr, n, largest);
    }
}

inline void make_heap(int arr[], int n) {
    int startIdx = (n / 2) - 1;
    for (int i = startIdx; i >= 0; i--) {
        heapify(arr, n, i);
    }
}

inline void pushHeap(int arr[], int& n, int key) {
    if (n >= 10000) { // Set a reasonable limit to prevent overflow
        std::cerr << "Heap capacity exceeded" << std::endl;
        return;
    }
    arr[n] = key;
    n++;
    heapify(arr, n, n - 1);
}

inline void popHeap(int arr[], int& n) {
    if (n <= 0) {
        std::cerr << "Attempt to pop from an empty heap" << std::endl;
        return;
    }
    std::swap(arr[0], arr[n - 1]);
    n--;
    if (n > 0) { // Only call heapify if there are elements left in the heap
        heapify(arr, n, 0);
    }
}

// Benchmark function using custom heap implementation with additional metrics
void benchmarkCustomHeapOperations(int initialHeapSize, int popRatePercent, int duration_seconds) {
    int* heap = new int[initialHeapSize + duration_seconds * 100];
    int heapSize = 0; // Initialize heap size to 0
    std::srand(static_cast<unsigned>(std::time(nullptr)));

    for (size_t i = 0; i < initialHeapSize; ++i) {
        pushHeap(heap, heapSize, std::rand() % 1000); // Use pushHeap to add elements safely
    }

    size_t operations = 0;
    size_t push_operations = 0;
    size_t pop_operations = 0;
    auto startTime = std::chrono::steady_clock::now();

    while (std::chrono::duration_cast<std::chrono::seconds>(std::chrono::steady_clock::now() - startTime).count() < duration_seconds) {
        if (std::rand() % 100 < popRatePercent && heapSize > 0) {
            popHeap(heap, heapSize);
            ++pop_operations;
        } else {
            int value = std::rand() % 1000;
            pushHeap(heap, heapSize, value);
            ++push_operations;
        }
        ++operations;
    }

    auto endTime = std::chrono::steady_clock::now();
    auto elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(endTime - startTime).count();
    double elapsed_seconds = elapsed / 1000.0;
    double opsPerSecond = operations / elapsed_seconds;

    std::cout << "Heap Size: " << initialHeapSize << ", Pop Rate: " << popRatePercent << "%\n";
    std::cout << "Performed " << operations << " operations in " << elapsed_seconds << " seconds (" << opsPerSecond << " OP/s)\n";
    std::cout << "Push Operations: " << push_operations << ", Pop Operations: " << pop_operations << "\n";

    delete[] heap;
}

int main() {
    std::srand(static_cast<unsigned>(std::time(nullptr)));
    std::vector<size_t> heap_sizes = {10, 20, 50, 100};
    std::vector<int> pop_rates = {10, 20, 50};
    int duration_seconds = 1;

    for (size_t heap_size : heap_sizes) {
        for (int pop_rate : pop_rates) {
            std::cout << "Entering benchmark for Heap Size: " << heap_size << ", Pop Rate: " << pop_rate << "%" << std::endl;
            benchmarkCustomHeapOperations(heap_size, pop_rate, duration_seconds);
        }
    }

    return 0;
}

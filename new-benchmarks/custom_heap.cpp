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
    n = n + 1;
    arr[n - 1] = key;
    make_heap(arr, n);
}

inline void popHeap(int arr[], int& n) {
    if (n <= 0)
        return;
    if (n == 1) {
        n--;
        return;
    }

    arr[0] = arr[n - 1];
    n--;
    heapify(arr, n, 0);
}

// Benchmark function using custom heap implementation with additional metrics
void benchmarkCustomHeapOperations(int initialHeapSize, int popRatePercent, int duration_seconds) {
    int* heap = new int[initialHeapSize + duration_seconds * 100];
    int heapSize = initialHeapSize;
    std::srand(static_cast<unsigned>(std::time(nullptr)));

    // Fill the heap with random values
    for (size_t i = 0; i < initialHeapSize; ++i) {
        heap[i] = std::rand() % 1000;
    }
    make_heap(heap, heapSize);

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
    double avgTimePerOp = elapsed_seconds / operations * 1000; // in milliseconds

    std::cout << "Heap Size: " << initialHeapSize << ", Pop Rate: " << popRatePercent << "%\n";
    std::cout << "Performed " << operations << " operations in " << elapsed_seconds << " seconds (" << opsPerSecond << " OP/s)\n";
    std::cout << "Push Operations: " << push_operations << ", Pop Operations: " << pop_operations << "\n";
    std::cout << "Average Time per Operation: " << avgTimePerOp << " ms\n";
    std::cout << "----------------------------------------\n";

    delete[] heap;
}

int main() {
    std::cout << "Entered into main" << std::endl;
    std::srand(static_cast<unsigned>(std::time(nullptr))); // Use the standard library's time function

    std::vector<size_t> heap_sizes = {10, 20, 50, 100}; // Defined heap sizes
    std::vector<int> pop_rates = {10, 20, 50}; // Defined pop rates
    int duration_seconds = 1; // Defined duration for the benchmark

    for (size_t heap_size : heap_sizes) {
        for (int pop_rate : pop_rates) {
            benchmarkCustomHeapOperations(heap_size, pop_rate, duration_seconds);
        }
    }

    return 0;
}

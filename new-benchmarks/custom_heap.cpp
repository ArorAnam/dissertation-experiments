#include <iostream>
#include <vector>
#include <algorithm>
#include <cstdlib>
#include <chrono>
#include <cmath>
#include <cstdio>

// Custom heap implementation
void heapify(int arr[], int n, int i) {
    while (true) {
        int largest = i;
        int l = 2 * i + 1;
        int r = 2 * i + 2;

        if (l < n && arr[l] > arr[largest]) {
            largest = l;
        }
        if (r < n && arr[r] > arr[largest]) {
            largest = r;
        }
        if (largest == i) {
            break;
        }
        std::swap(arr[i], arr[largest]);
        i = largest;
    }
}

void make_heap(int arr[], int n) {
    for (int i = (n / 2) - 1; i >= 0; i--) {
        heapify(arr, n, i);
    }
}

void pushHeap(int arr[], int& n, int key) {
    arr[n] = key;
    n++;
    make_heap(arr, n);
}

void popHeap(int arr[], int& n) {
    if (n <= 0) return;
    std::swap(arr[0], arr[n-1]);
    n--;
    if (n > 0) {
        heapify(arr, n, 0);
    }
}

// Benchmark function using custom heap implementation with additional metrics
void benchmarkCustomHeapOperations(int initialHeapSize, int popRatePercent, int duration_seconds) {
    int* heap = new int[initialHeapSize];  // Allocate heap based on initial size directly
    int heapSize = 0;  // Start with an empty heap
    std::srand(static_cast<unsigned>(std::time(nullptr)));

    // Fill the heap with random values
    for (int i = 0; i < initialHeapSize; ++i) {
        pushHeap(heap, heapSize, std::rand() % 1000);
    }

    size_t operations = 0, push_operations = 0, pop_operations = 0;
    auto startTime = std::chrono::steady_clock::now();

    while (std::chrono::duration_cast<std::chrono::seconds>(std::chrono::steady_clock::now() - startTime).count() < duration_seconds) {
        if (std::rand() % 100 < popRatePercent && heapSize > 0) {
            popHeap(heap, heapSize);
            pop_operations++;
        } else {
            if (heapSize < initialHeapSize) { // Prevent pushing beyond allocated size
                pushHeap(heap, heapSize, std::rand() % 1000);
                push_operations++;
            }
        }
        operations++;
    }

    auto endTime = std::chrono::steady_clock::now();
    auto elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(endTime - startTime).count();
    double elapsed_seconds = elapsed / 1000.0;
    double opsPerSecond = operations / elapsed_seconds;

    std::cout << "Heap Size: " << initialHeapSize << ", Pop Rate: " << popRatePercent << "%\n";
    std::cout << "Performed " << operations << " operations in " << elapsed_seconds << " seconds (" << opsPerSecond << " OP/s)\n";
    std::cout << "Push Operations: " << push_operations << ", Pop Operations: " << pop_operations << "\n";
    std::cout << "----------------------------------------\n";

    delete[] heap;
}

int main() {
    std::cout << "Entered into main\n";
    std::srand(static_cast<unsigned>(std::time(nullptr)));

    // Significantly increased heap sizes
    std::vector<size_t> heap_sizes = {1'000'000, 10'000'000, 100'000'000};
    std::vector<int> pop_rates = {10, 20, 50}; // Defined pop rates
    int duration_seconds = 1; // Defined duration for the benchmark

    for (size_t heap_size : heap_sizes) {
        for (int pop_rate : pop_rates) {
            std::cout << "Benchmarking Heap Size: " << heap_size << ", Pop Rate: " << pop_rate << "%" << std::endl;
            benchmarkCustomHeapOperations(heap_size, pop_rate, duration_seconds);
        }
    }

    return 0;
}

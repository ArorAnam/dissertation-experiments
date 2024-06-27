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

        if (l < n && arr[l] > arr[largest])
            largest = l;
        if (r < n && arr[r] > arr[largest])
            largest = r;
        if (largest == i)
            break;

        std::swap(arr[i], arr[largest]);
        i = largest;
    }
}

void make_heap(int arr[], int n) {
    for (int i = (n / 2) - 1; i >= 0; i--) {
        heapify(arr, n, i);
    }
}

void pushHeap(int arr[], int& n, int maxSize, int key) {
    if (n >= maxSize) {
        std::cerr << "Heap capacity exceeded, current size: " << n << std::endl;
        return;
    }
    arr[n++] = key;
    for (int i = n / 2 - 1; i >= 0; i--) {
        heapify(arr, n, i);
    }
}

void popHeap(int arr[], int& n) {
    if (n <= 0) {
        std::cerr << "Attempt to pop from an empty heap" << std::endl;
        return;
    }
    std::swap(arr[0], arr[--n]);
    heapify(arr, n, 0);
}

// Benchmark function
void benchmarkCustomHeapOperations(int initialHeapSize, int popRatePercent, int duration_seconds) {
    int maxSize = initialHeapSize + duration_seconds * 100;
    int* heap = new int[maxSize];
    int heapSize = 0;
    std::srand(static_cast<unsigned>(std::time(nullptr)));

    for (int i = 0; i < initialHeapSize; ++i) {
        pushHeap(heap, heapSize, maxSize, std::rand() % 1000);
    }

    size_t operations = 0;
    auto startTime = std::chrono::steady_clock::now();
    auto endTime = startTime + std::chrono::seconds(duration_seconds);

    while (std::chrono::steady_clock::now() < endTime) {
        if (std::rand() % 100 < popRatePercent && heapSize > 0) {
            popHeap(heap, heapSize);
        } else {
            pushHeap(heap, heapSize, maxSize, std::rand() % 1000);
        }
        ++operations;
    }

    double elapsed_seconds = std::chrono::duration<double>(std::chrono::steady_clock::now() - startTime).count();
    double opsPerSecond = operations / elapsed_seconds;

    std::cout << "Heap Size: " << initialHeapSize << ", Pop Rate: " << popRatePercent << "%\n";
    std::cout << "Performed " << operations << " operations in " << elapsed_seconds << " seconds (" << opsPerSecond << " OP/s)\n";
    std::cout << "----------------------------------------\n";

    delete[] heap;
}

int main() {
    std::cout << "Entered into main" << std::endl;
    std::vector<int> heap_sizes = {100, 500, 1000, 50000};
    std::vector<int> pop_rates = {10, 20, 50};
    for (int heap_size : heap_sizes) {
        for (int pop_rate : pop_rates) {
            std::cout << "Benchmarking Heap Size: " << heap_size << ", Pop Rate: " << pop_rate << "%" << std::endl;
            benchmarkCustomHeapOperations(heap_size, pop_rate, 1);
        }
    }

    return 0;
}

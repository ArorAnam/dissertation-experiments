// syscalls.c - assume to be the same as provided earlier with necessary modifications for extern "C"
extern "C" {
    #include "syscalls.c"
}

// heap.h contents
#include <algorithm>
#include <iostream>
#include <cstdlib>
#include <chrono>

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

inline void heapSort(int arr[], int n) {
    make_heap(arr, n);
    for (int i = n - 1; i > 0; i--) {
        std::swap(arr[0], arr[i]);
        heapify(arr, i, 0);
    }
}

inline void pushHeap(int arr[], int& n, int key) {
    n = n + 1;
    arr[n - 1] = key;
    make_heap(arr, n);
}

inline void popHeap(int arr[], int& n) {
    printstr("Popping element from heap\n");
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

// Benchmark function
void benchmarkHeapOperations(int initialHeapSize, int popRatePercent, int duration_seconds) {
    int* heap = new int[initialHeapSize + duration_seconds * 100];
    int heapSize = initialHeapSize;

    for (size_t i = 0; i < initialHeapSize; ++i) {
        heap[i] = std::rand() % 1000;
    }
    make_heap(heap, heapSize);

    size_t operations = 0;
    uint64_t startTime = riscv_time();

    while (riscv_time() - startTime < static_cast<uint64_t>(duration_seconds) * 1000000) { // convert seconds to microseconds
        if (std::rand() % 100 < popRatePercent && heapSize > 0) {
            popHeap(heap, heapSize);
        } else {
            int value = std::rand() % 1000;
            pushHeap(heap, heapSize, value);
        }
        operations++;
    }

    uint64_t endTime = riscv_time();
    uint64_t elapsed = endTime - startTime;
    double elapsed_seconds = elapsed / 1000000.0;
    double opsPerSecond = operations / elapsed_seconds;

    char buffer[256];
    sprintf(buffer, "Performed %zu operations in %.2f seconds (%.2f OP/s)\n", operations, elapsed_seconds, opsPerSecond);
    printstr(buffer);

    delete[] heap;
}

int main() {
    printstr("Entered into main\n");

    std::srand(static_cast<unsigned>(std::time(nullptr))); // Use the standard library's time function

    int initialHeapSize = 100; // Reduced initial number of elements in the heap
    int popRatePercent = 1;
    int duration_seconds = 1; // Reduced duration for the benchmark

    benchmarkHeapOperations(initialHeapSize, popRatePercent, duration_seconds);

    return 0;
}

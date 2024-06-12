#ifndef HEAP_H
#define HEAP_H

#include <algorithm>
#include <iostream>

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

    // Using custom push heap instruction
    asm volatile (
        "c0_push_heap %0, %1"
        :
        : "r"(arr), "r"(n)
    );
}

inline void popHeap(int arr[], int& n) {
    std::cout << "Popping element from heap of size " << n << std::endl;
    if (n <= 0)
        return;
    if (n == 1) {
        n--;
        return;
    }

    arr[0] = arr[n - 1];
    n--;

    // Using custom pop heap instruction
    asm volatile (
        "c0_pop_heap %0, %1"
        :
        : "r"(arr), "r"(n)
    );
}

#endif // HEAP_H

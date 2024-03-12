#ifndef HEAP_H
#define HEAP_H

#include <algorithm>

inline void heapify(int arr[], int n, int i) {
    int largest = i;
    int l = 2 * i + 1;
    int r = 2 * i + 2;

    // If left child is larger than root
    if (l < n && arr[l] > arr[largest])
        largest = l;

    // If right child is larger than largest so far
    if (r < n && arr[r] > arr[largest])
        largest = r;

    // If largest is not root
    if (largest != i) {
        std::swap(arr[i], arr[largest]);

        // Recursively heapify the affected sub-tree
        heapify(arr, n, largest);
    }
}

// Function to build a Max-Heap from the given array
inline void make_heap(int arr[], int n) {
    // Index of the last non-leaf node
    int startIdx = (n / 2) - 1;

    // Perform reverse level order traversal from last non-leaf node and heapify each node
    for (int i = startIdx; i >= 0; i--) {
        heapify(arr, n, i);
    }
}

inline void heapSort(int arr[], int n) {
    // Build a heap from the input data.
    make_heap(arr, n);

    // One by one extract an element from heap
    for (int i = n - 1; i > 0; i--) {
        // Move current root to end
        std::swap(arr[0], arr[i]);

        // call max heapify on the reduced heap
        heapify(arr, i, 0);
    }
}

inline void pushHeap(int arr[], int& n, int key) {
    n = n + 1;
    arr[n - 1] = key;
    make_heap(arr, n); // Rebuild the heap with the new element
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
    heapify(arr, n, 0); // Re-heapify the array
}

#endif // HEAP_H
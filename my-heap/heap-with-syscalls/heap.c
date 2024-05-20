#ifndef HEAP_H
#define HEAP_H

#include <stdlib.h> // for size_t

#include "syscalls.c"  // Include syscalls directly

void print_heap_operation(const char* operation, int value) {
    char buffer[100];
    snprintf(buffer, sizeof(buffer), "%s operation with value %d\n", operation, value);
    printstr(buffer);
}

void heapify(int arr[], int n, int i) {
    int largest = i;  // Initialize largest as root
    int l = 2 * i + 1;  // left = 2*i + 1
    int r = 2 * i + 2;  // right = 2*i + 2

    // If left child is larger than root
    if (l < n && arr[l] > arr[largest])
        largest = l;

    // If right child is larger than the largest so far
    if (r < n && arr[r] > arr[largest])
        largest = r;

    // If largest is not root
    if (largest != i) {
        int swap = arr[i];
        arr[i] = arr[largest];
        arr[largest] = swap;

        // Recursively heapify the affected sub-tree
        heapify(arr, n, largest);
    }
}

void make_heap(int arr[], int n) {
    // Build heap (rearrange array)
    for (int i = n / 2 - 1; i >= 0; i--)
        heapify(arr, n, i);
}

void heapSort(int arr[], int n) {
    // One by one extract an element from heap
    for (int i = n - 1; i >= 0; i--) {
        // Move current root to end
        int temp = arr[0];
        arr[0] = arr[i];
        arr[i] = temp;

        // call max heapify on the reduced heap
        heapify(arr, i, 0);
    }
}

void pushHeap(int arr[], int* n, int key) {
    // Insert the new element at the end of the array
    arr[*n] = key;
    int i = *n;  // Current index of the newly added element
    *n = *n + 1;

    // Adjust the heap
    while (i != 0 && arr[(i - 1) / 2] < arr[i]) {
       int temp = arr[i];
       arr[i] = arr[(i - 1) / 2];
       arr[(i - 1) / 2] = temp;
       i = (i - 1) / 2;
    }
    print_heap_operation("push", key);
}

void popHeap(int arr[], int* n) {
    if (*n <= 0) {
        printstr("Heap is empty, cannot pop\n");
        return;
    }
    if (*n == 1) {
        *n = *n - 1;
        return;
    }

    // Move the last element to root and decrease heap size
    int root = arr[0];
    arr[0] = arr[*n - 1];
    *n = *n - 1;
    heapify(arr, *n, 0);

    print_heap_operation("pop", root);
}

#endif // HEAP_H

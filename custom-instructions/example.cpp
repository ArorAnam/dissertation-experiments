#include "heap.h"

int main() {
    int heap[1000];
    int n = 0;

    pushHeap(heap, n, 10);
    pushHeap(heap, n, 20);
    pushHeap(heap, n, 5);

    popHeap(heap, n);

    return 0;
}

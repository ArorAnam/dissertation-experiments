#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "heap.c"  // Assuming heap.h is already adapted for C

#include "syscalls.c"  // Include syscalls directly

void benchmarkHeapOperations(int initialHeapSize, int popRatePercent, int duration) {
    int* heap = (int*)malloc((initialHeapSize + duration * 100) * sizeof(int));
    int heapSize = initialHeapSize;

    for (int i = 0; i < initialHeapSize; ++i) {
        heap[i] = rand() % 1000;
    }
    make_heap(heap, heapSize);

    size_t operations = 0;
    uint64_t startTime = time();

    while ((time() - startTime) < (uint64_t)duration * 1000000) {
        if (rand() % 100 < popRatePercent && heapSize > 0) {
            popHeap(heap, &heapSize);
        } else {
            pushHeap(heap, &heapSize, rand() % 1000);
        }
        operations++;
    }

    uint64_t endTime = time();
    uint64_t elapsed = endTime - startTime;
    double elapsedSeconds = elapsed / 1000000.0;
    double opsPerSecond = operations / elapsedSeconds;

    char buffer[256];
    sprintf(buffer, "Performed %zu operations in %f seconds (%f OP/s)\n", operations, elapsedSeconds, opsPerSecond);
    printstr(buffer);

    free(heap);
}

int main() {
    srand(time(NULL));

    int initialHeapSize = 10000;
    int popRatePercent = 1;
    int duration = 30;

    benchmarkHeapOperations(initialHeapSize, popRatePercent, duration);

    return 0;
}

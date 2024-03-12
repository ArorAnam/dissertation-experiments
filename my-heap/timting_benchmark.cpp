#include <iostream>
#include <chrono>
#include <vector>
#include <cstdlib> // For rand() and srand()
#include <ctime>   // For time()

// Include or implement your heap functions here

void generateRandomData(int arr[], int n) {
    for (int i = 0; i < n; ++i) {
        arr[i] = rand(); // Fill the array with random values
    }
}

void benchmarkMakeHeap(int arr[], int n) {
    auto start = std::chrono::high_resolution_clock::now();

    // Call your make_heap function here
    make_heap(arr, n);

    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double, std::milli> elapsed = end - start;
    std::cout << "make_heap for " << n << " elements took " << elapsed.count() << " ms\n";
}

int main() {
    srand(time(nullptr)); // Seed the random number generator

    const int sizes[] = {1000, 10000, 100000, 1000000}; // Different sizes to benchmark

    for (int size : sizes) {
        std::vector<int> data(size);
        generateRandomData(data.data(), size); // Fill the vector with random data

        benchmarkMakeHeap(data.data(), size); // Benchmark make_heap with this data
    }

    return 0;
}

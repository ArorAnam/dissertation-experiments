#include <iostream>
#include <vector>
#include <algorithm>
#include <cstdlib>
#include <chrono>

void benchmark_stl_heap(size_t heap_size, int pop_rate, int duration_seconds) {
    std::vector<int> heap;
    heap.reserve(heap_size + duration_seconds * 100); // Pre-allocate space to avoid reallocation
    srand(time(nullptr)); // Seed with current time

    // Fill the heap with random values
    for (size_t i = 0; i < heap_size; ++i) {
        heap.push_back(rand() % 1000);
    }
    std::make_heap(heap.begin(), heap.end());

    using namespace std::chrono;
    auto start_time = steady_clock::now();
    size_t operations = 0;
    int duration_ms = duration_seconds * 1000;

    while (duration_cast<milliseconds>(steady_clock::now() - start_time).count() < duration_ms) {
        if (rand() % 100 < pop_rate && !heap.empty()) {
            std::pop_heap(heap.begin(), heap.end()); // Move the largest to the end
            heap.pop_back(); // Remove the largest element from the vector
        } else {
            int value = rand() % 1000;
            heap.push_back(value); // Add new value
            std::push_heap(heap.begin(), heap.end()); // Re-heapify
        }
        operations++;
    }

    auto end_time = steady_clock::now();
    auto elapsed_ms = duration_cast<milliseconds>(end_time - start_time).count();
    double ops_per_second = operations / (elapsed_ms / 1000.0);

    std::cout << "Heap Size: " << heap_size << ", Pop Rate: " << pop_rate << "%\n";
    std::cout << "Operations: " << operations << std::endl;
    std::cout << "Elapsed Time (ms): " << elapsed_ms << std::endl;
    std::cout << "Operations per second: " << ops_per_second << std::endl;
    std::cout << "----------------------------------------\n";
}

int main() {
    std::cout << "Entered into main" << std::endl;
    // std::vector<size_t> heap_sizes = {10, 100, 500, 1000, 100000, 500000, 1000000}; // Different heap sizes for benchmarking
    std::vector<size_t> heap_sizes = {1'000'000, 10'000'000, 100'000'000};
    std::vector<int> pop_rates = {1, 5, 10, 20, 50}; // Different pop rates in percentage
    int duration_seconds = 1; // Defined duration for the benchmark

    for (size_t heap_size : heap_sizes) {
        for (int pop_rate : pop_rates) {
            benchmark_stl_heap(heap_size, pop_rate, duration_seconds); // Run each benchmark for 1 second
        }
    }

    return 0;
}

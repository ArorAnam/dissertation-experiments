#define NONIUS_RUNNER
#include <nonius/nonius.h++>

#include "heap.h" // Make sure this includes your heap functions
#include <vector>
#include <cstdlib>
#include <algorithm> // For std::generate

// Benchmark for push_heap
NONIUS_BENCHMARK("push_heap", [](nonius::chronometer meter) {
    std::vector<int> heap;
    // You might want to pre-fill the heap to a certain size for a more meaningful benchmark
    std::generate_n(std::back_inserter(heap), 1000, std::rand);
    make_heap(heap.begin(), heap.end());

    meter.measure([&heap] {
        heap.push_back(std::rand()); // Use a fixed seed for rand() for consistent benchmarks
        push_heap(heap.begin(), heap.end());
        return heap; // Returning to prevent optimization
    });
})

// Benchmark for pop_heap
NONIUS_BENCHMARK("pop_heap", [](nonius::chronometer meter) {
    std::vector<int> heap;
    // Initialize and make a heap here
    std::generate_n(std::back_inserter(heap), 1000, std::rand);
    make_heap(heap.begin(), heap.end());

    meter.measure([&heap] {
        if (!heap.empty()) {
            pop_heap(heap.begin(), heap.end());
            heap.pop_back();
        }
        return heap; // Returning to prevent optimization
    });
})

// Benchmark for make_heap
NONIUS_BENCHMARK("make_heap", [](nonius::chronometer meter) {
    std::vector<int> heap(1000); // Adjust size as needed

    meter.measure([&] {
        std::generate(heap.begin(), heap.end(), std::rand); // Fill with random numbers
        make_heap(heap.begin(), heap.end());
        return heap; // Returning to prevent optimization
    });
})

// Benchmark for sort_heap
NONIUS_BENCHMARK("sort_heap", [](nonius::chronometer meter) {
    std::vector<int> heap;
    // Fill the heap with random elements and then make it a heap
    std::generate_n(std::back_inserter(heap), 1000, std::rand); // Adjust size as needed
    make_heap(heap.begin(), heap.end());

    meter.measure([&heap] {
        sort_heap(heap.begin(), heap.end());
        return heap; // Returning to prevent optimization
    });
})


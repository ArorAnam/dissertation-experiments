#include <benchmark/benchmark.h>
#include "heap.h" // Your heap function declarations
#include <vector>
#include <cstdlib>

// Helper function to prepare a heap with `n` elements
std::vector<int> prepare_heap(int n) {
    std::vector<int> v(n);
    for (int& i : v) {
        i = std::rand(); // Fill the vector with random numbers
    }
    make_heap(v.begin(), v.end()); // Turn the vector into a heap
    return v;
}

// Benchmark for push_heap
static void BM_push_heap(benchmark::State& state) {
    for (auto _ : state) {
        auto v = prepare_heap(state.range(0));
        state.PauseTiming(); // Pause timing to not include preparation time
        v.push_back(std::rand()); // Add a new element to push into the heap
        state.ResumeTiming();
        push_heap(v.begin(), v.end());
    }
}
BENCHMARK(BM_push_heap)->Range(8, 8<<10); // Test with different heap sizes

// Benchmark for pop_heap
static void BM_pop_heap(benchmark::State& state) {
    for (auto _ : state) {
        auto v = prepare_heap(state.range(0) + 1); // Prepare heap with one extra element for popping
        state.PauseTiming();
        push_heap(v.begin(), v.end()); // Ensure there's an element to pop
        state.ResumeTiming();
        pop_heap(v.begin(), v.end());
        v.pop_back(); // Remove the element that was popped to the back
    }
}
BENCHMARK(BM_pop_heap)->Range(8, 8<<10);

// Benchmark for make_heap
static void BM_make_heap(benchmark::State& state) {
    for (auto _ : state) {
        std::vector<int> v(state.range(0));
        for (int& i : v) {
            i = std::rand(); // Fill the vector with random numbers
        }
        make_heap(v.begin(), v.end());
    }
}
BENCHMARK(BM_make_heap)->Range(8, 8<<10);

// Benchmark for sort_heap
static void BM_sort_heap(benchmark::State& state) {
    for (auto _ : state) {
        auto v = prepare_heap(state.range(0)); // Prepare a heap for sorting
        sort_heap(v.begin(), v.end());
    }
}
BENCHMARK(BM_sort_heap)->Range(8, 8<<10);

// Main function that runs the benchmarks
BENCHMARK_MAIN();


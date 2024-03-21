#include <benchmark/benchmark.h>
#include <vector>
#include <algorithm> // For STL heap functions and std::generate
#include <cstdlib>

// Helper function to prepare a heap with `n` elements using STL make_heap
std::vector<int> prepare_stl_heap(int n) {
    std::vector<int> v(n);
    std::generate(v.begin(), v.end(), std::rand); // Fill the vector with random numbers
    std::make_heap(v.begin(), v.end()); // Use STL make_heap
    return v;
}

// Benchmark for std::push_heap
static void BM_stl_push_heap(benchmark::State& state) {
    for (auto _ : state) {
        auto v = prepare_stl_heap(state.range(0));
        state.PauseTiming(); // Pause timing to exclude preparation
        v.push_back(std::rand()); // Add new element
        state.ResumeTiming();
        std::push_heap(v.begin(), v.end());
    }
}
BENCHMARK(BM_stl_push_heap)->Range(8, 8<<10);

// Benchmark for std::pop_heap
static void BM_stl_pop_heap(benchmark::State& state) {
    for (auto _ : state) {
        auto v = prepare_stl_heap(state.range(0) + 1); // Prepare heap with one extra element
        state.PauseTiming();
        std::push_heap(v.begin(), v.end()); // Ensure there's an element to pop
        state.ResumeTiming();
        std::pop_heap(v.begin(), v.end());
        v.pop_back(); // Remove the element moved to the back
    }
}
BENCHMARK(BM_stl_pop_heap)->Range(8, 8<<10);

// Benchmark for std::make_heap
static void BM_stl_make_heap(benchmark::State& state) {
    for (auto _ : state) {
        std::vector<int> v(state.range(0));
        std::generate(v.begin(), v.end(), std::rand); // Fill with random numbers
        std::make_heap(v.begin(), v.end());
    }
}
BENCHMARK(BM_stl_make_heap)->Range(8, 8<<10);

// Benchmark for std::sort_heap
static void BM_stl_sort_heap(benchmark::State& state) {
    for (auto _ : state) {
        auto v = prepare_stl_heap(state.range(0)); // Prepare a heap
        std::sort_heap(v.begin(), v.end());
    }
}
BENCHMARK(BM_stl_sort_heap)->Range(8, 8<<10);

// Main function that runs the benchmarks
BENCHMARK_MAIN();


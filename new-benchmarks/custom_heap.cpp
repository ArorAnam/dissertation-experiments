#include <iostream>
#include <vector>
#include <algorithm>
#include <cstdlib>
#include <chrono>
#include <cmath>

class Heap {
public:
    void push(int value);
    void pop();
    int top() const;
    bool empty() const;
    size_t size() const;

private:
    std::vector<int> data;
    void heapify_up(size_t index);
    void heapify_down(size_t index);
};

void Heap::push(int value) {
    data.push_back(value);
    heapify_up(data.size() - 1);
}

void Heap::pop() {
    if (data.empty()) return;
    std::swap(data.front(), data.back());
    data.pop_back();
    if (!data.empty()) {
        heapify_down(0);
    }
}

int Heap::top() const {
    if (data.empty()) throw std::runtime_error("Heap is empty");
    return data.front();
}

bool Heap::empty() const {
    return data.empty();
}

size_t Heap::size() const {
    return data.size();
}

void Heap::heapify_up(size_t index) {
    while (index != 0) {
        size_t parent = (index - 1) / 2;
        if (data[parent] >= data[index]) break;
        std::swap(data[parent], data[index]);
        index = parent;
    }
}

void Heap::heapify_down(size_t index) {
    size_t child;
    while ((child = 2 * index + 1) < data.size()) {
        if (child + 1 < data.size() && data[child + 1] > data[child]) {
            child++;
        }
        if (data[index] >= data[child]) break;
        std::swap(data[index], data[child]);
        index = child;
    }
}

void benchmark_heap(size_t heap_size, int pop_rate, int duration_seconds) {
    Heap heap;
    srand(time(nullptr)); // Seed with current time

    // Fill the heap with random values
    for (size_t i = 0; i < heap_size; ++i) {
        heap.push(rand() % 1000);
    }

    using namespace std::chrono;
    auto start_time = steady_clock::now();
    size_t operations = 0;
    int duration_ms = duration_seconds * 1000;

    while (duration_cast<milliseconds>(steady_clock::now() - start_time).count() < duration_ms) {
        if (rand() % 100 < pop_rate && !heap.empty()) {
            heap.pop();
        } else {
            heap.push(rand() % 1000);
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
    std::vector<size_t> heap_sizes = {10, 50, 100, 500, 1000}; // Different heap sizes for benchmarking
    std::vector<int> pop_rates = {1, 5, 10, 20, 50}; // Different pop rates in percentage

    for (size_t heap_size : heap_sizes) {
        for (int pop_rate : pop_rates) {
            benchmark_heap(heap_size, pop_rate, 30); // Run each benchmark for 1 second
        }
    }

    return 0;
}

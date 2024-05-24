#include <iostream>
#include <vector>
#include <cstdlib>
#include <ctime>
#include <chrono>

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
    heapify_down(0);
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
    while (index > 0) {
        size_t parent = (index - 1) / 2;
        if (data[index] <= data[parent]) break;
        std::swap(data[index], data[parent]);
        index = parent;
    }
}

void Heap::heapify_down(size_t index) {
    size_t left, right, largest;
    while (true) {
        left = 2 * index + 1;
        right = 2 * index + 2;
        largest = index;

        if (left < data.size() && data[left] > data[largest]) largest = left;
        if (right < data.size() && data[right] > data[largest]) largest = right;

        if (largest == index) break;
        std::swap(data[index], data[largest]);
        index = largest;
    }
}

void benchmark_heap(size_t heap_size, int pop_rate) {
    Heap heap;
    srand(time(nullptr));

    // Fill heap with random values
    for (size_t i = 0; i < heap_size; ++i) {
        heap.push(rand() % heap_size);
    }

    using namespace std::chrono;
    auto start_time = high_resolution_clock::now();

    size_t operations = 0;
    while (duration_cast<seconds>(high_resolution_clock::now() - start_time).count() < 30) {
        if (rand() % 100 < pop_rate && !heap.empty()) {
            heap.pop();
        } else {
            heap.push(rand() % heap_size);
        }
        ++operations;
    }

    auto end_time = high_resolution_clock::now();
    auto duration = duration_cast<milliseconds>(end_time - start_time).count();

    std::cout << "Heap Size: " << heap_size << ", Pop Rate: " << pop_rate << "%\n";
    std::cout << "Operations: " << operations << std::endl;
    std::cout << "Time (ms): " << duration << std::endl;
    std::cout << "Operations per second: " << (operations * 1000.0) / duration << std::endl;
    std::cout << "----------------------------------------\n";
}

int main() {
    std::vector<size_t> heap_sizes = {1000, 10000, 100000};
    std::vector<int> pop_rates = {1, 5, 10}; // Pop rates in percentage

    for (size_t heap_size : heap_sizes) {
        for (int pop_rate : pop_rates) {
            benchmark_heap(heap_size, pop_rate);
        }
    }

    return 0;
}

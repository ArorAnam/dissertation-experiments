#include <algorithm>
#include <iostream>
#include <vector>
#include <fstream>

int main() {
    // Create a vector of integers

    std::vector<int> v;
    std::ifstream file("heap_data.txt"); 
    int value;

    while (file >> value) {
        v.push_back(value);
    }

    // Convert the vector into a max heap
    std::make_heap(v.begin(), v.end());

    // Output the max heap
    std::cout << "Max Heap: ";
    for (int i : v) {
        std::cout << i << " ";
    }
    std::cout << "\n";

    // Add a new element
    v.push_back(99);
    std::push_heap(v.begin(), v.end());

    // Output the max heap after adding a new element
    std::cout << "Max Heap after push: ";
    for (int i : v) {
        std::cout << i << " ";
    }
    std::cout << "\n";

    // Remove the largest element
    std::pop_heap(v.begin(), v.end());
    v.pop_back();

    // Output the max heap after removing the largest element
    std::cout << "Max Heap after pop: ";
    for (int i : v) {
        std::cout << i << " ";
    }
    std::cout << "\n";

    // Check if the container is a heap
    bool isHeap = std::is_heap(v.begin(), v.end());
    std::cout << "Is heap: " << (isHeap ? "Yes" : "No") << "\n";

    // Find the largest subrange that is a max heap
    auto subrange = std::is_heap_until(v.begin(), v.end());
    std::cout << "Largest subrange forming a heap: ";
    for (auto it = v.begin(); it != subrange; ++it) {
        std::cout << *it << " ";
    }
    std::cout << "\n";

    // Sort the heap
    std::sort_heap(v.begin(), v.end());

    // Output the sorted elements
    std::cout << "Final sorted range: ";
    for (int i : v) {
        std::cout << i << " ";
    }
    std::cout << "\n";

    return 0;
}


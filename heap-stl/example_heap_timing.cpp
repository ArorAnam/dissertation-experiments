#include <algorithm>
#include <chrono>
#include <iostream>
#include <vector>
#include <fstream>

int main() {

    std::ifstream file("dataset_1GB.bin", std::ios::binary);
    if (!file) {
        std::cerr << "Error opening file." << std::endl;
        return 1;
    }

    std::vector<int> data;
    int value;
    while (file.read(reinterpret_cast<char*>(&value), sizeof(value))) {
        data.push_back(value);
    }

    file.close();

    //std::generate(data.begin(), data.end(), std::rand);

    auto start = std::chrono::high_resolution_clock::now();

    std::make_heap(data.begin(), data.end());

    for (int i = 0; i < 10000; ++i) {
        data.push_back(std::rand());
        std::push_heap(data.begin(), data.end());
        std::pop_heap(data.begin(), data.end());
        data.pop_back();
    }

    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> elapsed = end - start;

    std::cout << "Elapsed time: " << elapsed.count() << " seconds\n";

    return 0;
}

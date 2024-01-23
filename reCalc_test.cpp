#include "ReCalc.hpp"
#include <iostream>

// Define a simple binary operation functor
struct SumOperation {
  typedef int In;
  typedef int Partial;
  typedef int Out;

  void recalc_combine(Partial &accum, In input) {
    accum += input;
  }

  Out lower(Partial &partial) {
    return partial;
  }
};

int main() {
  // Create an instance of Aggregate using SumOperation
  recalc::Aggregate<SumOperation> aggregator(SumOperation(), 0);

  // Insert some elements
  aggregator.insert(1);
  aggregator.insert(2);
  aggregator.insert(3);

  // Query the aggregate
  std::cout << "Aggregate after inserts: " << aggregator.query() << std::endl;

  // Evict an element and query again
  aggregator.evict();
  std::cout << "Aggregate after eviction: " << aggregator.query() << std::endl;

  return 0;
}

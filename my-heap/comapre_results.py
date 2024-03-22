import json
import matplotlib.pyplot as plt

# Parsing function
def parse_benchmark_results(file_path):
    with open(file_path, 'r') as f:
        data = json.load(f)

    benchmarks = {}
    for bench in data['benchmarks']:
        # Extract the name and size from the benchmark name
        name, size = bench['name'].rsplit('/', 1)
        size = int(size)
        time = bench['cpu_time']
        if name not in benchmarks:
            benchmarks[name] = []
        benchmarks[name].append((size, time))

    # Sort entries by input size
    for bench in benchmarks.values():
        bench.sort()

    return benchmarks

# # Plotting function
# def plot_benchmarks(benchmark1, benchmark2, benchmark_name1, benchmark_name2):
#     sizes1, times1 = zip(*benchmark1[benchmark_name1])
#     sizes2, times2 = zip(*benchmark2[benchmark_name2])

#     plt.figure(figsize=(10, 6))
#     plt.plot(sizes1, times1, label='My Heap')
#     plt.plot(sizes2, times2, label='STL Heap')
#     plt.xlabel('Input Size')
#     plt.ylabel('CPU Time (ns)')
#     plt.title(f'Benchmark Comparison')
#     plt.legend()
#     plt.xscale('log')
#     plt.yscale('log')
#     plt.grid(True, which="both", ls="--")
#     plt.show()

# Plotting function modified to save plots
def plot_benchmarks(benchmark1, benchmark2, benchmark_name1, benchmark_name2):
    sizes1, times1 = zip(*benchmark1[benchmark_name1])
    sizes2, times2 = zip(*benchmark2[benchmark_name2])

    plt.figure(figsize=(10, 6))
    plt.plot(sizes1, times1, label='My Heap')
    plt.plot(sizes2, times2, label='STL Heap')
    plt.xlabel('Input Size')
    plt.ylabel('CPU Time (ns)')
    plt.title(f'Benchmark Comparison: {benchmark_name1} vs {benchmark_name2}')
    plt.legend()
    plt.xscale('log')
    plt.yscale('log')
    plt.grid(True, which="both", ls="--")

    # Save the plot to a file
    filename = f"{benchmark_name1}_vs_{benchmark_name2}.png"
    plt.savefig(filename, bbox_inches='tight')
    plt.close()  # Close the figure to free memory


# Replace 'results.json' and 'stl_results.json' with your actual file paths
my_heap_results = parse_benchmark_results('results.json')
stl_heap_results = parse_benchmark_results('stl_results.json')

# List of benchmarks to compare
benchmarks = [
    ('BM_push_heap', 'BM_stl_push_heap'),
    ('BM_pop_heap', 'BM_stl_pop_heap'),
    ('BM_make_heap', 'BM_stl_make_heap'),
    ('BM_sort_heap', 'BM_stl_sort_heap')
]

# Plot the results for each benchmark
for my_heap_bench, stl_heap_bench in benchmarks:
    plot_benchmarks(my_heap_results, stl_heap_results, my_heap_bench, stl_heap_bench)

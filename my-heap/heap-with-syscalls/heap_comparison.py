import matplotlib.pyplot as plt

# Custom heap results
my_heap_results = """
Heap Size: 10, Pop Rate: 1%
Performed 345 operations in 1.00 seconds (343.96 OP/s)
Push Operations: 338, Pop Operations: 7
Average Time per Operation: 2.9073 ms
----------------------------------------
Heap Size: 10, Pop Rate: 5%
Performed 369 operations in 1.00 seconds (367.82 OP/s)
Push Operations: 346, Pop Operations: 23
Average Time per Operation: 2.7187 ms
----------------------------------------
Heap Size: 10, Pop Rate: 10%
Performed 396 operations in 1.00 seconds (395.16 OP/s)
Push Operations: 356, Pop Operations: 40
Average Time per Operation: 2.5306 ms
----------------------------------------
Heap Size: 10, Pop Rate: 20%
Performed 515 operations in 1.00 seconds (513.13 OP/s)
Push Operations: 395, Pop Operations: 120
Average Time per Operation: 1.9488 ms
----------------------------------------
Heap Size: 10, Pop Rate: 50%
Performed 2457 operations in 1.00 seconds (2455.69 OP/s)
Push Operations: 1237, Pop Operations: 1220
Average Time per Operation: 0.4072 ms
----------------------------------------
Heap Size: 50, Pop Rate: 1%
Performed 308 operations in 1.00 seconds (307.27 OP/s)
Push Operations: 302, Pop Operations: 6
Average Time per Operation: 3.2544 ms
----------------------------------------
Heap Size: 50, Pop Rate: 5%
Performed 327 operations in 1.01 seconds (325.35 OP/s)
Push Operations: 308, Pop Operations: 19
Average Time per Operation: 3.0736 ms
----------------------------------------
Heap Size: 50, Pop Rate: 10%
Performed 350 operations in 1.00 seconds (348.84 OP/s)
Push Operations: 315, Pop Operations: 35
Average Time per Operation: 2.8667 ms
----------------------------------------
Heap Size: 50, Pop Rate: 20%
Performed 446 operations in 1.00 seconds (445.51 OP/s)
Push Operations: 345, Pop Operations: 101
Average Time per Operation: 2.2446 ms
----------------------------------------
Heap Size: 50, Pop Rate: 50%
Performed 1556 operations in 1.00 seconds (1555.73 OP/s)
Push Operations: 785, Pop Operations: 771
Average Time per Operation: 0.6428 ms
----------------------------------------
"""

# STL heap results
stl_heap_results = """
Heap Size: 5916, Pop Rate: 1%
Performed 6026 operations in 1.00 seconds (6023.97 OP/s)
Push Operations: 5966, Pop Operations: 60
Average Time per Operation: 0.1660 ms
----------------------------------------
Heap Size: 5080, Pop Rate: 5%
Performed 5688 operations in 1.00 seconds (5687.20 OP/s)
Push Operations: 5379, Pop Operations: 309
Average Time per Operation: 0.1758 ms
----------------------------------------
Heap Size: 4306, Pop Rate: 10%
Performed 5380 operations in 1.00 seconds (5378.97 OP/s)
Push Operations: 4838, Pop Operations: 542
Average Time per Operation: 0.1859 ms
----------------------------------------
Heap Size: 3006, Pop Rate: 20%
Performed 4896 operations in 1.00 seconds (4894.38 OP/s)
Push Operations: 3946, Pop Operations: 950
Average Time per Operation: 0.2043 ms
----------------------------------------
Heap Size: 65, Pop Rate: 50%
Performed 4921 operations in 1.00 seconds (4919.67 OP/s)
Push Operations: 2488, Pop Operations: 2433
Average Time per Operation: 0.2033 ms
----------------------------------------
Heap Size: 5950, Pop Rate: 1%
Performed 6034 operations in 1.00 seconds (6032.63 OP/s)
Push Operations: 5982, Pop Operations: 52
Average Time per Operation: 0.1658 ms
----------------------------------------
Heap Size: 5205, Pop Rate: 5%
Performed 5717 operations in 1.00 seconds (5716.05 OP/s)
Push Operations: 5451, Pop Operations: 266
Average Time per Operation: 0.1749 ms
----------------------------------------
Heap Size: 4326, Pop Rate: 10%
Performed 5362 operations in 1.00 seconds (5361.42 OP/s)
Push Operations: 4834, Pop Operations: 528
Average Time per Operation: 0.1865 ms
----------------------------------------
Heap Size: 2900, Pop Rate: 20%
Performed 4838 operations in 1.00 seconds (4837.25 OP/s)
Push Operations: 3859, Pop Operations: 979
Average Time per Operation: 0.2067 ms
----------------------------------------
Heap Size: 35, Pop Rate: 50%
Performed 5927 operations in 1.00 seconds (5925.92 OP/s)
Push Operations: 2971, Pop Operations: 2956
Average Time per Operation: 0.1688 ms
----------------------------------------
Heap Size: 5933, Pop Rate: 1%
Performed 6005 operations in 1.00 seconds (6003.58 OP/s)
Push Operations: 5944, Pop Operations: 61
Average Time per Operation: 0.1666 ms
----------------------------------------
Heap Size: 5286, Pop Rate: 5%
Performed 5736 operations in 1.00 seconds (5735.23 OP/s)
Push Operations: 5486, Pop Operations: 250
Average Time per Operation: 0.1744 ms
----------------------------------------
Heap Size: 4459, Pop Rate: 10%
Performed 5409 operations in 1.00 seconds (5407.78 OP/s)
Push Operations: 4909, Pop Operations: 500
Average Time per Operation: 0.1849 ms
----------------------------------------
Heap Size: 3089, Pop Rate: 20%
Performed 4911 operations in 1.00 seconds (4909.65 OP/s)
Push Operations: 3975, Pop Operations: 936
Average Time per Operation: 0.2037 ms
----------------------------------------
Heap Size: 188, Pop Rate: 50%
Performed 4558 operations in 1.00 seconds (4557.26 OP/s)
Push Operations: 2348, Pop Operations: 2210
Average Time per Operation: 0.2194 ms
----------------------------------------
Heap Size: 6017, Pop Rate: 1%
Performed 6021 operations in 1.00 seconds (6020.23 OP/s)
Push Operations: 5969, Pop Operations: 52
Average Time per Operation: 0.1661 ms
----------------------------------------
Heap Size: 5246, Pop Rate: 5%
Performed 5704 operations in 1.00 seconds (5702.98 OP/s)
Push Operations: 5425, Pop Operations: 279
Average Time per Operation: 0.1753 ms
----------------------------------------
Heap Size: 4368, Pop Rate: 10%
Performed 5360 operations in 1.00 seconds (5359.00 OP/s)
Push Operations: 4814, Pop Operations: 546
Average Time per Operation: 0.1866 ms
----------------------------------------
Heap Size: 3023, Pop Rate: 20%
Performed 4861 operations in 1.00 seconds (4859.27 OP/s)
Push Operations: 3892, Pop Operations: 969
Average Time per Operation: 0.2058 ms
----------------------------------------
Heap Size: 136, Pop Rate: 50%
Performed 4488 operations in 1.00 seconds (4487.19 OP/s)
Push Operations: 2262, Pop Operations: 2226
Average Time per Operation: 0.2229 ms
----------------------------------------
"""


def parse_results(results):
    data = []
    lines = results.strip().split("\n")
    for i in range(0, len(lines), 5):
        size_rate = lines[i].split(", ")
        heap_size = int(size_rate[0].split(": ")[1])
        pop_rate = int(size_rate[1].split("%")[0])
        ops_per_sec = float(lines[i + 1].split(" (")[1].split(" OP/s")[0])
        avg_time = float(lines[i + 3].split(": ")[1].split(" ms")[0])
        data.append((heap_size, pop_rate, ops_per_sec, avg_time))
    return data

# Parse the data
my_heap_data = parse_results(my_heap_results)
stl_heap_data = parse_results(stl_heap_results)

def plot_results(my_heap_data, stl_heap_data):
    # Create a dictionary to match data by heap size and pop rate
    my_data = {(d[0], d[1]): d for d in my_heap_data}
    stl_data = {(d[0], d[1]): d for d in stl_heap_data}

    # Filter keys present in both dictionaries
    common_keys = my_data.keys() & stl_data.keys()

    # Extracting the plots data
    plot_data = [(key, my_data[key], stl_data[key]) for key in common_keys]

    # Sorting by heap size then by pop rate for consistent plotting
    plot_data.sort()

    # Plotting
    fig, ax = plt.subplots(2, figsize=(12, 10), sharex=True)
    for (heap_size, pop_rate), my_dat, stl_dat in plot_data:
        ax[0].plot(heap_size, my_dat[2], 'ro-', label=f'My Heap {pop_rate}%')
        ax[0].plot(heap_size, stl_dat[2], 'bx--', label=f'STL Heap {pop_rate}%')

        ax[1].plot(heap_size, my_dat[3], 'ro-', label=f'My Heap {pop_rate}%')
        ax[1].plot(heap_size, stl_dat[3], 'bx--', label=f'STL Heap {pop_rate}%')

    ax[0].set_title("Operations per Second by Heap Size and Pop Rate")
    ax[0].set_ylabel("Operations per Second")
    ax[1].set_title("Average Time per Operation by Heap Size and Pop Rate")
    ax[1].set_ylabel("Average Time per Operation (ms)")
    ax[1].set_xlabel("Heap Size")

    # Legends and layout
    handles, labels = ax[0].get_legend_handles_labels()
    by_label = dict(zip(labels, handles))
    ax[0].legend(by_label.values(), by_label.keys())
    ax[1].legend(by_label.values(), by_label.keys())
    plt.tight_layout()
    plt.show()

plot_results(my_heap_data, stl_heap_data)

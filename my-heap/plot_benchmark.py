import matplotlib.pyplot as plt

def parse_benchmark_output(filename):
    data = {
        "Heap Size": [],
        "Pop Rate": [],
        "Operations per second": []
    }

    with open(filename, 'r') as file:
        lines = file.readlines()

        for i in range(0, len(lines), 4):
            if i + 3 >= len(lines):
                print(f"Skipping incomplete data set starting at line {i}")
                continue

            heap_size_line = lines[i].strip()
            ops_per_sec_line = lines[i + 3].strip()

            try:
                heap_size = int(heap_size_line.split(": ")[1].split(",")[0])
                pop_rate = int(heap_size_line.split(", Pop Rate: ")[1].replace('%', ''))
                ops_per_sec = float(ops_per_sec_line.split(": ")[1])

                data["Heap Size"].append(heap_size)
                data["Pop Rate"].append(pop_rate)
                data["Operations per second"].append(ops_per_sec)
            except (IndexError, ValueError) as e:
                print(f"Error parsing lines starting at line {i}: {e}")
                print(f"heap_size_line: {heap_size_line}")
                print(f"ops_per_sec_line: {ops_per_sec_line}")
                continue

    return data

def plot_benchmark_data(data, output_file):
    fig, ax = plt.subplots()

    for heap_size in sorted(set(data["Heap Size"])):
        x = [pop_rate for hs, pop_rate in zip(data["Heap Size"], data["Pop Rate"]) if hs == heap_size]
        y = [ops_per_sec for hs, ops_per_sec in zip(data["Heap Size"], data["Operations per second"]) if hs == heap_size]
        ax.plot(x, y, marker='o', label=f"Heap Size: {heap_size}")

    ax.set_xlabel("Pop Rate (%)")
    ax.set_ylabel("Operations per second")
    ax.set_title("Heap Operations per Second for Different Heap Sizes and Pop Rates")
    ax.legend()
    ax.grid(True)

    plt.savefig(output_file)
    print(f"Plot saved as {output_file}")

if __name__ == "__main__":
    benchmark_data = parse_benchmark_output("benchmark_3_output.txt")
    plot_benchmark_data(benchmark_data, "heap_benchmark_plot.png")

import pandas as pd
import matplotlib.pyplot as plt

# Data for your custom heap and STL heap
custom_heap_results = [
    {"Heap Size": 10, "Pop Rate": 1, "Operations per second": 2.08886e+07},
    {"Heap Size": 10, "Pop Rate": 5, "Operations per second": 2.0069e+07},
    {"Heap Size": 10, "Pop Rate": 10, "Operations per second": 1.96045e+07},
    {"Heap Size": 10, "Pop Rate": 20, "Operations per second": 1.80203e+07},
    {"Heap Size": 10, "Pop Rate": 50, "Operations per second": 1.98782e+07},
    {"Heap Size": 50, "Pop Rate": 1, "Operations per second": 2.0974e+07},
    {"Heap Size": 50, "Pop Rate": 5, "Operations per second": 2.00509e+07},
    {"Heap Size": 50, "Pop Rate": 10, "Operations per second": 1.95877e+07},
    {"Heap Size": 50, "Pop Rate": 20, "Operations per second": 1.80264e+07},
    {"Heap Size": 50, "Pop Rate": 50, "Operations per second": 1.99666e+07},
    # Add remaining entries for custom heap
]

stl_heap_results = [
    {"Heap Size": 10, "Pop Rate": 1, "Operations per second": 2.13619e+07},
    {"Heap Size": 10, "Pop Rate": 5, "Operations per second": 2.00025e+07},
    {"Heap Size": 10, "Pop Rate": 10, "Operations per second": 1.89193e+07},
    {"Heap Size": 10, "Pop Rate": 20, "Operations per second": 1.72758e+07},
    {"Heap Size": 10, "Pop Rate": 50, "Operations per second": 1.98525e+07},
    {"Heap Size": 50, "Pop Rate": 1, "Operations per second": 2.13585e+07},
    {"Heap Size": 50, "Pop Rate": 5, "Operations per second": 2.02258e+07},
    {"Heap Size": 50, "Pop Rate": 10, "Operations per second": 1.89914e+07},
    {"Heap Size": 50, "Pop Rate": 20, "Operations per second": 1.72733e+07},
    {"Heap Size": 50, "Pop Rate": 50, "Operations per second": 1.95758e+07},
    # Add remaining entries for STL heap
]

# Create DataFrames
df_custom_heap = pd.DataFrame(custom_heap_results)
df_stl_heap = pd.DataFrame(stl_heap_results)

# Merge data for direct comparison
merged_data = pd.merge(df_custom_heap, df_stl_heap, on=["Heap Size", "Pop Rate"], suffixes=('_custom', '_stl'))

# Calculate performance ratio
performance_ratio = merged_data['Operations per second_custom'] / merged_data['Operations per second_stl']

# Plotting the data
fig, ax = plt.subplots(2, 1, figsize=(14, 12))

# Operations per second comparison
ax[0].bar(merged_data.index - 0.2, merged_data['Operations per second_custom'], width=0.4, label='Custom Heap')
ax[0].bar(merged_data.index + 0.2, merged_data['Operations per second_stl'], width=0.4, label='STL Heap')
ax[0].set_xlabel('Comparison Index')
ax[0].set_ylabel('Operations per second')
ax[0].set_title('Operations per Second: Custom vs STL Heap')
ax[0].legend()

# Performance ratio
ax[1].plot(merged_data.index, performance_ratio, label='Performance Ratio (Custom/STL)', marker='o')
ax[1].set_xlabel('Comparison Index')
ax[1].set_ylabel('Performance Ratio (Custom/STL)')
ax[1].set_title('Performance Ratio of Custom Heap to STL Heap')
ax[1].axhline(1, color='red', linestyle='--')  # Add a horizontal line at ratio = 1 for reference
ax[1].legend()

plt.tight_layout()
plt.savefig("heap_comparison.png")  # Save the figure
plt.show()

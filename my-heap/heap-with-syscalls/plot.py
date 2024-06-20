import pandas as pd
import matplotlib.pyplot as plt

# Data from user's heap implementation
my_heap_data = [
    {"Heap Size": 10, "Pop Rate": 1, "OP/s": 343.96, "Avg Time per Op (ms)": 2.9073},
    {"Heap Size": 10, "Pop Rate": 5, "OP/s": 367.82, "Avg Time per Op (ms)": 2.7187},
    {"Heap Size": 10, "Pop Rate": 10, "OP/s": 395.16, "Avg Time per Op (ms)": 2.5306},
    {"Heap Size": 10, "Pop Rate": 20, "OP/s": 513.13, "Avg Time per Op (ms)": 1.9488},
    {"Heap Size": 10, "Pop Rate": 50, "OP/s": 2455.69, "Avg Time per Op (ms)": 0.4072},
    {"Heap Size": 50, "Pop Rate": 1, "OP/s": 307.27, "Avg Time per Op (ms)": 3.2544},
    {"Heap Size": 50, "Pop Rate": 5, "OP/s": 325.35, "Avg Time per Op (ms)": 3.0736},
    {"Heap Size": 50, "Pop Rate": 10, "OP/s": 348.84, "Avg Time per Op (ms)": 2.8667},
    {"Heap Size": 50, "Pop Rate": 20, "OP/s": 445.51, "Avg Time per Op (ms)": 2.2446},
    {"Heap Size": 50, "Pop Rate": 50, "OP/s": 1555.73, "Avg Time per Op (ms)": 0.6428}
]

# Data from STL heap implementation
stl_heap_data = [
    {"Heap Size": 5916, "Pop Rate": 1, "OP/s": 6023.97, "Avg Time per Op (ms)": 0.1660},
    {"Heap Size": 5080, "Pop Rate": 5, "OP/s": 5687.20, "Avg Time per Op (ms)": 0.1758},
    {"Heap Size": 4306, "Pop Rate": 10, "OP/s": 5378.97, "Avg Time per Op (ms)": 0.1859},
    {"Heap Size": 3006, "Pop Rate": 20, "OP/s": 4894.38, "Avg Time per Op (ms)": 0.2043},
    {"Heap Size": 65, "Pop Rate": 50, "OP/s": 4919.67, "Avg Time per Op (ms)": 0.2033}
]

# Creating DataFrames
df_my_heap = pd.DataFrame(my_heap_data)
df_stl_heap = pd.DataFrame(stl_heap_data)

# We'll adjust STL data to match My Heap's small sizes for comparison
stl_heap_adjusted = df_stl_heap[df_stl_heap['Heap Size'] <= 50]

# Re-plotting with emphasis on pop rates to ensure visibility of both datasets

# Filter and sort by Pop Rate for visual consistency
df_my_heap_sorted = df_my_heap.sort_values(by="Pop Rate")
df_stl_heap_sorted = df_stl_heap.sort_values(by="Pop Rate")

# Combine and plot
fig, ax = plt.subplots(2, 1, figsize=(10, 10))

# Operations per second
ax[0].bar(df_my_heap['Pop Rate'] - 0.15, df_my_heap['OP/s'], width=0.3, label='My Heap', color='blue')
ax[0].bar(stl_heap_adjusted['Pop Rate'] + 0.15, stl_heap_adjusted['OP/s'], width=0.3, label='STL Heap', color='red')
ax[0].set_xlabel('Pop Rate (%)')
ax[0].set_ylabel('Operations per second (OP/s)')
ax[0].set_title('Operations per Second by Pop Rate')
ax[0].legend()

# Average Time per Operation
ax[1].bar(df_my_heap['Pop Rate'] - 0.15, df_my_heap['Avg Time per Op (ms)'], width=0.3, label='My Heap', color='blue')
ax[1].bar(stl_heap_adjusted['Pop Rate'] + 0.15, stl_heap_adjusted['Avg Time per Op (ms)'], width=0.3, label='STL Heap', color='red')
ax[1].set_xlabel('Pop Rate (%)')
ax[1].set_ylabel('Average Time per Operation (ms)')
ax[1].set_title('Average Time per Operation by Pop Rate')
ax[1].legend()

plt.tight_layout()
plt.show()

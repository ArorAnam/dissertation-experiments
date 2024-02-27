import numpy as np

dataset_size_bytes = 1 * 1024 * 1024 * 1024  # 1GB
integer_size_bytes = 4  # 4 bytes, 32-bits
num_integers = dataset_size_bytes // integer_size_bytes


dataset = np.random.randint(low=np.iinfo(np.int32).min,
                            high=np.iinfo(np.int32).max,
                            size=num_integers,
                            dtype=np.int32)

file_path = 'dataset_1GB.bin'

dataset.tofile(file_path)

print(f"Dataset of 1 GB has been saved to {file_path}")

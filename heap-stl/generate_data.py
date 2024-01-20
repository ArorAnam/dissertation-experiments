import random

def generate_data(file_name, num_elements, range_min, range_max):
    with open(file_name, 'w') as file:
        for _ in range(num_elements):
            file.write(f"{random.randint(range_min, range_max)}\n")

if __name__ == "__main__":
    FILE_NAME = "heap_data.txt"
    NUM_ELEMENTS = 1000000  # Number of random integers to generate
    RANGE_MIN = 1  # Minimum value of integers
    RANGE_MAX = 100000  # Maximum value of integers

    generate_data(FILE_NAME, NUM_ELEMENTS, RANGE_MIN, RANGE_MAX)
    print(f"Data generated in {FILE_NAME}")


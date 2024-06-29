module max_heap(
    input clk,
    input reset,
    input [7:0] data_in,
    input insert,
    input delete,
    output reg [7:0] data_out,
    output reg heap_full,
    output reg heap_empty
);
    parameter HEAP_SIZE = 16; // Adjust heap size as needed
    reg [7:0] heap [0:HEAP_SIZE-1];
    reg [3:0] heap_count;
    
    integer i;

    // Function to swap two elements in the heap
    task swap;
        input integer idx1;
        input integer idx2;
        reg [7:0] temp;
        begin
            temp = heap[idx1];
            heap[idx1] = heap[idx2];
            heap[idx2] = temp;
        end
    endtask

    // Function to maintain max-heap property after insertion
    task heapify_up;
        input integer idx;
        integer parent_idx;
        begin
            if (idx > 0) begin
                parent_idx = (idx - 1) >> 1;
                if (heap[idx] > heap[parent_idx]) begin
                    swap(idx, parent_idx);
                    heapify_up(parent_idx);
                end
            end
        end
    endtask

    // Function to maintain max-heap property after deletion
    task heapify_down;
        input integer idx;
        integer left_child, right_child, largest;
        begin
            largest = idx;
            left_child = (idx << 1) + 1;
            right_child = (idx << 1) + 2;
            if (left_child < heap_count && heap[left_child] > heap[largest]) begin
                largest = left_child;
            end
            if (right_child < heap_count && heap[right_child] > heap[largest]) begin
                largest = right_child;
            end
            if (largest != idx) begin
                swap(idx, largest);
                heapify_down(largest);
            end
        end
    endtask

    // Main heap operations
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            heap_count <= 0;
            heap_full <= 0;
            heap_empty <= 1;
        end else begin
            if (insert && !heap_full) begin
                heap[heap_count] = data_in;
                heapify_up(heap_count);
                heap_count = heap_count + 1;
                heap_full <= (heap_count == HEAP_SIZE);
                heap_empty <= 0;
            end else if (delete && !heap_empty) begin
                data_out = heap[0];
                heap[0] = heap[heap_count - 1];
                heap_count = heap_count - 1;
                heapify_down(0);
                heap_full <= 0;
                heap_empty <= (heap_count == 0);
            end
        end
    end
endmodule

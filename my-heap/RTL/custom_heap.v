// Define the maximum size of the heap
`define MAX_HEAP_SIZE 32

module heap_module(
    input wire clk,
    input wire reset,
    input wire enable,
    input wire [4:0] operation,  // 0: initialize, 1: push, 2: pop, 3: sort
    input wire [31:0] input_value,
    output reg [31:0] heap_array[`MAX_HEAP_SIZE-1:0],
    output reg [4:0] heap_size
);

// Operation codes
localparam INIT = 0, PUSH = 1, POP = 2, SORT = 3;

integer i, j, largest, l, r, idx;
reg [31:0] temp;

// Initialize heap
always @(posedge clk or posedge reset) begin
    if (reset) begin
        for (i = 0; i < `MAX_HEAP_SIZE; i = i + 1) begin
            heap_array[i] <= 0;
        end
        heap_size <= 0;
    end
    else if (enable) begin
        case (operation)
            INIT: begin
                heap_size <= 0;
            end
            PUSH: begin
                if (heap_size < `MAX_HEAP_SIZE) begin
                    heap_array[heap_size] <= input_value;
                    heap_size <= heap_size + 1;
                    // Rebuild heap after insertion
                    for (j = (heap_size-1)/2; j >= 0; j = j - 1) begin
                        heapify(j, heap_size);
                    end
                end
            end
            POP: begin
                if (heap_size > 0) begin
                    heap_array[0] <= heap_array[heap_size - 1];
                    heap_size <= heap_size - 1;
                    heapify(0, heap_size);
                end
            end
            SORT: begin
                for (idx = heap_size - 1; idx > 0; idx = idx - 1) begin
                    // Swap max to the end
                    temp = heap_array[0];
                    heap_array[0] = heap_array[idx];
                    heap_array[idx] = temp;
                    // Re-heapify the remaining elements
                    heapify(0, idx);
                end
            end
        endcase
    end
end

// Heapify function in Verilog
task heapify(input integer start, input integer size);
    integer current, child, i_temp;
    begin
        current = start;
        child = 2*current + 1; // Left child
        while (child < size) begin
            // Find the largest among root, left child, and right child
            if (child + 1 < size && heap_array[child] < heap_array[child + 1])
                child = child + 1;
            if (heap_array[current] < heap_array[child]) begin
                // Swap
                i_temp = heap_array[current];
                heap_array[current] = heap_array[child];
                heap_array[child] = i_temp;
                // Move down the heap
                current = child;
                child = 2*current + 1;
            end else
                break;
        end
    end
endtask

endmodule

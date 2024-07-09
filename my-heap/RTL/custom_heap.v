`define MAX_HEAP_SIZE 32

module heap_module(
    input clk,
    input reset,
    input enable,
    input [4:0] operation,
    input [31:0] input_value,
    output reg [31:0] heap_array[`MAX_HEAP_SIZE-1:0],
    output reg [4:0] heap_size
);

localparam INIT = 0, PUSH = 1, POP = 2, SORT = 3;

integer i, j, largest, l, r, idx;
reg [31:0] temp;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        for (i = 0; i < `MAX_HEAP_SIZE; i = i + 1) begin
            heap_array[i] <= 0;
        end
        heap_size <= 0;
    end else if (enable) begin
        case (operation)
            INIT: begin
                heap_size <= 0;
            end
            PUSH: begin
                if (heap_size < `MAX_HEAP_SIZE) begin
                    heap_array[heap_size] <= input_value;
                    heap_size <= heap_size + 1;
                    for (j = (heap_size-1)/2; j >= 0; j = j - 1) begin
                        heapify(heap_array, j, heap_size);
                    end
                end
            end
            POP: begin
                if (heap_size > 0) begin
                    heap_array[0] <= heap_array[heap_size - 1];
                    heap_size <= heap_size - 1;
                    heapify(heap_array, 0, heap_size);
                end
            end
            SORT: begin
                for (idx = heap_size - 1; idx > 0; idx = idx - 1) begin
                    temp = heap_array[0];
                    heap_array[0] = heap_array[idx];
                    heap_array[idx] = temp;
                    heapify(heap_array, 0, idx);
                end
            end
        endcase
    end
end

task heapify;
    input [31:0] arr[`MAX_HEAP_SIZE-1:0];
    input integer start;
    input integer size;
    integer current, child, i_temp;
    begin
        current = start;
        child = 2*current + 1;
        while (child < size) begin
            if (child + 1 < size && arr[child] < arr[child + 1])
                child = child + 1;
            if (arr[current] < arr[child]) begin
                i_temp = arr[current];
                arr[current] = arr[child];
                arr[child] = i_temp;
                current = child;
                child = 2*current + 1;
            end else begin
                break;
            end
        end
    end
endtask

endmodule

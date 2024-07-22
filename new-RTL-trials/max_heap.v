module heap(
    input clk,
    input rst_n,
    input push,
    input pop,
    input [7:0] data_in,
    output reg [7:0] data_out,
    output reg empty,
    output reg full
);

    reg [7:0] heap_array [0:7]; // Array of 8 vector registers, each 8 bits wide
    reg [3:0] heap_size;
    reg [3:0] i;

    reg [3:0] state;
    reg [3:0] idx;
    reg [3:0] parent_idx;
    reg [3:0] left_idx;
    reg [3:0] right_idx;
    reg [3:0] largest_idx;

    reg [7:0] temp;

    localparam IDLE = 4'd0,
               PUSH = 4'd1,
               POP = 4'd2,
               HEAPIFY_UP = 4'd3,
               HEAPIFY_DOWN = 4'd4;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            heap_size <= 4'd0;
            empty <= 1'b1;
            full <= 1'b0;
            state <= IDLE;
            for (i = 0; i < 8; i = i + 1) begin
                heap_array[i] <= 8'd0; // Initialize all elements to zero
            end
        end else begin
            case (state)
                IDLE: begin
                    if (push && !full) begin
                        $display("Pushing value %d", data_in);
                        heap_size <= heap_size + 1;
                        heap_array[heap_size] <= data_in; // Add new element at the end
                        empty <= 1'b0;
                        if (heap_size == 4'd7)
                            full <= 1'b1;
                        else
                            full <= 1'b0;
                        state <= HEAPIFY_UP;
                        idx <= heap_size; // Start heapify-up from the newly added element
                    end else if (pop && !empty) begin
                        $display("Popping value %d", heap_array[0]);
                        data_out <= heap_array[0]; // Output the root element
                        heap_array[0] <= heap_array[heap_size-1]; // Move the last element to the root
                        heap_size <= heap_size - 1;
                        full <= 1'b0;
                        if (heap_size == 4'd0)
                            empty <= 1'b1;
                        else
                            empty <= 1'b0;
                        state <= HEAPIFY_DOWN;
                        idx <= 0; // Start heapify-down from the root
                    end
                end

                HEAPIFY_UP: begin
                    parent_idx = (idx - 1) >> 1;
                    if (idx > 0 && heap_array[idx] > heap_array[parent_idx]) begin
                        $display("Heapify up: swapping %d and %d", heap_array[idx], heap_array[parent_idx]);
                        temp = heap_array[idx];
                        heap_array[idx] = heap_array[parent_idx];
                        heap_array[parent_idx] = temp;
                        idx = parent_idx; // Move up to the parent index
                    end else begin
                        state <= IDLE;
                    end
                end

                HEAPIFY_DOWN: begin
                    left_idx = 2*idx + 1;
                    right_idx = 2*idx + 2;
                    largest_idx = idx;

                    if (left_idx < heap_size && heap_array[left_idx] > heap_array[largest_idx])
                        largest_idx = left_idx;
                    if (right_idx < heap_size && heap_array[right_idx] > heap_array[largest_idx])
                        largest_idx = right_idx;

                    if (largest_idx != idx) begin
                        $display("Heapify down: swapping %d and %d", heap_array[idx], heap_array[largest_idx]);
                        temp = heap_array[idx];
                        heap_array[idx] = heap_array[largest_idx];
                        heap_array[largest_idx] = temp;
                        idx = largest_idx; // Move down to the largest child index
                    end else begin
                        state <= IDLE;
                    end
                end

            endcase
        end
    end

endmodule

`define c3_pipe_cycles 5
`define VLEN 128 // Adjust VLEN as needed

module C3_custom_SIMD_instruction (
    input clk,
    input reset,
    input in_v,
    input [4:0] rd,
    input [2:0] vrd1, vrd2,
    input [31:0] in_data,
    input [`VLEN-1:0] in_vdata1, in_vdata2,
    output out_v,
    output [4:0] out_rd,
    output [2:0] out_vrd1, out_vrd2,
    output [31:0] out_data,
    output [`VLEN-1:0] out_vdata1, out_vdata2
);
    reg [`c3_pipe_cycles-1:0] valid_sr;
    reg [5*`c3_pipe_cycles-1:0] rd_sr; 
    reg [3*`c3_pipe_cycles-1:0] vrd1_sr, vrd2_sr;

    always @(posedge clk) begin
        if (reset) begin
            valid_sr <= 0;
            rd_sr <= 0;
            vrd1_sr <= 0;
            vrd2_sr <= 0;
        end else begin
            valid_sr <= (valid_sr << 1) | in_v;            
            rd_sr <= (rd_sr << 5) | rd;
            vrd1_sr <= (vrd1_sr << 3) | vrd1;
            vrd2_sr <= (vrd2_sr << 3) | vrd2;
        end
    end

    assign out_v = valid_sr[`c3_pipe_cycles-1];
    assign out_rd = rd_sr[5*`c3_pipe_cycles-1-:5];
    assign out_vrd1 = vrd1_sr[3*`c3_pipe_cycles-1-:3];
    assign out_vrd2 = vrd2_sr[3*`c3_pipe_cycles-1-:3];

    // Internal registers for heap control
    reg heap_push, heap_pop;
    wire heap_empty, heap_full;
    reg [7:0] heap_data_out;

    // Heap RTL code
    reg [7:0] heap_array [0:15]; // Array of 16 vector registers, each 8 bits wide
    reg [4:0] heap_size;
    reg [4:0] i;

    reg [4:0] state;
    reg [4:0] idx;
    reg [4:0] parent_idx;
    reg [4:0] left_idx;
    reg [4:0] right_idx;
    reg [4:0] largest_idx;

    reg [7:0] temp;

    localparam IDLE = 5'd0,
               PUSH = 5'd1,
               POP = 5'd2,
               HEAPIFY_UP = 5'd3,
               HEAPIFY_DOWN = 5'd4;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            heap_size <= 5'd0;
            state <= IDLE;
            for (i = 0; i < 16; i = i + 1) begin
                heap_array[i] <= 8'd0; // Initialize all elements to zero
            end
        end else begin
            case (state)
                IDLE: begin
                    if (heap_push && !heap_full) begin
                        $display("Pushing value %d", in_data[7:0]);
                        heap_size <= heap_size + 1;
                        heap_array[heap_size] <= in_data[7:0]; // Add new element at the end
                        state <= HEAPIFY_UP;
                        idx <= heap_size; // Start heapify-up from the newly added element
                    end else if (heap_pop && !heap_empty) begin
                        $display("Popping value %d", heap_array[0]);
                        heap_data_out <= heap_array[0]; // Output the root element
                        heap_array[0] <= heap_array[heap_size-1]; // Move the last element to the root
                        heap_size <= heap_size - 1;
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

    // Control logic for heap operations
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            heap_push <= 0;
            heap_pop <= 0;
        end else begin
            // Custom control logic to determine when to push/pop to/from the heap
            // For example, using in_v to trigger push/pop operations
            heap_push <= in_v && !heap_full; // Push if valid and not full
            heap_pop <= !in_v && !heap_empty; // Pop if not valid and not empty
        end
    end

    // Outputs from the heap
    assign out_data = {24'd0, heap_data_out}; // Assuming the heap output is 8-bit
    assign out_vdata1 = 0;
    assign out_vdata2 = 0;

    // Heap status signals
    assign heap_empty = (heap_size == 0);
    assign heap_full = (heap_size == 16);

endmodule // C3_custom_SIMD_instruction

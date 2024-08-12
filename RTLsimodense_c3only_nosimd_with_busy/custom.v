// Template for custom instruction 
// (just increments by 1, no pipeline, with busy signal)

// module C3_custom_instruction (clk, reset, 
// 	in_v, rd, in_data,
// 	out_v, out_rd, out_data, busy);
	
// 	input clk, reset;	
// 	input in_v;
// 	input [4:0] rd;
// 	input [32-1:0] in_data;
		
// 	output reg out_v;
// 	output reg [4:0] out_rd;
// 	output reg [32-1:0] out_data;
// 	output busy;
	 
// 	assign busy = 0;
	
// 	////// USER CODE HERE //////	
// 	always @(posedge clk) begin
// 		if (reset) begin
// 			out_v<=0; out_rd<=0; out_data<=0;
// 		end else begin
// 			out_v<=0;
// 			if (in_v) begin
// 				out_v<=1;
// 				out_rd<=rd;
// 				out_data<=in_data+1;
// 			end				
// 		end
// 	end
			
// endmodule // C3_custom_instruction


`define HEAP_SIZE 32 // Define the heap size
`define HEAP_IDX_WIDTH $clog2(`HEAP_SIZE) // Calculate the necessary bit width

module C3_custom_instruction (
    input clk,
    input reset,
    input in_v,
    input [4:0] rd, // Used to differentiate between push (0) and pop (non-zero)
    input [31:0] in_data,
    output reg out_v,
    output reg [4:0] out_rd, // Pass the destination register ID
    output reg [31:0] out_data,
    output reg busy
);

    // Heap RTL code
    reg [31:0] heap_array [0:`HEAP_SIZE-1]; // Array of HEAP_SIZE vector registers, each 32 bits wide
    reg [`HEAP_IDX_WIDTH-1:0] heap_size;

    reg [4:0] state;
    reg [`HEAP_IDX_WIDTH-1:0] idx;
    reg [`HEAP_IDX_WIDTH-1:0] parent_idx;
    reg [`HEAP_IDX_WIDTH-1:0] left_idx;
    reg [`HEAP_IDX_WIDTH-1:0] right_idx;
    reg [`HEAP_IDX_WIDTH-1:0] largest_idx;

    reg [31:0] temp;
    reg [31:0] heap_data_out;

    localparam IDLE = 5'd0,
               PUSH = 5'd1,
               POP = 5'd2,
               HEAPIFY_UP = 5'd3,
               HEAPIFY_DOWN = 5'd4;

    integer i;
    always @(posedge clk) begin
        if (reset) begin
            heap_size <= 0;
            state <= IDLE;
            out_v <= 0;
            busy <= 0;
            out_data <= 0;
            out_rd <= 5'd0;
            idx <= 0;
            parent_idx <= 0;
            left_idx <= 0;
            right_idx <= 0;
            largest_idx <= 0;
            temp <= 0;
            heap_data_out <= 0;
            for (i = 0; i < `HEAP_SIZE; i = i + 1) begin
                heap_array[i] <= 32'd0; // Initialize all elements to zero
            end
        end else begin
            out_v <= 0; // Default to 0 unless set in specific states
            case (state)
                IDLE: begin
                    busy <= 0;
                    out_v <= 0; // Reset out_v at the start of IDLE
                    if (in_v && rd == 5'd0 && heap_size < `HEAP_SIZE) begin // Push operation
                        $display("Pushing value %d at time %t", in_data, $time);
                        heap_array[heap_size] <= in_data;
                        heap_size <= heap_size + 1;
                        state <= HEAPIFY_UP;
                        idx <= heap_size; // Start heapify-up from the newly added element
                        busy <= 1;
                    end else if (in_v && rd != 5'd0 && heap_size > 0) begin // Pop operation (any rd != x0)
                        $display("Popping value %d at time %t", heap_array[0], $time);
                        heap_data_out <= heap_array[0]; // Output the root element
                        heap_array[0] <= heap_array[heap_size-1]; // Move the last element to the root
                        heap_size <= heap_size - 1;
                        state <= HEAPIFY_DOWN;
                        idx <= 0; // Start heapify-down from the root
                        out_rd <= rd; // Pass the destination register ID
                        busy <= 1;
                    end
                end

                HEAPIFY_UP: begin
                    parent_idx = (idx - 1) >> 1;
                    if (idx > 0 && heap_array[idx] > heap_array[parent_idx]) begin
                        // $display("Heapify up: swapping %d and %d at time %t", heap_array[idx], heap_array[parent_idx], $time);
                        temp = heap_array[idx];
                        heap_array[idx] = heap_array[parent_idx];
                        heap_array[parent_idx] = temp;
                        idx = parent_idx; // Move up to the parent index
                    end else begin
                        state <= IDLE;
                        busy <= 0;
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
                        // $display("Heapify down: swapping %d and %d at time %t", heap_array[idx], heap_array[largest_idx], $time);
                        temp = heap_array[idx];
                        heap_array[idx] = heap_array[largest_idx];
                        heap_array[largest_idx] = temp;
                        idx = largest_idx; // Move down to the largest child index
                    end else begin
                        out_v <= 1; // Set out_v when HEAPIFY_DOWN is done
                        out_data <= heap_data_out; // Assign the popped value to the register
                        state <= IDLE;
                        busy <= 0;
                    end
                end

                default: begin
                    state <= IDLE;
                    busy <= 0;
                end
            endcase
        end
    end
endmodule // C3_custom_instruction


`define c3_pipe_cycles 1

// Template for custom Heap instruction
module C3_custom_heap_instruction (
    clk, reset,
    in_v, rd, vrd1, vrd2,
    in_data, in_heap_addr, in_heap_size,
    out_v, out_rd, out_vrd1, out_vrd2,
    out_data, out_heap_addr, out_heap_size
);
    input clk, reset;
    input in_v;  // Valid signal for instruction
    input [4:0] rd;
    input [2:0] vrd1, vrd2;
    input [31:0] in_data;  // Input data, used for pushHeap
    input [31:0] in_heap_addr;  // Starting address of heap in memory
    input [31:0] in_heap_size;  // Number of elements in the heap

    output reg out_v;
    output [4:0] out_rd;
    output [2:0] out_vrd1, out_vrd2;
    output [31:0] out_data;
    output [31:0] out_heap_addr;
    output [31:0] out_heap_size;

    reg [`c3_pipe_cycles-1:0] valid_sr;
    reg [5*`c3_pipe_cycles-1:0] rd_sr;
    reg [3*`c3_pipe_cycles-1:0] vrd1_sr, vrd2_sr;

    always @(posedge clk) begin
        if (reset) begin
            valid_sr <= 0; rd_sr <= 0; vrd1_sr <= 0; vrd2_sr <= 0;
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

    reg [31:0] heap_mem [0:1023];  // Simplified heap memory model
    integer i;

    always @(posedge clk) begin
        if (in_v) begin
            case (vrd1)  // Operation type encoded in vrd1
                3'b000: begin  // pushHeap
                    heap_mem[in_heap_size] <= in_data;
                    out_heap_size <= in_heap_size + 1;
                end
                3'b001: begin  // popHeap
                    if (in_heap_size > 0) begin
                        out_data <= heap_mem[0];
                        for (i = 0; i < in_heap_size - 1; i = i + 1) begin
                            heap_mem[i] = heap_mem[i + 1];  // Simplified shift
                        end
                        out_heap_size <= in_heap_size - 1;
                    end
                end
                // Add other cases for heapify, make_heap, heapSort
            endcase
        end
    end

    assign out_data = 0;  // Default output
    assign out_heap_addr = in_heap_addr;  // Pass-through heap address

endmodule // C3_custom_heap_instruction

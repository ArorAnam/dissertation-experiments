`define c3_pipe_cycles 1

// Template for custom Heap instruction
module C3_custom_heap_instruction (
    input clk,
    input reset,
    input in_v,  // Valid signal for instruction
    input [4:0] rd,
    input [2:0] vrd1, vrd2,
    input [31:0] in_data,  // Input data, used for pushHeap
    input [31:0] in_heap_addr,  // Starting address of heap in memory
    input [31:0] in_heap_size,  // Number of elements in the heap
    output reg out_v,
    output [4:0] out_rd,
    output [2:0] out_vrd1, out_vrd2,
    output reg [31:0] out_data,
    output reg [31:0] out_heap_addr,
    output reg [31:0] out_heap_size
);

    reg [`c3_pipe_cycles-1:0] valid_sr;
    reg [5*`c3_pipe_cycles-1:0] rd_sr;
    reg [3*`c3_pipe_cycles-1:0] vrd1_sr, vrd2_sr;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            valid_sr <= 0;
            rd_sr <= 0;
            vrd1_sr <= 0;
            vrd2_sr <= 0;
            out_data <= 0;
            out_heap_size <= 0;
            out_heap_addr <= 0;
            out_v <= 0;
        end else begin
            valid_sr <= (valid_sr << 1) | in_v;
            rd_sr <= (rd_sr << 5) | rd;
            vrd1_sr <= (vrd1_sr << 3) | vrd1;
            vrd2_sr <= (vrd2_sr << 3) | vrd2;
            out_v <= valid_sr[`c3_pipe_cycles-1];
            out_rd <= rd_sr[5*`c3_pipe_cycles-1:5*(`c3_pipe_cycles-1)+5];
            out_vrd1 <= vrd1_sr[3*`c3_pipe_cycles-1:3*(`c3_pipe_cycles-1)+3];
            out_vrd2 <= vrd2_sr[3*`c3_pipe_cycles-1:3*(`c3_pipe_cycles-1)+3];
        end
    end

    // Heap logic block
    reg [31:0] heap_mem [0:1023];  // Simplified heap memory model
    integer i;
    always @(posedge clk) begin
        if (in_v) begin
            case (vrd1)  // Operation type encoded in vrd1
                3'b000: begin  // pushHeap
                    heap_mem[in_heap_size] <= in_data;
                    out_heap_size <= in_heap_size + 1;
                    out_heap_addr <= in_heap_addr;
                end
                3'b001: begin  // popHeap
                    if (in_heap_size > 0) begin
                        out_data <= heap_mem[0];
                        heap_mem[0] <= heap_mem[in_heap_size - 1];
                        out_heap_size <= in_heap_size - 1;
                        out_heap_addr <= in_heap_addr;
                        // Shuffle the heap down
                        for (i = 0; i < out_heap_size; i = i + 1) begin
                            heap_mem[i] = heap_mem[i + 1];  // Simplified shift
                        end
                    end
                end
                // Add other cases for heapify, make_heap, heapSort if needed
            endcase
        end
    end

endmodule

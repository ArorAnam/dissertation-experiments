`define c3_pipe_cycles 5
`define HEAP_SIZE 256  // Define the size of the heap array and the loop safety limit

module C3_custom_SIMD_instruction (
    clk, reset,
    in_v, rd, vrd1, vrd2,
    in_data, in_vdata1, in_vdata2,
    out_v, out_rd, out_vrd1, out_vrd2,
    out_data, out_vdata1, out_vdata2
);
    input clk, reset;

    input in_v;
    input [4:0] rd;
    input [2:0] vrd1, vrd2;
    input [31:0] in_data;
    input [`VLEN-1:0] in_vdata1, in_vdata2;

    output reg out_v;
    output [4:0] out_rd;
    output [2:0] out_vrd1, out_vrd2;
    output reg [31:0] out_data;
    output [`VLEN-1:0] out_vdata1, out_vdata2;

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

    ////// USER CODE HERE //////

    reg [31:0] heap_array[0:`HEAP_SIZE-1];  // Heap array
    integer n = 0;
    reg [7:0] i, parent, child;
    reg [31:0] temp;
    integer count;
    reg exit_loop;
    reg busy;

    always @(posedge clk) begin
        if (reset) begin
            n <= 0;
            busy <= 0;
            out_v <= 0;
            out_data <= 0;
            for (i = 0; i < `HEAP_SIZE; i = i + 1) begin
                heap_array[i] <= 0;
            end
        end else if (in_v && !busy) begin
            busy <= 1;
            case (vrd1)  // Assuming op_code is now mapped to vrd1
                1: begin  // Push operation
                    heap_array[n] <= in_data;
                    i <= n;
                    n <= n + 1;
                    count = 0;
                    exit_loop = 0;
                    while (i > 0 && count < `HEAP_SIZE && !exit_loop) begin
                        parent = (i - 1) >> 1;
                        if (heap_array[i] > heap_array[parent]) begin
                            temp = heap_array[i];
                            heap_array[i] = heap_array[parent];
                            heap_array[parent] = temp;
                            i = parent;
                        end else begin
                            exit_loop = 1;  // Used instead of 'break'
                        end
                        count = count + 1;
                    end
                    busy <= 0;
                end
                2: begin  // Pop operation
                    if (n > 0) begin
                        out_data <= heap_array[0];
                        out_v <= 1;
                        n <= n - 1;
                        heap_array[0] = heap_array[n];
                        i = 0;
                        count = 0;
                        exit_loop = 0;
                        while ((i << 1) + 1 < n && count < `HEAP_SIZE && !exit_loop) begin
                            child = (i << 1) + 1;
                            if (child + 1 < n && heap_array[child + 1] > heap_array[child]) child = child + 1;
                            if (heap_array[child] > heap_array[i]) begin
                                temp = heap_array[i];
                                heap_array[i] = heap_array[child];
                                heap_array[child] = temp;
                                i = child;
                            end else begin
                                exit_loop = 1;  // Used instead of 'break'
                            end
                            count = count + 1;
                        end
                        busy <= 0;
                    end else begin
                        out_v <= 0;
                        busy <= 0;
                    end
                end
            endcase
        end
    end
endmodule // C3_custom_SIMD_instruction

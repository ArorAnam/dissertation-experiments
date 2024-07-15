module HeapManagement(
    input clk,
    input reset,
    input [2:0] op_code,  // Operation codes: 1 = push, 2 = pop
    input valid_in,
    input [31:0] data_in,
    output reg valid_out,
    output reg [31:0] data_out,
    output reg busy
);

    reg [31:0] heap_array [0:255];  // Heap array
    integer n = 0;
    reg [7:0] i, parent, child;
    reg [31:0] temp;
    integer count;
    reg exit_loop;

    always @(posedge clk) begin
        if (reset) begin
            n <= 0;
            busy <= 0;
            valid_out <= 0;
            data_out <= 0;
            for (i = 0; i < 256; i = i + 1) begin
                heap_array[i] <= 0;
            end
        end else if (valid_in && !busy) begin
            busy <= 1;
            case (op_code)
                1: begin  // Push operation
                    heap_array[n] <= data_in;
                    i <= n;
                    n <= n + 1;
                    count = 0;
                    exit_loop = 0;
                    while (i > 0 && count < 256 && !exit_loop) begin
                        parent = (i - 1) >> 1;
                        if (heap_array[i] > heap_array[parent]) begin
                            temp = heap_array[i];
                            heap_array[i] = heap_array[parent];
                            heap_array[parent] = temp;
                            i = parent;
                        end else begin
                            exit_loop = 1; // Used instead of 'break'
                        end
                        count = count + 1;
                    end
                    busy <= 0;
                end
                2: begin  // Pop operation
                    if (n > 0) begin
                        data_out <= heap_array[0];
                        valid_out <= 1;
                        n <= n - 1;
                        heap_array[0] = heap_array[n];
                        i = 0;
                        count = 0;
                        exit_loop = 0;
                        while ((i << 1) + 1 < n && count < 256 && !exit_loop) begin
                            child = (i << 1) + 1;
                            if (child + 1 < n && heap_array[child + 1] > heap_array[child]) child = child + 1;
                            if (heap_array[child] > heap_array[i]) begin
                                temp = heap_array[i];
                                heap_array[i] = heap_array[child];
                                heap_array[child] = temp;
                                i = child;
                            end else begin
                                exit_loop = 1; // Used instead of 'break'
                            end
                            count = count + 1;
                        end
                        busy <= 0;
                    end else begin
                        valid_out <= 0;
                        busy <= 0;
                    end
                end
            endcase
        end
    end
endmodule

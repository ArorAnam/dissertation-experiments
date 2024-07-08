module heap_control (
    input clk,
    input reset,
    input start,
    input [1:0] instruction, // 01: Push, 10: Pop
    input [31:0] key,
    output reg done,
    output reg [9:0] n,
    output reg [31:0] arr_out,
    output reg [9:0] index
);

    reg [31:0] arr [1023:0];
    reg [31:0] temp;
    reg [9:0] i, largest, l, r;
    reg [3:0] state;

    localparam IDLE = 0,
               PUSH = 1,
               POP = 2,
               HEAPIFY = 3,
               MAKE_HEAP = 4,
               DONE = 5;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
            n <= 0;
            index <= 0;
            for (i = 0; i < 1024; i = i + 1) arr[i] <= 0;
        end else begin
            case (state)
                IDLE:
                    if (start) begin
                        done <= 0;
                        if (instruction == 2'b01)
                            state <= PUSH;
                        else if (instruction == 2'b10)
                            state <= POP;
                    end
                PUSH:
                    if (n < 1024) begin
                        arr[n] <= key;
                        n <= n + 1;
                        i <= n >> 1;
                        state <= HEAPIFY;
                    end
                POP:
                    if (n > 0) begin
                        arr[0] <= arr[n - 1];
                        n <= n - 1;
                        state <= HEAPIFY;
                        i <= 0;
                    end
                HEAPIFY:
                    if (i < n) begin
                        largest = i;
                        l = 2 * i + 1;
                        r = 2 * i + 2;
                        if (l < n && arr[l] > arr[largest]) largest = l;
                        if (r < n && arr[r] > arr[largest]) largest = r;
                        if (largest != i) begin
                            temp = arr[i];
                            arr[i] = arr[largest];
                            arr[largest] = temp;
                            i = largest; // Continue heapifying down the tree
                        end else state = DONE; // Heapify complete
                    end else state = DONE;
                DONE:
                    begin
                        done <= 1;
                        state <= IDLE;
                    end
            endcase
        end
    end
endmodule

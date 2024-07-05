module heap_control (
    input clk,
    input reset,
    input start,
    input [1:0] instruction, // 00: No-op, 01: Push, 10: Pop
    input [31:0] key,
    output reg done,
    output reg [9:0] n,
    output reg [31:0] arr_out
);

    reg [31:0] arr [0:1023];
    reg [31:0] temp;
    reg [9:0] i, largest, l, r;
    reg [2:0] state;

    localparam IDLE = 0,
               INIT = 1,
               HEAPIFY = 2,
               MAKE_HEAP = 3,
               PUSH = 4,
               POP = 5,
               DONE = 6;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
            n <= 0;
            arr_out <= 0;
            for (i = 0; i < 1024; i = i + 1) arr[i] <= 0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    if (start) state <= INIT;
                end
                INIT: begin
                    if (instruction == 2'b01) state <= PUSH;
                    else if (instruction == 2'b10) state <= POP;
                    else state <= DONE;
                end
                PUSH: begin
                    arr[n] <= key;
                    n <= n + 1;
                    state <= MAKE_HEAP;
                    i <= (n - 1) >> 1;
                end
                POP: begin
                    arr[0] <= arr[n - 1];
                    n <= n - 1;
                    state <= HEAPIFY;
                    i <= 0;
                end
                MAKE_HEAP: begin
                    if (i > 0) begin
                        i <= i - 1;
                        state <= HEAPIFY;
                    end else state <= DONE;
                end
                HEAPIFY: begin
                    largest = i;
                    l = (i << 1) + 1;
                    r = l + 1;
                    if (l < n && arr[l] > arr[largest]) largest = l;
                    if (r < n && arr[r] > arr[largest]) largest = r;
                    if (largest != i) begin
                        temp = arr[i];
                        arr[i] = arr[largest];
                        arr[largest] = temp;
                        i <= largest;
                    end else state <= MAKE_HEAP;
                end
                DONE: begin
                    done <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (done && n > 0) arr_out <= arr[0]; // Output the root of the heap
    end
endmodule

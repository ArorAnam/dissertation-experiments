module heap_control (
    input clk,
    input reset,
    input start,
    input [1:0] instruction, // 00: No-op, 01: Push, 10: Pop
    input [31:0] key,
    output reg done,
    output reg [9:0] n,
    output reg [31:0] arr_out,
    output reg [9:0] index
);

    reg [31:0] arr [0:1023]; // Heap array
    reg [31:0] temp; // Temporary variable for swapping elements
    reg [9:0] i, largest, l, r; // Indices for heap operations
    reg [2:0] state; // State register

    localparam IDLE = 3'b000,
               INIT = 3'b001,
               HEAPIFY = 3'b010,
               MAKE_HEAP = 3'b011,
               PUSH = 3'b100,
               POP = 3'b101,
               DONE = 3'b110;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
            n <= 0;
            index <= 0;
            for (i = 0; i < 1024; i = i + 1) begin
                arr[i] <= 0;
            end
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    index <= 0;
                    if (start) begin
                        state <= INIT;
                    end
                end

                INIT: begin
                    if (instruction == 2'b01) // push
                        state <= PUSH;
                    else if (instruction == 2'b10) // pop
                        state <= POP;
                    else
                        state <= DONE;
                end

                HEAPIFY: begin
                    largest = i;
                    l = (i << 1) + 1; // l = 2 * i + 1
                    r = (i << 1) + 2; // r = 2 * i + 2
                    if (l < n && arr[l] > arr[largest])
                        largest = l;
                    if (r < n && arr[r] > arr[largest])
                        largest = r;
                    if (largest != i) begin
                        temp = arr[i];
                        arr[i] = arr[largest];
                        arr[largest] = temp;
                        i <= largest;
                    end else begin
                        state <= MAKE_HEAP;
                    end
                end

                MAKE_HEAP: begin
                    if (i > 0) begin
                        i <= i - 1;
                        state <= HEAPIFY;
                    end else begin
                        state <= DONE;
                    end
                end

                PUSH: begin
                    n <= n + 1;
                    arr[n] <= key;
                    i <= (n - 1) >> 1; // i = (n + 1) / 2 - 1 without division
                    state <= MAKE_HEAP;
                end

                POP: begin
                    arr[0] <= arr[n - 1];
                    n <= n - 1;
                    i <= 0;
                    state <= HEAPIFY;
                end

                DONE: begin
                    done <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end

    // Output array elements one by one
    always @(posedge clk) begin
        if (done && index < n) begin
            arr_out <= arr[index];
            index <= index + 1;
        end
    end
endmodule

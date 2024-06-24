module heap_control (
    input clk,
    input reset,
    input start,
    input [31:0] key,
    input op, // 0 for push, 1 for pop
    output reg done,
    output reg [9:0] n,
    output reg [31:0] arr_out,
    output reg [9:0] index
);

    reg [31:0] arr [0:1023];
    reg [31:0] temp;
    reg [9:0] i, largest, l, r;
    reg [2:0] state;

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
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    if (start) begin
                        state <= INIT;
                    end
                end

                INIT: begin
                    if (op == 0) // push
                        state <= PUSH;
                    else // pop
                        state <= POP;
                end

                HEAPIFY: begin
                    largest <= i;
                    l <= 2 * i + 1;
                    r <= 2 * i + 2;
                    if (l < n && arr[l] > arr[largest])
                        largest <= l;
                    if (r < n && arr[r] > arr[largest])
                        largest <= r;
                    if (largest != i) begin
                        temp <= arr[i];
                        arr[i] <= arr[largest];
                        arr[largest] <= temp;
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
                    i <= (n + 1) / 2 - 1;
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
                    index <= 0;
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

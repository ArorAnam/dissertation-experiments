module heap_control (
    input clk,
    input reset,
    input start,
    input [31:0] key,
    input op, // 0 for push, 1 for pop
    output reg done,
    output reg [31:0] arr [0:1023],
    output reg [9:0] n
);

    reg [31:0] temp_arr [0:1023];
    reg [31:0] element;
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
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    if (start) begin
                        temp_arr <= arr;
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
                    largest = i;
                    l = 2 * i + 1;
                    r = 2 * i + 2;
                    if (l < n && temp_arr[l] > temp_arr[largest])
                        largest = l;
                    if (r < n && temp_arr[r] > temp_arr[largest])
                        largest = r;
                    if (largest != i) begin
                        element = temp_arr[i];
                        temp_arr[i] = temp_arr[largest];
                        temp_arr[largest] = element;
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
                        arr <= temp_arr;
                        state <= DONE;
                    end
                end

                PUSH: begin
                    n <= n + 1;
                    temp_arr[n] <= key;
                    i <= (n + 1) / 2 - 1;
                    state <= MAKE_HEAP;
                end

                POP: begin
                    temp_arr[0] <= temp_arr[n - 1];
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
endmodule
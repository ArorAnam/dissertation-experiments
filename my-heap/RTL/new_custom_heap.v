module HeapManagement(
    input clk,
    input reset,
    input [2:0] op_code,  // Operation codes like init (0), push (1), pop (2), etc.
    input valid_in,
    input [31:0] data_in,
    output reg valid_out,
    output reg [31:0] data_out,
    output reg busy
);

    reg [31:0] heap_array [0:255]; // Adjust size as needed
    integer n;
    reg [7:0] idx, child, parent;
    reg [31:0] temp_data;
    reg [3:0] state;

    // Use for random initial values and testing
    reg [31:0] random_value;
    wire [31:0] next_random_value;
    assign next_random_value = random_value * 1664525 + 1013904223; // Linear congruential generator

    // State definitions
    localparam IDLE = 0,
               INIT = 1,
               PUSH = 2,
               POP = 3,
               HEAPIFY = 4,
               MAKE_HEAP = 5,
               SORT = 6,
               SORT_POP = 7,
               FINISHED = 8;

    always @(posedge clk) begin
        if (reset) begin
            n <= 0;
            valid_out <= 0;
            busy <= 0;
            state <= IDLE;
            for (idx = 0; idx < 256; idx = idx + 1) begin
                heap_array[idx] <= 0;
            end
            random_value <= 32'h12345678; // Initial seed
        end else begin
            case (state)
                IDLE: begin
                    if (valid_in && !busy) begin
                        busy <= 1;
                        case (op_code)
                            0: state <= INIT;
                            1: state <= PUSH;
                            2: state <= POP;
                            3: state <= HEAPIFY;
                            4: state <= SORT;
                        endcase
                    end
                end
                INIT: begin
                    for (idx = 0; idx < 256; idx = idx + 1) begin
                        heap_array[idx] <= next_random_value; // Random initial values for testing
                        random_value <= next_random_value;
                    end
                    n <= 256; // Assume full capacity for random init
                    state <= FINISHED;
                end
                PUSH: begin
                    heap_array[n] <= data_in;
                    n <= n + 1;
                    idx <= (n >> 1) - 1; // Use shift for division by 2
                    state <= MAKE_HEAP;
                end
                POP: begin
                    if (n > 0) begin
                        data_out <= heap_array[0];
                        valid_out <= 1;
                        heap_array[0] <= heap_array[n - 1];
                        n <= n - 1;
                        idx <= 0;
                        state <= HEAPIFY;
                    end else begin
                        state <= FINISHED;
                    end
                end
                HEAPIFY: begin
                    if ((idx << 1) + 1 < n) begin
                        child = (idx << 1) + 1;
                        if (child + 1 < n && heap_array[child + 1] > heap_array[child])
                            child = child + 1;
                        if (heap_array[child] > heap_array[idx]) begin
                            temp_data = heap_array[idx];
                            heap_array[idx] = heap_array[child];
                            heap_array[child] = temp_data;
                            idx = child;
                        end else begin
                            state <= FINISHED;
                        end
                    end else begin
                        state <= FINISHED;
                    end
                end
                MAKE_HEAP: begin
                    if (idx >= 0) begin
                        parent = idx;
                        idx = idx - 1;
                        state <= HEAPIFY;
                        heapify(parent, n);
                    end else begin
                        state <= FINISHED;
                    end
                end
                SORT: begin
                    idx = n - 1;
                    state <= SORT_POP;
                end
                SORT_POP: begin
                    if (idx > 0) begin
                        temp_data = heap_array[0];
                        heap_array[0] = heap_array[idx];
                        heap_array[idx] = temp_data;
                        heapify(0, idx);
                        idx = idx - 1;
                    end else begin
                        state <= FINISHED;
                    end
                end
                FINISHED: begin
                    busy <= 0;
                    valid_out <= 0;
                    state <= IDLE;
                end
            endcase
        end
    end

    // Non-blocking heapify function
    task heapify;
        input integer i;
        input integer n;
        begin
            integer l, r;
            l = (i << 1) + 1;
            r = (i << 1) + 2;
            parent = i;
            if (l < n && heap_array[l] > heap_array[parent]) parent = l;
            if (r < n && heap_array[r] > heap_array[parent]) parent = r;
            if (parent != i) begin
                // Swap elements
                temp_data = heap_array[i];
                heap_array[i] = heap_array[parent];
                heap_array[parent] = temp_data;
                heapify(parent, n);
            end
        end
    endtask

endmodule

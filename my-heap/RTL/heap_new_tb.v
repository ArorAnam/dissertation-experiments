`timescale 1ns / 1ps

module heap_operations_tb;

    reg clk;
    reg reset;
    reg start;
    reg [1:0] instruction; // 00: No-op, 01: Push, 10: Pop
    reg [31:0] key;
    wire done;
    wire [31:0] arr_out;
    wire [9:0] n;
    wire [9:0] index;

    heap_control uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .instruction(instruction),
        .key(key),
        .done(done),
        .arr_out(arr_out),
        .n(n),
        .index(index)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        $monitor("Time=%0d, State=%0d, Done=%0d, N=%0d, Key=%0d, Instruction=%0d", $time, uut.state, done, n, key, instruction);
        reset = 1;
        start = 0;
        instruction = 2'b00;
        key = 0;
        #10;
        reset = 0;
        #10;

        // Initialize the heap with random values
        for (integer j = 0; j < 10; j = j + 1) begin
            uut.arr[j] = $random % 100;
        end
        uut.n = 10;

        // VCD dump commands
        $dumpfile("heap_operations_tb.vcd");
        $dumpvars(0, heap_operations_tb);

        // Start make_heap
        start = 1;
        instruction = 2'b00; // No-op to trigger make_heap
        #10;
        start = 0;
        wait(done);
        #10; // Ensure state transitions
        $display("Heap after make_heap:");
        for (integer i = 0; i < uut.n; i = i + 1) begin
            $display("%d", uut.arr[i]);
        end

        // Start push_heap
        key = 15;
        instruction = 2'b01; // Push
        start = 1;
        #10;
        start = 0;
        wait(done);
        #10; // Ensure state transitions
        $display("Heap after push_heap:");
        for (integer i = 0; i < uut.n; i = i + 1) begin
            $display("%d", uut.arr[i]);
        end

        // Start pop_heap
        instruction = 2'b10; // Pop
        start = 1;
        #10;
        start = 0;
        wait(done);
        #10; // Ensure state transitions
        $display("Heap after pop_heap:");
        for (integer i = 0; i < uut.n; i = i + 1) begin
            $display("%d", uut.arr[i]);
        end

        $finish;
    end
endmodule

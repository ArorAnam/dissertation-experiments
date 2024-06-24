`timescale 1ns / 1ps

module heap_operations_tb;

    reg clk;
    reg reset;
    reg start;
    reg [31:0] key;
    reg op; // 0 for push, 1 for pop
    wire done;
    reg [31:0] arr [0:1023];
    wire [31:0] out_arr [0:1023];
    wire [9:0] n;

    heap_control uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .key(key),
        .op(op),
        .done(done),
        .arr(arr),
        .n(n)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        reset = 1;
        start = 0;
        op = 0;
        #10;
        reset = 0;
        #10;

        // Initialize the heap with random values
        arr[0] = 10; arr[1] = 20; arr[2] = 5; arr[3] = 6; arr[4] = 1;
        arr[5] = 8; arr[6] = 9; arr[7] = 4; arr[8] = 7; arr[9] = 2;
        uut.n = 10;

        // VCD dump commands
        $dumpfile("heap_operations_tb.vcd");
        $dumpvars(0, heap_operations_tb);

        // Start make_heap
        start = 1;
        #10;
        start = 0;
        wait(done);
        $display("Heap after make_heap:");
        for (integer i = 0; i < n; i = i + 1) begin
            $display("%d", out_arr[i]);
        end

        // Start push_heap
        key = 15;
        op = 0;
        start = 1;
        #10;
        start = 0;
        wait(done);
        $display("Heap after push_heap:");
        for (integer i = 0; i < n; i = i + 1) begin
            $display("%d", out_arr[i]);
        end

        // Start pop_heap
        op = 1;
        start = 1;
        #10;
        start = 0;
        wait(done);
        $display("Heap after pop_heap:");
        for (integer i = 0; i < n; i = i + 1) begin
            $display("%d", out_arr[i]);
        end

        $finish;
    end
endmodule

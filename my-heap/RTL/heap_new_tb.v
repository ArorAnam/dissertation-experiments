`timescale 1ns / 1ps

module heap_operations_tb;

    reg clk;
    reg reset;
    reg start;
    reg [31:0] key;
    reg op; // 0 for push, 1 for pop
    wire done;
    wire [31:0] arr_out;
    wire [9:0] n;
    wire [9:0] index;

    heap_control uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .key(key),
        .op(op),
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
        reset = 1;
        start = 0;
        op = 0;
        #10;
        reset = 0;
        #10;

        // Initialize the heap with random values
        uut.arr[0] = 10; uut.arr[1] = 20; uut.arr[2] = 5; uut.arr[3] = 6; uut.arr[4] = 1;
        uut.arr[5] = 8; uut.arr[6] = 9; uut.arr[7] = 4; uut.arr[8] = 7; uut.arr[9] = 2;
        uut.n = 10;

        // VCD dump commands
        $dumpfile("heap_new_operations_tb.vcd");
        $dumpvars(0, heap_operations_tb);

        // Start make_heap
        start = 1;
        #10;
        start = 0;
        wait(done);
        $display("Heap after make_heap:");
        for (integer i = 0; i < uut.n; i = i + 1) begin
            wait(index == i);
            $display("%d", arr_out);
        end

        // Start push_heap
        key = 15;
        op = 0;
        start = 1;
        #10;
        start = 0;
        wait(done);
        $display("Heap after push_heap:");
        for (integer i = 0; i < uut.n; i = i + 1) begin
            wait(index == i);
            $display("%d", arr_out);
        end

        // Start pop_heap
        op = 1;
        start = 1;
        #10;
        start = 0;
        wait(done);
        $display("Heap after pop_heap:");
        for (integer i = 0; i < uut.n; i = i + 1) begin
            wait(index == i);
            $display("%d", arr_out);
        end

        $finish;
    end
endmodule

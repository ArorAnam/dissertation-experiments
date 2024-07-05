`timescale 1ns / 1ps

module heap_operations_tb;

    reg clk, reset, start;
    reg [1:0] instruction;
    reg [31:0] key;
    wire done;
    wire [31:0] arr_out;
    wire [9:0] n;

    heap_control uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .instruction(instruction),
        .key(key),
        .done(done),
        .arr_out(arr_out),
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
        instruction = 0; // No-op
        key = 0;
        #10 reset = 0;
        #10 start = 1;

        // Issue commands
        #10 instruction = 2'b01; key = $random; // Push random value
        #10 start = 0;
        #20 start = 1; instruction = 2'b10; // Pop

        #20 start = 0;
        #30 $finish;
    end

    initial begin
        $monitor("Time=%t, State=%0d, Done=%d, N=%0d, Arr_out=%0d", $time, uut.state, done, n, arr_out);
    end
endmodule

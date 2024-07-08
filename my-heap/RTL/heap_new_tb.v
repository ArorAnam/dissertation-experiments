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

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        start = 0;
        instruction = 0; // No-op
        key = $random % 1000;
        #10;
        reset = 0;

        // Delay after reset
        #20;

        // Push operation
        $display("Starting push operation");
        start = 1;
        instruction = 2'b01; // Push
        key = $random % 1000;
        #10 start = 0;

        #50; // Wait for operation to potentially complete

        // Check if done signal is asserted
        if (done) $display("Push operation completed");
        else $display("Push operation not completed");

        // Pop operation
        $display("Starting pop operation");
        start = 1;
        instruction = 2'b10; // Pop
        #10 start = 0;

        // Additional time to allow for operations to complete
        #50;

        // Check if done signal is asserted
        if (done) $display("Pop operation completed");
        else $display("Pop operation not completed");

        // Finish the simulation
        $display("Heap after operations: Top = %d", arr_out);
        $finish;
    end

    initial begin
        $monitor("Time=%0d, State=%0d, Done=%d, N=%0d, Key=%0d, Instruction=%0d", $time, uut.state, done, n, key, instruction);
    end
endmodule

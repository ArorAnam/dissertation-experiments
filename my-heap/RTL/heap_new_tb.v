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
        #10 reset = 0;

        // Delay after reset
        #20;

        // Push operation
        start = 1;
        instruction = 2'b01; // Push
        key = $random % 1000;
        #10 start = 0;

        #50; // Wait for operation to potentially complete

        // Pop operation
        start = 1;
        instruction = 2'b10; // Pop
        #10 start = 0;

        // Additional time to allow for operations to complete
        #50;

        if (!done) begin
            $display("Timeout or hang detected, operation did not complete.");
            $finish;
        end

        $display("Heap after operations: Key = %d, Top = %d", key, arr_out);
        $finish;
    end

    initial begin
        $monitor("Time=%t, State=%0d, Done=%d, N=%0d, Key=%0d, Instruction=%0d", $time, uut.state, done, n, key, instruction);
    end
endmodule

`timescale 1ns / 1ps

module Testbench;

    // Inputs
    reg clk;
    reg reset;
    reg [2:0] op_code;
    reg valid_in;
    reg [31:0] data_in;

    // Outputs
    wire valid_out;
    wire [31:0] data_out;
    wire busy;

    // Instantiate the Unit Under Test (UUT)
    HeapManagement uut (
        .clk(clk),
        .reset(reset),
        .op_code(op_code),
        .valid_in(valid_in),
        .data_in(data_in),
        .valid_out(valid_out),
        .data_out(data_out),
        .busy(busy)
    );

    // Clock generation
    always #5 clk = ~clk; // 100MHz Clock

    // Initial block for testing
    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;
        op_code = 0;
        valid_in = 0;
        data_in = 0;

        // Wait for global reset
        #100;
        reset = 0;
        #10;
        reset = 1;
        #10;
        reset = 0;

        // Test heap operations
        // Test Initialization
        #20;
        op_code = 0; // Initialize command
        valid_in = 1;
        #10;
        valid_in = 0;

        // Test Push operation
        #100;
        test_push(32'h10);
        test_push(32'h20);
        test_push(32'h15);
        test_push(32'h25);
        test_push(32'h5);

        // Test Pop operation
        #100;
        test_pop();

        // Test Sort operation
        #100;
        test_sort();

        // Finish testing
        #100;
        $finish;
    end

    // Tasks for different operations
    task test_push;
        input [31:0] value;
        begin
            @ (posedge clk);
            op_code = 1; // Push command
            valid_in = 1;
            data_in = value;
            @ (posedge clk);
            valid_in = 0;
            wait (!busy) @ (posedge clk);
        end
    endtask

    task test_pop;
        begin
            @ (posedge clk);
            op_code = 2; // Pop command
            valid_in = 1;
            @ (posedge clk);
            valid_in = 0;
            wait (!busy) @ (posedge clk);
        end
    endtask

    task test_sort;
        begin
            @ (posedge clk);
            op_code = 4; // Sort command
            valid_in = 1;
            @ (posedge clk);
            valid_in = 0;
            wait (!busy) @ (posedge clk);
        end
    endtask
    
endmodule

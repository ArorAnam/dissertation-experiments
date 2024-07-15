`timescale 1ns / 1ps

module Testbench;

    reg clk;
    reg reset;
    reg [2:0] op_code;
    reg valid_in;
    reg [31:0] data_in;
    wire valid_out;
    wire [31:0] data_out;
    wire busy;
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

    always #10 clk = ~clk; // 50 MHz clock

    initial begin
        clk = 0;
        reset = 1;
        op_code = 0;
        valid_in = 0;
        data_in = 0;

        #100;
        reset = 0;
        #20;
        reset = 1;
        #20;
        reset = 0;

        #30;
        test_push(20);
        test_push(5);
        test_push(15);
        test_push(22);
        test_push(40);
        test_push(3);

        #50;
        test_pop();
        test_pop();
        test_pop();
        test_pop();
        test_pop();
        test_pop();

        #100;
        $finish;
    end

    task test_push(input [31:0] value);
        begin
            @ (posedge clk);
            op_code = 1;
            valid_in = 1;
            data_in = value;
            @ (posedge clk);
            valid_in = 0;
            while (busy) @ (posedge clk);
        end
    endtask

    task test_pop;
        begin
            @ (posedge clk);
            op_code = 2;
            valid_in = 1;
            @ (posedge clk);
            valid_in = 0;
            while (busy) @ (posedge clk);
            while (!valid_out) @ (posedge clk);
            @ (posedge clk);
            $display("Popped: %d", data_out);
        end
    endtask

endmodule

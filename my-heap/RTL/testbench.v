`timescale 1ns / 1ps
`define VLEN 32 // Assuming vector length is 32 for simulation purposes.

module testbench;

    reg clk, reset;
    reg in_v;
    reg [4:0] rd;
    reg [2:0] vrd1, vrd2;
    reg [31:0] in_data;
    reg [`VLEN-1:0] in_vdata1, in_vdata2;

    wire out_v;
    wire [4:0] out_rd;
    wire [2:0] out_vrd1, out_vrd2;
    wire [31:0] out_data;
    wire [`VLEN-1:0] out_vdata1, out_vdata2;

    // Instantiate the Unit Under Test (UUT)
    C3_custom_SIMD_instruction uut(
        .clk(clk),
        .reset(reset),
        .in_v(in_v),
        .rd(rd),
        .vrd1(vrd1),
        .vrd2(vrd2),
        .in_data(in_data),
        .in_vdata1(in_vdata1),
        .in_vdata2(in_vdata2),
        .out_v(out_v),
        .out_rd(out_rd),
        .out_vrd1(out_vrd1),
        .out_vrd2(out_vrd2),
        .out_data(out_data),
        .out_vdata1(out_vdata1),
        .out_vdata2(out_vdata2)
    );

    // Clock generation
    always #5 clk = ~clk;  // 100MHz clock

    // Initialize all inputs
    initial begin
        clk = 0;
        reset = 1;
        in_v = 0;
        rd = 0;
        vrd1 = 0;
        vrd2 = 0;
        in_data = 0;
        in_vdata1 = 0;
        in_vdata2 = 0;

        // Reset the system
        #10;
        reset = 0;
        #10;
        reset = 1;
        #10;
        reset = 0;

        // Begin testing
        // Push operations
        @(posedge clk) push(10);
        @(posedge clk) push(20);
        @(posedge clk) push(15);
        @(posedge clk) push(30);
        @(posedge clk) push(40);

        // Pop operations
        @(posedge clk) pop();
        @(posedge clk) pop();
        @(posedge clk) pop();
        @(posedge clk) pop();
        @(posedge clk) pop();

        // Complete simulation
        #100;
        $finish;
    end

    // Tasks for push and pop operations
    task push;
        input [31:0] data;
        begin
            in_v = 1;
            vrd1 = 1;  // OpCode for push
            in_data = data;
            #10;  // Wait for a clock cycle
            in_v = 0;
            in_data = 0;
        end
    endtask

    task pop;
        begin
            in_v = 1;
            vrd1 = 2;  // OpCode for pop
            #10;  // Wait for a clock cycle
            in_v = 0;
        end
    endtask

    // Monitor outputs
    initial begin
        $monitor("Time = %t, out_v = %b, out_data = %d", $time, out_v, out_data);
    end

endmodule

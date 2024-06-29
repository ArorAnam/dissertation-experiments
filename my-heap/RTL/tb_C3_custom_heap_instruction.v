`timescale 1ns / 1ps

module tb_C3_custom_heap_instruction();

    // Inputs
    reg clk;
    reg reset;
    reg in_v;
    reg [4:0] rd;
    reg [2:0] vrd1, vrd2;
    reg [31:0] in_data;
    reg [31:0] in_heap_addr;
    reg [31:0] in_heap_size;

    // Outputs
    wire out_v;
    wire [4:0] out_rd;
    wire [2:0] out_vrd1, out_vrd2;
    wire [31:0] out_data;
    wire [31:0] out_heap_addr;
    wire [31:0] out_heap_size;

    // Instantiate the Unit Under Test (UUT)
    C3_custom_heap_instruction uut (
        .clk(clk), 
        .reset(reset), 
        .in_v(in_v), 
        .rd(rd), 
        .vrd1(vrd1), 
        .vrd2(vrd2), 
        .in_data(in_data), 
        .in_heap_addr(in_heap_addr), 
        .in_heap_size(in_heap_size), 
        .out_v(out_v), 
        .out_rd(out_rd), 
        .out_vrd1(out_vrd1), 
        .out_vrd2(out_vrd2), 
        .out_data(out_data), 
        .out_heap_addr(out_heap_addr), 
        .out_heap_size(out_heap_size)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100 MHz Clock
    end

    // Initialize Inputs and Apply Test Stimuli
    initial begin
        // Initialize Inputs
        reset = 1;
        in_v = 0;
        rd = 0;
        vrd1 = 0;
        vrd2 = 0;
        in_data = 0;
        in_heap_addr = 0;
        in_heap_size = 0;

        // Wait 100 ns for global reset
        #100;
        reset = 0;
        #50;  // Ensure reset is settled

        // Insert elements into the heap
        #10;
        in_v = 1;
        vrd1 = 3'b000; // pushHeap operation
        rd = 0;  // Not used in this test
        in_data = 10;  // Push value 10
        #10;
        in_v = 0; // Turn off valid to simulate completion

        #20;
        in_v = 1;
        in_data = 20;  // Push value 20
        #10;
        in_v = 0;

        #30;
        in_v = 1;
        in_data = 15;  // Push value 15
        #10;
        in_v = 0;

        // Wait before pop to let data settle
        #50;
        in_v = 1;
        vrd1 = 3'b001; // popHeap operation
        #10;
        in_v = 0;

        // Final Output Verification
        #50;
        $display("Expected output after Pop: 15, Actual Output: %d", out_data);
        $stop; // Properly end the simulation
    end

    // Display changes on important signals
    initial begin
        $monitor("At time %t, out_heap_size = %d, out_data = %d", $time, out_heap_size, out_data);
    end

endmodule

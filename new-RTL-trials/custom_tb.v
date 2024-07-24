`timescale 1ns / 1ps

module C3_custom_SIMD_instruction_tb;

    // Inputs
    reg clk;
    reg reset;
    reg in_v;
    reg push;
    reg pop;
    reg [4:0] rd;
    reg [2:0] vrd1, vrd2;
    reg [31:0] in_data;
    reg [`VLEN-1:0] in_vdata1, in_vdata2;

    // Outputs
    wire out_v;
    wire [4:0] out_rd;
    wire [2:0] out_vrd1, out_vrd2;
    wire [31:0] out_data;
    wire [`VLEN-1:0] out_vdata1, out_vdata2;

    // Instantiate the Unit Under Test (UUT)
    C3_custom_SIMD_instruction uut (
        .clk(clk), 
        .reset(reset), 
        .in_v(in_v), 
        .push(push), 
        .pop(pop), 
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
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 0;
        in_v = 0;
        push = 0;
        pop = 0;
        rd = 0;
        vrd1 = 0;
        vrd2 = 0;
        in_data = 0;
        in_vdata1 = 0;
        in_vdata2 = 0;

        // Dump waves
        $dumpfile("C3_custom_SIMD_instruction_tb.vcd");
        $dumpvars(0, C3_custom_SIMD_instruction_tb);

        // Display initialization message
        $display("Starting simulation");

        // Reset the heap
        #10;
        reset = 1;
        #10;
        reset = 0;
        $display("Applying reset");

        // Push random elements into the heap (up to HEAP_SIZE elements)
        for (i = 0; i < `HEAP_SIZE; i = i + 1) begin
            push_element($random % 256);
        end

        // Wait for a few cycles
        #100;

        // Pop elements from the heap
        for (i = 0; i < `HEAP_SIZE; i = i + 1) begin
            pop_element();
        end

        // End simulation
        #100;
        $finish;
    end

    integer i;

    task push_element(input [7:0] value);
        begin
            @(negedge clk);
            $display("Pushing element %d", value);
            in_data = value;
            push = 1;
            @(negedge clk);
            push = 0;
            in_data = 0;
            wait_for_idle();
        end
    endtask

    task pop_element;
        begin
            @(negedge clk);
            $display("Popping element");
            pop = 1;
            @(negedge clk);
            pop = 0;
            wait_for_idle();
        end
    endtask

    task wait_for_idle;
        begin
            while (uut.state != uut.IDLE) begin
                @(negedge clk);
            end
            $display("Heap is idle");
        end
    endtask

endmodule

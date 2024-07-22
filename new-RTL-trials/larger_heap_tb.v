`timescale 1ns / 1ps

module heap_tb;

    // Inputs
    reg clk;
    reg rst_n;
    reg push;
    reg pop;
    reg [7:0] data_in;

    // Outputs
    wire [7:0] data_out;
    wire empty;
    wire full;

    // Instantiate the Unit Under Test (UUT)
    heap uut (
        .clk(clk), 
        .rst_n(rst_n), 
        .push(push), 
        .pop(pop), 
        .data_in(data_in), 
        .data_out(data_out), 
        .empty(empty), 
        .full(full)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        rst_n = 0;
        push = 0;
        pop = 0;
        data_in = 0;

        // Dump waves
        $dumpfile("heap_tb.vcd");
        $dumpvars(0, heap_tb);

        // Display initialization message
        $display("Starting simulation");

        // Reset the heap
        #10;
        rst_n = 1;
        $display("Applying reset");

        // Push random elements into the heap
        for (i = 0; i < 20; i = i + 1) begin
            push_element($random % 256);
        end

        // Pop elements from the heap
        for (i = 0; i < 20; i = i + 1) begin
            pop_element();
        end

        // End simulation
        #10;
        $finish;
    end

    integer i;

    task push_element(input [7:0] value);
        begin
            @(negedge clk);
            $display("Pushing element %d", value);
            data_in = value;
            push = 1;
            @(negedge clk);
            push = 0;
            data_in = 0;
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

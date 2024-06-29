module tb_max_heap;

    reg clk;
    reg reset;
    reg [7:0] data_in;
    reg insert;
    reg delete;
    wire [7:0] data_out;
    wire heap_full;
    wire heap_empty;

    max_heap uut (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .insert(insert),
        .delete(delete),
        .data_out(data_out),
        .heap_full(heap_full),
        .heap_empty(heap_empty)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize inputs
        reset = 1;
        insert = 0;
        delete = 0;
        data_in = 0;

        // Apply reset
        #10;
        reset = 0;

        // Insert elements into the heap
        #10; data_in = 8'd10; insert = 1; #10; insert = 0;
        #10; data_in = 8'd20; insert = 1; #10; insert = 0;
        #10; data_in = 8'd5; insert = 1; #10; insert = 0;
        #10; data_in = 8'd7; insert = 1; #10; insert = 0;
        #10; data_in = 8'd25; insert = 1; #10; insert = 0;
        #10; data_in = 8'd3; insert = 1; #10; insert = 0;

        // Delete elements from the heap
        #10; delete = 1; #10; delete = 0;
        #10; delete = 1; #10; delete = 0;
        #10; delete = 1; #10; delete = 0;

        // Insert more elements
        #10; data_in = 8'd15; insert = 1; #10; insert = 0;
        #10; data_in = 8'd17; insert = 1; #10; insert = 0;

        // Delete remaining elements
        #10; delete = 1; #10; delete = 0;
        #10; delete = 1; #10; delete = 0;
        #10; delete = 1; #10; delete = 0;
        #10; delete = 1; #10; delete = 0;
        #10; delete = 1; #10; delete = 0;
        
        // End simulation
        #20;
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time = %0d, data_in = %d, insert = %b, delete = %b, data_out = %d, heap_full = %b, heap_empty = %b",
                 $time, data_in, insert, delete, data_out, heap_full, heap_empty);
    end

     // Waveform generation
    initial begin
        $dumpfile("heap_waveform.vcd");
        $dumpvars(0, tb_max_heap);
    end

endmodule

`timescale 1ns / 1ps

module heap_testbench;

reg clk, reset, enable;
reg [4:0] operation;
reg [31:0] input_value;
wire [31:0] heap_array[31:0];
wire [4:0] heap_size;

// Instantiate the heap module
heap_module dut(
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .operation(operation),
    .input_value(input_value),
    .heap_array(heap_array),
    .heap_size(heap_size)
);

// Clock generation
always #10 clk = ~clk;

// Initial setup and operation execution
initial begin
    clk = 0;
    reset = 1;
    enable = 0;
    operation = 0;
    input_value = 0;
    
    // Reset the module
    #20;
    reset = 0;
    enable = 1;
    operation = 0;  // Initialize

    // Push elements into the heap
    #20; input_value = 15; operation = 1;  // Push 15
    #20; input_value = 10; operation = 1;  // Push 10
    #20; input_value = 20; operation = 1;  // Push 20
    #20; input_value = 5;  operation = 1;  // Push 5
    #20; input_value = 30; operation = 1;  // Push 30

    // Pop an element from the heap
    #20; operation = 2;  // Pop

    // Sort the heap
    #20; operation = 3;  // Sort

    // Finalize
    #20; enable = 0;  // Disable operations

    #100;
    $finish;
end

// Monitor changes in the heap and print them
integer i;
always @(posedge clk) begin
    if (enable) begin
        $display("Heap size: %d", heap_size);
        for (i = 0; i < heap_size; i = i + 1) begin
            $display("Heap[%d] = %d", i, heap_array[i]);
        end
        $display("\n");
    end
end

endmodule

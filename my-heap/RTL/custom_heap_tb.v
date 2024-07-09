`timescale 1ns / 1ps

module heap_testbench;

reg clk, reset, enable;
reg [4:0] operation;
reg [31:0] input_value;
wire [31:0] heap_array[31:0];
wire [4:0] heap_size;

heap_module dut(
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .operation(operation),
    .input_value(input_value),
    .heap_array(heap_array),
    .heap_size(heap_size)
);

always #10 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    enable = 0;
    operation = 0;
    input_value = 0;

    #20;
    reset = 0;
    enable = 1;
    operation = 0;

    #20; input_value = 15; operation = 1;
    #20; input_value = 10; operation = 1;
    #20; input_value = 20; operation = 1;
    #20; input_value = 5;  operation = 1;
    #20; input_value = 30; operation = 1;

    #20; operation = 2;

    #20; operation = 3;

    #20; enable = 0;

    #100;
    $finish;
end

integer i; // Declaration of i
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

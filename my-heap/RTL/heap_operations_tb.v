`timescale 1ns / 1ps

module heap_operations_tb;
    reg [31:0] arr [0:1023];
    reg [9:0] n;
    reg [31:0] key;
    reg [31:0] out_arr [0:1023];
    wire [9:0] out_n;

    initial begin
        // Initialize the heap with random values
        n = 10;
        arr[0] = 10; arr[1] = 20; arr[2] = 5; arr[3] = 6; arr[4] = 1;
        arr[5] = 8; arr[6] = 9; arr[7] = 4; arr[8] = 7; arr[9] = 2;

        // VCD dump commands
        $dumpfile("heap_operations_tb.vcd");
        $dumpvars(0, heap_operations_tb);

        // Test make_heap
        make_heap mkh (.arr(arr), .n(n), .out_arr(out_arr));
        
        // Print the heap after make_heap
        $display("Heap after make_heap:");
        for (int i = 0; i < n; i = i + 1) begin
            $display("%d", out_arr[i]);
        end

        // Test push_heap
        key = 15;
        push_heap psh (.arr(arr), .n(n), .key(key), .out_arr(out_arr), .out_n(out_n));
        
        // Print the heap after push_heap
        $display("Heap after push_heap:");
        for (int i = 0; i < out_n; i = i + 1) begin
            $display("%d", out_arr[i]);
        end

        // Test pop_heap
        pop_heap pph (.arr(arr), .n(out_n), .out_arr(out_arr), .out_n(out_n));

        // Print the heap after pop_heap
        $display("Heap after pop_heap:");
        for (int i = 0; i < out_n; i = i + 1) begin
            $display("%d", out_arr[i]);
        end

        $finish;
    end
endmodule

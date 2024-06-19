`timescale 1ns / 1ps

module heap_operations_tb;

    reg [31:0] arr [0:1023];
    reg [9:0] n;
    reg [31:0] key;
    wire [31:0] make_heap_out_arr [0:1023];
    wire [31:0] push_heap_out_arr [0:1023];
    wire [31:0] pop_heap_out_arr [0:1023];
    wire [9:0] push_heap_out_n;
    wire [9:0] pop_heap_out_n;

    integer i;

    // Tasks to perform heap operations
    task heapify(input [31:0] arr [0:1023], input [9:0] n, input [9:0] i, output [31:0] out_arr [0:1023]);
        integer largest, l, r;
        reg [31:0] temp;
        begin
            largest = i;
            l = 2 * i + 1;
            r = 2 * i + 2;

            if (l < n && arr[l] > arr[largest])
                largest = l;

            if (r < n && arr[r] > arr[largest])
                largest = r;

            out_arr = arr;

            if (largest != i) begin
                temp = out_arr[i];
                out_arr[i] = out_arr[largest];
                out_arr[largest] = temp;
                heapify(out_arr, n, largest, out_arr);
            end
        end
    endtask

    task make_heap(input [31:0] arr [0:1023], input [9:0] n, output [31:0] out_arr [0:1023]);
        integer startIdx, i;
        begin
            startIdx = (n / 2) - 1;
            out_arr = arr;

            for (i = startIdx; i >= 0; i = i - 1) begin
                heapify(out_arr, n, i, out_arr);
            end
        end
    endtask

    task push_heap(input [31:0] arr [0:1023], input [9:0] n, input [31:0] key, output [31:0] out_arr [0:1023], output [9:0] out_n);
        begin
            out_n = n + 1;
            out_arr = arr;
            out_arr[out_n - 1] = key;
            make_heap(out_arr, out_n, out_arr);
        end
    endtask

    task pop_heap(input [31:0] arr [0:1023], input [9:0] n, output [31:0] out_arr [0:1023], output [9:0] out_n);
        begin
            if (n <= 0) begin
                out_n = 0;
            end else if (n == 1) begin
                out_n = 0;
            end else begin
                out_n = n - 1;
                out_arr = arr;
                out_arr[0] = arr[out_n];
                heapify(out_arr, out_n, 0, out_arr);
            end
        end
    endtask

    initial begin
        // Initialize the heap with random values
        n = 10;
        arr[0] = 10; arr[1] = 20; arr[2] = 5; arr[3] = 6; arr[4] = 1;
        arr[5] = 8; arr[6] = 9; arr[7] = 4; arr[8] = 7; arr[9] = 2;

        // VCD dump commands
        $dumpfile("heap_operations_tb.vcd");
        $dumpvars(0, heap_operations_tb);

        // Test make_heap
        #10;
        make_heap(arr, n, make_heap_out_arr);

        // Print the heap after make_heap
        $display("Heap after make_heap:");
        for (i = 0; i < n; i = i + 1) begin
            $display("%d", make_heap_out_arr[i]);
        end

        // Test push_heap
        key = 15;
        #10;
        push_heap(arr, n, key, push_heap_out_arr, push_heap_out_n);
        
        // Print the heap after push_heap
        $display("Heap after push_heap:");
        for (i = 0; i < push_heap_out_n; i = i + 1) begin
            $display("%d", push_heap_out_arr[i]);
        end

        // Test pop_heap
        #10;
        pop_heap(arr, push_heap_out_n, pop_heap_out_arr, pop_heap_out_n);

        // Print the heap after pop_heap
        $display("Heap after pop_heap:");
        for (i = 0; i < pop_heap_out_n; i = i + 1) begin
            $display("%d", pop_heap_out_arr[i]);
        end

        $finish;
    end
endmodule

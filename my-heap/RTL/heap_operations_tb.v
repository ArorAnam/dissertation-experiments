`timescale 1ns / 1ps

module heap_operations_tb;

    reg [31:0] arr [0:1023];
    reg [9:0] n;
    reg [31:0] key;
    reg [31:0] out_arr [0:1023];
    reg [9:0] out_n;
    integer i;

    // Task to heapify a subtree rooted with node i which is an index in arr[]
    task heapify(input integer n, input integer i);
        integer largest, l, r;
        reg [31:0] temp;
        begin
            largest = i; // Initialize largest as root
            l = 2 * i + 1; // left = 2*i + 1
            r = 2 * i + 2; // right = 2*i + 2

            // If left child is larger than root
            if (l < n && arr[l] > arr[largest])
                largest = l;

            // If right child is larger than largest so far
            if (r < n && arr[r] > arr[largest])
                largest = r;

            // If largest is not root
            if (largest != i) begin
                temp = arr[i];
                arr[i] = arr[largest];
                arr[largest] = temp;

                // Recursively heapify the affected sub-tree
                heapify(n, largest);
            end
        end
    endtask

    // Task to build a Max-Heap from the given array
    task make_heap(input integer n);
        integer startIdx;
        begin
            // Index of the last non-leaf node
            startIdx = (n / 2) - 1;

            // Perform reverse level order traversal
            // from last non-leaf node and heapify each node
            for (i = startIdx; i >= 0; i = i - 1) begin
                heapify(n, i);
            end
        end
    endtask

    // Task to push an element to the heap
    task push_heap(input integer key);
        begin
            n = n + 1;
            arr[n - 1] = key;
            make_heap(n);
        end
    endtask

    // Task to pop the root element from the heap
    task pop_heap();
        begin
            if (n <= 0)
                n = 0;
            else if (n == 1)
                n = 0;
            else begin
                arr[0] = arr[n - 1];
                n = n - 1;
                heapify(n, 0);
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
        make_heap(n);

        // Print the heap after make_heap
        $display("Heap after make_heap:");
        for (i = 0; i < n; i = i + 1) begin
            $display("%d", arr[i]);
        end

        // Test push_heap
        key = 15;
        #10;
        push_heap(key);

        // Print the heap after push_heap
        $display("Heap after push_heap:");
        for (i = 0; i < n; i = i + 1) begin
            $display("%d", arr[i]);
        end

        // Test pop_heap
        #10;
        pop_heap();

        // Print the heap after pop_heap
        $display("Heap after pop_heap:");
        for (i = 0; i < n; i = i + 1) begin
            $display("%d", arr[i]);
        end

        $finish;
    end
endmodule

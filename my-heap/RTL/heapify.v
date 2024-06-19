module heapify (
    input [31:0] arr [0:1023],
    input [9:0] n,
    input [9:0] i,
    output reg [31:0] out_arr [0:1023]
);
    integer largest, l, r;

    always @(*) begin
        largest = i;
        l = 2 * i + 1;
        r = 2 * i + 2;

        if (l < n && arr[l] > arr[largest])
            largest = l;

        if (r < n && arr[r] > arr[largest])
            largest = r;

        out_arr = arr;

        if (largest != i) begin
            out_arr[i] = arr[largest];
            out_arr[largest] = arr[i];
            heapify(out_arr, n, largest, out_arr);
        end
    end
endmodule

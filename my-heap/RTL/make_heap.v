module make_heap (
    input [31:0] arr [0:1023],
    input [9:0] n,
    output [31:0] out_arr [0:1023]
);
    integer startIdx, i;

    always @(*) begin
        startIdx = (n / 2) - 1;
        out_arr = arr;

        for (i = startIdx; i >= 0; i = i - 1) begin
            heapify(out_arr, n, i, out_arr);
        end
    end
endmodule

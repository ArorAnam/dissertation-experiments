module push_heap (
    input [31:0] arr [0:1023],
    input [9:0] n,
    input [31:0] key,
    output [31:0] out_arr [0:1023],
    output [9:0] out_n
);
    always @(*) begin
        out_n = n + 1;
        out_arr = arr;
        out_arr[out_n - 1] = key;
        make_heap(out_arr, out_n, out_arr);
    end
endmodule

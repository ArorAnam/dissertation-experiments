module pop_heap (
    input [31:0] arr [0:1023],
    input [9:0] n,
    output [31:0] out_arr [0:1023],
    output [9:0] out_n
);
    always @(*) begin
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
endmodule

module testbench;
    reg clk;
    reg reset;
    reg [4:0] rd;
    reg [31:0] in_data;
    reg [127:0] in_vdata1, in_vdata2;
    wire [31:0] out_data;
    wire [4:0] out_rd;
    wire [2:0] out_vrd1, out_vrd2;
    wire [127:0] out_vdata1, out_vdata2;
    wire out_v;

    C3_custom_SIMD_instruction dut (
        .clk(clk),
        .reset(reset),
        .rd(rd),
        .vrd1(3'd0),
        .vrd2(3'd0),
        .in_data(in_data),
        .in_vdata1(in_vdata1),
        .in_vdata2(in_vdata2),
        .out_v(out_v),
        .out_rd(out_rd),
        .out_vrd1(out_vrd1),
        .out_vrd2(out_vrd2),
        .out_data(out_data),
        .out_vdata1(out_vdata1),
        .out_vdata2(out_vdata2)
    );

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        rd = 0;
        in_data = 0;
        in_vdata1 = 0;
        in_vdata2 = 0;

        // Reset the design
        #100;
        reset = 0;

        // Push values into the heap
        for (int i = 0; i < 25; i = i + 1) begin
            rd = 5'd0; // Push operation
            in_data = $random;
            #40;
            clk = ~clk; #20; clk = ~clk; #20;
        end

        // Pop values from the heap
        for (int i = 0; i < 25; i = i + 1) begin
            rd = 5'd1; // Pop operation
            #40;
            clk = ~clk; #20; clk = ~clk; #20;
        end

        $finish;
    end

    always #10 clk = ~clk;

endmodule

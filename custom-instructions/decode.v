module decode (
    input [31:0] instr,
    output reg [6:0] opcode,
    output reg [2:0] funct3,
    output reg [6:0] funct7,
    output reg [4:0] rs1,
    output reg [4:0] rs2,
    output reg [4:0] rd,
    output reg [31:0] imm,
    output reg custom_push_heap,
    output reg custom_pop_heap
);

always @(*) begin
    opcode = instr[6:0];
    funct3 = instr[14:12];
    funct7 = instr[31:25];
    rs1 = instr[19:15];
    rs2 = instr[24:20];
    rd = instr[11:7];
    imm = {instr[31:20], 12'b0};  // For simplicity

    custom_push_heap = 0;
    custom_pop_heap = 0;

    case (opcode)
        7'b0001011: begin // Custom instructions opcode
            case (funct3)
                3'b000: custom_push_heap = 1;
                3'b001: custom_pop_heap = 1;
            endcase
        end
        // Other opcode cases
    endcase
end

endmodule

`timescale 1ns / 1ps

module Immediate(
input [31:0] inst,
input [2:0] imm_type,
output reg [31:0] imm
);
always @(*) begin
    case (imm_type)
        3'b001: //I
        if(inst[31]) imm={20'hFFFFF, inst[31:20]};//sign-extend
        else imm={20'b0, inst[31:20]};
        3'b010: //S
        if(inst[31]) imm={20'hFFFFF, inst[31:25], inst[11:7]};
        else imm={20'b0, inst[31:25], inst[11:7]};
        3'b011: //B
        if(inst[31]) imm={3'b111,16'hFFFF, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};
        else imm={19'b0, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};
        3'b100: //U 左移12
        imm={inst[31:12],12'b0};
        3'b101://J
        if(inst[31]) imm={11'h7FF, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};
        else imm={11'b0, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};
        default: imm=32'b0;
    endcase
end
endmodule

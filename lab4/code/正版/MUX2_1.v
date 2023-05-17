`timescale 1ns / 1ps

module MUX2_1(
input [31:0] src0, src1,
input sel,
output reg [31:0] res
);
always @(*) begin
    res=(sel==0?src0:src1);
end
endmodule

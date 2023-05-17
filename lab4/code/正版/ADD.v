`timescale 1ns / 1ps

module ADD(
input [31:0] lhs, rhs,
output [31:0] res
);
assign res=(lhs+rhs);
endmodule

`timescale 1ns / 1ps

module PC(
input [31:0] pc_next,
input clk, rst,
output reg [31:0] pc_cur
);
always @(posedge clk) begin
    if(rst) pc_cur<=32'h2ffc;   //异步复位
    else 
    pc_cur<=pc_next;
end
// initial begin
//     pc_cur<=32'h2ffc;
// end
endmodule

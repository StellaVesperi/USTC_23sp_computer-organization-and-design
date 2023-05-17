`timescale 1ns / 1ps

module RF //三端口32 xWIDTH寄存器堆
#(  parameter WIDTH = 32 ,
    parameter DEPTH = 5) //数据宽度和存储器深度
( 
input clk, //时钟（上升沿有效）
input[DEPTH-1 : 0] ra0, //读端口0地址
output[WIDTH - 1 : 0] rd0, //读端口0数据
input[DEPTH-1: 0] ra1, //读端口1地址
output[WIDTH - 1 : 0] rd1, //读端口1数据
input[DEPTH-1 : 0] wa, //写端口地址
input we, //写使能，高电平有效
input[WIDTH - 1 : 0] wd, //写端口数据
input[DEPTH-1 : 0] ra_dbg, //读端口2地址, 用于PDU从外部读取寄存器的值
output[WIDTH - 1 : 0] rd_dbg //读端口2数据
);
reg [WIDTH - 1 : 0] regfile[0 : 31];
assign rd0 = regfile[ra0], 
       rd1 = regfile[ra1],
       rd_dbg = regfile[ra_dbg];

always @ (posedge clk) begin
    if (we ) 
    if(|wa) regfile[wa] <= wd;
end



integer i;
initial begin
i = 0;
while (i < 32) begin
regfile[i] = 32'b0;
i = i + 1;
end
regfile [2] = 32'h2ffc;
regfile [3] = 32'h1800;
end
endmodule
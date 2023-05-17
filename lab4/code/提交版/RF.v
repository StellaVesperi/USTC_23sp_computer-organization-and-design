module RF // 三端口32 x WIDTH寄存器堆
#(
  parameter WIDTH = 32,
  parameter DEPTH = 5
)
(
  input clk, // 时钟（上升沿有效）
  input [DEPTH-1 : 0] ra0, // 读端口0地址
  output [WIDTH - 1 : 0] rd0, // 读端口0数据
  input [DEPTH-1: 0] ra1, // 读端口1地址
  output [WIDTH - 1 : 0] rd1, // 读端口1数据
  input [DEPTH-1 : 0] wa, // 写端口地址
  input we, // 写使能，高电平有效
  input [WIDTH - 1 : 0] wd, // 写端口数据
  input [DEPTH-1 : 0] ra_dbg, // 读端口2地址，用于PDU从外部读取寄存器的值
  output [WIDTH - 1 : 0] rd_dbg // 读端口2数据
);
  reg [WIDTH - 1 : 0] regfile [0 : 31]; // 定义一个32 x WIDTH的寄存器堆

  // 连接读端口0、读端口1和读端口2的数据输出
  assign rd0 = regfile[ra0];
  assign rd1 = regfile[ra1];
  assign rd_dbg = regfile[ra_dbg];

  always @(posedge clk) begin
    if (we) begin
      if (|wa) // 使用位或运算符检查写地址是否非零
        regfile[wa] <= wd; // 将写数据写入指定地址的寄存器
    end
  end

  integer i;
  initial begin
    i = 0;
    while (i < 32) begin
      regfile[i] = 32'b0; // 初始化寄存器堆中的所有寄存器为全零
      i = i + 1;
    end

    regfile[2] = 32'h2ffc; // 初始化寄存器堆中第2个寄存器的值为32'h2ffc
    regfile[3] = 32'h1800; // 初始化寄存器堆中第3个寄存器的值为32'h1800
  end
endmodule

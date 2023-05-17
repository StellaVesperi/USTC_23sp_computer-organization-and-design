module MUX2_1(
  input [31:0] src0, src1, // 输入源数据
  input sel, // 选择信号
  output reg [31:0] res // 输出结果
);
  always @(*) begin
    res = (sel == 0) ? src0 : src1; // 如果选择信号为0，选择src0作为输出结果；否则选择src1作为输出结果
  end
endmodule

module MUX4_1(
  input [31:0] src0, src1, src2, src3, // 输入源数据
  input [1:0] sel, // 选择信号
  output reg [31:0] res // 输出结果
);
  always @(*) begin
    case (sel)
      2'b00: res = src0; // 如果选择信号为2'b00，选择src0作为输出结果
      2'b01: res = src1; // 如果选择信号为2'b01，选择src1作为输出结果
      2'b10: res = src2; // 如果选择信号为2'b10，选择src2作为输出结果
      2'b11: res = src3; // 如果选择信号为2'b11，选择src3作为输出结果
      default: res = src0; // 如果选择信号不匹配任何情况，默认选择src0作为输出结果
    endcase
  end
endmodule

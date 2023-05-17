module PC(
  input [31:0] pc_next, // 输入下一指令地址
  input clk, rst, // 时钟和复位信号
  output reg [31:0] pc_cur // 当前指令地址
);
  always @(posedge clk) begin
    if (rst) // 异步复位
      pc_cur <= 32'h2ffc; // 复位时将当前指令地址设置为32'h2ffc
    else 
      pc_cur <= pc_next; // 在时钟上升沿时更新当前指令地址为下一指令地址
  end

  // initial begin
  //     pc_cur <= 32'h2ffc;
  // end
endmodule

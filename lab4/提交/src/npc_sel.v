module npc_sel(
  input [31:0] pc_add4, pc_jal_br, pc_jalr, // 输入PC的增加4、JAL/BR跳转的PC、JALR跳转的PC
  input jal, jalr, br, // 输入JAL、JALR、BR控制信号
  output reg [31:0] pc_next // 输出下一PC地址
);
  always @(*) begin
    if (jal || br) // 如果JAL或BR控制信号为高电平，则选择pc_jal_br作为下一PC地址
      pc_next = pc_jal_br;
    else if (jalr) // 如果JALR控制信号为高电平，则选择pc_jalr作为下一PC地址
      pc_next = pc_jalr;
    else // 否则选择pc_add4作为下一PC地址
      pc_next = pc_add4;
  end
endmodule

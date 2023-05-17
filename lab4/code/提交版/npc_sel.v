module npc_sel(
  input [31:0] pc_add4, pc_jal_br, pc_jalr, // ����PC������4��JAL/BR��ת��PC��JALR��ת��PC
  input jal, jalr, br, // ����JAL��JALR��BR�����ź�
  output reg [31:0] pc_next // �����һPC��ַ
);
  always @(*) begin
    if (jal || br) // ���JAL��BR�����ź�Ϊ�ߵ�ƽ����ѡ��pc_jal_br��Ϊ��һPC��ַ
      pc_next = pc_jal_br;
    else if (jalr) // ���JALR�����ź�Ϊ�ߵ�ƽ����ѡ��pc_jalr��Ϊ��һPC��ַ
      pc_next = pc_jalr;
    else // ����ѡ��pc_add4��Ϊ��һPC��ַ
      pc_next = pc_add4;
  end
endmodule

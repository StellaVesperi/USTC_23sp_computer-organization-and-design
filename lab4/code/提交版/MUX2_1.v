module MUX2_1(
  input [31:0] src0, src1, // ����Դ����
  input sel, // ѡ���ź�
  output reg [31:0] res // ������
);
  always @(*) begin
    res = (sel == 0) ? src0 : src1; // ���ѡ���ź�Ϊ0��ѡ��src0��Ϊ������������ѡ��src1��Ϊ������
  end
endmodule

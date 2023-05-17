module MUX4_1(
  input [31:0] src0, src1, src2, src3, // ����Դ����
  input [1:0] sel, // ѡ���ź�
  output reg [31:0] res // ������
);
  always @(*) begin
    case (sel)
      2'b00: res = src0; // ���ѡ���ź�Ϊ2'b00��ѡ��src0��Ϊ������
      2'b01: res = src1; // ���ѡ���ź�Ϊ2'b01��ѡ��src1��Ϊ������
      2'b10: res = src2; // ���ѡ���ź�Ϊ2'b10��ѡ��src2��Ϊ������
      2'b11: res = src3; // ���ѡ���ź�Ϊ2'b11��ѡ��src3��Ϊ������
      default: res = src0; // ���ѡ���źŲ�ƥ���κ������Ĭ��ѡ��src0��Ϊ������
    endcase
  end
endmodule

module RF // ���˿�32 x WIDTH�Ĵ�����
#(
  parameter WIDTH = 32,
  parameter DEPTH = 5
)
(
  input clk, // ʱ�ӣ���������Ч��
  input [DEPTH-1 : 0] ra0, // ���˿�0��ַ
  output [WIDTH - 1 : 0] rd0, // ���˿�0����
  input [DEPTH-1: 0] ra1, // ���˿�1��ַ
  output [WIDTH - 1 : 0] rd1, // ���˿�1����
  input [DEPTH-1 : 0] wa, // д�˿ڵ�ַ
  input we, // дʹ�ܣ��ߵ�ƽ��Ч
  input [WIDTH - 1 : 0] wd, // д�˿�����
  input [DEPTH-1 : 0] ra_dbg, // ���˿�2��ַ������PDU���ⲿ��ȡ�Ĵ�����ֵ
  output [WIDTH - 1 : 0] rd_dbg // ���˿�2����
);
  reg [WIDTH - 1 : 0] regfile [0 : 31]; // ����һ��32 x WIDTH�ļĴ�����

  // ���Ӷ��˿�0�����˿�1�Ͷ��˿�2���������
  assign rd0 = regfile[ra0];
  assign rd1 = regfile[ra1];
  assign rd_dbg = regfile[ra_dbg];

  always @(posedge clk) begin
    if (we) begin
      if (|wa) // ʹ��λ����������д��ַ�Ƿ����
        regfile[wa] <= wd; // ��д����д��ָ����ַ�ļĴ���
    end
  end

  integer i;
  initial begin
    i = 0;
    while (i < 32) begin
      regfile[i] = 32'b0; // ��ʼ���Ĵ������е����мĴ���Ϊȫ��
      i = i + 1;
    end

    regfile[2] = 32'h2ffc; // ��ʼ���Ĵ������е�2���Ĵ�����ֵΪ32'h2ffc
    regfile[3] = 32'h1800; // ��ʼ���Ĵ������е�3���Ĵ�����ֵΪ32'h1800
  end
endmodule

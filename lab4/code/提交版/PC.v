module PC(
  input [31:0] pc_next, // ������һָ���ַ
  input clk, rst, // ʱ�Ӻ͸�λ�ź�
  output reg [31:0] pc_cur // ��ǰָ���ַ
);
  always @(posedge clk) begin
    if (rst) // �첽��λ
      pc_cur <= 32'h2ffc; // ��λʱ����ǰָ���ַ����Ϊ32'h2ffc
    else 
      pc_cur <= pc_next; // ��ʱ��������ʱ���µ�ǰָ���ַΪ��һָ���ַ
  end

  // initial begin
  //     pc_cur <= 32'h2ffc;
  // end
endmodule

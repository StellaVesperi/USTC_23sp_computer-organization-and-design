module alu #(parameter WIDTH = 32)
(
    input [WIDTH-1:0] a, b,   // �������������ڼ����㣬a�Ǳ�������
    input [3:0] func,         // �������ܣ��ӡ������롢�����ȣ�
    output reg [WIDTH-1:0] y, // ���������͡��� ����
    output reg of             // �����־of���Ӽ���������ʱ��1
);

always @(*) begin
    of = 1'b0;
    y = 1'b0;
    case (func)
        4'b0: begin
            y = a + b;
            // �ж��Ƿ������
            if ((a[WIDTH-1] == b[WIDTH-1]) && (a[WIDTH-1] != y[WIDTH-1]))
                of = 1;
        end
        4'b0001: begin
            y = a - b;
            // �ж��Ƿ������
            if ((a[WIDTH-1] != b[WIDTH-1]) && (a[WIDTH-1] != y[WIDTH-1]))
                of = 1;
        end
        4'b0010: begin
            if (a == b) y = 2'b01;
            else y = 2'b0;
        end
        4'b0011: begin
            y = (a < b ? 2'b01 : 2'b0);
        end
        4'b0100: begin
            // ��Ϊ�����Ϊ��
            if (~(a[WIDTH-1] ^ b[WIDTH-1])) 
                // ���޷������Ƚ���ͬ
                y = (a < b ? 2'b01 : 2'b0);
            else if (a[WIDTH-1] && !b[WIDTH-1])
                y = 1'b1;
            else 
                y = 1'b0;
        end
        4'b0101: begin
            y = a & b;
        end
        4'b0110: begin
            y = a | b;
        end
        4'b0111: begin
            y = a ^ b;
        end
        4'b1000: begin
            y = a >> ({27'd0, b[4:0]});
        end
        4'b1001: begin
            y = a << ({27'd0, b[4:0]});
        end
        4'b1010: begin
            y = a >>>({27'd0, b[4:0]});
        end
        default: begin
            y = 2'b0;
            of = 1'b0;
        end
    endcase
end

endmodule
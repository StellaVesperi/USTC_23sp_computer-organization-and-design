module alu #(parameter WIDTH = 6)   (
    input [WIDTH - 1:0] a, b,       // ������
    input [2:0] f,                  // ����
    output reg [WIDTH - 1:0] y,     // ������
    output z                        // �����־of
);
    assign z = (y == {WIDTH{1'h0}}); // ������������Ϊ1������Ϊ0
    always @(*) begin
        case (f)
            4'b0000:
                y = a + b;
            4'b0001:
                y = a - b;
            4'b0010:
                y = (a == b) ? 6'b000001 : 6'b0; // ������a����b����Ϊ1������Ϊ0
            4'b0011:
                y = (a < b) ? 6'b000001 : 6'b0;  // ������aС��b����Ϊ1������Ϊ0
            4'b0101:
                y = a & b;
            4'b0110:
                y = a | b;
            4'b0111:
                y = a ^ b;
            default:
                y = {WIDTH{1'h0}};               // δ���幦��
        endcase
    end
endmodule
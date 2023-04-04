module alu #(parameter WIDTH = 6)   (
    input [WIDTH - 1:0] a, b,       // 操作数
    input [2:0] f,                  // 功能
    output reg [WIDTH - 1:0] y,     // 运算结果
    output z                        // 溢出标志of
);
    assign z = (y == {WIDTH{1'h0}}); // 如果有溢出，则为1，否则为0
    always @(*) begin
        case (f)
            4'b0000:
                y = a + b;
            4'b0001:
                y = a - b;
            4'b0010:
                y = (a == b) ? 6'b000001 : 6'b0; // 若满足a等于b，则为1，否则为0
            4'b0011:
                y = (a < b) ? 6'b000001 : 6'b0;  // 若满足a小于b，则为1，否则为0
            4'b0101:
                y = a & b;
            4'b0110:
                y = a | b;
            4'b0111:
                y = a ^ b;
            default:
                y = {WIDTH{1'h0}};               // 未定义功能
        endcase
    end
endmodule
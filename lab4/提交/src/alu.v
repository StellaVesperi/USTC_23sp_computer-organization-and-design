module alu #(parameter WIDTH = 32)
(
    input [WIDTH-1:0] a, b,   // 两操作数（对于减运算，a是被减数）
    input [3:0] func,         // 操作功能（加、减、与、或、异或等）
    output reg [WIDTH-1:0] y, // 运算结果（和、差 …）
    output reg of             // 溢出标志of，加减法结果溢出时置1
);

always @(*) begin
    of = 1'b0;
    y = 1'b0;
    case (func)
        4'b0: begin
            y = a + b;
            // 判断是否发生溢出
            if ((a[WIDTH-1] == b[WIDTH-1]) && (a[WIDTH-1] != y[WIDTH-1]))
                of = 1;
        end
        4'b0001: begin
            y = a - b;
            // 判断是否发生溢出
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
            // 均为正或均为负
            if (~(a[WIDTH-1] ^ b[WIDTH-1])) 
                // 和无符号数比较相同
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
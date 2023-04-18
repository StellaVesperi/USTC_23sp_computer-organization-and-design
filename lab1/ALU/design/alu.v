module alu #(parameter WIDTH = 6) ( 
    input [WIDTH - 1:0] a, b,       // 操作数
    input [2:0] f,                  // 功能
    output reg [WIDTH - 1:0] y,     // 运算结果
    output reg z                    // 溢出标志of
);

    always @(*) begin
        case (f)
            4'b0000:  
            begin       
                    y = a + b;
                    if ((a[5] == b[5]) && (y[5] != a[5]))
                        z = 1'b1;
                    else
                        z = 1'b0;
            end
            4'b0001:
            begin     
                    y = a - b;
                    if ((a[5] != b[5]) && (y[5] != a[5])) 
                    else
                        z = 1'b0;
            end
            4'b0010:
            begin      
                    y = (a == b) ? 6'b000001 : 6'b0; // 若满足a等于b，则为1，否则为0
                    z = 1'b0;
            end
            4'b0011:
            begin      
                    y = (a < b) ? 6'b000001 : 6'b0;  // 若满足a小于b，则为1，否则为0
                    z = 1'b0;
            end
            4'b0101:
                begin
                    y = a & b;
                    z = 1'b0;
                end
            4'b0110:
                begin
                    y = a | b;
                    z = 1'b0;
                end
            4'b0111:
                begin
                    y = a ^ b;
                    z = 1'b0;
                end
            default:
                begin
                    y = {WIDTH{1'h0}};               // 未定义功能
                    z = 1'b0;
                end
        endcase
    end
endmodule


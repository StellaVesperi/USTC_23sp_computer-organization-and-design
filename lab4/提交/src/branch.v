module branch(
    input [31:0] op1, op2,
    input [2:0] br_type,
    output reg br //�Ƿ��֧
);
    always @(*) begin
        case (br_type)
            3'b000: br = 0; // ����֧
            3'b001: // beq
            begin
                if (op1 == op2) br = 1; // ���ʱ��֧
                else br = 0;
            end
            3'b010: // blt // �з������Ƚ�
            begin
                if (~(op1[31] ^ op2[31])) // ��Ϊ�����Ϊ��
                    br = (op1 < op2 ? 1'b1 : 1'b0); // ���޷������Ƚ���ͬ
                else if (op1[31] && !op2[31])
                    br = 1'b1;
                else 
                    br = 1'b0;
            end
            3'b011: // bne ����ʱ��֧
            begin
                if (op1 != op2) br = 1'b1; // �����ʱ��֧
                else br = 1'b0;
            end
            3'b100: // bgeu �޷��Ŵ��ڵ���ʱ��֧
            begin
                if (op1 >= op2) br = 1'b1; // ���ڵ���ʱ��֧
                else br = 1'b0;
            end
            3'b101: // bltu �޷���С��ʱ��֧
            begin
                if (op1 < op2) br = 1'b1; // С��ʱ��֧
                else br = 1'b0;
            end
            default: br = 1'b0;
        endcase
    end
endmodule

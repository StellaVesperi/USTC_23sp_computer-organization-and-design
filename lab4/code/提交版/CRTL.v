module CTRL(
    input [31:0] inst,
    output reg jal, jalr,
    output reg [2:0] br_type,
    output reg wb_en, // write_back, RFдʹ��
    output reg [1:0] wb_sel,
    output reg [1:0] alu_op1_sel,
    output reg alu_op2_sel,
    output reg [3:0] alu_ctrl,
    output reg [2:0] imm_type,
    output reg mem_we
);

always @(*) begin
    case (inst[6:0])
        7'b0010011: begin
            if (inst[14:12] == 3'b000) // addi
            begin 
                jal = 1'b0;
                jalr = 1'b0;
                br_type = 3'b00; // ����֧
                wb_en = 1'b1; // д�ؼĴ���
                wb_sel = 2'b0; // alu ���
                alu_op1_sel = 2'b00; // inst[19:15]
                alu_op2_sel = 1'b1; // imm
                alu_ctrl = 4'b0000; // �ӷ�
                imm_type = 3'b001; // I-type
                mem_we = 1'b0; // ��д��洢��
            end
            else if (inst[14:12] == 3'b111) // andi
            begin
                jal = 1'b0;
                jalr = 1'b0;
                br_type = 3'b00; // ����֧
                wb_en = 1'b1; // д�ؼĴ���
                wb_sel = 2'b0; // alu ���
                alu_op1_sel = 2'b00; // inst[19:15]
                alu_op2_sel = 1'b1; // imm
                alu_ctrl = 4'b0101; // �����
                imm_type = 3'b001; // I-type
                mem_we = 1'b0; // ��д��洢��
            end
            else // ȫ0
            begin
                jal = 1'b0;
                jalr = 1'b0;
                br_type = 3'b00; // ����֧
                wb_en = 1'b0; // ��д�ؼĴ���
                wb_sel = 2'b00; // ����
                alu_op1_sel = 2'b00; // rs1
                alu_op2_sel = 1'b0; // rs2
                alu_ctrl = 4'b0000; // �ӷ�
                imm_type = 3'b000; // R-type
                mem_we = 1'b0; // ��д��洢��
            end
        end
        7'b0110011: begin 
            if (inst[14:12] == 3'b111) // and
            begin
                jal = 1'b0;
                jalr = 1'b0;
                br_type = 3'b00; // ����֧
                wb_en = 1'b1; // д�ؼĴ���
                wb_sel = 2'b0; // alu ���
                alu_op1_sel = 2'b00; // inst[19:15]
                alu_op2_sel = 1'b0; // inst[24:20]
                imm_type = 3'b000; // R-type
                mem_we = 1'b0; // ��д��洢��
            end
            else if (inst[14:12] == 3'b000) // add
            begin
                jal = 1'b0;
                jalr = 1'b0;
                br_type = 3'b00; // ����֧
                wb_en = 1'b1; // д�ؼĴ���
                wb_sel = 2'b0; // alu ���
                alu_op1_sel = 2'b00; // inst[19:15]
                alu_op2_sel = 1'b0; // inst[24:20]
                alu_ctrl = 4'b0000; // �ӷ�
                imm_type = 3'b000; // R-type
                mem_we = 1'b0; // ��д��洢��
            end
            else if (inst[14:12] == 3'b110) // or
            begin
                jal = 1'b0;
                jalr = 1'b0;
                br_type = 3'b00; // ����֧
                wb_en = 1'b1; // д�ؼĴ���
                wb_sel = 2'b0; // alu ���
                alu_op1_sel = 2'b00; // inst[19:15]
                alu_op2_sel = 1'b0; // inst[24:20]
                alu_ctrl = 4'b0110; // �����
                imm_type = 3'b000; // R-type
                mem_we = 1'b0; // ��д��洢��
            end
            else if (inst[14:12] == 3'b001) // sll
            begin
                jal = 1'b0;
                jalr = 1'b0;
                br_type = 3'b00; // ����֧
                wb_en = 1'b1; // д�ؼĴ���
                wb_sel = 2'b0; // alu ���
                alu_op1_sel = 2'b00; // inst[19:15]
                alu_op2_sel = 1'b0; // inst[24:20]
                alu_ctrl = 4'b1001; // ���Ʋ���
                imm_type = 3'b000; // R-type
                mem_we = 1'b0; // ��д��洢��
            end
            else if (inst[14:12] == 3'b101 && inst[31:25] == 7'b0000000) // srl
            begin
                jal = 1'b0;
                jalr = 1'b0;
                br_type = 3'b00; // ����֧
                wb_en = 1'b1; // д�ؼĴ���
                wb_sel = 2'b0; // alu ���
                alu_op1_sel = 2'b00; // inst[19:15]
                alu_op2_sel = 1'b0; // inst[24:20]
                alu_ctrl = 4'b1000; // �߼����Ʋ���
                imm_type = 3'b000; // R-type
                mem_we = 1'b0; // ��д��洢��
            end
            else if (inst[14:12] == 3'b101 && inst[31:25] == 7'b0100000) // sra
            begin
                jal = 1'b0;
                jalr = 1'b0;
                br_type = 3'b00; // ����֧
                wb_en = 1'b1; // д�ؼĴ���
                wb_sel = 2'b0; // alu ���
                alu_op1_sel = 2'b00; // inst[19:15]
                alu_op2_sel = 1'b0; // inst[24:20]
                alu_ctrl = 4'b1000; // �������Ʋ���
                imm_type = 3'b000; // R-type
                mem_we = 1'b0; // ��д��洢��
            end
            else // ȫ0
            begin
                jal = 1'b0;
                jalr = 1'b0;
                br_type = 3'b00; // ����֧
                wb_en = 1'b0; // ��д�ؼĴ���
                wb_sel = 2'b00; // ����
                alu_op1_sel = 2'b00; // rs1
                alu_op2_sel = 1'b0; // rs2
                alu_ctrl = 4'b0000; // �ӷ�
                imm_type = 3'b000; // R-type
                mem_we = 1'b0; // ��д��洢��
            end
        end
        7'b0110111: begin // lui
            jal = 1'b0;
            jalr = 1'b0;
            br_type = 3'b00; // ����֧
            wb_en = 1'b1; // д�ؼĴ���    
            wb_sel = 2'b0; // alu ���
            alu_op1_sel = 2'b10; // 12
            alu_op2_sel = 1'b1; // imm(�Ѿ�����12λ)
            alu_ctrl = 4'b0000; // �ӷ�
            imm_type = 3'b100; // U-type
            mem_we = 1'b0; // ��д��洢��
        end    
        7'b0010111: begin // auipc
            jal = 1'b0;
            jalr = 1'b0;
            br_type = 3'b00; // ����֧
            wb_en = 1'b1; // д�ؼĴ���
            wb_sel = 2'b0; // alu ���
            alu_op1_sel = 2'b01; // pc
            alu_op2_sel = 1'b1; // imm(�Ѿ�����12λ)
            alu_ctrl = 4'b0000; // �ӷ�
            imm_type = 3'b100; // U-type
            mem_we = 1'b0; // ��д��洢��        
        end
        7'b1101111: begin // jal
            jal = 1'b1;
            jalr = 1'b0;
            br_type = 3'b00; // ����֧
            wb_en = 1'b1; // д�ؼĴ���
            wb_sel = 2'b01; // pc+4
            alu_op1_sel = 2'b01; // inst[19:12], rs1
            alu_op2_sel = 1'b1; // imm
            alu_ctrl = 4'b0000; // �ӷ�, ����� NPC_sel
            imm_type = 3'b101; // J-type
            mem_we = 1'b0; // ��д��洢��
        end
        7'b1100111: begin // jalr
            jal = 1'b0;
            jalr = 1'b1;
            br_type = 3'b00; // ����֧
            wb_en = 1'b1; // д�ؼĴ���
            wb_sel = 2'b01; // pc+4
            alu_op1_sel = 2'b00; // rs1
            alu_op2_sel = 1'b1; // imm
            alu_ctrl = 4'b0000; // �ӷ�, ����� AND, �ٸ� NPC_sel
            imm_type = 3'b001; // I-type
            mem_we = 1'b0; // ��д��洢��
        end
        7'b1100011: begin
            if (inst[14:12] == 3'b000) // beq
            br_type = 3'b001; // beq
            else if (inst[14:12] == 3'b100) // blt
            br_type = 3'b010; // blt
            else if (inst[14:12] == 3'b001) // bne
            br_type = 3'b011; // bne
            else if (inst[14:12] == 3'b111) // bgeu
            br_type = 3'b100; // bgeu
            else if (inst[14:12] == 3'b110) // bltu
            br_type = 3'b101; // bltu
            else
            br_type = 3'b000; // ����֧
            jal = 1'b0;
            jalr = 1'b0;
            wb_en = 1'b0; // ��д�ؼĴ���
            wb_sel = 2'b11; // ����
            alu_op1_sel = 2'b01; // pc
            alu_op2_sel = 1'b1; // imm
            alu_ctrl = 4'b0000; // �ӷ�
            imm_type = 3'b011; // B-type
            mem_we = 1'b0; // ��д��洢��
        end
        7'b0000011: begin // lw
            jal = 1'b0;
            jalr = 1'b0;
            br_type = 3'b00; // ����֧
            wb_en = 1'b1; // д�ؼĴ���
            wb_sel = 2'b10; // mem_read_data
            alu_op1_sel = 2'b00; // rs1
            alu_op2_sel = 1'b1; // imm
            alu_ctrl = 4'b0000; // �ӷ�, �����Ϊ��ַ�� mem_addr
            imm_type = 3'b001; // I-type
            mem_we = 1'b0; // ��д��洢��
        end
        7'b0100011: begin // sw
            jal = 1'b0;
            jalr = 1'b0;
            br_type = 3'b00; // ����֧
            wb_en = 1'b0; // ��д�ؼĴ���
            wb_sel = 2'b10; // ����
            alu_op1_sel = 2'b00; // rs1
            alu_op2_sel = 1'b1; // imm
            alu_ctrl = 4'b0000; // �ӷ�, �����Ϊ��ַ�� mem_addr
            imm_type = 3'b010; // S-type
            mem_we = 1'b1; // д��洢��
        end
        default: begin // ȫ0
            jal = 1'b0;
            jalr = 1'b0;
            br_type = 3'b00; // ����֧
            wb_en = 1'b0; // ��д�ؼĴ���
            wb_sel = 2'b00; // ����
            alu_op1_sel = 2'b00; // rs1
            alu_op2_sel = 1'b0; // rs2
            alu_ctrl = 4'b0000; // �ӷ�
            imm_type = 3'b000; // R-type
            mem_we = 1'b0; // ��д��洢��
        end
    endcase
end
endmodule

module CHECK_DATA_SEL(
    input [31:0] pc_in, pc_out, instruction,
    input [4:0] rf_ra0, rf_ra1,
    input [31:0] rf_rd0, rf_rd1,
    input [4:0] rf_wa,
    input [31:0] rf_wd,
    input rf_we,
    input [31:0] imm,
    input [31:0] alu_sr1, alu_sr2, alu_ans,
    input [3:0] alu_func,
    input [31:0] pc_jalr,
    input [31:0] dm_addr, dm_din, dm_dout,
    input dm_we,
    input [31:0] check_addr,
    output reg [31:0] check_data
);

// ����check_addrѡ���Ӧ������
always @(*) begin
    case (check_addr[7:0])
        8'h01: check_data = pc_in;  // ����д��� PC
        8'h02: check_data = pc_out; // ��ǰ PC
        8'h03: check_data = instruction; // ��ǰָ��
        8'h04: check_data = rf_ra0; // �Ĵ����Ѷ���ַ 0
        8'h05: check_data = rf_ra1; // �Ĵ����Ѷ���ַ 1
        8'h06: check_data = rf_rd0; // �Ĵ������� 0
        8'h07: check_data = rf_rd1; // �Ĵ������� 1
        8'h08: check_data = rf_wa; // �Ĵ�����д��ַ
        8'h09: check_data = rf_wd; // �Ĵ�����д����	<---- NEW
        8'h0a: check_data = rf_we; // �Ĵ�����дʹ��
        8'h0b: check_data = imm;   // ������ģ�����
        8'h0c: check_data = alu_sr1; // ALU ���� 1 
        8'h0d: check_data = alu_sr2; // ALU ���� 2
        8'h0e: check_data = alu_func; // ALU ģʽ��
        8'h0f: check_data = alu_ans; // ALU ������
        8'h10: check_data = pc_jalr; // Jalr ָ��Ŀ���ַ
        8'h11: check_data = dm_addr; // �洢����д��ַ
        8'h12: check_data = dm_din; // �洢��д������
        8'h13: check_data = dm_dout; // �洢����������
        8'h14: check_data = dm_we; // �洢��дʹ��
        default: check_data = 0;
    endcase
end

endmodule

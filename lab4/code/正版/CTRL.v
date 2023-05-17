`timescale 1ns / 1ps

module CTRL(
input     [31:0] inst,
output reg       jal,jalr,
output reg [2:0] br_type,
output reg       wb_en,//write_back,RF写使能
output reg [1:0] wb_sel,
output reg [1:0] alu_op1_sel,
output reg       alu_op2_sel,
output reg [3:0] alu_ctrl,
output reg [2:0] imm_type,
output reg       mem_we
);

always @(*) begin
    case (inst[6:0])
        7'b0010011: begin
        if(inst[14:12]==3'b000)//addi
        begin 
            jal=0;
            jalr=0;
            br_type=3'b00;//not branch
            wb_en=1'b1;//write back
            wb_sel=2'b0;//alu out
            alu_op1_sel=2'b00;//inst[19:15]
            alu_op2_sel=1'b1;//imm
            alu_ctrl=4'b0000;//+
            imm_type=3'b001;//I-type
            mem_we=1'b0;//do not write mem
        end
        else if(inst[14:12]==3'b111)//andi
        begin
            jal=0;
            jalr=0;
            br_type=3'b00;//not branch
            wb_en=1'b1;//write back
            wb_sel=2'b0;//alu out
            alu_op1_sel=2'b00;//inst[19:15]
            alu_op2_sel=1'b1;//imm
            alu_ctrl=4'b0101;//&
            imm_type=3'b001;//I-type
            mem_we=1'b0;//do not write mem
        end
        else//全0
            begin
                jal=0;
                jalr=0;
                br_type=3'b00;//not branch
                wb_en=1'b0;//do not write back
                wb_sel=2'b00;//随便
                alu_op1_sel=2'b00;//rs1
                alu_op2_sel=1'b0;//rs2
                alu_ctrl=4'b0000;//+
                imm_type=3'b000;//R-type
                mem_we=1'b0;//do not write mem
            end
        end
        7'b0110011: begin 
            if(inst[14:12]==3'b111)//and
            begin
                jal=0;
                jalr=0;
                br_type=3'b00;//not branch
                wb_en=1'b1;//write back
                wb_sel=2'b0;//alu out
                alu_op1_sel=2'b00;//inst[19:15]
                alu_op2_sel=1'b0;//inst[24:20]
                alu_ctrl=4'b0101;//&
                imm_type=3'b000;//R-type
                mem_we=1'b0;//do not write mem
            end
            else if(inst[14:12]==3'b000)//add
            begin
                jal=0;
                jalr=0;
                br_type=3'b00;//not branch
                wb_en=1'b1;//write back
                wb_sel=2'b0;//alu out
                alu_op1_sel=2'b00;//inst[19:15]
                alu_op2_sel=1'b0;//inst[24:20]
                alu_ctrl=4'b0000;//+
                imm_type=3'b000;//R-type
                mem_we=1'b0;//do not write mem
            end
            else if(inst[14:12]==3'b110)//or
            begin
                jal=0;
                jalr=0;
                br_type=3'b00;//not branch
                wb_en=1'b1;//write back
                wb_sel=2'b0;//alu out
                alu_op1_sel=2'b00;//inst[19:15]
                alu_op2_sel=1'b0;//inst[24:20]
                alu_ctrl=4'b0110;//|
                imm_type=3'b000;//R-type
                mem_we=1'b0;//do not write mem
            end
            else if(inst[14:12]==3'b001)//sll
            begin
                jal=0;
                jalr=0;
                br_type=3'b00;//not branch
                wb_en=1'b1;//write back
                wb_sel=2'b0;//alu out
                alu_op1_sel=2'b00;//inst[19:15]
                alu_op2_sel=1'b0;//inst[24:20]
                alu_ctrl=4'b1001;//<<
                imm_type=3'b000;//R-type
                mem_we=1'b0;//do not write mem
            end
            else if(inst[14:12]==3'b101 && inst[31:25]==7'b0000000)//srl
            begin
                jal=0;
                jalr=0;
                br_type=3'b00;//not branch
                wb_en=1'b1;//write back
                wb_sel=2'b0;//alu out
                alu_op1_sel=2'b00;//inst[19:15]
                alu_op2_sel=1'b0;//inst[24:20]
                alu_ctrl=4'b1000;//>>
                imm_type=3'b000;//R-type
                mem_we=1'b0;//do not write mem
            end
            else if(inst[14:12]==3'b101 && inst[31:25]==7'b0100000)//sra
            begin
                jal=0;
                jalr=0;
                br_type=3'b00;//not branch
                wb_en=1'b1;//write back
                wb_sel=2'b0;//alu out
                alu_op1_sel=2'b00;//inst[19:15]
                alu_op2_sel=1'b0;//inst[24:20]
                alu_ctrl=4'b1000;//>>
                imm_type=3'b000;//R-type
                mem_we=1'b0;//do not write mem
            end
            else//全0
            begin
                jal=0;
                jalr=0;
                br_type=3'b00;//not branch
                wb_en=1'b0;//do not write back
                wb_sel=2'b00;//随便
                alu_op1_sel=2'b00;//rs1
                alu_op2_sel=1'b0;//rs2
                alu_ctrl=4'b0000;//+
                imm_type=3'b000;//R-type
                mem_we=1'b0;//do not write mem
            end
        end
        7'b0110111: begin //lui
            jal=0;
            jalr=0;
            br_type=3'b00;//not branch
            wb_en=1'b1;//write back
            wb_sel=2'b0;//alu out
            alu_op1_sel=2'b10;//12
            alu_op2_sel=1'b1;//imm(已经左移12bit)
            alu_ctrl=4'b0000;//+
            imm_type=3'b100;//U-type
            mem_we=1'b0;//do not write mem
        end
        7'b0010111: begin //auipc
            jal=0;
            jalr=0;
            br_type=3'b00;//not branch
            wb_en=1'b1;//write back
            wb_sel=2'b0;//alu out
            alu_op1_sel=2'b01;//pc
            alu_op2_sel=1'b1;//imm(已经左移12bit)
            alu_ctrl=4'b0000;//+
            imm_type=3'b100;//U-type
            mem_we=1'b0;//do not write mem
        end
        7'b1101111: begin //jal
            jal=1;
            jalr=0;
            br_type=3'b00;//not branch
            wb_en=1'b1;//write back
            wb_sel=2'b01;//pc+4
            alu_op1_sel=2'b01;//inst[19:12],rs1
            alu_op2_sel=1'b1;//imm
            alu_ctrl=4'b0000;//+,结果给NPC_sel
            imm_type=3'b101;//J-type
            mem_we=1'b0;//do not write mem
        end
        7'b1100111: begin //jalr
            jal=0;
            jalr=1;
            br_type=3'b00;//not branch
            wb_en=1'b1;//write back
            wb_sel=2'b01;//pc+4
            alu_op1_sel=2'b00;//rs1
            alu_op2_sel=1'b1;//imm
            alu_ctrl=4'b0000;//+,结果给AND,再给NPC_sel
            imm_type=3'b001;//I-type
            mem_we=1'b0;//do not write mem
        end
        7'b1100011: begin 
            if(inst[14:12]==3'b000)//beq
                br_type=3'b001;//beq
            else if(inst[14:12]==3'b100)//blt
                br_type=3'b010;//blt
            else if(inst[14:12]==3'b001)//bne
                br_type=3'b011;//bne
            else if(inst[14:12]==3'b111)//bgeu
                br_type=3'b100;//bgeu
            else if(inst[14:12]==3'b110)//bltu
                br_type=3'b101;//bltu
            else br_type=3'b000;//do not branch
            jal=0;
            jalr=0;
            wb_en=1'b0;//do not write back
            wb_sel=2'b11;//随便
            alu_op1_sel=2'b01;//pc
            alu_op2_sel=1'b1;//imm
            alu_ctrl=4'b0000;//+
            imm_type=3'b011;//B-type
            mem_we=1'b0;//do not write mem
        end
        7'b0000011: begin //lw
            jal=0;
            jalr=0;
            br_type=3'b00;//not branch
            wb_en=1'b1;//write back
            wb_sel=2'b10;//mem_read_data
            alu_op1_sel=2'b00;//rs1
            alu_op2_sel=1'b1;//imm
            alu_ctrl=4'b0000;//+,结果作为地址给mem_addr
            imm_type=3'b001;//I-type
            mem_we=1'b0;//do not write mem
        end
        7'b0100011: begin //sw
            jal=0;
            jalr=0;
            br_type=3'b00;//not branch
            wb_en=1'b0;//do not write back
            wb_sel=2'b10;//随便
            alu_op1_sel=2'b00;//rs1
            alu_op2_sel=1'b1;//imm
            alu_ctrl=4'b0000;//+,结果作为地址给mem_addr
            imm_type=3'b010;//S-type
            mem_we=1'b1;//write mem
        end
        default: begin
            // 全0
            jal=0;
            jalr=0;
            br_type=3'b00;//not branch
            wb_en=1'b0;//do not write back
            wb_sel=2'b00;//随便
            alu_op1_sel=2'b00;//rs1
            alu_op2_sel=1'b0;//rs2
            alu_ctrl=4'b0000;//+
            imm_type=3'b000;//R-type
            mem_we=1'b0;//do not write mem
        end
    endcase
end
endmodule

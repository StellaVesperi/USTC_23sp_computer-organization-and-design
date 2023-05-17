module CPU(
    input clk, 
    input rst,

    // MEM And MMIO Data BUS
    output [31:0] im_addr,      // Instruction address (The same as current PC)
    input [31:0] im_dout,       // Instruction data (Current instruction)
    output [31:0] mem_addr,     // Memory read/write address
    output mem_we,              // Memory writing enable		            
    output [31:0] mem_din,      // Data ready to write to memory
    input [31:0] mem_dout,	    // Data read from memory

    // Debug BUS with PDU
    output [31:0] current_pc, 	        // Current_pc, pc_out
    output [31:0] next_pc,              // Next_pc, pc_in    
    input [31:0] cpu_check_addr,	    // Check current datapath state (code)
    output [31:0] cpu_check_data    // Current datapath state data
);
    
    
    // Write your CPU here!
    // You might need to write these modules:
    // ALU、RF、Control、Add(Or just add-mode ALU)、And(Or just and-mode ALU)、PCReg、Imm、Branch、Mux、...
    
    wire [31:0] inst, mem_rd, pc_cur, alu_res, rd1, pc_next;  // CPU 输入和输出
    wire [31:0] wb_data, rd0, rd_dbg, pc_add4, pc_jalr, alu_op1, alu_op2, imm;  // 寄存器文件（rf）
    wire wb_en, jal, jalr, alu_op2_sel, br;  // 控制信号
    wire [1:0] wb_sel, alu_op1_sel;  // 控制信号
    wire [3:0] alu_ctrl;  // ALU 控制信号
    wire [2:0] imm_type, br_type;  // 立即数类型和分支类型
    wire [31:0] check_data;  // 调试时检查的数据

    assign inst = im_dout;  // 指令从指令存储器读取
    assign mem_rd = mem_dout;  // 数据从数据存储器读取
    assign im_addr = pc_cur;  // 指令存储器地址
    assign mem_addr = alu_res;  // 数据存储器地址
    assign mem_din = rd1;  // 数据存储器输入
    assign current_pc = pc_cur;  // 当前程序计数器
    assign next_pc = pc_next;  // 下一个程序计数器

    // 实例化模块并连接输入/输出

    PC pc(
        .pc_next(pc_next),
        .clk(clk),
        .rst(rst),
        .pc_cur(pc_cur)
    );

    ADD ADD(
        .lhs(32'd4),
        .rhs(pc_cur),
        .res(pc_add4)
    );

    AND AND(
        .lhs(32'hFFFFFFFE),
        .rhs(alu_res),
        .res(pc_jalr)
    );

    MUX4_1 alu_sel1(
        .src0(rd0),
        .src1(pc_cur),
        .src2(32'd0),
        .src3(32'd0),
        .sel(alu_op1_sel),
        .res(alu_op1)
    );

    MUX2_1 alu_sel2(
        .src0(rd1),
        .src1(imm),
        .sel(alu_op2_sel),
        .res(alu_op2)
    );

    RF rf(
        .clk(clk),
        .ra0(inst[19:15]),
        .rd0(rd0),
        .ra1(inst[24:20]),
        .rd1(rd1),
        .wa(inst[11:7]),
        .we(wb_en),
        .wd(wb_data),
        .ra_dbg(cpu_check_addr[4:0]),
        .rd_dbg(rd_dbg)
    );

    Immediate immediate(
        .inst(inst),
        .imm_type(imm_type),
        .imm(imm)
    );

    alu alu(
        .a(alu_op1),
        .b(alu_op2),
        .func(alu_ctrl),
        .y(alu_res),
        .of()  // 浮点输出未连接
    );

    MUX4_1 reg_write_sel(
        .src0(alu_res),
        .src1(pc_add4),
        .src2(mem_rd),
        .src3(imm),
        .sel(wb_sel),
        .res(wb_data)
    );

    branch branch(
        .op1(rd0),
        .op2(rd1),
        .br_type(br_type),
        .br(br)
    );

    npc_sel npc_sel(
        .pc_add4(pc_add4),
        .pc_jal_br(alu_res),
        .pc_jalr(pc_jalr),
        .jal(jal),
        .jalr(jalr),
        .br(br),
        .pc_next(pc_next)
    );

    CTRL ctrl(
        .inst(inst),
        .jal(jal),
        .jalr(jalr),
        .br_type(br_type),
        .wb_en(wb_en),
        .wb_sel(wb_sel),
        .alu_op1_sel(alu_op1_sel),
        .alu_op2_sel(alu_op2_sel),
        .alu_ctrl(alu_ctrl),
        .imm_type(imm_type),
        .mem_we(mem_we)
    );

    MUX2_1 cpu_check_data_sel(
        .src0(check_data),
        .src1(rd_dbg),
        .sel(cpu_check_addr[12]),
        .res(cpu_check_data)
    );

    CHECK_DATA_SEL check_data_sel(
        .pc_in(pc_next),
        .pc_out(pc_cur),
        .instruction(inst),
        .rf_ra0(inst[19:15]),
        .rf_ra1(inst[24:20]),
        .rf_rd0(rd0),
        .rf_rd1(rd1),
        .rf_wa(inst[11:7]),
        .rf_wd(wb_data),
        .rf_we(wb_en),
        .imm(imm),
        .alu_sr1(alu_op1),
        .alu_sr2(alu_op2),
        .alu_ans(alu_res),
        .alu_func(alu_ctrl),
        .pc_jalr(pc_jalr),
        .dm_addr(alu_res),
        .dm_din(mem_din),
        .dm_dout(mem_rd),
        .dm_we(mem_we),
        .check_addr(cpu_check_addr),
        .check_data(check_data)
    );


endmodule
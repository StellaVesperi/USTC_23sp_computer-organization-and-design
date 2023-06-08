# Lab 5 流水线cpu

<center>姓名:张芷苒 学号: PB21081601 </center>

## 实验题目

流水线 CPU 设计

## 实验目的

- 理解流水线CPU的结构和工作原理
- 掌握流水线CPU的设计和调试方法，特别是流水线中数据相关和控制相关的处理
- 熟练掌握数据通路和控制器的设计和描述方法

## 实验平台

- Xilinx Vivado v2019.1
- Microsoft Visual Studio Code
- FPGAOL

## 实验内容

以下是本次实验中的关键模块：

### 数据通路

![datapath](C:\Users\MinervaZH\Desktop\2023sp\computer organization and design\ref\USTC_LuJianLiang_COD_Lab-main\COD_Lab5\src\figs\datapath.png)

### hazard.v

- 输入信号：
  - `rf_ra0_ex`和`rf_ra1_ex`：执行阶段的指令需要读取的寄存器地址。
  - `rf_re0_ex`和`rf_re1_ex`：执行阶段的指令是否需要读取寄存器堆。
  - `rf_wa_mem`：内存访问阶段需要写入的寄存器地址。
  - `rf_we_mem`：内存访问阶段是否需要写入寄存器堆。
  - `rf_wd_sel_mem`：内存访问阶段选择的写回值来源。
  - `alu_ans_mem`：内存访问阶段的ALU计算结果。
  - `pc_add4_mem`：内存访问阶段的PC+4值。
  - `imm_mem`：内存访问阶段的立即数值。
  - `rf_wa_wb`：写回阶段需要写入的寄存器地址。
  - `rf_we_wb`：写回阶段是否需要写入寄存器堆。
  - `rf_wd_wb`：写回阶段的写回数据。
- 输出信号：
  - `rf_rd0_fe`和`rf_rd1_fe`：执行阶段需要从寄存器堆读取的数据的使能信号。
  - `rf_rd0_fd`和`rf_rd1_fd`：执行阶段需要从寄存器堆读取的数据。
  - `stall_if`、`stall_id`和`stall_ex`：用于指示是否需要在流水线的不同阶段插入气泡（stall）。
  - `flush_if`、`flush_id`、`flush_ex`和`flush_mem`：用于指示是否需要在流水线的不同阶段进行刷新（flush）。

然后，根据输入信号的值，使用组合逻辑生成输出信号的值。

- 在`always @(*)`块中，根据`rf_wd_sel_mem`选择适当的写回值来源，并将结果赋值给`rf_wd_mem`。
- 在另一个`always @(*)`块中，根据输入信号的值，设置输出信号的值。具体包括：
  - 根据上一条指令写回的寄存器与当前指令需要读取的寄存器进行比较，确定是否需要从寄存器堆中读取数据。
  - 根据上一条指令写回的寄存器与当前指令需要读取的寄存器进行比较，并结合`rf_wd_sel_mem`的值，确定是否需要插入气泡（stall）。
  - 根据当前指令的控制流选择信号，确定是否需要进行刷新（flush）。

```verilog
module Hazard (
    input [4:0] rf_ra0_ex,
    input [4:0] rf_ra1_ex,
    input rf_re0_ex,
    input rf_re1_ex,
    input [4:0] rf_wa_mem,
    input rf_we_mem,
    input [1:0] rf_wd_sel_mem,
    input [31:0] alu_ans_mem,
    input [31:0] pc_add4_mem,
    input [31:0] imm_mem,
    input [4:0] rf_wa_wb,
    input rf_we_wb,
    input [31:0] rf_wd_wb,
    input [1:0] pc_sel_ex,
    output reg rf_rd0_fe,
    output reg rf_rd1_fe,
    output reg [31:0] rf_rd0_fd,
    output reg [31:0] rf_rd1_fd,
    output reg stall_if,
    output reg stall_id,
    output reg stall_ex,
    output reg flush_if,
    output reg flush_id,
    output reg flush_ex,
    output reg flush_mem
);
    reg [31:0] rf_wd_mem;
    always @(*) begin
        rf_wd_mem=0;
        case (rf_wd_sel_mem)
            0: rf_wd_mem=alu_ans_mem;
            1: rf_wd_mem=pc_add4_mem;
            3: rf_wd_mem=imm_mem;       //rf_wd_sel_mem==2时，写回值源于数据存储器，需要插入气泡
        endcase
    end

    always @(*) begin
        rf_rd0_fe=0; rf_rd0_fd=0; rf_rd1_fe=0; rf_rd1_fd=0;
        stall_if=0; stall_id=0; stall_ex=0;
        flush_if=0; flush_id=0; flush_ex=0; flush_mem=0;
        if(rf_we_wb)begin   
        //上上条指令存在写回寄存器堆
            if(rf_re0_ex==1 && rf_ra0_ex==rf_wa_wb)begin    
            //这一条指令需要读寄存器堆，且所读寄存器与上一条指令写回的寄存器相同
                rf_rd0_fe=1;
                rf_rd0_fd=rf_wd_wb;
            end
            if(rf_re1_ex==1 && rf_ra1_ex==rf_wa_wb)begin    
            //这一条指令需要读寄存器堆，且所读寄存器与上一条指令写回的寄存器相同
                rf_rd1_fe=1;
                rf_rd1_fd=rf_wd_wb;
            end
        end
        if(rf_we_mem)begin  //上一条指令存在写回寄存器堆
            if(rf_re0_ex==1 && rf_ra0_ex==rf_wa_mem)
                begin   
                //这一条指令需要读寄存器堆，且所读寄存器与上一条指令写回的寄存器相同
                if(rf_wd_sel_mem==2)
                    begin//上一条指令写回值源于数据存储器需要插入气泡
                    stall_if=1;
                    stall_id=1;
                    stall_ex=1;
                    flush_mem=1;
                end
                rf_rd0_fe=1;
                rf_rd0_fd=rf_wd_mem;
            end
            if(rf_re1_ex==1 && rf_ra1_ex==rf_wa_mem)begin 
      //这一条指令需要读寄存器堆，且所读寄存器与上一条指令写回的寄存器相同
                if(rf_wd_sel_mem==2)begin   
                //上一条指令写回值源于数据存储器，需要插入气泡
                    stall_if=1;
                    stall_id=1;
                    stall_ex=1;
                    flush_mem=1;
                end
                rf_rd1_fe=1;
                rf_rd1_fd=rf_wd_mem;
            end
        end
        if(pc_sel_ex==1 || pc_sel_ex==2)begin    //jalr, br
            //flush_if=1;   //没有必要
            flush_id=1;
            flush_ex=1;
        end
        if(pc_sel_ex==3)begin   //jal 提前跳转，只清空前两阶段寄存器
            //flush_if=1;   //没有必要
            flush_id=1;
        end
    end
endmodule
```

### MEM.v

添加了两个模块实例化的代码，分别是`dist_mem_gen_0`和`dist_mem_gen_1`。这些实例化的模块用于实现指令存储器（`Inst_mem`）和数据存储器（`Data_mem`）。

- 对于指令存储器（IM），使用`dist_mem_gen_0`模块实例化，并将`im_addr[10:2]`连接到模块的`a`端口，将`im_dout`连接到模块的`spo`端口。这样，根据输入的指令地址，模块将从指令存储器中读取对应的指令数据，并输出到`im_dout`。
- 对于数据存储器（DM），使用`dist_mem_gen_1`模块实例化，并将`dm_addr[9:2]`连接到模块的`a`端口，将`dm_din`连接到模块的`d`端口，将`mem_check_addr[9:2]`连接到模块的`dpra`端口。同时，将时钟信号`clk`连接到模块的`clk`端口，将写使能信号`dm_we`连接到模块的`we`端口，将数据存储器的输出`dm_dout`连接到模块的`spo`端口，将调试总线的数据`mem_check_data`连接到模块的`dpo`端口。这样，根据输入的数据存储器地址和写入数据，模块将执行相应的读写操作，并将读取的数据输出到`dm_dout`和`mem_check_data`。

```verilog
module MEM(
    input clk,

    // MEM Data BUS with CPU
	// IM port
    input [31:0] im_addr,
    output [31:0] im_dout,
	
	// DM port
    input  [31:0] dm_addr,
    input dm_we,
    input  [31:0] dm_din,
    output [31:0] dm_dout,

    // MEM Debug BUS
    input [31:0] mem_check_addr,
    output [31:0] mem_check_data
);
   
   // TODO : Your IP here.
   // Remember that we need [9:2]?
   dist_mem_gen_0 Inst_mem (
        .a(im_addr[10:2]),
        .spo(im_dout)
    );
    dist_mem_gen_1 Data_mem (
    .a(dm_addr[9:2]),        
    .d(dm_din),        
    .dpra(mem_check_addr[9:2]),  
    .clk(clk),    
    .we(dm_we),     
    .spo(dm_dout),   
    .dpo(mem_check_data)   
    );

endmodule
```

### PDU_ctrl.v

创建了一个大小为256x32位的内存（存储器）`memory`，用于存储指令和数据。在时钟的上升沿，根据指令地址（`im_addr[9:2]`），将指令数据从内存中读取到`im_dout`中。对于数据存储器，如果`dm_we`为1，则在时钟上升沿将`dm_din`的数据写入到`dm_addr[9:2]`指定的内存地址中，然后从相同的地址读取数据，并将其放入`dm_dout`中。最后，根据`mem_check_addr[9:2]`指定的地址，将内存中的数据放入`mem_check_data`中，以供调试使用。

```verilog
RUN_enter: 
begin
	if (current_pc == bp_pc || current_pc > 32'h3fff || current_pc < 32'h2ff0)  
    // TODO : Add a counter
    	main_next_state = RUN_done;
     else if (pc_seg_vld) 
     	main_next_state = SEG_display;
end
```


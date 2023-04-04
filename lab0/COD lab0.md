# COD lab0

## PB21081601 张芷苒

1. 实验题代码

```verilog
module Clock (
	input clk,
	input rst,
	output reg [2:0] hour,
	output reg [3:0] min,
	output reg [4:0] sec
);
	
	always @(posedge clk) begin
		if (rst) begin
			hour <= 3'b0;
			min <= 4'b0;
			sec <= 5'b0;
		end
		else begin
			sec <= sec + 1;
			if (sec == 20) begin
				sec <= 5'b0;
				min <= min + 1;
				if (min == 10) begin
					min <= 4'b0;
					hour <= hour + 1;
					if (hour == 5) begin
						hour <= 3'b0;
						min <= 4'b0;
						sec <= 5'b0;
					end
				end
			end
		end
	end
	
endmodule

module Sec (
	input clk,
	input rst,
	output reg [4:0] sec
);

	always @(posedge clk) begin
		if (rst) begin
			sec <= 5'b0;
		end
		else begin
			sec <= sec + 1;
			if (sec == 20) begin
				sec <= 5'b0;
			end
		end
	end
	
endmodule

module Min (
	input clk,
	input rst,
	input [4:0] sec,
	output reg [3:0] min
);

	always @(posedge clk) begin
		if (rst) begin
			min <= 4'b0;
		end
		else begin
			if (sec == 20) begin
				min <= min + 1;
				if (min == 10) begin
					min <= 4'b0;
				end
			end
		end
	end
	
endmodule

module Hour (
	input clk,
	input rst,
	input [3:0] min,
	input [4:0] sec,
	output reg [2:0] hour
);

	always @(posedge clk) begin
		if (rst) begin
			hour <= 3'b0;
		end
		else begin
			if (min == 10 && sec == 0) begin
				hour <= hour + 1;
				if (hour == 5) begin
					hour <= 3'b0;
				end
			end
		end
	end
	
endmodule
```



2. 仿真波形

![image-20230326221432095](C:\Users\MinervaZH\AppData\Roaming\Typora\typora-user-images\image-20230326221432095.png)

![image-20230326221454820](C:\Users\MinervaZH\AppData\Roaming\Typora\typora-user-images\image-20230326221454820.png)



3. 生成的电路图

![image-20230326221541493](C:\Users\MinervaZH\AppData\Roaming\Typora\typora-user-images\image-20230326221541493.png)



4. 实验反馈

- 希望以后群里讨论的内容能设个精华之类的，因为不可能时时刻刻都看着群，也不可能每次都在实验第一天就写完，这样就会因为自己还没开始做或者没及时看消息错过很多讨论内容，廷焦虑的
- 助教用latex写的文档吗，为啥我用福昕打开pdf，链接不能跳转，一些想要复制的东西还会乱码... 崩溃
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

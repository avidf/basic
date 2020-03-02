//定义一个4X4的键盘矩阵
module button_scan(clk,in_s,out_s,key_value);

input clk;
input in_s;//交叉线路输入到模块的扫描信号
output out_s;//模块输出到交叉线路的信号
output key_value;//按键位

wire [3:0] out_s;
reg [3:0] out_t;//由于out_s是wire型不能用于always块中
wire [3:0] in_s;
reg [7:0] key_value;
reg [1:0] out_i;
reg [7:0] mm;//mm<={out_s,in_s}组合输入输出信号，用于判断键位
reg [1:0] tmp;//

assign out_s=out_t;
always@(posedge clk) begin//需要四个上升沿才能做完一次检测
	if(out_i<4) begin
		out_i<=out_i+1;
		case(out_i)
		2'b00:	out_t<=4'b0001;
		2'b01:	out_t<=4'b0010;
		2'b10:	out_t<=4'b0100;
		2'b11:	out_t<=4'b1000;
		endcase
		end
	else
		out_i<=0;
	end

always@(posedge clk) begin
	if(in_s==4'b0000) begin
		if(tmp==3) begin	    //因为确定一个按键需要四个时钟，当一次时钟对应的in_s为0000，并不能说明没有按键，所以定义tmp保证四个时钟都没有
			key_value <= 4'd17;//如果没有按键被按下定义为17无效态
			tmp<=0;
		end
		else begin
			key_value <= key_value;
			tmp<=tmp+1;
		end
	end
	else begin
		mm<={out_s,in_s};
		tmp<=0;
		case(mm)
		8'b1000_0001: key_value <= 8'd0;
		8'b1000_0010: key_value <= 8'd1;
		8'b1000_0100: key_value <= 8'd2;
		8'b1000_1000: key_value <= 8'd3;
		
		8'b0100_0001: key_value <= 8'd4;
		8'b0100_0010: key_value <= 8'd5;
		8'b0100_0100: key_value <= 8'd6;
		8'b0100_1000: key_value <= 8'd7;
		
		8'b0010_0001: key_value <= 8'd8;
		8'b0010_0010: key_value <= 8'd9;
		8'b0010_0100: key_value <= 8'd10;
		8'b0010_1000: key_value <= 8'd11;
		
		8'b0001_0001: key_value <= 8'd12;
		8'b0001_0010: key_value <= 8'd13;
		8'b0001_0100: key_value <= 8'd14;
		8'b0001_1000: key_value <= 8'd15;
		endcase
	end
end
endmodule
		

	



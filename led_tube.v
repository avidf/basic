//实现一个不带小数点的四位数码管，采用共阴极设计，显示数据
//输入频率1MHz,，这里用1000,000/256的刷新频率
module led_tube(clk, rst, data0, data1, data2, data3, wei, seg);

input clk;
input rst;
input data0,data1,data2,data3;//四个数码管的显示数据
output wei;//位选端
output seg;//段选端

wire[3:0] wei;
wire[6:0] seg;
wire [3:0] data0,data1,data2,data3;

reg[3:0] data[3:0];//将输入的数据存放到datamemory中
reg [7:0] data_wei[3:0];  //记录每一个data[data_i]数值对应段选编码
reg [9:0] clk_signal=0;//用于对1M时钟分频
reg [7:0] data_i;

reg[3:0] wei_reg;
reg[6:0] seg_reg;


assign seg=seg_reg;
assign wei=wei_reg;
 
always @(posedge clk ) begin
		clk_signal<=clk_signal+1;
	end
	
always @(posedge clk) begin
	if(!rst) 
		wei_reg <= 0;
	else
		case(clk_signal[9:8])
		0'b01: wei_reg <= 4'b0001;
		0'b10: wei_reg <= 4'b0010;
		0'b11: wei_reg <= 4'b0100;
		0'b00: wei_reg <= 4'b1000;
		endcase
	end

always @(posedge clk) begin
	if(!rst)
		seg_reg <= 0;
	else
		case(clk_signal[9:8])
		0'b01: seg_reg <= data_wei[0];
		0'b10: seg_reg <= data_wei[1];
		0'b11: seg_reg <= data_wei[2];
		0'b00: seg_reg <= data_wei[3];
		endcase 
	end
	
always @(posedge clk) begin//数码管ABCDEFG各个段的控制信号
	data[0]<=data0;
	data[1]<=data1;
	data[2]<=data2;
	data[3]<=data3;
	for(data_i=0;data_i<4;data_i=data_i+1)		
		case(data[data_i])
		0: data_wei[data_i] <= 7'b100_0000;
		1: data_wei[data_i] <= 7'b111_1001;
		2: data_wei[data_i] <= 7'b010_0100;
		3: data_wei[data_i] <= 7'b011_0000;
		4: data_wei[data_i] <= 7'b001_1001;
		5: data_wei[data_i] <= 7'b001_0010;
		6: data_wei[data_i] <= 7'b000_0010;
		7: data_wei[data_i] <= 7'b111_1000;
		8: data_wei[data_i] <= 7'b000_0000;
		9: data_wei[data_i] <= 7'b001_0000;
		default: data_wei[data_i] <= 7'b000_0000;
		endcase
	end	

endmodule
	
	
	
	

	






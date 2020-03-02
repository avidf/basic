`timescale 10ns/100ps

module led_tube_tb(wei,seg);
input wei;
input seg;
reg clk;
reg rst;
reg[3:0] data[3:0];//用于产生四个数码管的数据
reg[3:0] i;
wire[3:0] wei;
wire[6:0] seg;

reg [31:0] mm;//用于改变data
initial begin
	data[0]=0;
	data[1]=0;
	data[2]=0;
	data[3]=0;
	clk=0;
	rst=1;
	mm=0;	
	#50
	rst=0;
	#30
	rst=1;
	end
	

always #1 clk=~clk;

always@ (posedge clk) begin
	if(mm>2000)begin //改变的周期应该大于四位数码管的显示周期4*1M/256
		for(i=0;i<4;i=i+1)
			data[i]={$random}%9;
			mm=0;
		end
	else
		mm=mm+1;
	end

led_tube m_example(.clk(clk),.rst(rst),.data0(data[0]),.data1(data[1]),.data2(data[2]),.data3(data[3]),.wei(wei),.seg(seg));	
endmodule		
		
	
	

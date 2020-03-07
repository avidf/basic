//8位移位寄存器，串入并出或者串出
module register_right8(en, clk, din, dout_se, dout_pa);  

input en;
input clk; 
input din;

output dout_se;
output dout_pa;

wire dout_se;//串行出口
reg [7:0] dout_pa;//并行出口&八位寄存器
 
always @ (posedge clk)  begin
	if(en) begin
		dout_pa <= {dout_pa[6:0], din}; //每次输入一位
	end
end  

assign dout_se = dout_pa[7];//串行输出

endmodule  


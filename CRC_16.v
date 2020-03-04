/* 单字节校验
计算方法一般都是：
（1）、预置1个16位的寄存器为十六进制FFFF（即全为1），称此寄存器为CRC寄存器；
（2）、把第一个8位二进制数据与16位的CRC寄存器的低8位相异或，把结果放于CRC寄存器，高八位数据不变；
（3）、把CRC寄存器的内容右移一位（朝低位）用0填补最高位，并检查右移后的移出位；
（4）、如果移出位为0：重复第3步（再次右移一位）；如果移出位为1，CRC寄存器与多项式A001（1010,0000,0000,0001）进行异或；
（5）、重复步骤3和4，直到右移8次，这样整个8位数据全部进行了处理；
（6）、将该通讯信息帧所有字节按上述步骤计算完成后，得到的16位CRC寄存器的高、低字节进行交换；
（7）、最后得到的CRC寄存器内容即为：CRC码。
*/
module CRC_16(clk,data,rst,CRC);
input clk;
input data;//输入的一个字节数据
input rst;
output CRC;//输出校验码

wire [7:0] data;
reg [15:0] CRC;
reg [4:0] i;

parameter [15:0] CRC16=16'b1010_0000_0000_0001;
parameter [15:0] CRC16_start= 16'hFFFF;	

always@(posedge clk, negedge rst) begin//实际是组合逻辑只不过没来一个时钟就计算一次，clk也并不连在组合逻辑端，
	if (!rst) 
		CRC<=CRC;
	else begin
	CRC = CRC16_start ^ data;
	for(i=0;i<8;i=i+1)//对8位依次计算
		if(CRC[0] == 0) begin
		CRC = CRC>>1;
		end
		else begin
			CRC = (CRC>>1)^CRC16;
		end
	end
end
endmodule

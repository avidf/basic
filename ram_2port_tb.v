`timescale 1ns / 1ps   //1 period of clk is 10ns
module ram_2port_tb (
 output reg               rst_o,
 
 output reg               clk_wr_o,
 output reg               wr_en_o,
 output reg[7:0]          wr_addr_o,
 output reg[31:0]         wr_data_o,
 
 output reg               clk_rd_o,	
 output reg               rd_en_o,
 output reg[7:0]          rd_addr_o,	 
 input     [31:0]         rd_data_i
  );
  
initial begin
	$monitor($time,,,"Data = %d %d", wr_data_o,rd_data_i);    //监视数据线
	clk_rd_o   = 0;
	clk_wr_o   = 0;
	wr_en_o = 0;
	rd_en_o = 0;
	wr_addr_o  = 0;
	rd_addr_o  = 0;
	rst_o   = 1;	
	#20 rst_o = 0;
	//为方便查看，使写入的数据为地址的5倍
	write(50,250);
	write(100,500);  //地址100，写入500,下同
	write(200,1000); 
	write (250,1250);
	//读取数据
	read(50);
	read(100);
	read(200);
	read(250);
end

always begin
	#5 clk_wr_o = ~clk_wr_o;    //提供100MHz时钟
end
always begin
	#8 clk_rd_o = ~clk_rd_o;    
end

//0 < addr <255, 0 < WriteRAM <2^32 - 1
task write(
input[7:0]       x_i,
input[31:0]      y_i
);
begin
  #100;                  //拉开每次读写之间的间隔，简化innitial内容
  @(posedge clk_wr_o);      //时钟控制
  wr_addr_o = x_i;
  wr_data_o= y_i;
  #1                    //先给出地址和数据，再使能
  wr_en_o = 1'b1;
 // @(posedge clk_o);		//没有必要
  #50                   //拉长有效时间便于波形显示
  wr_en_o = 1'b0;
end
endtask

task read(             //读操作只需给出地址参数
input[7:0]       x_i
);
 begin
  #100;
  @(posedge clk_rd_o);
  rd_addr_o = x_i;
  #1
  rd_en_o = 1'b1;
  //@(posedge clk_o);		//没有必要
  #50
  rd_en_o =  1'b0;
 end
  endtask 

ram_2port inst_ram(
.rst_i(rst_o),
.clk_wr_i(clk_wr_o),
.wr_en_i(wr_en_o),
.wr_addr_i(wr_addr_o),
.wr_data_i(wr_data_o),
 
.clk_rd_i(clk_rd_o),	
.rd_en_i(rd_en_o),
.rd_addr_i(rd_addr_o),	 
.rd_data_o(rd_data_i)
  );  
endmodule

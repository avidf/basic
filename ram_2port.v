//异步双端口，读写时钟地址数据都是独立的两套
//模拟实现一个宽度为32，深度为256的内存空间
module ram_2port(
 input                   rst_i,
 
 input                   clk_wr_i,
 input                   wr_en_i,
 input [7:0]             wr_addr_i,
 input [31:0]            wr_data_i,
 
 input                   clk_rd_i,	
 input                   rd_en_i,
 input [7:0]             rd_addr_i,	 
 output[31:0]            rd_data_o
);

 reg [31:0]		bram[255:0];    
 integer	   	i;          //用于memory复位
 reg [31:0]		rd_addr_reg;

always @(posedge clk_wr_i or posedge rst_i)
    begin
       if (rst_i)   begin
           for(i=0;i<=255;i=i+1) //reset, 按字操作
           bram[i] <= 32'b0;
         end
       else 
		 if (wr_en_i) begin         //读数据可以设置为高阻，但是写数据是由外部控制，不能设置高阻
           bram[wr_addr_i] <= wr_data_i;
       end
    end

always @(posedge clk_rd_i)
		 if (rd_en_i) begin
           rd_addr_reg <= rd_addr_i;
       end	 
	 
assign rd_data_o = rd_en_i? bram[rd_addr_reg] : 32'bz; //三态门实现
endmodule



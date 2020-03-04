//模拟实现一个宽度为32，深度为256的内存空间；如果要实现异步的话可以定义读时钟和写时钟，写两个always块
module ram(
    input                   clk_i,
    input                   rst_i,
    input                   wr_en_i,
    input                   rd_en_i,
    input [7:0]             addr_i,
    inout [31:0]            data_io
);

    reg [31:0]       bram[255:0];    
    integer          i;   
    reg [31:0]       data;
//add implementation code here 
always @(posedge clk_i or posedge rst_i)
    begin
       if (rst_i)   
         begin
           for(i=0;i<=255;i=i+1) //reset, 按字操作
           bram[i] <= 32'b0;
         end
       else if (wr_en_i) begin
           bram[addr_i] <= data_io;
       end
       else if (rd_en_i) begin
           data <= bram[addr_i];//data_io是wire类型不能再always块中赋值
       end
       else begin
           data <= 32'bz;      //读写均无效时，为高阻态。若不加此句，时序会出现问题
       end
    end

    assign data_io = rd_en_i? data : 32'bz; //三态门实现
endmodule



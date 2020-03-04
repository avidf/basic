//tb_top
module tb_top;
  wire          clk;//把wire两个模块的接口连接起来
  wire          rst;
  wire          wr_en;
  wire          rd_en;
  wire[7:0]     addr;
  wire[31:0]    data;
  ram inst_ram(
      .clk_i(clk),
      .rst_i(rst),
      .wr_en_i(wr_en),
      .rd_en_i(rd_en),
      .addr_i(addr),
      .data_io(data)
  );
  tb_ram inst_tb_ram(
      .clk_o(clk),
      .rst_o(rst),
      .wr_en_o(wr_en),
      .rd_en_o(rd_en),
      .addr_o(addr),
      .data_io(data)
  );
 endmodule
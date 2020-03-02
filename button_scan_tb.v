`timescale 10ns/1ns
module button_scan_tb;

reg clk;
reg [3:0] in_s;
wire [3:0] out_s;
wire [7:0] key_value;

always #10 clk=~clk;

initial begin
	clk=0;
	in_s=4'b0001;
	end
	
always@ (posedge clk) begin//循环左移
	in_s={in_s[0],in_s[3:1]};
	end

button_scan mm (.clk(clk),.in_s(in_s),.out_s(out_s),.key_value(key_value));
endmodule
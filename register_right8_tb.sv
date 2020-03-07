`timescale 1ns/1ps  
module register_right8_tb; 
 
logic din;  
logic clk;  
logic en;  

reg [7:0] data;
wire dout_se;  
wire[7:0] dout_pa; 
       
always  #10 clk = ~clk;  
 
initial  
	begin 
	data = 8'b1110_0010;	
	clk = 0;   
	en = 1'b0;   
	#50 en = 1'b1;  	   
	#150 en = 1'b0;    
	end  
always @(posedge clk) begin
	if (en) begin
		din= data[0];		
		data=data>>1;
	end
end
	
register_right8 mm(.clk(clk), .en(en), .din(din), .dout_pa(dout_pa), .dout_se(dout_se));  
endmodule  

`timescale 1ns/1ps

//module declarations
module fake_RAM(
   //input declarations
   input I_clk,
   input I_we,
   input [15:0] I_addr,
   input [15:0] I_data,
   
   //output
   output [15:0] O_data
);
   
   //memeory declarations
   reg [15:0] mem [8:0];
   reg [15:0] O_data;
   
   //initialize regsiters
   initial begin
       
	   mem[0]=16'b1000000011111110;
	   mem[1]=16'b1000100111101101;
	   mem[2]=16'b0010001000100000;
	   mem[3]=16'b1000000011111111;
	   mem[4]=16'b1100000000111110;
	   mem[5]=16'b1010000011100110;
	   mem[6]=16'b1000001111111110;
	   mem[7]=0;
	   mem[8]=0;
	   
	   O_data =16'b0000000000000000;
	end
	
	//RAM operations
	always @(negedge I_clk) begin
	     
		if(I_we) begin
		   mem[I_addr [15:0]] <=I_data;
		end
		
        O_data<= mem[I_addr [15:0]];
	end
	
endmodule
		

`timescale 1ns/1ps

module cntrl_unit(

    //input declaration  
    input I_clk,
	input I_reset,
	
    //output declaration
    output O_enfetch,
	output O_endec,
	output O_enrgrd,
	output O_enrgwr,
	output O_enalu,
	output O_enmem
);
   
    reg [5:0] state; //reg declaration
	
	initial	begin
	   state <=6'b000001;
	end 
	
	always @(posedge I_clk) begin
	   if(I_reset)
	      state <=6'b000001;
		else begin
		   case (state)
		       6'b000001 : state<=6'b000010;
			   6'b000010 : state<=6'b000100;
			   6'b000100 : state<=6'b001000;
			   6'b001000 : state<=6'b010000;
			   6'b010000 : state<=6'b100000;
		    endcase
		end
	end	
	
	assign O_enfetch =state [0];
	assign O_endec   =state [1];
	assign O_enrgrd  =state [2];
	assign O_enalu   =state [3];
	assign O_enrgwr  =state [4];
	assign o_enmem   =state [5];
	
endmodule	

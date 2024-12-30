`timescale 1ns / 1ps

//module declarations
module alu(

    //input declarartion
    input I_clk,
	input I_en,
	input [4:0]  I_aluop,
	input [15:0] I_dataA,
	input [15:0] I_dataB,
	input [7:0]  I_Imm,
	
	//output declarartion
	output [15:0] O_dataResult,
	output reg O_shldBranch
);
    
	//reg/wire declarartion
    reg [17:0] int_result;
	wire [3:0 ] opcode;
	wire op_lsb;
	
	//initial block
	initial
	    int_result <=0;
		
	//assign values
    assign op_lsb = I_aluop[0];
    assign opcode =I_aluop[4:1];	
	   
	//parameter declaration
	localparam add=0,
	           sub=1,
			   or1 = 2,
			   and1 =3,
			   xor1 =4,
			   not1 =5,
			   load=8,
			   cmp=9,   //compare
			   shl=10,  //shift by left
			   shr=11,  //shift by right
			   jmpa=12, //jump address
			   jmpr=13; //jump resgiter
	
    //ALU operations
   	always @(negedge I_clk) begin
	
	     if(I_en) begin
		     
			case(opcode)
			    
				add : begin
				    int_result <=(op_lsb? ($signed(I_dataA)+ $signed(I_dataB)) :(I_dataA)+(I_dataB));
					O_shldBranch <=0;
				end
				
				sub : begin
				    int_result <=(op_lsb? ($signed(I_dataA)- $signed(I_dataB)) :(I_dataA)-(I_dataB));
					O_shldBranch <=0;
				end
				
				or1 : begin
				    int_result <= I_dataA | I_dataB;
					O_shldBranch <=0;
				end
				
				and1 : begin
				    int_result <= I_dataA & I_dataB;
					O_shldBranch <=0;
				end
				
				xor1 : begin
				    int_result <= I_dataA ^ I_dataB;
					O_shldBranch <=0;
				end
				
				not1 : begin
				    int_result <= ~I_dataA ;
					O_shldBranch <=0;
				end
				
				load : begin
				    int_result <= (op_lsb ? {I_Imm, 8'h00} : {8'h00, I_Imm});
					O_shldBranch <=0;
				end
				
				cmp : begin
				    
					if(op_lsb) begin
					   int_result[0] <=($signed(I_dataA)==$signed(I_dataA))? 1:0;
					   int_result[1] <=($signed(I_dataA)==0)? 1:0;
					   int_result[2] <=($signed(I_dataB)==0)? 1:0;
					   int_result[3] <=($signed(I_dataA) > $signed(I_dataB))? 1:0;
					   int_result[4] <=($signed(I_dataA) < $signed(I_dataB))? 1:0;
					   O_shldBranch <=0;
					end
					
					else begin
					   int_result[0] <=($signed(I_dataA)==$signed(I_dataA))? 1:0;
					   int_result[1] <=($signed(I_dataA)==0)? 1:0;
					   int_result[2] <=($signed(I_dataB)==0)? 1:0;
					   int_result[3] <=($signed(I_dataA) > $signed(I_dataB))? 1:0;
					   int_result[4] <=($signed(I_dataA) < $signed(I_dataB))? 1:0;
					   O_shldBranch <=0;
					end
			    end	

            	shl : begin
    			    int_result <= I_dataA << (I_dataB[3:0]);
					O_shldBranch <=0;
                
                end

				shl : begin
    			    int_result <= I_dataA >> (I_dataB[3:0]);
					O_shldBranch <=0;
                
                end
				
				jmpa :begin
				    int_result <= (op_lsb ? I_dataA : I_Imm );
                    O_shldBranch <=1;
                end	

                /*jmpr :begin
				   int_result <= I_dataA;
                   O_shldBranch <= I_dataB [op_lsb,I_Imm[1:0]];


                end	*/
                
            endcase
			
		end
			
    end	

endmodule

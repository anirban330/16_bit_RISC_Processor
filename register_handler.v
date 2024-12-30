`timescale 1ns/1ps

// Register File Module
module reg_file(
   input I_clk,
   input I_en,
   input I_we,
   input [2:0] I_selA,
   input [2:0] I_selB,
   input [2:0] I_selD,
   input [15:0] I_dataD,
   output reg [15:0] O_dataA,
   output reg [15:0] O_dataB
);

   reg [15:0] regs [7:0];
   integer count;

   initial begin
      O_dataA = 0;
      O_dataB = 0;
       for (count = 0; count < 8; count = count + 1) begin
         regs[count] = 0;
      end
   end

   always @(negedge I_clk) begin 
      if (I_en) begin
         if (I_we)
            regs[I_selD] <= I_dataD;
         O_dataA <= regs[I_selA];
         O_dataB <= regs[I_selB];
      end
   end

endmodule

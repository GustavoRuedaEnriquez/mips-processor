module BranchBox(
	input [31:0] reg1,
	input [31:0] reg2,
	input BEQ_Option,
	input BNE_Option,
	
	output reg Branch
);

   always @(*)
	begin 
	   Branch <= 1'b0;
	   if(BEQ_Option == 1 && reg1 == reg2)
		begin
          Branch <= 1'b1;
		end
	   if(BNE_Option == 1 && reg1 != reg2)
		begin
          Branch <=  1'b1;
		end
	end
	
endmodule

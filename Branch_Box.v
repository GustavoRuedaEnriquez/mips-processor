module BranchBox(
  input [31:0] reg1,
  input [31:0] reg2,
  input BEQ_Option,
  input BNE_Option,
  
  output reg Branch
);
  
  reg Equal;
	
  always@(*)
    begin
      Equal = (reg1 == reg2) ? 1'b1 : 1'b0;
      Branch = (BEQ_Option && Equal) || (BNE_Option && ~Equal);
    end
  
endmodule

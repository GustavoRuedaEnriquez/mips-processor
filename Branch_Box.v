module BranchBox(
  input [31:0] reg1,
  input [31:0] reg2,
  input BEQ_Option,
  input BNE_Option,
  
  output reg Branch
);
  
  always @(*)
  begin 
    if(BEQ_Option == 1 && reg1 == reg2)
    begin
      Branch <= 1'b1;
    end
    else if(BNE_Option == 1 && reg1 != reg2)
    begin
      Branch <=  1'b1;
    end
    else
    begin
      Branch <= 1'b0;
    end
  end
  
endmodule

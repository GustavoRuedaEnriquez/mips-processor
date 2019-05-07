module HazardDetectionUnit(
  input Branch,
  input ID_EX_MemRead,
  input [4:0] ID_EX_Rt_Reg,
  input [4:0] IF_ID_Rs_Reg,
  input [4:0] IF_ID_Rt_Reg,
  
  output reg Stall,
  output reg Flush,
  output reg Block_PC_Write,
  output reg Block_IF_ID_Write
);

  always @(*)
  begin 
    if(ID_EX_MemRead && ((ID_EX_Rt_Reg == IF_ID_Rs_Reg) || (ID_EX_Rt_Reg == IF_ID_Rt_Reg)))
    begin
      Stall <= 1'b1;
      Block_PC_Write <= 1'b1;
      Block_IF_ID_Write <= 1'b1;
    end
    else
    begin
      Stall <= 1'b0;
      Block_PC_Write <= 1'b0;
      Block_IF_ID_Write <= 1'b0;
    end
    Flush <= Branch;
  end
endmodule

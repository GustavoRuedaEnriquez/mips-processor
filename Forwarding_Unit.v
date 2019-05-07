module ForwardingUnit(
  input EX_MEM_RegWrite,
  input MEM_WB_RegWrite,
  input [4:0] ID_EX_Rs_Reg,
  input [4:0] ID_EX_Rt_Reg,
  input [4:0] EX_MEM_Rd_Reg,
  input [4:0] MEM_WB_Rd_Reg,
  
  output reg [1:0] ForwardA,
  output reg [1:0] ForwardB
);

  always @(*)
  begin
    ForwardA <= 2'b00;
    ForwardB <= 2'b00;
    if(EX_MEM_RegWrite && (EX_MEM_Rd_Reg != 0) && (EX_MEM_Rd_Reg == ID_EX_Rs_Reg))
    begin
      ForwardA <= 2'b10;
    end
    if(EX_MEM_RegWrite && (EX_MEM_Rd_Reg != 0) && (EX_MEM_Rd_Reg == ID_EX_Rt_Reg))
    begin
      ForwardB <= 2'b10;
    end
     if(MEM_WB_RegWrite && (MEM_WB_Rd_Reg != 0) && (EX_MEM_Rd_Reg != ID_EX_Rs_Reg) && (MEM_WB_Rd_Reg == ID_EX_Rs_Reg)) 
    begin
      ForwardA <= 2'b01;
    end
    if(MEM_WB_RegWrite && (MEM_WB_Rd_Reg != 0) && (EX_MEM_Rd_Reg != ID_EX_Rt_Reg) && (MEM_WB_Rd_Reg == ID_EX_Rt_Reg))
    begin
      ForwardB <= 2'b01;
    end
  end

endmodule
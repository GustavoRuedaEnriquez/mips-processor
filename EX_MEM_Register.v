module EX_MEM_Register(
  input clk,
  input reset,
	input in_Ctrl_Jal,
  input in_Ctrl_RegWrite,
  input in_Ctrl_MemToReg,
  input in_Ctrl_MemRead,
  input in_Ctrl_MemWrite,
	input [4:0]  in_Write_Register,
  input [31:0] in_ALU_Result,
  input [31:0] in_Write_Data,
  
  output reg out_Ctrl_Jal,
	output reg out_Ctrl_RegWrite,
  output reg out_Ctrl_MemToReg,
  output reg out_Ctrl_MemRead,
  output reg out_Ctrl_MemWrite,
  output reg [4:0]  out_Write_Register,
  output reg [31:0] out_ALU_Result,
  output reg [31:0] out_Write_Data
);
  
  always @(negedge reset or posedge  clk)
  begin
    if(reset==0)
    begin
      out_Ctrl_Jal          <= 0;
			out_Ctrl_RegWrite     <= 0;
      out_Ctrl_MemToReg     <= 0;
      out_Ctrl_MemRead      <= 0;
      out_Ctrl_MemWrite     <= 0;
      out_Write_Register    <= 0;
      out_ALU_Result        <= 0;
      out_Write_Data        <= 0;
    end 
    else
    begin
			out_Ctrl_Jal          <= in_Ctrl_Jal;
      out_Ctrl_RegWrite     <= in_Ctrl_RegWrite;
      out_Ctrl_MemToReg     <= in_Ctrl_MemToReg;
      out_Ctrl_MemRead      <= in_Ctrl_MemRead;
      out_Ctrl_MemWrite     <= in_Ctrl_MemWrite;
      out_Write_Register    <= in_Write_Register;
      out_ALU_Result        <= in_ALU_Result;
      out_Write_Data        <= in_Write_Data;
    end
  end
endmodule
	
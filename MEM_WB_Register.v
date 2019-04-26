module MEM_WB_Register(
  input clk,
  input reset,
  input in_Ctrl_RegWrite,
  input in_Ctrl_MemToReg,
  input [31:0] in_RAM_Read_Data,
  input [31:0] in_ALU_Result,
  input [4:0]  in_Write_Register,
  
  output reg out_Ctrl_RegWrite,
  output reg out_Ctrl_MemToReg,
  output reg [31:0] out_RAM_Read_Data,
  output reg [31:0] out_ALU_Result,
  output reg [4:0]  out_Write_Register
);
  
  always @(negedge reset or posedge  clk) begin
  if(reset==0) 
    begin
      out_Ctrl_RegWrite     <= 0;
      out_Ctrl_MemToReg     <= 0;
      out_RAM_Read_Data     <= 0; 
      out_ALU_Result        <= 0;
      out_Write_Register    <= 0;
    end 
  else
    begin
      out_Ctrl_RegWrite     <= in_Ctrl_RegWrite;
      out_Ctrl_MemToReg     <= in_Ctrl_MemToReg;
      out_RAM_Read_Data     <= in_RAM_Read_Data;  
      out_ALU_Result        <= in_ALU_Result;
      out_Write_Register    <= in_Write_Register;
    end
  end
endmodule
	
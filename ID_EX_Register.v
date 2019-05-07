module ID_EX_Register
(
  input clk,
  input reset,
  input in_Ctrl_RegWrite,
  input in_Ctrl_MemtoReg,
  input in_Ctrl_MemRead,
  input in_Ctrl_MemWrite,
  input in_Ctrl_BranchEQ,
  input [3:0]  in_Ctrl_ALUOp,
  input in_Ctrl_ALUSrc,
  input in_Ctrl_RegDst,
  input [31:0] in_InmmediateExtend,
  input [5:0]  in_funct,
  input [31:0] in_ReadData1,
  input [31:0] in_ReadData2,
  input [4:0]  in_rt,
  input [4:0]  in_rd,
  input [4:0] in_rs,
  input [4:0]  in_shamt,
  
  output reg out_Ctrl_RegWrite,
  output reg out_Ctrl_MemtoReg,
  output reg out_Ctrl_MemRead,
  output reg out_Ctrl_MemWrite,
  output reg out_Ctrl_BranchEQ,
  output reg [3:0] out_Ctrl_ALUOp,
  output reg out_Ctrl_ALUSrc,
  output reg out_Ctrl_RegDst,
  output reg [31:0] out_InmmediateExtend,
  output reg [5:0]  out_funct,
  output reg [31:0] out_ReadData1,
  output reg [31:0] out_ReadData2,
  output reg [4:0]  out_rt,
  output reg [4:0]  out_rd,
  output reg [4:0]  out_rs,
  output reg [4:0]  out_shamt
);

  always@(negedge reset or posedge clk) begin
    if(reset==0)
      begin
        out_Ctrl_RegWrite    <= 0;
        out_Ctrl_MemtoReg    <= 0;
        out_Ctrl_MemRead     <= 0;
        out_Ctrl_MemWrite    <= 0;
        out_Ctrl_BranchEQ    <= 0;
        out_Ctrl_ALUOp       <= 0;
        out_Ctrl_ALUSrc      <= 0;
        out_Ctrl_RegDst      <= 0;
        out_InmmediateExtend <= 0;
        out_funct            <= 0;
        out_ReadData1        <= 0;
        out_ReadData2        <= 0;
        out_rt               <= 0;
        out_rd               <= 0;
        out_rs               <= 0;
        out_shamt            <= 0;
      end
    else
      begin
        out_Ctrl_RegWrite    <= in_Ctrl_RegWrite;
        out_Ctrl_MemtoReg    <= in_Ctrl_MemtoReg;
        out_Ctrl_MemRead     <= in_Ctrl_MemRead;
        out_Ctrl_MemWrite    <= in_Ctrl_MemWrite;
        out_Ctrl_BranchEQ    <= in_Ctrl_BranchEQ;
        out_Ctrl_ALUOp       <= in_Ctrl_ALUOp;
        out_Ctrl_ALUSrc      <= in_Ctrl_ALUSrc;
        out_Ctrl_RegDst      <= in_Ctrl_RegDst;
        out_InmmediateExtend <= in_InmmediateExtend;
        out_funct            <= in_funct;
        out_ReadData1        <= in_ReadData1;
        out_ReadData2        <= in_ReadData2;
        out_rt               <= in_rt;
        out_rd               <= in_rd;
        out_rs               <= in_rs;
        out_shamt            <= in_shamt;
      end
  end

endmodule

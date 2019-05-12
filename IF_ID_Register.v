module IF_ID_Register
(
  input clk,
  input reset,
  input Flush,
  input Block_IF_ID_Write,
  input [31:0] in_PC_4,
  input [31:0] in_Instruction,
  
  output reg [31:0] out_PC_4,
  output reg [31:0] out_Instruction
);

  always@(negedge reset or posedge clk) 
  begin
    if(reset==0)
    begin
      out_PC_4        <= 0;
      out_Instruction <= 0;
    end
    else if(!Block_IF_ID_Write)
//		  begin
//        out_PC_4        <= in_PC_4;
//        out_Instruction <= in_Instruction;
//      end
    begin
      if(Flush)
      begin
        out_PC_4        <= 32'h0040_0000;
        out_Instruction <= 0;
      end
      else
      begin
        out_PC_4        <= in_PC_4;
        out_Instruction <= in_Instruction;
      end
    end
  end

endmodule

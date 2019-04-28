module ALU 
(
  input [3:0] ALUOperation,
  input [31:0] A,
  input [31:0] B,
  input [4:0] ALUShamt,
  output reg [31:0]ALUResult
);

//All possible operations.
localparam AND  = 4'b0000;
localparam OR   = 4'b0001;
localparam NOR  = 4'b0010;
localparam ADD  = 4'b0011;
localparam SLL  = 4'b0100;
localparam SRL  = 4'b0101;
localparam ORI  = 4'b0111;
localparam LUI  = 4'b1000;
localparam SUB  = 4'b1001;

always @ (A or B or ALUOperation or ALUShamt)
  begin
    case (ALUOperation)
      AND:
        ALUResult = A & B;
      OR:
        ALUResult = A | B;
      NOR:
        ALUResult = ~(A|B);
      ADD:
        ALUResult = A + B;
      SUB:
        ALUResult = A - B;
      SLL:
        ALUResult = B << ALUShamt;
      SRL:
        ALUResult = B >> ALUShamt;
      LUI:
        ALUResult = {B[15:0],16'h0000};
      default:
        ALUResult = 0;
    endcase
  end
endmodule 
module Control
(
  input [5:0]OP,
  
  output Jal,
  output Jump,
  output RegDst,
  output BranchEQ,
  output BranchNE,
  output MemRead,
  output MemtoReg,
  output MemWrite,
  output ALUSrc,
  output RegWrite,
  output [3:0]ALUOp
);
  //All instruction types.
  localparam R_Type       = 0;
  localparam I_Type_ADDI  = 6'b001000;
  localparam I_Type_ORI   = 6'b001101;
  localparam I_Type_LUI   = 6'b001111;
  localparam I_Type_ANDI  = 6'b001100;
  localparam I_Type_BEQ   = 6'b000100;
  localparam I_Type_BNE   = 6'b000101;
  localparam I_Type_LW    = 6'b100011;
  localparam I_Type_SW    = 6'b101011;
  localparam J_Type_J     = 6'b000010;
  localparam J_Type_JAL   = 6'b000011;

  reg [13:0] ControlValues;


  //Here we activate all the needed flags depending of the instruction.
  always@(OP) begin
    casex(OP)
      R_Type     : ControlValues = 14'b001_001_00_00_0111; 
      I_Type_ADDI: ControlValues = 14'b000_101_00_00_0100;
      I_Type_ANDI: ControlValues = 14'b000_101_00_00_0101;
      I_Type_ORI : ControlValues = 14'b000_101_00_00_0110;
      I_Type_LUI : ControlValues = 14'b000_101_00_00_0011;
      I_Type_BEQ : ControlValues = 14'b000_000_00_01_1000;
      I_Type_BNE : ControlValues = 14'b000_000_00_10_1001;
      I_Type_LW  : ControlValues = 14'b000_111_10_00_1010;
      I_Type_SW  : ControlValues = 14'b000_100_01_00_1011;
      J_Type_J   : ControlValues = 14'b010_000_00_00_0001;
      J_Type_JAL : ControlValues = 14'b110_001_00_00_0010;
      
      default:
        ControlValues= 14'b0;
      endcase
  end

  assign Jal      = ControlValues[13];  //Jal MUX Selector.
  assign Jump     = ControlValues[12];  //Jump MUX Selector.
  assign RegDst   = ControlValues[11];  //RegDest MUX Selector.
  assign ALUSrc   = ControlValues[10];  //ALUsrc MUX Selector.
  assign MemtoReg = ControlValues[9];   //MemtoReg MUX Selector.
  assign RegWrite = ControlValues[8];   //RegWrite signal.
  assign MemRead  = ControlValues[7];   //MemRead signal.
  assign MemWrite = ControlValues[6];   //MemWrite signal.
  assign BranchNE = ControlValues[5];   //BranchNE signal.
  assign BranchEQ = ControlValues[4];   //BranchEQ signal.
  assign ALUOp    = ControlValues[3:0];

endmodule

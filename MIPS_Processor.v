module MIPS_Processor
#(
  parameter MEMORY_DEPTH = 64
)

(
  input clk,
  input reset,
  input [7:0] PortIn,
  output [31:0] ALUResultOut,
  output [31:0] PortOut
);

assign  PortOut = 0;

//************ Register IF/ID I/O ************//
wire IF_ID_in_Flush_wire;
wire [31:0]  PC_4_wire;
wire [31:0]  Instruction_wire;

wire [31:0]  IF_ID_out_PC_4_wire;
wire [31:0]  IF_ID_out_Instruction_wire;
//********************************************//


//************ Register ID/EX I/O ************//
wire RegWrite_wire;
wire MemtoReg;
wire MemRead;
wire MemWrite;
wire BranchEQ_wire;
wire ALUSrc_wire;
wire RegDst_wire;
wire [3:0]  ALUOp_wire;
wire [31:0] InmmediateExtend_wire;
wire [31:0] ReadData1_wire;
wire [31:0] ReadData2_wire;

wire [31:0] ID_EX_out_PC;
wire [5:0]  ID_EX_out_funct_wire;
wire [4:0]  ID_EX_out_rt_wire;
wire [4:0]  ID_EX_out_rd_wire;
wire [4:0]  ID_EX_out_rs_wire;
wire [4:0]  ID_EX_out_shamt_wire;
wire [11:0] ID_EX_out_Ctrl_Signals_wire;
wire [31:0] ID_EX_out_InmmediateExtend_wire;
wire [31:0] ID_EX_out_ReadData1_wire;
wire [31:0] ID_EX_out_ReadData2_wire;
//********************************************//


//************ Register EX/MEM I/O ************//
wire [4:0]  WriteRegister_wire;
wire [31:0] AdderShiftedPlusPC4Result_wire;
wire [31:0] ALUResult_wire;

wire [31:0] EX_MEM_out_PC;
wire [4:0]  EX_MEM_out_Ctrl_Signals_wire;
wire [4:0]  EX_MEM_out_WriteRegister_wire;
wire [31:0] EX_MEM_out_ALUResult_wire;
wire [31:0] EX_MEM_out_WriteData_wire;
//*********************************************//


//************ Register MEM/WB I/O ************//
wire [31:0] EX_MEM_PC;
wire [31:0]  ReadDataRAM_wire;

wire [31:0] MEM_WB_out_PC;
wire [3:0]  MEM_WB_out_Ctrl_Signals_wire;
wire [4:0]  MEM_WB_out_Write_Register_wire;
wire [31:0] MEM_WB_out_RAM_Read_Data_wire;
wire [31:0] MEM_WB_out_ALU_Result_wire;
//*********************************************//

wire [1:0] Forward_A_Selector_wire;
wire [1:0] Forward_B_Selector_wire;
wire [31:0] Register_To_Use_wire;
wire [31:0] Entry_ALU_A_wire;
wire [31:0] Entry_ALU_B_wire;

wire Stall_wire;
wire Block_PC_Write_wire;
wire Block_IF_ID_Write_wire;
wire [12:0] Ctrl_Mux_Output_wire;

wire Branch_Selector_wire;

wire [31:0] Branch_MUX_Output;
wire [31:0] RAMtoReg_MUX_output_wire;
wire BranchNE_wire;
wire ORForBranch;
wire Jump;
wire Jal;
wire Jr;
wire [3:0]   ALUOperation_wire;
wire [4:0]   RegJalMux_wire;
wire [31:0]  WriteRegisterData_wire;
wire [31:0]  ShifthLeft2BranchOutput_wire;
wire [31:0]  ShifthLeft2JumpOutput_wire;
wire [31:0]  JumpAdderMuxOutput;
wire [31:0]  NextPC_wire;
wire [31:0]  PC8JalMuxOutput_wire;
wire [31:0]  PCPlus8_wire;
wire [31:0]  BranchAdderMuxOutput_wire;
wire [31:0]  MUX_PC_wire;
wire [31:0]  PC_wire;
wire [31:0]  InmmediateExtendAnded_wire;
wire [31:0]  PCtoBranch_wire;
wire [31:0]  PCToROM;
wire [31:0]  ALUToRAM;
wire [31:0]  WriteRegister_MUX_output_wire;

integer ALUStatus;


//******************************************************************/

Multiplexer2to1
#(
  .NBits(32)
)
MUX_ForPC
(
  .Selector(Branch_Selector_wire),
  .MUX_Data0(PC_4_wire),
  .MUX_Data1(AdderShiftedPlusPC4Result_wire),
  .MUX_Output(Branch_MUX_Output)
);

PC_Register
PC
(
  .clk(clk),
  .reset(reset),
  .Block_PC_Write(Block_PC_Write_wire),
  .NewPC(NextPC_wire),
  .PCValue(PC_wire)
);

Adder32bits
PC_Plus_4
(
  .Data0(PC_wire),
  .Data1(4),
  .Result(PC_4_wire)
);

Adder32bits
AdderPCToROM
(
  .Data0(PC_wire),
  .Data1(32'hFFC0_0000),
  .Result(PCToROM)
);

ProgramMemory
#(
  .MEMORY_DEPTH(MEMORY_DEPTH)
)
ROMProgramMemory
(
  .Address(PCToROM),
  .Instruction(Instruction_wire)
);

IF_ID_Register
IF_ID_Reg
(
  .clk(clk),
  .reset(reset),
  .Flush(IF_ID_in_Flush_wire),
  .Block_IF_ID_Write(Block_IF_ID_Write_wire),
  .in_PC_4(PC_4_wire),
  .in_Instruction(Instruction_wire),
  .out_PC_4(IF_ID_out_PC_4_wire),
  .out_Instruction(IF_ID_out_Instruction_wire)
);
//******************************************************************/




//******************************************************************/
HazardDetectionUnit
Hazard
(
  .Branch(Branch_Selector_wire),
	.Jump(Jump),
  .ID_EX_MemRead(ID_EX_out_Ctrl_Signals_wire[8]),
  .ID_EX_Rt_Reg(ID_EX_out_rt_wire),
  .IF_ID_Rs_Reg(IF_ID_out_Instruction_wire[25:21]),
  .IF_ID_Rt_Reg(IF_ID_out_Instruction_wire[20:16]),
  .Stall(Stall_wire),
  .Flush(IF_ID_in_Flush_wire),
  .Block_PC_Write(Block_PC_Write_wire),
  .Block_IF_ID_Write(Block_IF_ID_Write_wire)
);

Control
ControlUnit
(
  .OP(IF_ID_out_Instruction_wire[31:26]),
  .RegDst(RegDst_wire),
  .BranchNE(BranchNE_wire),
  .BranchEQ(BranchEQ_wire),
  .ALUOp(ALUOp_wire),
  .ALUSrc(ALUSrc_wire),
  .RegWrite(RegWrite_wire),
  .MemWrite(MemWrite),
  .MemRead(MemRead),
  .MemtoReg(MemtoReg),
  .Jump(Jump),
  .Jal(Jal)
);

Multiplexer2to1
#(
  .NBits(12)
)
MUX_ForControl
(
  .Selector(Stall_wire),
  .MUX_Data0({Jal,RegWrite_wire,MemtoReg,MemRead,MemWrite,BranchEQ_wire,ALUSrc_wire,RegDst_wire,ALUOp_wire}),
  .MUX_Data1(12'b000000000000),
  .MUX_Output(Ctrl_Mux_Output_wire)
);

RegisterFile
Register_File
(
  .clk(clk),  
  .reset(reset),
  .RegWrite(MEM_WB_out_Ctrl_Signals_wire[1]),
  .WriteRegister(WriteRegister_MUX_output_wire),
  .ReadRegister1(IF_ID_out_Instruction_wire[25:21]),
  .ReadRegister2(IF_ID_out_Instruction_wire[20:16]),
  .WriteData(WriteRegisterData_wire),
  .ReadData1(ReadData1_wire),
  .ReadData2(ReadData2_wire)

);

BranchBox
Branch
(
  .reg1(ReadData1_wire),
  .reg2(ReadData2_wire),
  .BEQ_Option(BranchEQ_wire),
  .BNE_Option(BranchNE_wire),
  .Branch(Branch_Selector_wire)
);

SignExtend
SignExtendForConstants
(   
  .DataInput(IF_ID_out_Instruction_wire[15:0]),
  .SignExtendOutput(InmmediateExtend_wire)
);

ShiftLeft2
ShiftLeft2Branch
(
  .DataInput(InmmediateExtend_wire),
  .DataOutput(ShifthLeft2BranchOutput_wire)
);

Adder32bits
AdderShiftedPlusPC4
(
  .Data0(ShifthLeft2BranchOutput_wire),
  .Data1(IF_ID_out_PC_4_wire),
  .Result(AdderShiftedPlusPC4Result_wire)
);

Multiplexer2to1
#(
  .NBits(32)
)
JumpMux
(
  .Selector(Jump),
  .MUX_Data0(Branch_MUX_Output),
  .MUX_Data1({IF_ID_out_PC_4_wire[31:28],IF_ID_out_Instruction_wire[27:0]<<2}),
  .MUX_Output(NextPC_wire)
);

ID_EX_Register
ID_EX_Reg
(
  .clk(clk),
  .reset(reset),
	.in_PC(IF_ID_out_PC_4_wire),
	.in_Ctrl_Jal(Ctrl_Mux_Output_wire[11]),
  .in_Ctrl_RegWrite(Ctrl_Mux_Output_wire[10]),
  .in_Ctrl_MemtoReg(Ctrl_Mux_Output_wire[9]),
  .in_Ctrl_MemRead(Ctrl_Mux_Output_wire[8]),
  .in_Ctrl_MemWrite(Ctrl_Mux_Output_wire[7]),
  .in_Ctrl_BranchEQ(Ctrl_Mux_Output_wire[6]),
  .in_Ctrl_ALUSrc(Ctrl_Mux_Output_wire[5]),
  .in_Ctrl_RegDst(Ctrl_Mux_Output_wire[4]),
  .in_Ctrl_ALUOp(Ctrl_Mux_Output_wire[3:0]),
  .in_InmmediateExtend(InmmediateExtend_wire),
  .in_funct(IF_ID_out_Instruction_wire[5:0]),
  .in_ReadData1(ReadData1_wire),
  .in_ReadData2(ReadData2_wire),
  .in_rt(IF_ID_out_Instruction_wire[20:16]),
  .in_rd(IF_ID_out_Instruction_wire[15:11]),
  .in_rs(IF_ID_out_Instruction_wire[25:21]),
  .in_shamt(IF_ID_out_Instruction_wire[10:6]),
	.out_PC(ID_EX_out_PC),
  .out_Ctrl_Jal(ID_EX_out_Ctrl_Signals_wire[11]),
  .out_Ctrl_RegWrite(ID_EX_out_Ctrl_Signals_wire[10]),
  .out_Ctrl_MemtoReg(ID_EX_out_Ctrl_Signals_wire[9]),
  .out_Ctrl_MemRead(ID_EX_out_Ctrl_Signals_wire[8]),
  .out_Ctrl_MemWrite(ID_EX_out_Ctrl_Signals_wire[7]),
  .out_Ctrl_BranchEQ(ID_EX_out_Ctrl_Signals_wire[6]),
  .out_Ctrl_ALUSrc(ID_EX_out_Ctrl_Signals_wire[5]),
  .out_Ctrl_RegDst(ID_EX_out_Ctrl_Signals_wire[4]),
  .out_Ctrl_ALUOp(ID_EX_out_Ctrl_Signals_wire[3:0]),
  .out_InmmediateExtend(ID_EX_out_InmmediateExtend_wire),
  .out_funct(ID_EX_out_funct_wire),
  .out_ReadData1(ID_EX_out_ReadData1_wire),
  .out_ReadData2(ID_EX_out_ReadData2_wire),
  .out_rt(ID_EX_out_rt_wire),
  .out_rd(ID_EX_out_rd_wire),
  .out_rs(ID_EX_out_rs_wire),
  .out_shamt(ID_EX_out_shamt_wire)
);
//******************************************************************/





//******************************************************************/

ALUControl
ArithmeticLogicUnitControl
(
  .ALUOp(ID_EX_out_Ctrl_Signals_wire[3:0]),
  .ALUFunction(ID_EX_out_funct_wire),
  .ALUOperation(ALUOperation_wire),
  .Jr(Jr)
);

Multiplexer3to1
#(
  .NBits(32)
)
MUX_ForALUEntryA
(
  .Selector(Forward_A_Selector_wire),
  .MUX_Data0(ID_EX_out_ReadData1_wire),
  .MUX_Data1(WriteRegisterData_wire),
  .MUX_Data2(EX_MEM_out_ALUResult_wire),
  .MUX_Output(Entry_ALU_A_wire)
);

Multiplexer3to1
#(
  .NBits(32)
)
MUX_ForRegisterToUse
(
  .Selector(Forward_B_Selector_wire),
  .MUX_Data0(ID_EX_out_ReadData2_wire),
  .MUX_Data1(WriteRegisterData_wire),
  .MUX_Data2(EX_MEM_out_ALUResult_wire),
  .MUX_Output(Register_To_Use_wire)
);

Multiplexer2to1
#(
  .NBits(32)
)
MUX_ForALUEntryB
(
  .Selector(ID_EX_out_Ctrl_Signals_wire[5]),  //ALUsrc
  .MUX_Data0(Register_To_Use_wire),
  .MUX_Data1(ID_EX_out_InmmediateExtend_wire),
  .MUX_Output(Entry_ALU_B_wire)
);

ALU
ArithmeticLogicUnit 
(
  .ALUOperation(ALUOperation_wire),
  .A(Entry_ALU_A_wire),
  .B(Entry_ALU_B_wire),
  .ALUShamt(ID_EX_out_shamt_wire),
  .ALUResult(ALUResult_wire)
);
assign ALUResultOut = ALUResult_wire;

Multiplexer2to1
#(
  .NBits(5)
)
MUX_ForRTypeAndIType
(
  .Selector(ID_EX_out_Ctrl_Signals_wire[4]),  //RedDest
  .MUX_Data0(ID_EX_out_rt_wire),
  .MUX_Data1(ID_EX_out_rd_wire),
  .MUX_Output(WriteRegister_wire)
);

ForwardingUnit
ForwardUnit
(
  .EX_MEM_RegWrite(EX_MEM_out_Ctrl_Signals_wire[3]),
  .MEM_WB_RegWrite(MEM_WB_out_Ctrl_Signals_wire[0]),
  .ID_EX_Rs_Reg(ID_EX_out_rs_wire),
  .ID_EX_Rt_Reg(ID_EX_out_rt_wire),
  .EX_MEM_Rd_Reg(EX_MEM_out_WriteRegister_wire),
  .MEM_WB_Rd_Reg(MEM_WB_out_Write_Register_wire),
  .ForwardA(Forward_A_Selector_wire),
  .ForwardB(Forward_B_Selector_wire)
);

EX_MEM_Register
EX_MEM_Reg
(
  .clk(clk),
  .reset(reset),
	.in_PC(ID_EX_out_PC),
  .in_Ctrl_Jal(ID_EX_out_Ctrl_Signals_wire[11]),
  .in_Ctrl_RegWrite(ID_EX_out_Ctrl_Signals_wire[10]),
  .in_Ctrl_MemToReg(ID_EX_out_Ctrl_Signals_wire[9]),
  .in_Ctrl_MemRead(ID_EX_out_Ctrl_Signals_wire[8]),
  .in_Ctrl_MemWrite(ID_EX_out_Ctrl_Signals_wire[7]),
  .in_Write_Register(WriteRegister_wire),
  .in_ALU_Result(ALUResult_wire),
  .in_Write_Data(Register_To_Use_wire),
	.out_PC(EX_MEM_out_PC),
  .out_Ctrl_Jal(EX_MEM_out_Ctrl_Signals_wire[4]),
  .out_Ctrl_RegWrite(EX_MEM_out_Ctrl_Signals_wire[3]),
  .out_Ctrl_MemToReg(EX_MEM_out_Ctrl_Signals_wire[2]),
  .out_Ctrl_MemRead(EX_MEM_out_Ctrl_Signals_wire[1]),
  .out_Ctrl_MemWrite(EX_MEM_out_Ctrl_Signals_wire[0]),
  .out_Write_Register(EX_MEM_out_WriteRegister_wire),
  .out_ALU_Result(EX_MEM_out_ALUResult_wire),
  .out_Write_Data(EX_MEM_out_WriteData_wire)
);
//******************************************************************/





//******************************************************************/
Adder32bits
AdderALUToRAM
(
  .Data0(EX_MEM_out_ALUResult_wire),
  .Data1(32'hEFFF_0000),
  .Result(ALUToRAM)
);

DataMemory
RAM
(
  .WriteData(EX_MEM_out_WriteData_wire),
  .Address(ALUToRAM >> 2),
  .MemWrite(EX_MEM_out_Ctrl_Signals_wire[0]),
  .MemRead(EX_MEM_out_Ctrl_Signals_wire[1]),
  .clk(clk),
  .ReadData(ReadDataRAM_wire)
);

MEM_WB_Register
MEM_WB_Reg
(
  .clk(clk),
  .reset(reset),
	.in_PC(EX_MEM_out_PC),
  .in_Ctrl_Jal(EX_MEM_out_Ctrl_Signals_wire[4]),
  .in_Ctrl_RegWrite(EX_MEM_out_Ctrl_Signals_wire[3]),
  .in_Ctrl_MemToReg(EX_MEM_out_Ctrl_Signals_wire[2]),
  .in_RAM_Read_Data(ReadDataRAM_wire),
  .in_ALU_Result(EX_MEM_out_ALUResult_wire),
  .in_Write_Register(EX_MEM_out_WriteRegister_wire),
  .out_PC(MEM_WB_out_PC),
	.out_Ctrl_Jal(MEM_WB_out_Ctrl_Signals_wire[2]),
  .out_Ctrl_RegWrite(MEM_WB_out_Ctrl_Signals_wire[1]),
  .out_Ctrl_MemToReg(MEM_WB_out_Ctrl_Signals_wire[0]),
  .out_RAM_Read_Data(MEM_WB_out_RAM_Read_Data_wire),
  .out_ALU_Result(MEM_WB_out_ALU_Result_wire),
  .out_Write_Register(MEM_WB_out_Write_Register_wire)
);
//******************************************************************/





//******************************************************************/

Multiplexer2to1
#(
  .NBits(32)
)
RAMtoRegDataMux
(
  .Selector(MEM_WB_out_Ctrl_Signals_wire[0]), //MemToReg
  .MUX_Data0(MEM_WB_out_ALU_Result_wire),
  .MUX_Data1(MEM_WB_out_RAM_Read_Data_wire),
  .MUX_Output(RAMtoReg_MUX_output_wire)
);

Multiplexer2to1
#(
  .NBits(32)
)
WriteDataMux
(
  .Selector(MEM_WB_out_Ctrl_Signals_wire[2]),
  .MUX_Data0(RAMtoReg_MUX_output_wire),
  .MUX_Data1(MEM_WB_out_PC),
  .MUX_Output(WriteRegisterData_wire)
);


Multiplexer2to1
#(
  .NBits(32)
)
WriteRegisterMux
(
  .Selector(MEM_WB_out_Ctrl_Signals_wire[2]), 
  .MUX_Data0(MEM_WB_out_Write_Register_wire),
  .MUX_Data1(31),
  .MUX_Output(WriteRegister_MUX_output_wire)
);

Multiplexer2to1
#(
  .NBits(32)
)
BranchAdderMux
(
  .Selector(ORForBranch),
  .MUX_Data0(PC_4_wire),
  .MUX_Data1(AdderShiftedPlusPC4Result_wire),
  .MUX_Output(BranchAdderMuxOutput_wire)
);
ShiftLeft2
ShiftLeft2Jump
(
  .DataInput(Instruction_wire[25:0]),
  .DataOutput(ShifthLeft2JumpOutput_wire)
);


//Multiplexer2to1
//#(
//  .NBits(32)
//)
//JrAdderMux
//(
//  .Selector(Jr),
//  .MUX_Data0(JumpAdderMuxOutput),
//  .MUX_Data1(ReadData1_wire),
//  .MUX_Output(NextPC_wire)
//);

endmodule


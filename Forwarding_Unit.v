module ForwardingUnit(
	input [4:0] ID_EX_Rt_Reg,
	input [4:0] ID_EX_Rs_Reg,
	input [4:0] EX_MEM_Rt_Reg,
	input [4:0] MEM_WB_Rs_Reg,
	input EX_MEM_RegWrite,
	input MEM_WB_RegWrite,
	
	output reg [1:0] ForwardA,
	output reg [1:0] ForwardB
);

endmodule

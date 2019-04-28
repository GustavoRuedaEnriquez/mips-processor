module PC_Register
#(
  parameter N=32
)
(
  input clk,
  input reset,
  input Block_PC_Write,
  input [N-1:0] NewPC,
  
  output reg [N-1:0] PCValue
);

always@(negedge reset or posedge clk) begin
  if(reset==0)
    PCValue <= 32'h0040_0000;
  else if(Block_PC_Write != 1) 
    PCValue<=NewPC;
end

endmodule

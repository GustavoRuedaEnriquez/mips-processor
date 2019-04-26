module ShiftLeft2 
(   
  input [31:0]  DataInput,
  output reg [31:0] DataOutput

);
  always @ (DataInput)
    DataOutput = {DataInput[29:0], 1'b0, 1'b0};
    
endmodule 

module SignExtend
(   
  input [15:0]  DataInput,
  output[31:0] SignExtendOutput
);

assign  SignExtendOutput = {{16{DataInput[15]}},DataInput[15:0]};

endmodule 


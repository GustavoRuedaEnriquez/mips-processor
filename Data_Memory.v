module DataMemory 
#(  parameter DATA_WIDTH=32,
  parameter MEMORY_DEPTH = 1024

)
(
  input  [DATA_WIDTH-1:0] WriteData,
  input  [DATA_WIDTH-1:0]  Address,
  input  MemWrite,MemRead, clk,
  output [DATA_WIDTH-1:0]  ReadData
);
  
  // Declare the RAM variable
  reg [DATA_WIDTH-1:0] ram[MEMORY_DEPTH-1:0];
  wire [DATA_WIDTH-1:0] ReadDataAux;
  always @ (posedge clk)
  begin
    if (MemWrite)
      ram[Address] <= WriteData;
  end
  assign ReadDataAux = ram[Address];
  assign ReadData = {DATA_WIDTH{MemRead}}& ReadDataAux;

endmodule

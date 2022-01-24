module data_memory 
#( 
  parameter DATA_WIDTH=32,
  parameter MEMORY_DEPTH = 1024
)
(
  input  clk,
  input  read_enable,
  input  write_enable,
  input  [DATA_WIDTH-1:0] in_data,
  input  [DATA_WIDTH-1:0] address,
  output [DATA_WIDTH-1:0] out_data
);
  
  reg  [DATA_WIDTH-1:0] ram[MEMORY_DEPTH-1:0];
  wire [DATA_WIDTH-1:0] aux_out_data;
  
  always @ (posedge clk)
  begin
    if (write_enable)
      ram[address] <= in_data;
  end
  assign aux_out_data = ram[address];
  assign out_data = { DATA_WIDTH{read_enable} } & aux_out_data;

endmodule

module program_memory
#
(
  parameter MEMORY_DEPTH=256,
  parameter DATA_WIDTH=32
)
(
  input      [DATA_WIDTH-1:0] address,
  output reg [DATA_WIDTH-1:0] instruction
);

  wire [DATA_WIDTH-1:0] real_address;
  reg  [DATA_WIDTH-1:0] rom[MEMORY_DEPTH-1:0];

  assign real_address = {2'b0, address[DATA_WIDTH-1:2]};

  initial
  begin
    $readmemh("text.dat", rom);
  end

  always @ (real_address)
  begin
    instruction = rom[real_address];
  end

endmodule

module Adder32bits
#
(
  parameter NBits=32
)
(
  input [NBits-1:0] Data0,
  input [NBits-1:0] Data1,
  
  output [NBits-1:0] Result
);

assign Result = Data1 + Data0;

endmodule

module Multiplexer2to1
#(
  parameter NBits=32
)
(
  input Selector,
  input [NBits-1:0] MUX_Data0,
  input [NBits-1:0] MUX_Data1,
  
  output reg [NBits-1:0] MUX_Output

);

  always@(Selector,MUX_Data1,MUX_Data0) begin
    if(Selector)
      MUX_Output = MUX_Data1;
    else
      MUX_Output = MUX_Data0;
  end

endmodule

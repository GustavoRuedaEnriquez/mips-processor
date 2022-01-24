module register
#(
  parameter N=32
)
(
  input clk,
  input reset,
  input enable,
  input [N-1:0] in_data,
  output reg [N-1:0] out_data
);

  always@(negedge reset or negedge clk)
  begin
    if(reset==0)
      out_data <= 0;
    else  
      if(enable==1)
        out_data <= in_data;
  end

endmodule

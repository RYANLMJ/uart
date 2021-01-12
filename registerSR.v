module registerSR(clock,reset,out_max,D);

input clock,reset;
input[7:0] out_max;

output[7:0] D;

reg[7:0] D=8'b00000000;

always@(posedge clock or negedge reset)
begin
 if (reset==0)
 D=8'b00000000;
 else
 D=out_max;
 end
 
endmodule 
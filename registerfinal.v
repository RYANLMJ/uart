module registerfinal(clock, reset, in_final, out_final);

input clock, reset;
input [31:0] in_final;
output [31:0] out_final;

reg[31:0] out_final;



always@(posedge clock or negedge reset)
begin
 if (reset==0)
 out_final=8'b00000000;
 else
 out_final=in_final;
 end
 
 endmodule 
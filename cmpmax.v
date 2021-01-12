module cmpmax (out_data,D,out_max, count_clock);

 input count_clock;
 input [7:0] out_data, D;
 output [7:0] out_max;
 

 reg [7:0] out_max;
 
 
always @(negedge count_clock)
begin
 if (out_data==8'b11111111)
 begin 
  out_max=8'b00000000;
  end else
  begin
  if (out_data>D)
   begin
	out_max=out_data;
	end
  else if (out_data<D)
   begin
	 out_max=D;
	 end
  else out_max=out_data;
  end
end
endmodule 
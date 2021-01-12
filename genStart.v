module genStart(reset, clock, adc_start);
 input reset, clock;
 output adc_start;
 
 reg adc_start;
 integer count;
 
 always @(negedge reset or posedge clock)
 begin
  if (reset == 0) begin
	adc_start = 0;
   count=0;
  end else begin 
   if (count >= 16400) begin
    count=0;
	 adc_start=1;
	end else begin
    adc_start = 0;
	 count=count+1;
	end
  end
 end

endmodule	
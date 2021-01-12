module freqADC(reset, clock, adc_clock);
 input reset, clock;
 output adc_clock;
 
 reg adc_clock;
 integer count;
 
 always @(negedge reset or posedge clock)
  begin
   if (reset == 0)
	begin
    adc_clock=0;
	 count=0;
   end else
	
   begin
	 if (count>=50) 
	 begin
	  count=0;
	  adc_clock=~adc_clock;
	 end else
	  count=count+1;
	 end
	end

endmodule 


module freqcount(reset, clock, count_clock);
 input reset, clock;
 output count_clock;
 
 reg count_clock;
 integer count;
 
 always @(negedge reset or posedge clock)
  begin
   if (reset == 0)
	begin
    count_clock=0;
	 count=0;
   end else
	
   begin
	 if (count>=900000) 
	 begin
	  count=0;
	  count_clock=~count_clock;
	 end else
	  count=count+1;
	 end
	end

endmodule 
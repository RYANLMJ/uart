module comm(reset, clock, eoc, adc_data, adc_clock, start, ale, oe, address, txPin, ready, data);
 
 input reset, clock, eoc;
 input [7:0] adc_data;

 output adc_clock;
 output start, ale, oe;
 output [2:0] address;

 wire [7:0] out_reg_1, out_reg_2, out_reg_3, out_reg_4;
 wire [7:0] out_max_1, out_max_2, out_max_3, out_max_4;
 
middle U28(reset, clock, adc_clock, eoc, adc_data, start, ale, oe, address, out_reg_1, out_reg_2, out_reg_3, out_reg_4, out_max_1, out_max_2, out_max_3, out_max_4);


 integer count=0;
 
always@(posedge thirtyEightKHz or negedge reset)
begin
 if (reset==0) begin
   send=1;
   data=8'b00000000;
    end
		
 else
  if (count >= 3) count=0;
  else count = count+1;
  
  case (count)
   0 : begin
	 send=1;
	 data=out_reg_1;
   end
   1 : begin
	 send=1;
	 data=out_reg_2;
   end
   2 : begin
	 send=1;
	 data=out_reg_3;
   end
   default : begin
	 send=1;
    data=out_reg_4;
   end
   endcase
 end
 
  reg send;
  wire thirtyEightKHz;
  output txPin, ready;
  output [7:0] data;
  wire [7:0] data;
 
 tx_sys U29(reset, clock, send, txPin, ready, data);

 
endmodule



module ADC(reset, clock, adc_clock, eoc, adc_data, start, ale, oe, address, out_data);
 
 input reset, clock, eoc;
 input [7:0] adc_data;
 
 output adc_clock;
 output start, ale, oe;
 output [2:0] address;
 output [7:0] out_data;
 
 wire adc_clock;
 reg start, ale, oe;
 reg [2:0] address;
 reg [7:0] out_data;
 
 wire start_1, start_2, start_3, start_4;
 wire ale_1, ale_2, ale_3, ale_4;
 wire oe_1, oe_2, oe_3, oe_4;
 wire [2:0] address_1, address_2, address_3, address_4;
 wire [7:0] out_data_1, out_data_2, out_data_3, out_data_4;
 wire count_clock;
 
freqADC U1(1, clock, adc_clock);
freqcount U8(1, clock, count_clock);
adc_Controller U4(reset, adc_clock, eoc, adc_data, start_1, ale_1, oe_1, 3'b000, address_1, out_data_1);
adc_Controller U5(reset, adc_clock, eoc, adc_data, start_2, ale_2, oe_2, 3'b001, address_2, out_data_2);
adc_Controller U6(reset, adc_clock, eoc, adc_data, start_3, ale_3, oe_3, 3'b010, address_3, out_data_3);
adc_Controller U7(reset, adc_clock, eoc, adc_data, start_4, ale_4, oe_4, 3'b011, address_4, out_data_4);

integer count=0;
wire rst;

assign rst=~reset;

always@(posedge count_clock or negedge rst)
begin
 if (rst==0) begin
   out_data=8'b00000000;
    end
		
 else
  if (count >= 3) count=0;
  else count = count+1;
  
  case (count)
   0 : begin
	 address=address_1;
	 start=start_1;
	 ale=ale_1; 
	 oe=oe_1;
	 out_data=out_data_1;
   end
   1 : begin
	 address=address_2;
	 start=start_2;
	 ale=ale_2; 
	 oe=oe_2;
	 out_data=out_data_2;
   end
   2 : begin
	 address=address_3;
	 start=start_3;
	 ale=ale_3; 
	 oe=oe_3;
	 out_data=out_data_3;
   end
   default : begin
	 address=address_4;
	 start=start_4;
	 ale=ale_4; 
	 oe=oe_4;
	 out_data=out_data_4;
   end
   endcase
 end
 
 endmodule 
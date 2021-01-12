module first(reset, clock, adc_clock, eoc, adc_data, start, ale, oe, address, out_reg_1, out_reg_2, out_reg_3, out_reg_4);


ADC U9(reset, clock, adc_clock, eoc, adc_data, start, ale, oe, address, out_data);

 input reset, clock, eoc;
 input [7:0] adc_data;
 wire [7:0] out_data;
 output adc_clock;
 output start, ale, oe;
 output [2:0] address;

 reg [7:0] in_reg_1, in_reg_2, in_reg_3, in_reg_4;
 output [7:0] out_reg_1, out_reg_2, out_reg_3, out_reg_4;

freqcount U8(1, clock, count_clock);
SRregister U11(in_reg_1, reset, clock, out_reg_1);
SRregister U12(in_reg_2, reset, clock, out_reg_2);
SRregister U13(in_reg_3, reset, clock, out_reg_3);
SRregister U14(in_reg_4, reset, clock, out_reg_4);
 
always @(posedge count_clock)
begin
if (address==3'b000)
 in_reg_1=out_data;
else if (address==3'b001)
 in_reg_2=out_data;
else if (address==3'b010)
 in_reg_3=out_data;
else if(address == 3'b011)
 in_reg_4=out_data;
end

endmodule 
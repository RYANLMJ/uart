module middle(reset, clock, adc_clock, eoc, adc_data, start, ale, oe, address, out_reg_1, out_reg_2, out_reg_3, out_reg_4, out_max_1, out_max_2, out_max_3, out_max_4);

 input reset, clock, eoc;
 input [7:0] adc_data;
 
 output adc_clock;
 output start, ale, oe;
 output [2:0] address;
 output [7:0] out_reg_1, out_reg_2, out_reg_3, out_reg_4;
 
first U17(reset, clock, adc_clock, eoc, adc_data, start, ale, oe, address, out_reg_1, out_reg_2, out_reg_3, out_reg_4);
 
 wire [7:0] D_1, D_2, D_3, D_4;
 output [7:0] out_max_1, out_max_2, out_max_3, out_max_4;
 
cmpmax U18(out_reg_1, D_1, out_max_1, clock);
cmpmax U19(out_reg_2, D_2, out_max_2, clock);
cmpmax U20(out_reg_3, D_3, out_max_3, clock);
cmpmax U21(out_reg_4, D_4, out_max_4, clock);

SRregister U22(out_max_1, reset, clock, D_1);
SRregister U23(out_max_2, reset, clock, D_2);
SRregister U24(out_max_3, reset, clock, D_3);
SRregister U25(out_max_4, reset, clock, D_4);

endmodule 
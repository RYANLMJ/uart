module final(reset, clock, adc_clock, eoc, adc_data, start, ale, oe, address, lcd_d, lcd_rs, lcd_rw, lcd_e, out_reg_2, out_reg_3, out_max_2, out_max_3);

 input reset, clock, eoc;
 input [7:0] adc_data;

 output adc_clock;
 output start, ale, oe;
 output [2:0] address;
 
 output [7:0] out_reg_2, out_reg_3;
 wire [7:0] out_reg_1, out_reg_4;
 output [7:0] out_max_2, out_max_3;
 wire [7:0] out_max_1, out_max_4;
 
middle U28(reset, clock, adc_clock, eoc, adc_data, start, ale, oe, address, out_reg_1, out_reg_2, out_reg_3, out_reg_4, out_max_1, out_max_2, out_max_3, out_max_4);
 
 
 wire [7:0] tens_1, tens_2, tens_3, tens_4;
 wire [7:0] ones_1, ones_2, ones_3, ones_4;
 
conversion U29(out_max_1, tens_1, ones_1);
conversion U30(out_max_2, tens_2, ones_2);
conversion U31(out_max_3, tens_3, ones_3);
conversion U32(out_max_4, tens_4, ones_4);


 wire [7:0] tens_11, tens_21, tens_31, tens_41;
 wire [7:0] ones_11, ones_21, ones_31, ones_41;
 
conversion U33(out_reg_1, tens_11, ones_11);
conversion U34(out_reg_2, tens_21, ones_21);
conversion U35(out_reg_3, tens_31, ones_31);
conversion U36(out_reg_4, tens_41, ones_41);


 output [7:0] lcd_d;
 output lcd_rs, lcd_rw, lcd_e;
 wire clk_50;

lcdcontroller U37(clk_50, reset, lcd_d, lcd_rs, lcd_rw, lcd_e, clock, tens_1, ones_1, tens_2, ones_2, tens_3, ones_3, tens_4, ones_4, tens_11, ones_11, tens_21, ones_21, tens_31, ones_31, tens_41, ones_41);

endmodule 
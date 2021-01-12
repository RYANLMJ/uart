module lcdcontroller(clk_50, reset, lcd_d, lcd_rs, lcd_rw, lcd_e, clock, tens_1, ones_1, tens_2, ones_2, tens_3, ones_3, tens_4, ones_4, tens_11, ones_11, tens_21, ones_21, tens_31, ones_31, tens_41, ones_41);
input reset, clock;
output[7:0] lcd_d;
output lcd_rs, lcd_rw, lcd_e ,clk_50;

wire rst;
wire clk_50;
input [7:0] tens_1, ones_1, tens_2, ones_2, tens_3, ones_3, tens_4, ones_4, tens_11, ones_11, tens_21, ones_21, tens_31, ones_31, tens_41, ones_41;

assign rst=~reset;
freqlcd U26 (rst,clock,clk_50);
textLCD U27 (clk_50, rst, lcd_d, lcd_rs, lcd_rw, lcd_e, tens_1, ones_1, tens_2, ones_2, tens_3, ones_3, tens_4, ones_4, tens_11, ones_11, tens_21, ones_21, tens_31, ones_31, tens_41, ones_41);
endmodule 
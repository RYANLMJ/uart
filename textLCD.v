module textLCD(clk_50, reset, lcd_d, lcd_rs, lcd_rw, lcd_e, tens_1, ones_1, tens_2, ones_2, tens_3, ones_3, tens_4, ones_4, tens_11, ones_11, tens_21, ones_21, tens_31, ones_31, tens_41, ones_41);
input reset,clk_50;
output[7:0] lcd_d;
output lcd_rs, lcd_rw, lcd_e;

reg [8:0] lcd_cnt;
reg [7:0] lcd_db;
wire [7:0] lcd_d;
wire[7:0] lcd_state;
wire lcd_rs,lcd_rw,lcd_e;

input [7:0] tens_1, ones_1, tens_2, ones_2, tens_3, ones_3, tens_4, ones_4;
input [7:0] tens_11, ones_11, tens_21, ones_21, tens_31, ones_31, tens_41, ones_41;

always @(posedge clk_50 or negedge reset)
begin
if (reset==0) 
lcd_cnt = 0;
else 
begin
if (lcd_cnt == 9'b001101001)
lcd_cnt = 0;
else
lcd_cnt=lcd_cnt+1;
end
end

assign lcd_state={lcd_cnt[8:1]};

always @(posedge clk_50) begin
 case (lcd_state)
8'h00   :lcd_db=   8'b00111000;
8'h01   :lcd_db=   8'b00001000;
8'h02   :lcd_db=   8'b00000001;
8'h03   :lcd_db=   8'b00000110;
8'h04   :lcd_db=   8'b00001100;
8'h05   :lcd_db=   8'b00000011;
8'h06   :lcd_db=   8'h52;
8'h07   :lcd_db=   tens_11;//real 1 ten
8'h08   :lcd_db=   8'h2E;
8'h09   :lcd_db=   ones_11;//real 1 one
8'h0A   :lcd_db=   8'h20;
8'h0B   :lcd_db=   tens_21;//real 2 ten
8'h0C   :lcd_db=   8'h2E;
8'h0D   :lcd_db=   ones_21;//real 2 one
8'h0E   :lcd_db=   8'h20;
8'h0F   :lcd_db=   tens_31;//real 3 ten
8'h10   :lcd_db=   8'h2E;
8'h11   :lcd_db=   ones_31;//real 3 one
8'h12   :lcd_db=   8'h20;
8'h13   :lcd_db=   tens_41;//real 4 ten
8'h14   :lcd_db=   8'h2E;
8'h15   :lcd_db=   ones_41;//real 4 one
8'h16   :lcd_db=   8'hC0;
8'h17   :lcd_db=   8'h4D;
8'h18   :lcd_db=   tens_1;//max 1 ten
8'h19   :lcd_db=   8'h2E;
8'h1A   :lcd_db=   ones_1;//max 1 one
8'h1B   :lcd_db=   8'h20;
8'h1C   :lcd_db=   tens_2;//max 2 ten
8'h1D   :lcd_db=   8'h2E;
8'h1E   :lcd_db=   ones_2;//max 2 one
8'h1F   :lcd_db=   8'h20;
8'h20   :lcd_db=   tens_3;//max 3 ten
8'h21   :lcd_db=   8'h2E;
8'h22   :lcd_db=   ones_3;//max 3 one
8'h23   :lcd_db=   8'h20;
8'h24   :lcd_db=   tens_4;//max 4 ten
8'h25   :lcd_db=   8'h2E;
8'h26   :lcd_db=   ones_4;//max 4 one
default:lcd_db=8'h00;
endcase;
end

assign lcd_rw =1'b0;
assign lcd_e = lcd_cnt[0];
assign lcd_rs=((lcd_state >=8'h00 && lcd_state <=8'h05)||(lcd_state==8'h16))? 1'b0 : 1'b1;
assign lcd_d=lcd_db;


endmodule
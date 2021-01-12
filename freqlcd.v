module freqlcd(reset,clock,clk_50);
input reset,clock;
output clk_50;
reg clk_50;
integer clk_cnt;

always @(posedge clock or negedge reset) 
begin
if (reset==0)
begin
clk_cnt=0;
clk_50 =0;
end
else begin
if (clk_cnt>=24999) begin
clk_cnt=0;
clk_50<=~clk_50;
end else
clk_cnt=clk_cnt+1;
end
end
endmodule
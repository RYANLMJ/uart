module freq38K(reset,clock,thirtyEightKHz);
input reset,clock;
output thirtyEightKHz;

reg thirtyEightKHz;
integer count;

always @(negedge reset or posedge clock)
begin
 if (reset == 0)
begin
 thirtyEightKHz =0;
count = 0;
end else
begin
 if (count>= 650) begin
count = 0;
thirtyEightKHz = ~thirtyEightKHz;
end else
count= count +1;
end
end
endmodule
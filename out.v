module out(reset, clock, adc_clock, eoc, adc_data, start, ale, oe, address, out_data, out_final);

 input reset, clock, eoc;
 input [7:0] adc_data;
 
 output adc_clock;
 output start, ale, oe;
 output [2:0] address;
 output [7:0] out_data;
 wire [31:0] out_regst;
 
 
ADC U11(reset, clock, adc_clock, eoc, adc_data, start, ale, oe, address, out_data);
registerfirst U12(out_data, out_regst);


reg [7:0] in_cmp_1, in_cmp_2, in_cmp_3, in_cmp_4;
wire [7:0] D_1, D_2, D_3, D_4;
wire [7:0] out_max_1, out_max_2, out_max_3, out_max_4;


cmp U21(in_cmp_1, D_1, out_max_1, clock, reset);
cmp U22(in_cmp_2, D_2, out_max_2, clock, reset);
cmp U23(in_cmp_3, D_3, out_max_3, clock, reset);
cmp U24(in_cmp_4, D_4, out_max_4, clock, reset);

SRregister U31(out_max_1, reset, clock, D_1);
SRregister U32(out_max_2, reset, clock, D_2);
SRregister U33(out_max_3, reset, clock, D_3);
SRregister U34(out_max_4, reset, clock, D_4);

reg [31:0] in_final;
output [31:0] out_final;

registerfinal U13(clock, reset, in_final, out_final);


always @(posedge clock)
begin
in_cmp_1=out_regst[31:24];
in_cmp_2=out_regst[23:16];
in_cmp_3=out_regst[15:8];
in_cmp_4=out_regst[7:0];

in_final[31:24]=out_max_1;
in_final[23:16]=out_max_2;
in_final[15:8]=out_max_3;
in_final[7:0]=out_max_4;
end


endmodule 
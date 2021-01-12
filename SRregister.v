module SRregister(out_max,reset, clock,D);
 input[7:0]out_max;
 input clock, reset;
 output[7:0] D;
 
 wire [7:0] D;
 wire rst;
 wire dbreset;
 
 assign rst = ~dbreset;
 freqcount U8(1, clock, count_clock);
 registerSR U16 (count_clock, rst, out_max,D);
 debouncer U10(clock,reset,dbreset);
 endmodule 
 
module adc_Controller(reset, clock, eoc, adc_data, start, ale, oe, selectInput, address, out_data);

 input reset, clock, eoc;
 input [7:0] adc_data;
 input [2:0] selectInput;
 
 output start, ale, oe;
 output [2:0] address;
 output [7:0] out_data;
 
 wire rst, dbreset, adc_start;

 assign rst=~dbreset;
 assign address=selectInput;
 
 genStart U2(rst, clock, adc_start);
 adcFSM U3(rst, adc_start, eoc, adc_data, clock, oe, ale, start, out_data);
 debouncer U10(clock,reset,dbreset);
 
endmodule 
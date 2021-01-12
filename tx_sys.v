module tx_sys(reset, clock, swSend, txPin, ready, data);
 input reset, clock, swSend;
 output txPin, ready;
 
 wire rst, sendCmd, thirtyEightKHz;
 output [7:0] data; 
 
 assign rst=~reset;

 freq38K U26(rst, clock, thirtyEightKHz);
 uart_tx U27(rst, thirtyEightKHz, sendCmd, data, txPin, ready);
 
 endmodule 
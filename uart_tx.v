module uart_tx(reset, clock, sendCmd, data, txPin, ready);
 
 input reset, clock, sendCmd;
 input [7:0] data;
 output txPin, ready;
 
 reg txPin, ready;
 parameter waiting=1'b0, sending=1'b1;
 reg state;
 integer cntClock;
 integer cntBit;
 reg [8:0] txBuffer;
 reg beginSending;
 
 always @(posedge clock)
 begin : Gen_BaudRateClock
  if (cntClock < 15)
   cntClock = cntClock + 1;
  else
	cntClock=0;
 end
 
 always @(posedge sendCmd or posedge state)
 begin : Gen_writeSignal
  if (state == sending)
   beginSending = 0;
  else if (sendCmd == 1)
   beginSending = 1;
 end

 always @(negedge reset or posedge clock)
 begin : State_Transition
  if (reset == 0) begin
   state = waiting;
   txPin = 1;
   cntBit = 0;
  end else begin
   case (state)
    waiting : begin
	  txPin = 1;
	  cntBit = 0;
	  if (beginSending == 1) begin
	   state = sending;
	   ready = 0;
	   txBuffer[0] = 0;
	   txBuffer[8:1] = data;
	  end else
	   ready = 1;
    end
    sending : begin
	  if (cntClock == 0)
	  begin 
	   if (cntBit < 10) begin
	    cntBit = cntBit + 1;
		 txPin = txBuffer[0];
		 txBuffer = {1'b1, txBuffer[8:1]};
		end else 
	    state = waiting;
		end
	end
   default : state = waiting;
 endcase
end
end

endmodule 
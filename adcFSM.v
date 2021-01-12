module adcFSM(reset, adc_start, eoc, adc_data, clock, oe, ale, start, out_data);
 input reset, clock, adc_start, eoc;
 input [7:0] adc_data;
 output oe, ale, start;
 output [7:0] out_data;
 
 reg oe, ale, start;
 reg [7:0] out_data;
 
 parameter idle=3'h0, starting=3'h1, waiting=3'h2;
 parameter converting=3'h3, done=3'h4, reading=3'h5;
 reg [2:0] p_state, n_state;
 reg readData;
 integer dly;
 
 always @(negedge reset or posedge clock)
 begin : ChangeState
  if (reset == 0) begin
   p_state = idle;
  end else
   p_state = n_state;
 end
 
 always @(negedge reset or posedge clock)
 begin
  if (reset == 0) begin
   dly=0;
  end else begin
   if (p_state == n_state) dly=dly+1;
	else dly=0;
  end
 end
 
 always @(posedge clock)
 begin : Gen_NextState
  case (p_state)
   idle :
	 if (adc_start == 1) n_state=starting;
	starting :
	 if (dly>10) n_state=waiting;
	waiting :
	 if (eoc == 0) n_state=converting;
	converting :
	 if (eoc == 1) n_state=done;
	done :
	 if (dly>10) n_state=reading; 
	reading :
	 n_state = idle;
	default :
	 n_state = idle;
	endcase
 end
 
 always @(negedge reset or posedge clock)
 begin : Gen_ADCSignal
  if (reset == 0) begin
   ale=0; start=0; oe=0;
  end else begin
   case(p_state)
	 idle : begin
	  ale=0; start=0; oe=0; readData=0;
	 end
	 starting : begin
	  ale=1; start=1; oe=0; readData=0;
	 end
	 waiting : begin
	  ale=0; start=0; oe=0; readData=0;
	 end
	 converting : begin
	  ale=0; start=0; oe=0; readData=0;
	 end
	 done : begin
	  ale=0; start=0; oe=1; readData=0;
	 end
	 reading : begin
	  ale=0; start=0; oe=1; readData=1;
	 end
	 default : begin
	  ale=0; start=0; oe=0; readData=0;
	 end
	endcase
  end
 end
 
 always @(negedge reset or posedge readData)
 begin : Gen_OutputData
  if (reset == 0)
   out_data = 8'b00000000;
  else
   out_data = adc_data;
  end
 endmodule 
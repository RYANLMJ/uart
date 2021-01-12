ADC+UART Verilog Open Source

블록 지정
 freqADC U1(1, clock, adc_clock);
 genStart U2(rst, clock, adc_start);
 adcFSM U3(rst, adc_start, eoc, adc_data, clock, oe, ale, start, out_data);
 debouncer U10(clock,reset,dbreset);

1. adcFSM
- 동작 개요
adc 기본 상태도
- 입력 신호
 input reset, clock, adc_start, eoc;
 input [7:0] adc_data;
- 출력 신호
 output oe, ale, start;
 output [7:0] out_data;
 
2. genStart
- 동작 개요
adc를 주기적으로 동작시키기 위한 신호를 생성(대략 1.5 kHz)
- 입력 신호
 input reset, clock;
- 출력 신호
 output adc_start;
 
3. debouncer
- 동작 개요
reset 버튼용 디바운서
- 입력 신호
 input clock,reset;
- 출력 신호
 output dbreset;
 
4. adc_controller
- 동작 개요
FSR 센서의 adc_data를 받아 out_data로 출력
- 입력 신호
 input reset, clock, eoc;
 input [7:0] adc_data;
 input [2:0] selectInput;
- 출력 신호
 output start, ale, oe;
 output [2:0] address;
 output [7:0] out_data;
- 서브 모듈
 genStart U2(rst, clock, adc_start);
 adcFSM U3(rst, adc_start, eoc, adc_data, clock, oe, ale, start, out_data);
 debouncer U10(clock,reset,dbreset);

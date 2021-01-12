ADC+UART Verilog Open Source

블록 지정
 freqADC U1(1, clock, adc_clock);
 genStart U2(rst, clock, adc_start);
 adcFSM U3(rst, adc_start, eoc, adc_data, clock, oe, ale, start, out_data);
 adc_Controller U4(reset, adc_clock, eoc, adc_data, start_1, ale_1, oe_1, 3'b000, address_1, out_data_1);
 adc_Controller U5(reset, adc_clock, eoc, adc_data, start_2, ale_2, oe_2, 3'b001, address_2, out_data_2);
 adc_Controller U6(reset, adc_clock, eoc, adc_data, start_3, ale_3, oe_3, 3'b010, address_3, out_data_3);
 adc_Controller U7(reset, adc_clock, eoc, adc_data, start_4, ale_4, oe_4, 3'b011, address_4, out_data_4);
 freqcount U8(1, clock, count_clock);
 ADC U9(reset, clock, adc_clock, eoc, adc_data, start, ale, oe, address, out_data);
 debouncer U10(clock,reset,dbreset);
 SRregister U11(in_reg_1, reset, clock, out_reg_1);
 SRregister U12(in_reg_2, reset, clock, out_reg_2);
 SRregister U13(in_reg_3, reset, clock, out_reg_3);
 SRregister U14(in_reg_4, reset, clock, out_reg_4);
 registerSR U16 (count_clock, rst, out_max,D);
 first U17(reset, clock, adc_clock, eoc, adc_data, start, ale, oe, address, out_reg_1, out_reg_2, out_reg_3, out_reg_4);
 cmpmax U18(out_reg_1, D_1, out_max_1, clock);
 cmpmax U19(out_reg_2, D_2, out_max_2, clock);
 cmpmax U20(out_reg_3, D_3, out_max_3, clock);
 cmpmax U21(out_reg_4, D_4, out_max_4, clock);
 SRregister U22(out_max_1, reset, clock, D_1);
 SRregister U23(out_max_2, reset, clock, D_2);
 SRregister U24(out_max_3, reset, clock, D_3);
 SRregister U25(out_max_4, reset, clock, D_4);
 
 
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

5. freqADC
- 동작 개요
ADC의 주파수를 결정. 500 kHz
-입력 신호
 input reset, clock;
- 출력 신호 
 output adc_clock;

6. freqcount
- 동작 개요 
ADC 모듈에서 out_data가 레지스터에 할당되는 주파수. 27 Hz
- 입력 신호
 input reset, clock;
- 출력 신호
 output count_clock;

7. ADC
- 동작 개요
adc_controller 4개를 count마다 동작시킴.
- 입력 신호
 input reset, clock, eoc;
 input [7:0] adc_data;
- 출력 신호 
 output adc_clock;
 output start, ale, oe;
 output [2:0] address;
 
8. registerSR
- 동작 개요
인풋값을 레지스터에 저장
- 입력 신호
 input clock,reset;
 * first 모듈에서는 input[7:0] in_reg;
- 출력 신호
 * first 모듈에서는 output[7:0] out_reg;

9. SRregister
- 동작 개요 
리셋, 디바운서 합친 레지스터. count_clock(27 Hz)를 따라감.
- 입력 신호
 input[7:0]out_max;
 * first 모듈에서는 input[7:0] in_reg;
- 출력 신호
 output[7:0] D;

10. first
- 동작개요
ADC에서 카운트마다 나오는 센서 값을 각 4개의 레지스터에 저장함.
count_clock(27 Hz)을 따라감
- 입력 신호
 input reset, clock, eoc;
 input [7:0] adc_data;
- 출력 신호
 output adc_clock;
 output start, ale, oe;
 output [2:0] address;
 output [7:0] out_reg_1, out_reg_2, out_reg_3, out_reg_4;
- 서브 모듈
 ADC U9(reset, clock, adc_clock, eoc, adc_data, start, ale, oe, address, out_data);
 
11. cmpmax
- 동작 개요
실시간 센서 값과 레지스터에 저장된 이전 최대값을 비교해 최대값 출력
- 입력 신호
 input count_clock;
 input [7:0] out_data, D;
- 출력 신호
 output [7:0] out_max;

12. middle
- 4개의 레지스터에 저장된 센서 값을 비교기를 통해 최대값 도출. 
새로운 4개의 레지스터에 최대값이 저장되었다가 비교기로 들어감.
- 입력 신호
 input reset, clock, eoc;
 input [7:0] adc_data;
- 출력 신호 
 output adc_clock;
 output start, ale, oe;
 output [2:0] address;
 output [7:0] out_reg_1, out_reg_2, out_reg_3, out_reg_4;

module debouncer(clock,reset,dbreset);
input clock,reset;
output dbreset;

reg dbreset;
integer count;

always @ (posedge clock)
begin 
 dbreset<=reset;
end
endmodule 
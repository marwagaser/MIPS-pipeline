module adder_2(add_result,PCincremented,shift_out);
input [31:0] PCincremented;
input [31:0] shift_out;
output reg [31:0] add_result;
always @ (shift_out)
begin
add_result = shift_out + PCincremented;
end
endmodule

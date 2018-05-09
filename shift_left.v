module shift_left(shift_out,shift_in);
input [31:0] shift_in;
output reg [31:0] shift_out;
always @ (shift_in)
begin
shift_out = shift_in <<2;
end
endmodule

module shift_test();
reg [31:0] IN;
wire [31:0] OUT;
 initial begin 
 IN=32'b00000000000000000000000000000011;//3
 #10 $display ("%d", IN);
 #10  IN=32'b00000000000000000000000000000100;//4
 #10 $display ("%d", IN);
 end 
 always @ (IN);
 shift_left stest(OUT,IN);
 endmodule
module adder (add_out,add_in);
input [31:0] add_in;
output reg [31:0] add_out;
always @ (add_in)
begin
add_out = add_in + 32'b00000000000000000000000000000001;
end
endmodule 
 

module adder_test();
reg [31:0] add_in;
wire [31:0] add_out;
initial begin
  add_in =32'b00000000000000000000000000000000;
 #10 $display ("%d", add_out);
 #10 add_in = 32'b00000000000000000000000000000100;
 #10 $display ("%d", add_out);
  #10 add_in = 32'b00000000000000000000000000000110;
 #10 $display ("%d", add_out);
  #10 add_in = 32'b00000000000000000000000000000101;
 #10 $display ("%d", add_out);
    end  
always @ (add_in);
adder addertest(add_out,add_in);
endmodule 

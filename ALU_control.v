module ALU_control (in1,in2,out);
input [5:0] in1;
input [1:0] in2; //aluop 
output reg [2:0] out;
always @ (in1 ,in2)
begin 
casex ({in2,in1})
8'b00101010: out = 3'b010; //addi 
8'b00101011: out = 3'b010; //sw 
8'b00101111: out = 3'b010; //l-w 
8'b00100110: out = 3'b010; //lhu 
8'b00111010: out = 3'b010; //lh 
8'b00111111: out = 3'b000;//andi
8'b00111110: out = 3'b001;//ori
8'b01xxxxxx: out = 3'b110; //beq 
8'b10100000: out = 3'b010; //add
8'b10100010: out = 3'b110;//sub
8'b10100100: out = 3'b000;//and
8'b10100101: out = 3'b001;//or
8'b10101010: out = 3'b111; //slt
8'b10111111: out = 3'b011; //sltu
8'b10111000: out = 3'b101; //sll
8'b10000111: out = 3'b100;//slr
endcase 
end 
endmodule 

module a_controltest();
reg [5:0] in1;
reg [1:0] in2;
wire [2:0] out;

initial begin
in1=6'b101011;
in2=2'b00;
#10 $display ("%b", out);
end 
always @(in1,in2);
ALU_control alucntrltest (in1,in2,out);
endmodule 

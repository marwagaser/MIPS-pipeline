module ALU (OUT, ZeroFlag, In1, In2, ALUcontrol);
input [31:0] In1, In2;
input [2:0] ALUcontrol;
output reg [31:0] OUT;
output reg ZeroFlag;
always @ (In1, In2, ALUcontrol)
begin
if (In1 == In2)
ZeroFlag = 1;
else
ZeroFlag = 0;
end
always @ (In1, In2, ALUcontrol)
begin
case (ALUcontrol)
3'b000 : OUT = In1 & In2; //and 
3'b001 : OUT = In1 | In2; //or 
3'b010 : OUT= $signed(In1) +  $signed(In2); //add,addi,sw,lw,lhu,lh
3'b011 : OUT= $unsigned(In1) < $unsigned(In2);//sltu
3'b100 : OUT = $signed(In1)>>$signed(In2);//slr  //10
3'b101 : OUT = $signed(In1)<<$signed(In2); //sll //9
3'b110 : OUT = $signed(In1) - $signed(In2); //beq,sub //5
3'b111 : OUT = $signed(In1) < $signed(In2);//slt //4
endcase
end
endmodule



module ALU_Test();
reg [31:0] a, b;
reg [2:0] select;
wire [31:0] OUT;
wire zeroflag;
initial begin
a = 1;
b = 2;

#10 select = 3'b000;
#10 $display ("%d", $signed(OUT)); $display ("%d", zeroflag);
#10 a = 2; b = 2;
#10 $display ("%d", $signed(OUT)); $display ("%d", zeroflag);
#10 a = 10; b = 20;
#10 $display ("%d", $signed(OUT)); $display ("%d", zeroflag);

#10 select = 3'b001;
#10 a = 1;b = 2;
#10 $display ("%d", $signed(OUT)); $display ("%d", zeroflag);
#10 a = 2; b = 2;
#10 $display ("%d", $signed(OUT)); $display ("%d", zeroflag);
#10 a = 10; b = 20;
#10 $display ("%d", $signed(OUT)); $display ("%d", zeroflag);

#10 select = 3'b010;
#10 a = 1;b = 2;
#10 $display ("%d", $signed(OUT)); $display ("%d", zeroflag);
#10 a = 2; b = 2;
#10 $display ("%d", $signed(OUT)); $display ("%d", zeroflag);
#10 a = 10; b = 20;
#10 $display ("%d", $signed(OUT)); $display ("%d", zeroflag);

#10 select = 3'b011;
#10 a = 1;b = 2;
#10 $display ("%d", $signed(OUT)); $display ("%d", zeroflag);
#10 a = 2; b = 2;
#10 $display ("%d",  $signed(OUT)); $display ("%d", zeroflag);
#10 a = 10; b = 20;
#10 $display ("%d",  $signed(OUT)); $display ("%d", zeroflag);

end
always@(a, b, select);
ALU aluTest(OUT, zeroflag, a, b, select);
endmodule

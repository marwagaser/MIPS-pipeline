module InstructionMemory( instruction, PC, clk);
input [31:0] PC;
input clk;
output reg [31:0] instruction;
reg [31:0] memory [0:255];
initial 
begin 
memory [0]= 32'b00000001000010010101000000100000;//add
memory [1]= 32'b00000001000010010101000000100010;//sub
memory [2] =32'b00100001000010010000000000000001;//addi
memory [3] =32'b10001101000010010000000000000100;//lw posiiton 4
memory [4] =32'b10101101000010010000000000001110;//sw position 14
memory [5] =32'b10000101000010010000000000000001;//lh position 1
memory [6] =32'b10010101000010010000000000000010;//lhu position 2
memory [7]= 32'b00000001000010010101000000100100;//and
memory [8]= 32'b00000001000010010101000000100101;//or
memory [9] =32'b00000001000010010101000000000000;//sll
memory [10]=32'b00000001000010010101000000000010;//srl
memory [11]=32'b00010010000100100000000000000000;//beq
memory [12]=32'b00000001000010010101000000101010;//slt 2a
memory [13]=32'b00000001000010010101000000101011;//sltu

end
always @ (PC)
begin
instruction[31:0] <= memory[PC[31:0]];
 end
endmodule

module IM_TEST();
reg [31:0] pc;
reg [1:0] clk;
wire[31:0] OUT;
initial begin
        pc = 0; //start by zero
        clk = 0;
forever
 begin       
        #10;clk = 1;
        #10;clk = 0;
        pc = pc + 1;
		$display ("%d", OUT);
		end 
    end  
always @ (pc , clk);
InstructionMemory imTest(OUT ,pc,clk );
endmodule

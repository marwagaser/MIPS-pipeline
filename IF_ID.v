module IF_ID(PCincremented,InstructionOutput,Instruction,PC,clk);
input [31:0] PC;
input [31:0] Instruction;
input clk;
output reg [31:0] PCincremented;
output reg [31:0] InstructionOutput;
initial
begin
    PCincremented= 32'b0;
	InstructionOutput= 32'b0;
	
end
always@(posedge clk)
    begin
    InstructionOutput = Instruction ;
    PCincremented = PC ;
    end
endmodule
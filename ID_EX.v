module ID_EX(WB,MEM,EX,Rdin,Rtin,signExtenderOffset,read1,read2,PCincremented,WBOutput,MEMOutput,RegDst,ALUop,ALUSrc,InstructionIncrementedOutput,read1Output,read2Output, signExtenderOffsetOutput,rd,rt,clk);
input [1:0] WB;//2
input [2:0] MEM;// 3
input [3:0] EX; // 4 we need to change this in case addi or ori
input [4:0] Rdin;
input [4:0] Rtin;
input [31:0] signExtenderOffset;
input [31:0] read1;
input [31:0] read2;
input [31:0] PCincremented;
input clk;
////////////////////

output reg [1:0] WBOutput;
output reg [2:0] MEMOutput;
output reg RegDst,ALUSrc;
output reg [1:0] ALUop;
output reg [31:0]InstructionIncrementedOutput;
output reg [31:0] read1Output,read2Output;
output reg [31:0] signExtenderOffsetOutput;
output reg [4:0] rd,rt;

initial
begin
WBOutput =2'b00;
MEMOutput=3'b000;
RegDst=1'b0;
ALUSrc=0;
ALUop=2'b00;
InstructionIncrementedOutput=32'b0;
read1Output =32'b0;
read2Output =32'b0;
signExtenderOffsetOutput=32'b0;
rd=5'b0;
rt=5'b0;
end

always@(posedge clk)
    begin
       read1Output <= read1;
	   read2Output<=read2;
	   signExtenderOffsetOutput<=signExtenderOffset;
   InstructionIncrementedOutput <= PCincremented;
        rd<=Rdin;
	    rt<=Rtin;
		WBOutput<=WB;
		MEMOutput<=MEM;
        ALUSrc <= EX[0];
        ALUop<= {EX[2],EX[1]};
        RegDst<= EX[3];
    end

endmodule
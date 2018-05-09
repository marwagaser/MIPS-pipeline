module EX_MEM(MEM,WB,AddResult,zero,AluResult,readData2,rdORrt,branch,memRead,memWrite,AddResultOutput,AluResultOutput,readData2Output,rdORrtOutput, WBoutput,clk);
input [2:0] MEM;
input [1:0] WB;
input [31:0] AddResult;
input zero;
input [31:0] AluResult;
input [31:0] readData2;
input [4:0] rdORrt;
input clk;
output reg branch,memRead,memWrite;
output reg [31:0] AddResultOutput,AluResultOutput;
output reg [31:0] readData2Output;
output reg [4:0] rdORrtOutput;
output reg [1:0] WBoutput;
initial
begin
    branch = 0;
	memRead=0;
	memWrite=0;
	AddResultOutput=32'b0;
	AddResultOutput=32'b0;
	readData2Output=32'b0;
	rdORrtOutput=5'b0;
	WBoutput = 2'b00;
end
always@(posedge clk)
    begin
       branch<=MEM[0];
	   memRead<=MEM[1];
	   memWrite<=MEM[2];
	   AddResultOutput<=AddResult;
	   AluResultOutput<= AluResult;
	   readData2Output<=readData2;
	   rdORrtOutput<=rdORrt;
	   WBoutput<=WB;
    end


endmodule
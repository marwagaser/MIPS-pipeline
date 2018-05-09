module MEM_WB(WB,AluResult,readData,rdORrt,RegWrite,MemToReg,readDataoutput,AluResultoutput,rdORrtoutput,clk);

output reg RegWrite,MemToReg;
output reg [31:0] readDataoutput,AluResultoutput;
output reg [4:0]rdORrtoutput;

input [1:0]WB;
input clk ;
input   [31:0] readData,AluResult;
input [4:0] rdORrt;


initial
begin
	RegWrite=0;
	MemToReg=0;
	readDataoutput =32'b0;
	AluResultoutput=32'b0;
	rdORrtoutput =5'b0;
end


// On clock
always@(posedge clk)
    begin
        RegWrite<= WB[0];
		MemToReg <= WB[1];
		readDataoutput<=readData;
		AluResultoutput<=AluResult;
		rdORrtoutput<=rdORrt;
    end

endmodule
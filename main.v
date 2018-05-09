module main(clk,InstructionOutputO,add_outO,mem_writeO,reg_writeO,
reg_destO,mem_to_regO,alu_srcO,alu_opO,branchO,mem_readO,
read_data_1O,read_data_2O,WBOutputO
,MEMOutputO,RegDstO,ALUSrcO,ALUopO,PCIncrementedOutputieO,
read1OutputO,read2OutputO,rdO,rtO,shift_outO,add_resultO,
write_dataO,RegWriteO,MemToRegO,read_data_OutO,
AluResultOutputmemO,rdORrtOutputemO,read_dataO,branchmemO,MEMReadO,MEMWriteO,
AddResultOutputO, AluResultOutputO,readData2OutputO,
WBOutputemO,signExtenderOffsetOutputO,
alu_control_outO);
reg [31:0]PC;//elly tal3 mn el PC
initial begin PC = 32'b0; end
input clk;
wire[31:0] add_out;
wire [31:0] PCincremented;//elly tal3 mn el IF_ID hwa hwa add_out
wire [31:0] InstructionOutput;// hya hya el InstructionOutput bs tal3a mn el IF_ID
wire [31:0] read_data_1;
wire [31:0] read_data_2;
wire [4:0] rdORrtOutput;
reg [31:0] write_data;
wire RegWrite;//di RegWrite elly 5arga mn MEM_WB
wire mem_write;
wire [4:0] WriteReg;
wire reg_dest;
wire mem_to_reg;
wire alu_src;
wire [1:0] alu_op;
wire branch;
wire mem_read;
wire [4:0] rdORrt;
reg PCsrc;
reg [1:0] WB;
reg [2:0] MEM;
reg [3:0] EX;
wire ZeroFlag;
wire [31:0] read_data;

wire [1:0] WBOutput;//WBout of ID_EX
wire [2:0] MEMOutput;//Memout of ID_EX
wire RegDst;//RegDstout of ID_EX
wire [1:0] ALUop;//ALUopout of ID_EX
wire ALUSrc;//ALUSrcout of ID_EX
wire [31:0] PCIncrementedOutputie;//PC out of ID_EX
wire [31:0] read1Output;//read_data_1 out of ID_EX
wire [31:0] read2Output;//read_data_2 out of ID_EX
wire [31:0] signExtenderOffsetOutput;//sign extender 32 bits out of ID_EX
wire [4:0] rd;//Rd out of ID_EX
wire [4:0] rt;//Rt out of ID_EX
wire [31:0] shift_out;
wire [31:0] add_result;
wire [2:0] alu_control_out;
wire [31:0] AluResult;
wire [31:0] AddResultOutput;//add result from EX_MEM.
wire [31:0] AluResultOutput;
wire [31:0] readData2Output;
wire [4:0] rdORrtOutputem;
wire MemToReg; //5arga men MEM/WB 
wire [1:0]WBOutputem;

wire branchmem;
wire MEMRead;
wire MEMWrite;
wire [31:0] read_data_Out;
wire [31:0] AluResultOutputmem;
reg [31:0] signExtenderOffset;
reg [31:0] input2ALU;

reg [4:0] RdRt;
wire reg_write;



output [31:0] InstructionOutputO; 
output [31:0] add_outO;
output mem_writeO;
output	reg_writeO;
output	reg_destO;
output	mem_to_regO;
output	alu_srcO;
output	[1:0]	alu_opO;
output	branchO;
output mem_readO;
output	[31:0]	read_data_1O;
output	[31:0]	read_data_2O;
output [1:0] WBOutputO;
output [2:0] MEMOutputO;
output RegDstO;
output ALUSrcO;
output [1:0] ALUopO;
output [31:0] PCIncrementedOutputieO;
output [31:0] read1OutputO;
output [31:0]read2OutputO;
output [4:0] rdO;
output [4:0]  rtO;
output [31:0] shift_outO;
output [31:0] add_resultO;
output [31:0] write_dataO;
output RegWriteO;
output MemToRegO;
output [31:0] read_data_OutO;
output [31:0] AluResultOutputmemO;
output [4:0] rdORrtOutputemO;
output [31:0] read_dataO;
output branchmemO;
output MEMReadO;
output MEMWriteO;
output [31:0] AddResultOutputO;
output [31:0] AluResultOutputO;
output [31:0] readData2OutputO;
output WBOutputemO;
output [31:0] signExtenderOffsetOutputO;
output [2:0] alu_control_outO;



always @ (posedge clk) begin
WB<={reg_write,mem_to_reg};
MEM<={mem_read,mem_write,branch};
EX<={reg_dest,alu_op[1:0],alu_src};
end
InstructionMemory theInstructionMemory(InstructionOutput,PC,clk);
adder theadder(add_out,PC);
IF_ID theIF_ID(PCincremented,InstructionOutput,InstructionOutput,add_out,clk);
control_unit thecontrol_unit(InstructionOutput[31:26],ZeroFlag,mem_write,reg_write,reg_dest,mem_to_reg,alu_src,alu_op,branch,mem_read);
registerfile theregisterfile(InstructionOutput[25:21],InstructionOutput[20:16],WriteReg,write_data,RegWrite,read_data_1,read_data_2);

always @ (posedge clk) begin
if (InstructionOutput[15]==0)
begin 
signExtenderOffset <= {16'b0,InstructionOutput[15:0]};
end
else
begin
signExtenderOffset <= {16'b1,InstructionOutput[15:0]};
end
end
ID_EX theID_EX(WB,MEM,EX,InstructionOutput[20:16],InstructionOutput[15:11],signExtenderOffset,read_data_1,read_data_2,PCincremented,
	WBOutput,MEMOutput,RegDst,ALUop,ALUSrc,PCIncrementedOutputie,read1Output,read2Output,
	signExtenderOffsetOutput,rd,rt,clk);

shift_left theshift_left(shift_out,signExtenderOffsetOutput);
adder_2 theadder_2(add_result,PCIncrementedOutputie,shift_out);

ALU_control theALU_control(signExtenderOffsetOutput[31:26],ALUop,alu_control_out);

always @ (posedge clk) begin
if(ALUSrc==0) 
begin
input2ALU<=read2Output;
end 
else
 begin
input2ALU=signExtenderOffsetOutput;
end
end
ALU theALU (AluResult,ZeroFlag,read1Output,input2ALU,alu_control_out);
//mux

always @ (posedge clk) begin
if(RegDst==0) begin
RdRt <=rd;
end else
 begin
 RdRt<=rt;
end
end

EX_MEM theEX_MEM(MEMOutput,WBOutput,add_result,ZeroFlag,AluResult,read2Output,RdRt,branchmem,MEMRead
,MEMWrite,AddResultOutput,AluResultOutput,readData2Output,rdORrtOutputem,WBOutputem,clk);

always @ (posedge clk) begin
 PCsrc<= ZeroFlag & branch; 
end

data_memory thedata_memory(AluResultOutput,readData2Output,MEMRead,MEMWrite,read_data,clk);

MEM_WB theMEM_WB(WBOutputem,AluResultOutput,readData2Output,rdORrtOutputem,RegWrite,MemToReg,read_data_Out,AluResultOutputmem,rdORrtOutputem,clk);
assign WriteReg =RdRt;

always @ (posedge clk) begin
if(MemToReg==0)begin
 write_data<=read_data_Out;
end else begin
write_data<=AluResultOutputmem;
end
end
always @ (posedge clk) begin
if (PCsrc==0)
begin 
PC<=add_out;
end
else
begin
PC<=AddResultOutput;
end
end


assign InstructionOutputO=InstructionOutput;
//always @* $display ("%b", InstructionOutputO);

assign add_outO=add_out;
assign mem_writeO=mem_write;
assign reg_writeO=reg_write;
assign reg_destO=reg_dest;
assign mem_to_regO=mem_to_reg;
assign alu_srcO=alu_src;
assign alu_opO=alu_op;
assign branchO=branch;
assign mem_readO=mem_read;
assign read_data_1O=read_data_1;
assign read_data_2O=read_data_2;
assign WBOutputO=WBOutput;
assign MEMOutputO=MEMOutput;
assign RegDstO=RegDst;
assign ALUSrcO=ALUSrc;
assign ALUopO=ALUop;
assign PCIncrementedOutputieO=PCIncrementedOutputie;
assign read1OutputO=read1Output;
assign read2OutputO=read2Output;
assign rdO=rd;
assign  rtO=rt;
assign shift_outO=shift_out;
assign add_resultO=add_result;
assign write_dataO=write_data;
assign RegWriteO=RegWrite;
assign MemToRegO=MemToReg;
assign read_data_OutO=read_data_Out;
assign AluResultOutputmemO=AluResultOutputmem;
assign rdORrtOutputemO=rdORrtOutputem;

assign read_dataO=read_data;

assign branchmemO=branchmem;
assign MEMReadO=MEMRead;
assign MEMWriteO=MEMWrite;
assign AddResultOutputO =  AddResultOutput;
assign AluResultOutputO = AluResultOutput;
assign readData2OutputO = readData2Output;
assign WBOutputemO = WBOutputem;
assign signExtenderOffsetOutputO = signExtenderOffsetOutput;
assign alu_control_outO = alu_control_out;



endmodule
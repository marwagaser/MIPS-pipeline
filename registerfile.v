module	registerfile(	read_reg_1,	read_reg_2,	write_reg,	write_data,	regWrite,	read_data_1,	read_data_2);

input	[4:0]	read_reg_1,	read_reg_2,	write_reg;
input	[31:0]	write_data;
input	regWrite;
output	reg	[31:0]	read_data_1,	read_data_2;
reg	[31:0]	registers[0:31];	
always	@	(read_reg_1,	read_reg_2)
begin
			 read_data_1	<=	(read_reg_1==0)?	32'b0	:	registers[read_reg_1];
			 read_data_2	<=	(read_reg_2==0)?	32'b0	:	registers[read_reg_2];
			 if(regWrite)	
				begin
							 registers[write_reg]	<=	write_data;
			 end
end

endmodule




module tb;
reg clk;
reg [4:0] read_reg_1, read_reg_2, write_reg;
reg [31:0] write_data;
reg regWrite;
wire [31:0] read_data_1, read_data_2;
registerfile r(read_reg_1, read_reg_2, write_reg, write_data, regWrite, read_data_1, read_data_2);
initial begin
clk = 0;
forever begin
#5 clk = ~clk;
end
end
initial
begin
$monitor("%t %b %b %b", $time, read_data_1, read_data_2, clk);
#5 read_reg_1 <= 2'b0;
#5 write_reg <= 2'b01; regWrite <= 1; write_data<=32'd55;
#15 regWrite = 0;
#5 read_reg_2 <= 2'b1;
#5 $finish;
end
endmodule
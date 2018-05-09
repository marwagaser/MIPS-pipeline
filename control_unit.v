module control_unit(instruction,alu_zero,mem_write,reg_write,reg_dest,mem_to_reg,alu_src,alu_op,branch,mem_read);
input [5:0] instruction;
input alu_zero;

output reg mem_write;
output	reg reg_write;
output	reg reg_dest;
output	reg mem_to_reg;
output	reg alu_src;
output	reg [1:0]	alu_op;
output	reg branch;
output reg mem_read;

assign op = instruction[31:26]; // Set the opcode

always @(instruction)
begin
begin
if (instruction == 6'h4) begin
branch = 1'b1;
end else begin
branch = 1'b0;
end
end

begin
if(instruction == 6'h0) begin
    reg_dest=1'b1;
end else begin
    reg_dest=1'b0;
end
end

begin
if(instruction == 6'h23) begin
    mem_read=1'b1;
    mem_to_reg=1'b1;
end else begin
    mem_read=1'b0;
    mem_to_reg=1'b0;
end
end

begin
if(instruction == 6'h2B) begin
    mem_write=1'b1;
end else begin
    mem_write=1'b0;
end
end

begin
if((instruction == 6'h0) || 
    (instruction == 6'h4)) begin
    alu_src=1'b0;
end else begin
    alu_src=1'b1;
end
end

begin
if((instruction == 6'h2B) || 
    (instruction == 6'h4)) begin
    reg_write=1'b0;
end else begin
    reg_write=1'b1;
end
end

begin
if((instruction == 6'h8) ||
    (instruction == 6'h2B) ||
    (instruction == 6'h23)) begin
    alu_op=2'b00;
end else begin
if(instruction == 6'h4) begin
    alu_op=2'b01;
end else begin
    alu_op[1]=1'b1;
end
end
end
end
endmodule
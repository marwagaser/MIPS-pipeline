module data_memory

(

    addr,

    wdata,

    mem_write,

    mem_read,
	
	 read_data,
	     clk
);


    input         [31:0]    addr;

    input        [31:0]    wdata;

    input       mem_read;

     input         mem_write;
    input clk;
    

output     reg    [31:0]     read_data;


 reg    [31:0] memory    [255:0];
		
initial 
begin 

//data in memory
memory [0]= 32'b00000001000010010101000000100000;
memory [1]= 32'b00000001000010010101000000100010;
memory [2] =32'b00100001000010010000000000000001;
memory [3] =32'b10001101000010010101000000100000;
memory [4] =32'b11111100000000000000000000000001; 
memory [5] =32'b10101001010100101001010101001111;
memory [6] =32'b10000000000000010101001010011111;
memory [7]= 32'b00000001000010010101000000100100;
memory [8]= 32'b00000001000010010101000000100101;
memory [9]= 32'b00000001000010010101000000000000;
memory [10]=32'b00000001000010010101000000000101;
memory [11]=32'b10010100101010010100111111111001;
memory [12]=32'b00000001000010010101000001010101;
memory [13]=32'b00000001000010010101000001010111;
memory [14]=32'b00000000000000000000000000000001;
end
    always @(addr)

    begin

        if (mem_write)begin

            memory[addr[31:0]] <= wdata;

        end

        if(mem_read)begin

            read_data <= memory[addr[31:0]];

        end
    
    end

    
 endmodule 
 
 
  module IM_TEST();
reg [31:0] pc;
reg  clk;
reg  w;
reg  r;
reg [31:0]wdata;
wire[31:0] OUT;
initial begin
        // Initialize Inputs
        pc = 0;
        clk = 0;
		w=0;
		r=1;
		wdata= 32'b00000000000000000000000000000000;
        // Wait 100 ns for global reset to finish
        #100;
        // Add stimulus here
        clk = 0;
        pc = 0;
        #100;

        #20;
        clk = 1;
        #20;
        clk = 0;
        pc = pc + 1;
		$display ("%b", OUT);
    end  
always @ (pc , clk);
data_memory imTest(pc,wdata,w,r,OUT,clk);
endmodule
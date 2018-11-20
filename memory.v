//--------------
// Design Name: memory
// Function: synchronous RAM
// Author: Douglas Karmondy
//-----------------

module memory(clk, data_in, x_loc, y_loc, readEnable, data_out, rst);
	input clk, rst;
	input readEnable; //0 write, 1 read
	input  [0:1] data_in;
	input [0:14] x_loc, y_loc;
	output reg [0:1] data_out;
	
	integer i;
	reg [0:1] data;
	reg [1:0] world_memory [0:224]; //15 X 15 = 225
	
	reg output_bit; //225 grid of on and off
	
	
	// Keep track of food
	// 00 - world
	// 01 - food
	// 10 - snake
	// 11
	
	// food is initially at (3,3)
	// snake is 3 blocks initially
	
	
	always @(posedge clk)
	begin
	    if(rst)begin
			for(i=3; i<225; i= i+1)begin
			world_memory[i] <= 2'b00;
			end
			world_memory[0] <= 2'b10;
			world_memory[1] <= 2'b10;
			world_memory[2] <= 2'b10;
			end
			
			if(!readEnable) world_memory[15 * (y_loc - 1) + x_loc]<= data_in;
	end
	
	always @*
	begin
		//always check
		if(readEnable)
		begin
			data_out = world_memory[15 * (y_loc - 1) + x_loc];
		end
		else
		begin
			//write
			data_out = 2'b00;
		end
	end
	 
endmodule


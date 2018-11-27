//--------------
// Design Name: memory
// Function: synchronous RAM
// Author: Douglas Karmondy
//-----------------

module memory(clk, data_in, x_loc, y_loc, readEnable, data_out, rst);
	input clk, rst;
	input readEnable; //0 write, 1 read
	input  [1:0] data_in;
	//input [0:14] x_loc, y_loc;
	input [4:0] x_loc, y_loc;
	output reg [1:0] data_out;
	
	integer i;
	reg [1:0] data;
	reg [1:0] world_memory [244:0]; //15 X 15 = 225
	
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
				world_memory[i] <= 2'b00;    // world populated
			end
			
			world_memory[0] <= 2'b10;    // 3 snake blocks populated
			world_memory[1] <= 2'b10;
			world_memory[2] <= 2'b10;
			world_memory[55] <= 2'b01;  // 1 food block
		end
			
		if(!readEnable) world_memory[15 * (y_loc - 1) + x_loc]<= data_in;
	end
	
	always @*
	begin
		//always check
		if(readEnable)
		begin
			data_out = world_memory[(15 * (y_loc - 1)) + (x_loc - 1)];
			//data_out = 2'b01;
		end
	// Took out the code for the else statement - data_out needs to keep the previous value
	end
	
	 
endmodule


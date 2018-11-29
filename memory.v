//--------------
// Design Name: memory
// Function: synchronous RAM
// Author: Douglas Karmondy
//-----------------

module memory(clk, data_in, x_loc_vga, y_loc_vga, x_loc_sw, y_loc_sw, writeEnable, 
					data_out, rst, sw_reset);
	input clk, rst;
	input writeEnable; //0 write, 1 read
	input  [1:0] data_in;
	input sw_reset;
	//input [0:14] x_loc, y_loc;
	input [3:0] x_loc_vga, y_loc_vga, x_loc_sw, y_loc_sw;
	output reg [1:0] data_out;
	
	integer i;
	reg [1:0] data;
	reg [1:0] world_memory [255:0]; //15 X 15 = 225 //16X16 256
	
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
	    if(rst || sw_reset)begin
			for(i=0; i<255; i= i+1)begin
				world_memory[i] <= 2'b00;    // world populated
			end
			
			//world_memory[0] <= 2'b10;    // 3 snake blocks populated
			//world_memory[1] <= 2'b10;
			//world_memory[2] <= 2'b10;
			//world_memory[55] <= 2'b01;  // 1 food block
		end

		
		//if(writeEnable) world_memory[15 * (y_loc_sw - 1) + x_loc_sw]<= data_in;
		if(writeEnable) world_memory[15 * (y_loc_sw) + x_loc_sw]<= data_in;
		end
	
	always @*
	begin
		//always check
		//if(readEnable)
		//begin
			//data_out = world_memory[(15 * (y_loc_vga - 1)) + (x_loc_vga - 1)];
			data_out = world_memory[(15 *y_loc_vga) + x_loc_vga];
			//data_out = 2'b01;
		//end
	// Took out the code for the else statement - data_out needs to keep the previous value
	end
	
	 
endmodule


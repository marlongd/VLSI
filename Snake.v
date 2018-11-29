module Snake(
input slw_clk,
input reset,
input right,
input left,
input up,
input down,
output reg[1799:0] snake,
output reg write_snake,
output reg [10:0] index,
output reg [3:0] xfood, //x pixel
output reg [3:0] yfood //y pixel
);
 

	reg [3:0] state, next_state;

	reg[2:0] direction;
	 //snake locations the tail will be stored up front.
	reg[7:0] new_head;


	parameter RESET   = 3'd0;
	parameter S_UP    = 3'd1; 
	parameter S_DOWN  = 3'd2; 
	parameter S_LEFT  = 3'd3; 
	parameter S_RIGHT = 3'd4; 
	parameter EAT     = 3'd5;
	parameter DIE     = 3'd6;
	 

	always@(posedge slw_clk)
	begin
		if(reset)begin 
			state <= 3'd0; //RESET
			snake = 1800'd0;
			write_snake <=0;
		end
		
		else begin
			if (state == RESET) begin
				state <= 3'd4; // Move right
				direction= 3'd4; 
				xfood = 4'd3;
				yfood = 4'd3;//in the memory
				snake = {1775'd0, 4'd1, 4'd3, 4'd1, 4'd2, 4'd1, 4'd1};
				index =11'd23;
				new_head =0; //right
			end
			
			else begin state <= next_state;
							write_snake <=1;
			end 
		end

							
		new_head = snake[index -:8];
		
		
		case(state)
		
			RESET: begin
				snake = 1800'd0;
				new_head = 0;
			end
			S_UP:		begin
				if(direction != S_DOWN) begin

				new_head = {new_head[7:4]-1'b1, new_head[3:0]};	
				direction = S_UP;
				
				end
				else new_head ={new_head[7:4]+1'b1, new_head[3:0]};	
			end
			
			S_DOWN:	begin
				if(direction != S_UP) begin
				new_head = {new_head[7:4]+1'b1, new_head[3:0]};
				direction = S_DOWN;
				end
				
				else new_head ={new_head[7:4]-1'b1, new_head[3:0]};		
			end 
			
			S_LEFT:  begin
				if(direction != S_RIGHT) begin
				new_head = {new_head[7:4], new_head[3:0]-1'b1};
				direction = S_LEFT;
				end
				else new_head ={new_head[7:4], new_head[3:0]+1'b1};	
			end 
			
			S_RIGHT: begin
				if(direction != S_LEFT) begin
				new_head = {new_head[7:4], new_head[3:0]+1'b1};
				direction = S_RIGHT;
				end
				else new_head ={new_head[7:4], new_head[3:0]-1'b1};
			end
			
			EAT: begin
				new_head = {yfood, xfood};
				index = index + 8;
				snake = snake << 8;
				xfood = 0;
				yfood = 0;
			end
			
			default: begin
			
			 
			end
		endcase
		
		snake = snake >> 8; 
		snake[index-7 +:8] = new_head;
		
	end

	always @*
	begin
	
		if(reset) next_state =3'd4;

		else if(snake[index -:4] == yfood && snake[index-4 -: 4] == xfood)
						next_state = EAT;
						
		else if(up) next_state = S_UP;

		else if(down) next_state = S_DOWN;

		else if(left) next_state = S_LEFT;

		else if(right) next_state = S_RIGHT;

		else if (next_state == EAT) next_state = direction;
		
		else next_state = next_state;

	end
endmodule 
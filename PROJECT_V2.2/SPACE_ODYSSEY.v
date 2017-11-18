module STEM(CLOCK_50, KEY, SW, VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_R, VGA_G, VGA_B, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

	input	CLOCK_50;				//	50 MHz
	// Declare your inputs and outputs here
	input [9:0] SW;
	input [3:0] KEY;
	
	// Do not change the following outputsfile

	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	output [6:0] HEX3;
	output [6:0] HEX4;
	output [6:0] HEX5;
	//the public input signals
	wire resetn, load;
	assign load = ~KEY[1];
	assign resetn = KEY[0];
	wire [7:0]state;




	//the control signals for the spaceship
	wire [2:0] color;
	wire [8:0] X;
	wire [7:0] Y;
	wire enable_x, enable_y, ld_color;
    wire DD, DE, SD, SE;
	wire up, down, left, right;
	assign up    = SW[9];
	assign down  = SW[8];
	assign left  = SW[7];
	assign right = SW[6];
	wire move_up, move_down, move_left, move_right;


	//the control signals for the meteor
	wire [2:0] color_M;
	wire [8:0] X_M;
	wire [7:0] Y_M;
	wire enable_x_M, enable_y_M, ld_color_M;
    wire DD_M, DE_M, SD_M, SE_M;
	
	
	control_top c1(CLOCK_50, resetn, load, 

				   DD, DE, up, down, left, right,
				   DD_M, DE_M,

				   SD, SE, enable_x, enable_y, ld_color, move_up, move_down, move_left, move_right,
				   SD_M, SE_M, enable_x_M, enable_y_M, ld_color_M, 

				   state);
	
	datapath_top d1(CLOCK_50, resetn, 

					SW[2:0], enable_x, enable_y, ld_color, move_up, move_down, move_left, move_right, 
					SW[2:0], enable_x_M, enable_y_M, ld_color_M,

					X, Y, color,
					X_M, Y_M, color_M);

	fill D1(CLOCK_50, resetn, 

			X, Y, color, SD, SE, 
			X_M, Y_M, color_M, SD_M, SE_M,

			DD, DE, 
			DD_M, DE_M,

			VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_R, VGA_G, VGA_B);

	hexDisplay H0(X[3:0], HEX0[6:0]);
	hexDisplay H1(X[7:4], HEX1[6:0]);
	hexDisplay H2(Y[3:0], HEX2[6:0]);
	hexDisplay H3({1'b0,Y[6:4]}, HEX3[6:0]);
	hexDisplay H4(state[3:0], HEX4[6:0]);
	hexDisplay H5(state[7:4], HEX5[6:0]);
 endmodule
 
 module control_top(input clk, resetn, load, 

 					input iDD, iDE, up, down, left, right,
 					input iDD_M, iDE_M, 


					output reg oSD, oSE, enable_x, enable_y, ld_color, move_up, move_down, move_left, move_right, 
					output reg oSD_M, oSE_M, enable_x_M, enable_y_M, ld_color_M,

					output reg [7:0]state);

	 reg [7:0] current_state, next_state; 
	 reg [27:0] count;
	 // reg [27:0] ecount;
	    
    localparam  S_RESET            = 8'd0,
	 
				S_INDRAW           = 8'd1,
				S_INACKDRAW        = 8'd2,

				S_INDRAW_M         = 8'd3,
				S_INACKDRAW_M      = 8'd4,


					 
				S_IDLE             = 8'd5,
					 
				//these are the spaceship states	 
				S_ERASE        	   = 8'd6,
				S_ACKERASE         = 8'd7,
					 
				S_MOVE			   = 8'd8,
					 
                S_DRAW             = 8'd9,
				S_ACKDRAW          = 8'd10,

				//these are other sprites states

				S_ERASE_M          = 8'd11,
				S_ACKERASE_M       = 8'd12,
					 
				S_MOVE_M		   = 8'd13,
					 
                S_DRAW_M           = 8'd14,
				S_ACKDRAW_M        = 8'd15,


					 
                S_WAIT             = 8'd16;
					 			
    // Next state logic aka our state table
    always@(*)
    begin: state_table 
			state[7:0] = current_state[7:0];
            case (current_state)
				    S_RESET:       next_state = load ? S_INDRAW : S_RESET;
					 
                	S_INDRAW:      next_state = iDD ? S_INACKDRAW : S_INDRAW;
					S_INACKDRAW:   next_state = S_INDRAW_M;

					S_INDRAW_M:    next_state = iDD_M ? S_INACKDRAW_M : S_INDRAW_M;
					S_INACKDRAW_M: next_state = S_IDLE;

					 
					S_IDLE:        next_state = ( (up == 1)||(down == 1)||(left == 1)||(right == 1) ) ? S_ERASE : S_ERASE_M;
					 
					 
					S_ERASE:       next_state = iDE ? S_ACKERASE : S_ERASE;
					// S_ACKERASE:    next_state = ( (up == 1)||(down == 1)||(left == 1)||(right == 1) ) ? S_MOVE : S_ACKERASE;
					S_ACKERASE:    next_state = S_MOVE ;
					 
					S_MOVE:		   next_state = S_DRAW;
					 
					S_DRAW:        next_state = iDD ? S_ACKDRAW : S_DRAW;
					S_ACKDRAW:     next_state = S_ERASE_M;



					S_ERASE_M:     next_state = iDE_M ? S_ACKERASE_M : S_ERASE_M;
					S_ACKERASE_M:  next_state = S_ACKERASE_M;
					 
					S_MOVE_M:	   next_state = S_DRAW_M;
					 
					S_DRAW_M:      next_state = iDD_M ? S_ACKDRAW_M : S_DRAW_M;
					S_ACKDRAW_M:   next_state = S_WAIT;

				 				 
                	S_WAIT :       next_state = (count ==  28'd1_099_999)? S_IDLE : S_WAIT;//wait 0.04s  28'd10000000
		 
					default:       next_state = S_IDLE;
				endcase	
    end // state_table


	 // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
		  enable_x = 1'b0; 
		  enable_y = 1'b0; 
		  ld_color = 1'b0;
		  oSD      = 1'b0;
		  oSE      = 1'b0;
		  move_up  = 1'b0;
		  move_down= 1'b0;
		  move_left= 1'b0; 
		  move_right=1'b0;

		  enable_x_M = 1'b0; 
		  enable_y_M = 1'b0; 
		  ld_color_M = 1'b0; 
		  oSD_M      = 1'b0;
		  oSE_M      = 1'b0;



       	  
        case (current_state)
		  
			S_RESET: begin
				ld_color = 1'b1;
				ld_color_M = 1'b1;
			end
				
			S_INDRAW:    oSD = 1'b1;
			S_INACKDRAW: oSD = 1'b0;

			S_INDRAW_M:    oSD_M = 1'b1;
			S_INACKDRAW_M: oSD_M = 1'b0;




			//the signal for the spaceship
         S_ERASE: oSE = 1'b1;
			S_ACKERASE: oSE = 1'b0;			
			S_MOVE:	begin
				if(up) move_up = 1;
				else if(down) move_down = 1;
				else if(left) move_left = 1;
				else if(right) move_right = 1;

			end
			S_DRAW:     oSD = 1'b1;
			S_ACKDRAW:  oSD = 1'b0;


			//the signals for the meteor
			S_ERASE_M: oSE_M = 1'b1;
			S_ACKERASE_M: oSE_M = 1'b0;
			S_MOVE_M:	begin
				enable_x_M = 1'b1; 
				enable_y_M = 1'b1;
			end
			S_DRAW_M:     oSD_M = 1'b1;
			S_ACKDRAW_M:  oSD_M = 1'b0;
				
        endcase
    end // enable_signals

    always@(posedge clk)
    begin: state_FFs
	 
        if(!resetn)
				begin
					current_state <= S_RESET;
					count <= 28'd0;  
					// ecount <= 28'd0;
				end
				
        else if((current_state == S_WAIT) && (count != 28'd1_099_999))//count != 28'd12500000
				begin
				current_state <= next_state;
				count <= count + 1'b1;
				end
				
		// else if((current_state == S_EWAIT) && (ecount != 28'd20000))//ecount != 28'd1666666
		// 		begin
		// 		current_state <= next_state;
		// 		ecount <= ecount + 1'b1;
		// 	end
				
		else if(current_state == S_ERASE_M)
			begin
				current_state <= next_state;
				count <= 28'd0;
				// ecount <= 28'd0;
			end
				
		else
			current_state <= next_state;
			
    end // state_FFS
endmodule
 
 
 
module datapath_top(clk, resetn, 
					
					data_in, enable_x, enable_y, ld_color, move_up, move_down, move_left, move_right, 
					data_in_M, enable_x_M, enable_y_M, ld_color_M,

					x_final, y_final, color,
					x_final_M, y_final_M, color_M);


	input clk, resetn;

	input [2:0] data_in;
	input enable_x, enable_y, ld_color, move_up, move_down, move_left, move_right;

	input [2:0] data_in_M;
	input enable_x_M, enable_y_M, ld_color_M;




	output reg [8:0] x_final;
	output reg [7:0] y_final;
	output reg [2:0] color;
	

	output reg [8:0] x_final_M;
	output reg [7:0] y_final_M;
	output reg [2:0] color_M;
	
	always@(posedge clk) begin
		if(ld_color) color[2:0] <= data_in[2:0];
	end
	
	always@(posedge clk) begin
		if(!resetn)
			x_final <= 9'd0;
			
		else if(move_left == 1) begin
			if(x_final == 9'd0) x_final <= 9'd316;
			else x_final <= x_final - 1;
			
		end
		
		else if(move_right == 1) begin
			if(x_final == 9'd316) x_final <= 9'd0;
			else x_final <= x_final + 1;
		end
	end
	
	always@(posedge clk) begin
		if(!resetn)
			y_final <= 8'd0;
			
		else if(move_up == 1)begin	
			if(y_final == 8'd0) y_final <= 8'd236;
			else y_final <= y_final - 1;
		end
		
		else if(move_down == 1)begin
			if(y_final == 8'd236) y_final <= 8'd0;
			else y_final <= y_final + 1;
		end
		
	end
 




	//the meteor
	always@(posedge clk) begin
		if(ld_color_M) color_M[2:0] <= data_in_M[2:0];
	end
	
	reg H, V;	

	always@(*) begin
		if(!resetn) begin
			H <= 1'b0;
			V <= 1'b0;
		end
		
		if((x_final_M == 8'b0) && (H == 0))
			H <= 1;
		else if((x_final_M == 8'd156) && (H == 1))
			H <= 0;
		
		if((y_final_M == 7'b0) && (V == 0))
			V <= 1;
		else if((y_final_M == 7'd116) && (V == 1))
			V <= 0;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			x_final_M <= 8'b0;
		else if(enable_x_M && (H == 0))
			x_final_M <= x_final_M - 1;
		else if(enable_x_M && (H == 1))
			x_final_M <= x_final_M + 1;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			y_final_M <= 7'b0;
		else if(enable_y_M && (V == 0))
			y_final_M <= y_final_M - 1;
		else if(enable_y_M && (V == 1))
			y_final_M <= y_final_M + 1;
	end




 endmodule                                                 
 
 
 module hexDisplay (input [3:0] segment, output [6:0] light);
    
    assign light[6] = (~segment[3] & ~segment[2] & ~segment[1] & ~segment[0])    |
                     (~segment[3] & ~segment[2] & ~segment[1] & segment[0])    |
                    (~segment[3] & segment[2] & segment[1] & segment[0])      |
                    (segment[3] & segment[2] & ~segment[1] & ~segment[0]);

    assign light[5] = (~segment[3] & ~segment[2] & ~segment[1] & segment[0]) |
                    (~segment[3] & ~segment[2] & segment[1] & ~segment[0])    |
                    (~segment[3] & ~segment[2] & segment[1] & segment[0])     |
                    (~segment[3] & segment[2] & segment[1] & segment[0])      |
                    (segment[3] & segment[2] & ~segment[1] & segment[0]);
    
    assign light[4] = (~segment[3] & ~segment[2] & ~segment[1] & segment[0]) |
                    (~segment[3] & ~segment[2] & segment[1] & segment[0])     |
                    (~segment[3] & segment[2] & ~segment[1] & ~segment[0])    |
                    (~segment[3] & segment[2] & ~segment[1] & segment[0])     |
                    (~segment[3] & segment[2] & segment[1] & segment[0])      |
                    (segment[3] & ~segment[2] & ~segment[1] & segment[0]);
    
    assign light[3] = (~segment[3] & ~segment[2] & ~segment[1] & segment[0]) |
                    (~segment[3] & segment[2] & ~segment[1] & ~segment[0])    |
                    (~segment[3] & segment[2] & segment[1] & segment[0])      |
                    (segment[3] & ~segment[2] & segment[1] & ~segment[0])     |
                    (segment[3] & segment[2] & segment[1] & segment[0]); 
    
    assign light[2] = (~segment[3] & ~segment[2] & segment[1] & ~segment[0]) |
                    (segment[3] & segment[2] & ~segment[1] & ~segment[0])     |
                    (segment[3] & segment[2] & segment[1] & ~segment[0])      |
                    (segment[3] & segment[2] & segment[1] & segment[0]);
    
    assign light[1] = (~segment[3] & segment[2] & ~segment[1] & segment[0])      |
                    (~segment[3] & segment[2] & segment[1] & ~segment[0])     |
                    (segment[3] & ~segment[2] & segment[1] & segment[0])      |
                    (segment[3] & segment[2] & ~segment[1] & ~segment[0])     |
                    (segment[3] & segment[2] & segment[1] & ~segment[0])      |
                    (segment[3] & segment[2] & segment[1] & segment[0]); 
                          
    assign light[0] = (~segment[3] & ~segment[2] & ~segment[1] & segment[0]) |
                    (~segment[3] & segment[2] & ~segment[1] & ~segment[0])    |
                    (segment[3] & ~segment[2] & segment[1] & segment[0])      |
                    (segment[3] & segment[2] & ~segment[1] & segment[0]); 
    
    
endmodule
